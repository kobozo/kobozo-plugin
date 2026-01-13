---
name: help
description: Explain Ralph Loop plugin and available commands
---

# Chief Wiggum - PRD Story Orchestrator

Chief Wiggum executes user stories from a PRD JSON file autonomously. Each story runs through the full multi-agent workflow:

```
Dev → Code Review → QA → Docs → Next Story
```

## Commands

| Command | Description |
|---------|-------------|
| `/chief-wiggum [file]` | Execute all stories from PRD file |
| `/cancel-chief-wiggum` | Cancel the active loop |
| `/prd [description]` | Generate a new PRD JSON file |
| `/prd-convert <file>` | Convert markdown PRD to JSON |

## Workflow

1. **Setup**: `/chief-wiggum .chief-wiggum/prd.json` loads stories and starts loop
2. **Dev Agent**: Implements the current story
3. **Code Review Agent**: Reviews code (can reject → back to Dev)
4. **QA Agent**: Tests functionality (can reject → back to Dev)
5. **Doc Writer Agent**: Updates documentation
6. **Advancement**: Automatically moves to next story
7. **Completion**: Exits when all stories done or BLOCKED

## PRD JSON Format

```json
{
  "project": "Feature Name",
  "branchName": "feature/name",
  "userStories": [
    {
      "id": "US-001",
      "title": "Story Title",
      "description": "As a user...",
      "acceptanceCriteria": ["..."],
      "priority": 1
    }
  ]
}
```

## Monitoring

- State file: `.chief-wiggum/state.md`
- View progress: `head -50 .chief-wiggum/state.md`

## Quick Start

```bash
# Create PRD interactively
/prd "Add user authentication"

# Or convert existing PRD
/prd-convert docs/my-feature.md

# Execute stories
/chief-wiggum

# Cancel if needed
/cancel-chief-wiggum
```
