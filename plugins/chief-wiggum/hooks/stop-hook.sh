#!/bin/bash

# Chief Wiggum Stop Hook
# Orchestrates multi-story workflow with multi-agent stages per story

set -euo pipefail

STATE_FILE=".claude/chief-wiggum.local.md"

# Exit early if no state file
if [[ ! -f "$STATE_FILE" ]]; then
  exit 0
fi

# Read state file
STATE_CONTENT=$(cat "$STATE_FILE")

# Extract YAML frontmatter
FRONTMATTER=$(echo "$STATE_CONTENT" | sed -n '/^---$/,/^---$/p' | sed '1d;$d')

# Check if active
ACTIVE=$(echo "$FRONTMATTER" | grep -E '^active:' | sed 's/active: *//' | tr -d ' ')
if [[ "$ACTIVE" != "true" ]]; then
  exit 0
fi

# Extract key values
ITERATION=$(echo "$FRONTMATTER" | grep -E '^iteration:' | sed 's/iteration: *//' | tr -d ' ')
MAX_ITERATIONS=$(echo "$FRONTMATTER" | grep -E '^max_iterations_per_story:' | sed 's/max_iterations_per_story: *//' | tr -d ' ')
CURRENT_STAGE=$(echo "$FRONTMATTER" | grep -E '^current_stage:' | sed 's/current_stage: *//' | tr -d ' ')
CURRENT_AGENT=$(echo "$FRONTMATTER" | grep -E '^current_agent:' | sed 's/current_agent: *//' | tr -d ' ')
CURRENT_STORY_INDEX=$(echo "$FRONTMATTER" | grep -E '^current_story_index:' | sed 's/current_story_index: *//' | tr -d ' ')
TOTAL_STORIES=$(echo "$FRONTMATTER" | grep -E '^total_stories:' | sed 's/total_stories: *//' | tr -d ' ')
SKIP_DOCS=$(echo "$FRONTMATTER" | grep -E '^skip_docs:' | sed 's/skip_docs: *//' | tr -d ' ')
BRANCH_NAME=$(echo "$FRONTMATTER" | grep -E '^branch_name:' | sed 's/branch_name: *//' | tr -d '"')

