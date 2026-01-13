#!/bin/bash

# Chief Wiggum Setup Script
# Initializes state file from PRD JSON for multi-story execution

set -euo pipefail

# Parse arguments
PRD_FILE=""
BRANCH_NAME=""
SKIP_DOCS="false"
MAX_ITERATIONS=25

# Parse options and positional arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      cat << 'HELP_EOF'
Chief Wiggum - PRD-driven story orchestrator

USAGE:
  /chief-wiggum <prd-file> [OPTIONS]

ARGUMENTS:
  prd-file    Path to PRD JSON file containing user stories

OPTIONS:
  --branch <name>          Override feature branch name
  --skip-docs              Skip documentation stage for all stories
  --max-iterations <n>     Max iterations per story (default: 25)
  -h, --help               Show this help message

DESCRIPTION:
  Executes user stories from a PRD JSON file sequentially.
  Each story goes through Dev→Code Review→QA→Docs stages.

  The stop hook intercepts exit attempts and:
  1. Routes to the appropriate agent based on current stage
  2. Handles feedback loops when reviewers reject
  3. Advances to next story when current story completes
  4. Exits when all stories are done

EXAMPLES:
  /chief-wiggum .chief-wiggum/prd.json
  /chief-wiggum .chief-wiggum/auth-prd.json --branch feature/custom-name
  /chief-wiggum .chief-wiggum/prd.json --skip-docs --max-iterations 30

PRD JSON FORMAT:
  {
    "project": "Feature Name",
    "branchName": "feature/name",
    "userStories": [
      {
        "id": "US-001",
        "title": "Story Title",
        "description": "As a user...",
        "acceptanceCriteria": ["...", "..."],
        "priority": 1
      }
    ]
  }
HELP_EOF
      exit 0
      ;;
    --branch)
      if [[ -z "${2:-}" ]]; then
        echo "❌ Error: --branch requires a name argument" >&2
        exit 1
      fi
      BRANCH_NAME="$2"
      shift 2
      ;;
    --skip-docs)
      SKIP_DOCS="true"
      shift
      ;;
    --max-iterations)
      if [[ -z "${2:-}" ]]; then
        echo "❌ Error: --max-iterations requires a number argument" >&2
        exit 1
      fi
      if ! [[ "$2" =~ ^[0-9]+$ ]]; then
        echo "❌ Error: --max-iterations must be a positive integer" >&2
        exit 1
      fi
      MAX_ITERATIONS="$2"
      shift 2
      ;;
    *)
      # First non-option argument is the PRD file
      if [[ -z "$PRD_FILE" ]]; then
        PRD_FILE="$1"
      else
        echo "❌ Error: Unexpected argument: $1" >&2
        exit 1
      fi
      shift
      ;;
  esac
done

# Validate PRD file
if [[ -z "$PRD_FILE" ]]; then
  echo "❌ Error: No PRD file provided" >&2
  echo "" >&2
  echo "   Usage: /chief-wiggum <prd-file>" >&2
  echo "   Example: /chief-wiggum .chief-wiggum/prd.json" >&2
  exit 1
fi

if [[ ! -f "$PRD_FILE" ]]; then
  echo "❌ Error: PRD file not found: $PRD_FILE" >&2
  exit 1
fi

# Validate JSON
if ! jq empty "$PRD_FILE" 2>/dev/null; then
  echo "❌ Error: Invalid JSON in PRD file: $PRD_FILE" >&2
  exit 1
fi

# Extract PRD data
PROJECT_NAME=$(jq -r '.project // "Unknown Project"' "$PRD_FILE")
PRD_BRANCH=$(jq -r '.branchName // ""' "$PRD_FILE")
PRD_DESCRIPTION=$(jq -r '.description // ""' "$PRD_FILE")
STORY_COUNT=$(jq -r '.userStories | length' "$PRD_FILE")

# Use provided branch name or derive from PRD
if [[ -z "$BRANCH_NAME" ]]; then
  if [[ -n "$PRD_BRANCH" ]]; then
    BRANCH_NAME="$PRD_BRANCH"
  else
    # Convert project name to kebab-case for branch
    BRANCH_NAME="feature/$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')"
  fi
