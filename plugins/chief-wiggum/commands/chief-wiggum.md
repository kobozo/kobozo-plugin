---
name: chief-wiggum
description: Execute all user stories from prd.json autonomously
arguments:
  - name: file
    description: Path to PRD JSON file (default: .chief-wiggum/prd.json or from .chief-wiggum/current-prd)
    required: false
  - name: --branch
    description: Override feature branch name
    required: false
  - name: --skip-docs
    description: Skip documentation stage for all stories
    required: false
  - name: --max-iterations
    description: Max iterations per story (default: 25)
    required: false
---

# Chief Wiggum - PRD Story Orchestrator

Execute all user stories from a PRD JSON file autonomously. Each story runs through the full multi-agent workflow:

**Dev → Code Review → QA → Docs → Next Story**

## Usage

```bash
/chief-wiggum                                    # Uses default PRD file
/chief-wiggum .chief-wiggum/prd.json            # Specify PRD file
/chief-wiggum .chief-wiggum/auth.json --branch feature/custom-name
/chief-wiggum .chief-wiggum/prd.json --skip-docs --max-iterations 30
```

## How It Works

1. **Setup**: Parses PRD JSON and creates state file with all stories
2. **Story Loop**: Each story goes through:
   - **Dev Agent**: Implements the story
   - **Code Review Agent**: Reviews code quality (can reject → back to Dev)
   - **QA Agent**: Tests functionality (can reject → back to Dev)
   - **Doc Writer Agent**: Updates documentation (if not skipped)
3. **Advancement**: After story completion, automatically advances to next story
4. **Completion**: Exits when all stories are complete or BLOCKED

## PRD JSON Format

```json
{
  "project": "Feature Name",
  "branchName": "feature/name",
  "description": "Feature description",
  "userStories": [
    {
      "id": "US-001",
      "title": "Story Title",
      "description": "As a user, I want...",
      "acceptanceCriteria": ["Criterion 1", "Criterion 2"],
      "priority": 1
    }
  ]
}
```

## Monitoring

- **State file**: `.chief-wiggum/state.md`
- **View progress**: `head -50 .chief-wiggum/state.md`
- **Cancel**: `/cancel-chief-wiggum`

## Warning

⚠️ This loop runs until ALL stories complete or BLOCKED is encountered!

---

Run the setup script to initialize the workflow:

```bash
${CLAUDE_PLUGIN_ROOT}/scripts/setup-chief-wiggum.sh $ARGUMENTS
```

After setup completes, you are the **Dev Agent** for the first story. Read the state file at `.chief-wiggum/state.md` to see:

- Current story requirements in `## Current Story`
- Your responsibilities as Dev Agent

**Begin implementing the first story now.**
