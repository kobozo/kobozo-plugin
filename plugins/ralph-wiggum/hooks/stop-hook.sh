#!/bin/bash

# Ralph Wiggum Multi-Agent Stop Hook
# Routes to different agents based on workflow stage
# Handles stage transitions and rejection feedback loops

set -euo pipefail

# Script directory for loading agent prompts
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"
AGENTS_DIR="$PLUGIN_DIR/agents"

# Read hook input from stdin (advanced stop hook API)
HOOK_INPUT=$(cat)

# Check if ralph-loop is active
RALPH_STATE_FILE=".claude/ralph-loop.local.md"

if [[ ! -f "$RALPH_STATE_FILE" ]]; then
  # No active loop - allow exit
  exit 0
fi

# Parse markdown frontmatter (YAML between ---) and extract values
FRONTMATTER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$RALPH_STATE_FILE")
ITERATION=$(echo "$FRONTMATTER" | grep '^iteration:' | sed 's/iteration: *//')
MAX_ITERATIONS=$(echo "$FRONTMATTER" | grep '^max_iterations:' | sed 's/max_iterations: *//')
COMPLETION_PROMISE=$(echo "$FRONTMATTER" | grep '^completion_promise:' | sed 's/completion_promise: *//' | sed 's/^"\(.*\)"$/\1/')
STAGE=$(echo "$FRONTMATTER" | grep '^stage:' | sed 's/stage: *//' || echo "dev")
CURRENT_AGENT=$(echo "$FRONTMATTER" | grep '^current_agent:' | sed 's/current_agent: *//' || echo "dev-agent")
SKIP_DOCS=$(echo "$FRONTMATTER" | grep '^skip_docs:' | sed 's/skip_docs: *//' || echo "false")

# Default stage if not set (backward compatibility)
if [[ -z "$STAGE" ]]; then
  STAGE="dev"
fi

# Validate numeric fields before arithmetic operations
if [[ ! "$ITERATION" =~ ^[0-9]+$ ]]; then
  echo "⚠️  Ralph loop: State file corrupted" >&2
  echo "   File: $RALPH_STATE_FILE" >&2
  echo "   Problem: 'iteration' field is not a valid number (got: '$ITERATION')" >&2
  rm "$RALPH_STATE_FILE"
  exit 0
fi

if [[ ! "$MAX_ITERATIONS" =~ ^[0-9]+$ ]]; then
  echo "⚠️  Ralph loop: State file corrupted" >&2
  echo "   File: $RALPH_STATE_FILE" >&2
  echo "   Problem: 'max_iterations' field is not a valid number (got: '$MAX_ITERATIONS')" >&2
  rm "$RALPH_STATE_FILE"
  exit 0
fi

# Check if max iterations reached
if [[ $MAX_ITERATIONS -gt 0 ]] && [[ $ITERATION -ge $MAX_ITERATIONS ]]; then
  echo "🛑 Ralph loop: Max iterations ($MAX_ITERATIONS) reached."
  rm "$RALPH_STATE_FILE"
  exit 0
fi

# Check for complete stage - allow exit
if [[ "$STAGE" == "complete" ]]; then
  echo "✅ Ralph loop: All stages complete!"
  rm "$RALPH_STATE_FILE"
  exit 0
fi

# Get transcript path from hook input
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | jq -r '.transcript_path')

if [[ ! -f "$TRANSCRIPT_PATH" ]]; then
  echo "⚠️  Ralph loop: Transcript file not found" >&2
  rm "$RALPH_STATE_FILE"
  exit 0
fi

# Read last assistant message from transcript (JSONL format)
if ! grep -q '"role":"assistant"' "$TRANSCRIPT_PATH"; then
  echo "⚠️  Ralph loop: No assistant messages found in transcript" >&2
  rm "$RALPH_STATE_FILE"
  exit 0
fi

LAST_LINE=$(grep '"role":"assistant"' "$TRANSCRIPT_PATH" | tail -1)
if [[ -z "$LAST_LINE" ]]; then
  echo "⚠️  Ralph loop: Failed to extract last assistant message" >&2
  rm "$RALPH_STATE_FILE"
  exit 0
fi

