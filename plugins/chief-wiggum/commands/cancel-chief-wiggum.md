---
name: cancel-chief-wiggum
description: Cancel a running Chief Wiggum loop
---

# Cancel Chief Wiggum

Cancels the active Chief Wiggum workflow by deactivating the state file.

## What This Does

1. Sets `active: false` in the state file
2. The stop hook will no longer intercept exits
3. Reports current progress status

## Usage

```bash
/cancel-chief-wiggum
```

---

Check if there's an active Chief Wiggum loop and cancel it:

```bash
STATE_FILE=".chief-wiggum/state.md"

if [[ ! -f "$STATE_FILE" ]]; then
  echo "❌ No Chief Wiggum state file found"
  echo "No active loop to cancel."
  exit 0
fi

# Check if active
if grep -q "^active: true" "$STATE_FILE"; then
  # Get current progress
  CURRENT_STORY=$(grep -E "^current_story_index:" "$STATE_FILE" | sed 's/.*: *//' | tr -d ' ')
  TOTAL_STORIES=$(grep -E "^total_stories:" "$STATE_FILE" | sed 's/.*: *//' | tr -d ' ')
  CURRENT_STAGE=$(grep -E "^current_stage:" "$STATE_FILE" | sed 's/.*: *//' | tr -d ' ')
  ITERATION=$(grep -E "^iteration:" "$STATE_FILE" | sed 's/.*: *//' | tr -d ' ')

  # Deactivate
  sed -i.bak 's/^active: true/active: false/' "$STATE_FILE"
  rm -f "${STATE_FILE}.bak"

  echo "✅ Chief Wiggum loop cancelled"
  echo ""
  echo "Progress at cancellation:"
  echo "  Story: $((CURRENT_STORY + 1)) of $TOTAL_STORIES"
  echo "  Stage: $CURRENT_STAGE"
  echo "  Iteration: $ITERATION"
  echo ""
  echo "State file preserved at: $STATE_FILE"
  echo "To resume, set 'active: true' in the state file and try to exit."
else
  echo "ℹ️ No active Chief Wiggum loop"
  echo ""
  echo "State file exists but loop is not active."
  echo "To restart, run /chief-wiggum with your PRD file."
fi
```

The loop has been cancelled. You can now work freely without the stop hook intercepting.
