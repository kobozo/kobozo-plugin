# Chief Wiggum Plugin

PRD-driven story orchestrator that executes user stories sequentially with a multi-agent workflow. Each story goes through Dev→Code Review→QA→Docs stages before advancing to the next story.

## Overview

Chief Wiggum reads a PRD JSON file containing user stories and executes them one by one using the ralph-wiggum stop hook pattern. Unlike the original chief-wiggum that spawns separate Claude instances, this version runs entirely in-context using stop hooks to orchestrate the workflow.

## Workflow

```
/chief-wiggum .chief-wiggum/prd.json
         ↓
   Load all stories
         ↓
┌─────────────────────────────────────┐
│  STORY LOOP (for each story)        │
│                                     │
│  ┌─────┐    ┌────────┐    ┌─────┐  │
│  │ Dev │───▶│CodeRev │───▶│ QA  │──▶│ Docs
│  └─────┘    └────────┘    └─────┘  │
│      ↑          │            │      │
│      └──────────┴────────────┘      │
│           (reject loop)             │
│                                     │
│  Story Complete → Next Story        │
└─────────────────────────────────────┘
         ↓
   All stories complete
```

## Quick Start

### 1. Generate a PRD

```bash
/prd "Build a user authentication system with login, logout, and password reset"
```

This will ask clarifying questions and generate `.chief-wiggum/prd.json`.

### 2. Execute the PRD

```bash
/chief-wiggum .chief-wiggum/prd.json
```

Chief Wiggum will:
- Create a feature branch (gitflow: `feature/auth`)
- Execute each story through Dev→Code Review→QA→Docs
- Commit after each story completion
- Continue until all stories are done or BLOCKED

### 3. Cancel if needed

```bash
/cancel-chief-wiggum
```

## Commands

### /chief-wiggum

Execute user stories from a PRD JSON file.

```bash
/chief-wiggum <prd-file> [--branch <name>] [--skip-docs]
```

**Arguments:**
- `<prd-file>` - Path to PRD JSON file (required)

**Options:**
- `--branch <name>` - Override feature branch name
- `--skip-docs` - Skip documentation stage for all stories

### /prd

Generate a PRD JSON file from a feature description.

```bash
/prd "Feature description"
```

Outputs: `.chief-wiggum/prd.json`

### /cancel-chief-wiggum

Cancel the active Chief Wiggum loop.

```bash
/cancel-chief-wiggum
```

## PRD JSON Format

```json
{
  "project": "Feature Name",
  "branchName": "feature/feature-name",
  "description": "Feature description",
  "userStories": [
    {
      "id": "US-001",
      "title": "Story Title",
      "description": "As a user, I want X so that Y",
      "acceptanceCriteria": [
        "Criterion 1",
        "Criterion 2",
        "Typecheck passes"
      ],
      "testInstructions": "Run npm test src/auth.test.ts. Verify in browser at localhost:3000/login",
      "priority": 1
    }
  ]
}
```

### Test Instructions (Required)

Each story **must** have `testInstructions` that tell the QA agent how to verify:
- Test commands to run (`npm test`, `pytest`, etc.)
- API endpoints to call (`curl http://...`)
- URLs to check in browser
- Log files to inspect
- Build commands to verify

## Multi-Agent Workflow

Each story goes through four stages:

### 1. Dev Agent
- Implements the story based on description and acceptance criteria
- Addresses feedback from Code Review or QA
- Transitions to code-review when implementation is complete

### 2. Code Review Agent
- Reviews code changes (git diff)
- Checks for quality, security, patterns
- Can APPROVE (→QA) or REJECT (→Dev with feedback)

### 3. QA Agent
- Runs tests and verifies acceptance criteria
- Checks for edge cases and regressions
- Can APPROVE (→Docs) or REJECT (→Dev with feedback)

### 4. Doc Writer Agent
- Updates relevant documentation
- Creates changelog entries
- Transitions story to complete

## State File

Chief Wiggum maintains state in `.chief-wiggum/state.md`:

```yaml
---
active: true
current_story_index: 0
current_stage: dev
stories:
  - id: "US-001"
    status: in_progress
  - id: "US-002"
    status: pending
feedback_history: []
---
```

## Self-Learning

Chief Wiggum learns from mistakes and records patterns to `CLAUDE.md`:

- **Code Review Agent**: Records code patterns after rejections
- **QA Agent**: Records testing patterns after failures
- **Dev Agent**: Reads learnings before implementing

Learnings are stored in `## Chief Wiggum Learnings` section (max 10 entries):
```markdown
## Chief Wiggum Learnings

- **Null check**: Always check `user.settings` before accessing nested props
- **API routes**: Use `withAuth` wrapper for all /api/admin/* endpoints
```

## Blocked Handling

If a story outputs `<promise>BLOCKED</promise>`, Chief Wiggum:
1. Halts all execution immediately
2. Logs the blocker to the state file
3. Removes the state file
4. Reports the blocker to the user

Fix the blocker manually and restart with `/chief-wiggum`.

## Git Integration

- Creates feature branch on startup (gitflow convention)
- Commits after each story: `feat(US-XXX): Story title`
- Review fixes committed as: `fix(US-XXX): Address review feedback`

## For Help

Run `/help` in Claude Code for detailed command reference.