# Get current story info from YAML
# Extract stories array and find current story
CURRENT_STORY_ID=$(echo "$FRONTMATTER" | awk -v idx="$CURRENT_STORY_INDEX" '
  /^stories:/ { in_stories=1; story_idx=-1; next }
  in_stories && /^  - id:/ {
    story_idx++;
    if (story_idx == idx) {
      gsub(/.*id: *"?/, "");
      gsub(/".*/, "");
      print;
      exit
    }
  }
  in_stories && /^[a-z]/ && !/^  / { exit }
')

# Default values
ITERATION=${ITERATION:-1}
MAX_ITERATIONS=${MAX_ITERATIONS:-25}
CURRENT_STAGE=${CURRENT_STAGE:-dev}
CURRENT_STORY_INDEX=${CURRENT_STORY_INDEX:-0}
TOTAL_STORIES=${TOTAL_STORIES:-0}
SKIP_DOCS=${SKIP_DOCS:-false}

# Check for BLOCKED in recent output
if [[ -n "${CLAUDE_STOP_CONTENT:-}" ]]; then
  if echo "$CLAUDE_STOP_CONTENT" | grep -q "BLOCKED"; then
    echo "🚫 BLOCKED detected - halting Chief Wiggum execution"

    # Update state file to inactive
    sed -i.bak 's/^active: true/active: false/' "$STATE_FILE"
    rm -f "${STATE_FILE}.bak"

    # Allow exit
    exit 0
  fi
fi

# Check for story completion
if [[ "$CURRENT_STAGE" == "story_complete" ]]; then
  # Current story is complete, advance to next
  NEXT_STORY_INDEX=$((CURRENT_STORY_INDEX + 1))

  if [[ $NEXT_STORY_INDEX -ge $TOTAL_STORIES ]]; then
    # All stories complete!
    echo "🎉 All $TOTAL_STORIES stories complete!"
    echo ""
    echo "Chief Wiggum workflow finished successfully."

    # Deactivate
    sed -i.bak 's/^active: true/active: false/' "$STATE_FILE"
    rm -f "${STATE_FILE}.bak"

    exit 0
  fi

  # Advance to next story
  echo "📖 Story $CURRENT_STORY_ID complete! Advancing to story $((NEXT_STORY_INDEX + 1)) of $TOTAL_STORIES..."

  # Update state for next story
  sed -i.bak \
    -e "s/^current_story_index: $CURRENT_STORY_INDEX/current_story_index: $NEXT_STORY_INDEX/" \
    -e "s/^current_stage: story_complete/current_stage: dev/" \
    -e "s/^current_agent: none/current_agent: dev-agent/" \
    -e "s/^iteration: $ITERATION/iteration: 1/" \
    "$STATE_FILE"
  rm -f "${STATE_FILE}.bak"

  # Get next story details from PRD file
  PRD_FILE=$(echo "$FRONTMATTER" | grep -E '^prd_file:' | sed 's/prd_file: *//' | tr -d '"')
  if [[ -f "$PRD_FILE" ]]; then
    NEXT_STORY_ID=$(jq -r ".userStories[$NEXT_STORY_INDEX].id" "$PRD_FILE")
    NEXT_STORY_TITLE=$(jq -r ".userStories[$NEXT_STORY_INDEX].title" "$PRD_FILE")
    NEXT_STORY_DESC=$(jq -r ".userStories[$NEXT_STORY_INDEX].description" "$PRD_FILE")
    NEXT_STORY_CRITERIA=$(jq -r ".userStories[$NEXT_STORY_INDEX].acceptanceCriteria | map(\"- [ ] \" + .) | join(\"\n\")" "$PRD_FILE")

    # Update Current Story section in state file
    # Replace everything between "## Current Story" and "## Agent Outputs"
    TEMP_FILE=$(mktemp)
    awk -v id="$NEXT_STORY_ID" -v title="$NEXT_STORY_TITLE" -v desc="$NEXT_STORY_DESC" -v criteria="$NEXT_STORY_CRITERIA" '
      /^## Current Story/ {
        print "## Current Story: " id " - " title
        print ""
        print "**Description:** " desc
        print ""
        print "**Acceptance Criteria:**"
        print criteria
        print ""
        skip=1
        next
      }
      /^## Agent Outputs/ { skip=0 }
      !skip { print }
    ' "$STATE_FILE" > "$TEMP_FILE"
    mv "$TEMP_FILE" "$STATE_FILE"

    # Also update story status in YAML
    # Mark current story as in_progress
    sed -i.bak "s/status: pending/status: in_progress/" "$STATE_FILE"
    rm -f "${STATE_FILE}.bak"
  fi

  # Output prompt to continue with next story
  cat <<PROMPT
{"decision": "block", "prompt": "🚔 Chief Wiggum - Story $((NEXT_STORY_INDEX + 1)) of $TOTAL_STORIES

You are the **Dev Agent** starting a new story.

Read the state file at .claude/chief-wiggum.local.md to see:
- The new story's requirements in ## Current Story
- Your responsibilities as Dev Agent

Implement the story according to its acceptance criteria. When complete:
1. Verify all criteria are met
2. Run quality checks (typecheck)
3. Update state file: current_stage → code-review, current_agent → code-review-agent
4. Add your summary to ## Agent Outputs

Begin implementation now."}
PROMPT
  exit 0
fi

# Check iteration limit
if [[ $ITERATION -ge $MAX_ITERATIONS ]]; then
  echo "⚠️ Maximum iterations ($MAX_ITERATIONS) reached for current story"
  echo "Story: $CURRENT_STORY_ID"
  echo ""
  echo "The workflow will halt. Review the state file and Agent Outputs to understand the issue."

  # Deactivate
  sed -i.bak 's/^active: true/active: false/' "$STATE_FILE"
  rm -f "${STATE_FILE}.bak"

  exit 0
fi

# Increment iteration
NEW_ITERATION=$((ITERATION + 1))
sed -i.bak "s/^iteration: $ITERATION/iteration: $NEW_ITERATION/" "$STATE_FILE"
rm -f "${STATE_FILE}.bak"

# Route based on current stage
case "$CURRENT_STAGE" in
  dev)
    cat <<PROMPT
{"decision": "block", "prompt": "🚔 Chief Wiggum - Story $((CURRENT_STORY_INDEX + 1))/$TOTAL_STORIES | Iteration $NEW_ITERATION | Stage: Dev

You are the **Dev Agent** for story $CURRENT_STORY_ID.

Read the state file at .claude/chief-wiggum.local.md to see:
- Current story requirements in ## Current Story
- Any feedback in feedback_history that needs addressing

Your task:
1. Implement the story per acceptance criteria (or address feedback)
2. Run quality checks (typecheck must pass)
3. When done, update state file:
   - current_stage: code-review
   - current_agent: code-review-agent
4. Add your summary to ## Agent Outputs

Continue implementation now."}
PROMPT
    ;;

  code-review)
    cat <<PROMPT
{"decision": "block", "prompt": "🚔 Chief Wiggum - Story $((CURRENT_STORY_INDEX + 1))/$TOTAL_STORIES | Iteration $NEW_ITERATION | Stage: Code Review

You are the **Code Review Agent** for story $CURRENT_STORY_ID.

Read the state file at .claude/chief-wiggum.local.md to see:
- Story requirements in ## Current Story
- Dev Agent's output in ## Agent Outputs

Your task:
1. Review code changes using git diff
2. Check for bugs, security issues, code quality
3. APPROVE → Update state: current_stage: qa, current_agent: qa-agent
   REJECT → Update state: current_stage: dev, current_agent: dev-agent
           Add feedback to feedback_history with specific issues
4. Add your review summary to ## Agent Outputs

Begin code review now."}
PROMPT
    ;;

  qa)
    if [[ "$SKIP_DOCS" == "true" ]]; then
      NEXT_STAGE_MSG="APPROVE → Update state: current_stage: story_complete, current_agent: none"
    else
      NEXT_STAGE_MSG="APPROVE → Update state: current_stage: docs, current_agent: doc-writer-agent"
    fi

    cat <<PROMPT
{"decision": "block", "prompt": "🚔 Chief Wiggum - Story $((CURRENT_STORY_INDEX + 1))/$TOTAL_STORIES | Iteration $NEW_ITERATION | Stage: QA

You are the **QA Agent** for story $CURRENT_STORY_ID.

Read the state file at .claude/chief-wiggum.local.md to see:
- Story acceptance criteria in ## Current Story
- Implementation details in ## Agent Outputs

Your task:
1. Run tests (npm test, pytest, etc.)
2. Verify EVERY acceptance criterion is met
3. $NEXT_STAGE_MSG
   REJECT → Update state: current_stage: dev, current_agent: dev-agent
           Add feedback to feedback_history with specific issues
4. Add your test results to ## Agent Outputs

Begin QA testing now."}
PROMPT
    ;;

  docs)
    cat <<PROMPT
{"decision": "block", "prompt": "🚔 Chief Wiggum - Story $((CURRENT_STORY_INDEX + 1))/$TOTAL_STORIES | Iteration $NEW_ITERATION | Stage: Documentation

You are the **Doc Writer Agent** for story $CURRENT_STORY_ID.

Read the state file at .claude/chief-wiggum.local.md to see:
- Story details in ## Current Story
- What was implemented in ## Agent Outputs

Your task:
1. Update README if the story affects usage
2. Add inline documentation (JSDoc, docstrings) for new APIs
3. Create changelog entry if appropriate
4. When done, update state file:
   - current_stage: story_complete
   - current_agent: none
   - Mark story status: complete in stories array
5. Add your summary to ## Agent Outputs
6. Add story to ## Progress Log

Complete documentation now."}
PROMPT
    ;;

  *)
    echo "⚠️ Unknown stage: $CURRENT_STAGE"
    echo "Resetting to dev stage..."

    sed -i.bak \
      -e "s/^current_stage: .*/current_stage: dev/" \
      -e "s/^current_agent: .*/current_agent: dev-agent/" \
      "$STATE_FILE"
    rm -f "${STATE_FILE}.bak"

    cat <<PROMPT
{"decision": "block", "prompt": "🚔 Chief Wiggum - Story $((CURRENT_STORY_INDEX + 1))/$TOTAL_STORIES | Reset to Dev

Unknown stage detected. Resetting to Dev stage.

You are the **Dev Agent** for story $CURRENT_STORY_ID.

Read the state file at .claude/chief-wiggum.local.md and continue implementation."}
PROMPT
    ;;
esac