fi

# Validate stories exist
if [[ "$STORY_COUNT" -eq 0 ]]; then
  echo "❌ Error: No user stories found in PRD file" >&2
  exit 1
fi

# Build stories YAML array from JSON
# This converts the JSON userStories array to YAML format for the state file
STORIES_YAML=$(jq -r '.userStories | to_entries | map(
  "  - id: \"" + .value.id + "\"\n" +
  "    title: \"" + (.value.title | gsub("\""; "\\\"")) + "\"\n" +
  "    description: \"" + (.value.description | gsub("\""; "\\\"") | gsub("\n"; " ")) + "\"\n" +
  "    acceptanceCriteria:\n" + (.value.acceptanceCriteria | map("      - \"" + (. | gsub("\""; "\\\"")) + "\"") | join("\n")) + "\n" +
  "    priority: " + (.value.priority | tostring) + "\n" +
  "    status: pending\n" +
  "    story_iteration: 0"
) | join("\n")' "$PRD_FILE")

# Get first story details for initial context
FIRST_STORY_ID=$(jq -r '.userStories[0].id' "$PRD_FILE")
FIRST_STORY_TITLE=$(jq -r '.userStories[0].title' "$PRD_FILE")
FIRST_STORY_DESC=$(jq -r '.userStories[0].description' "$PRD_FILE")
FIRST_STORY_CRITERIA=$(jq -r '.userStories[0].acceptanceCriteria | map("- [ ] " + .) | join("\n")' "$PRD_FILE")

# Create chief-wiggum directory
mkdir -p .chief-wiggum

# Create state file with all stories loaded
# State file schema for multi-story + multi-stage tracking
cat > .chief-wiggum/state.md <<EOF
---
active: true
iteration: 1
max_iterations_per_story: $MAX_ITERATIONS
completion_promise: "STORY_COMPLETE"
blocked_promise: "BLOCKED"
prd_file: "$PRD_FILE"
branch_name: "$BRANCH_NAME"
skip_docs: $SKIP_DOCS
current_story_index: 0
current_stage: dev
current_agent: dev-agent
total_stories: $STORY_COUNT
stories:
$STORIES_YAML
feedback_history: []
started_at: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
---

## Current Story: $FIRST_STORY_ID - $FIRST_STORY_TITLE

**Description:** $FIRST_STORY_DESC

**Acceptance Criteria:**
$FIRST_STORY_CRITERIA

## Agent Outputs

## Progress Log
EOF

# Output setup message
cat <<EOF
🚔 Chief Wiggum activated!

Project: $PROJECT_NAME
Branch: $BRANCH_NAME
Stories: $STORY_COUNT total
Max iterations per story: $MAX_ITERATIONS
Skip docs: $SKIP_DOCS

Workflow: Dev → Code Review → QA → $(if [[ "$SKIP_DOCS" == "true" ]]; then echo "Complete"; else echo "Docs → Complete"; fi)

Starting with: $FIRST_STORY_ID - $FIRST_STORY_TITLE

The stop hook is now active. When you try to exit:
1. Dev Agent implements the story
2. Code Review Agent reviews (or rejects back to Dev)
3. QA Agent tests (or rejects back to Dev)
4. Doc Writer updates docs (if not skipped)
5. Story completes → advances to next story
6. All stories complete → loop exits

To monitor: head -30 .chief-wiggum/state.md
To cancel: /cancel-chief-wiggum

⚠️  WARNING: This loop runs until all stories complete or BLOCKED!

🚔
EOF

# Display first story context
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "STORY: $FIRST_STORY_ID - $FIRST_STORY_TITLE"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "$FIRST_STORY_DESC"
echo ""
echo "Acceptance Criteria:"
echo "$FIRST_STORY_CRITERIA"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Begin implementing this story. When all acceptance criteria are met,"
echo "update the state file to transition to code-review stage."