LAST_OUTPUT=$(echo "$LAST_LINE" | jq -r '
  .message.content |
  map(select(.type == "text")) |
  map(.text) |
  join("\n")
' 2>&1)

if [[ $? -ne 0 ]] || [[ -z "$LAST_OUTPUT" ]]; then
  echo "⚠️  Ralph loop: Failed to parse assistant message" >&2
  rm "$RALPH_STATE_FILE"
  exit 0
fi

# Check for completion promise (only if set)
if [[ "$COMPLETION_PROMISE" != "null" ]] && [[ -n "$COMPLETION_PROMISE" ]]; then
  PROMISE_TEXT=$(echo "$LAST_OUTPUT" | perl -0777 -pe 's/.*?<promise>(.*?)<\/promise>.*/$1/s; s/^\s+|\s+$//g; s/\s+/ /g' 2>/dev/null || echo "")
  if [[ -n "$PROMISE_TEXT" ]] && [[ "$PROMISE_TEXT" = "$COMPLETION_PROMISE" ]]; then
    echo "✅ Ralph loop: Detected <promise>$COMPLETION_PROMISE</promise>"
    rm "$RALPH_STATE_FILE"
    exit 0
  fi
fi

# Extract original task from state file (the ## Original Task section)
ORIGINAL_TASK=$(awk '/^## Original Task$/,/^## /{if(/^## / && !/^## Original Task$/)exit; if(!/^## Original Task$/)print}' "$RALPH_STATE_FILE")

# Count unaddressed issues in feedback_history
# Using grep to check for "addressed: false" patterns
PENDING_ISSUES=$(grep -c 'addressed: false' "$RALPH_STATE_FILE" 2>/dev/null || echo "0")

# Get agent prompt based on current stage
get_agent_prompt() {
  local agent_file="$AGENTS_DIR/$1.md"
  if [[ -f "$agent_file" ]]; then
    # Extract content after frontmatter
    awk '/^---$/{i++; next} i>=2' "$agent_file"
  else
    echo "Agent instructions not found. Please follow the workflow for stage: $STAGE"
  fi
}

# Increment iteration
NEXT_ITERATION=$((ITERATION + 1))

# Update iteration in state file
TEMP_FILE="${RALPH_STATE_FILE}.tmp.$$"
sed "s/^iteration: .*/iteration: $NEXT_ITERATION/" "$RALPH_STATE_FILE" > "$TEMP_FILE"
mv "$TEMP_FILE" "$RALPH_STATE_FILE"

# Build prompt based on current stage
case "$STAGE" in
  dev)
    AGENT_PROMPT=$(get_agent_prompt "dev-agent")
    if [[ "$PENDING_ISSUES" -gt 0 ]]; then
      SYSTEM_MSG="🔄 Ralph iteration $NEXT_ITERATION | Stage: dev | ⚠️ $PENDING_ISSUES issues to address"
    else
      SYSTEM_MSG="🔄 Ralph iteration $NEXT_ITERATION | Stage: dev | Implement the task"
    fi
    PROMPT="$AGENT_PROMPT

---

## Current State File
Read the state at: $RALPH_STATE_FILE

## Original Task
$ORIGINAL_TASK

---

Work on the task. When complete, update the state file to transition to code-review stage."
    ;;

  code-review)
    AGENT_PROMPT=$(get_agent_prompt "code-review-agent")
    SYSTEM_MSG="🔄 Ralph iteration $NEXT_ITERATION | Stage: code-review | Review the implementation"
    PROMPT="$AGENT_PROMPT

---

## Current State File
Read the state at: $RALPH_STATE_FILE

## Original Task
$ORIGINAL_TASK

---

Review the changes. Either APPROVE (transition to qa) or REJECT (transition back to dev with feedback)."
    ;;

  qa)
    AGENT_PROMPT=$(get_agent_prompt "qa-agent")
    SYSTEM_MSG="🔄 Ralph iteration $NEXT_ITERATION | Stage: qa | Test the implementation"
    PROMPT="$AGENT_PROMPT

---

## Current State File
Read the state at: $RALPH_STATE_FILE

## Original Task
$ORIGINAL_TASK

---

Test the changes. Either APPROVE (transition to docs) or REJECT (transition back to dev with feedback)."
    ;;

  docs)
    AGENT_PROMPT=$(get_agent_prompt "doc-writer-agent")
    SYSTEM_MSG="🔄 Ralph iteration $NEXT_ITERATION | Stage: docs | Document the changes"
    PROMPT="$AGENT_PROMPT

---

## Current State File
Read the state at: $RALPH_STATE_FILE

## Original Task
$ORIGINAL_TASK

---

Update documentation as needed, then transition to complete stage."
    ;;

  *)
    # Unknown stage - try to recover by going to dev
    SYSTEM_MSG="🔄 Ralph iteration $NEXT_ITERATION | Unknown stage: $STAGE - defaulting to dev"
    PROMPT="Unknown workflow stage. Please read $RALPH_STATE_FILE and continue working on the task.

## Original Task
$ORIGINAL_TASK"
    ;;
esac

# Add completion promise reminder if set
if [[ "$COMPLETION_PROMISE" != "null" ]] && [[ -n "$COMPLETION_PROMISE" ]]; then
  SYSTEM_MSG="$SYSTEM_MSG | Promise: <promise>$COMPLETION_PROMISE</promise>"
fi

# Output JSON to block the stop and feed prompt back
jq -n \
  --arg prompt "$PROMPT" \
  --arg msg "$SYSTEM_MSG" \
  '{
    "decision": "block",
    "reason": $prompt,
    "systemMessage": $msg
  }'

exit 0
