---
name: prd
description: Generate a Product Requirements Document (PRD) for a new feature
arguments:
  - name: description
    description: Brief description of the feature to build
    required: false
  - name: --file
    description: Output file path (default: .chief-wiggum/prd.json)
    required: false
---

# PRD Generator

Generate a PRD JSON file for Chief Wiggum to execute.

## Process

1. **Gather Requirements**: Ask clarifying questions about the feature
2. **Design Stories**: Break into right-sized, sequentially implementable stories
3. **Output JSON**: Write directly to `.chief-wiggum/prd.json` (or specified path)

## Story Sizing Rules

**Each story must be completable in ONE Claude Code context window.**

Right-sized stories:
- Add a database column and migration
- Add a UI component to an existing page
- Update a server action with new logic
- Add a filter dropdown to a list

Too big (split these):
- "Build the entire dashboard" → Split into: schema, queries, UI components, filters
- "Add authentication" → Split into: schema, middleware, login UI, session handling

## Story Ordering

Stories execute in priority order. Earlier stories must not depend on later ones.

Correct order:
1. Schema/database changes (migrations)
2. Server actions / backend logic
3. UI components that use the backend
4. Dashboard/summary views that aggregate data

## Output Format

```json
{
  "project": "[Project Name]",
  "branchName": "feature/[kebab-case-name]",
  "description": "[Feature description]",
  "userStories": [
    {
      "id": "US-001",
      "title": "[Story title]",
      "description": "As a [user], I want [feature] so that [benefit]",
      "acceptanceCriteria": [
        "Criterion 1",
        "Criterion 2",
        "Typecheck passes"
      ],
      "priority": 1
    }
  ]
}
```

## Usage

```bash
/prd "Add user authentication with login and logout"
/prd                                        # Interactive mode
/prd "Feature description" --file tasks/auth-prd.json
```

---

You are now in PRD generation mode. Your task is to create a comprehensive PRD JSON file.

**If a feature description was provided**: Analyze it and ask 2-3 clarifying questions before generating the PRD.

**If no description was provided**: Ask the user to describe what they want to build.

## Clarifying Questions to Consider

1. **Scope**: What's the minimum viable version?
2. **Users**: Who will use this feature?
3. **Existing Code**: What existing patterns should be followed?
4. **Dependencies**: What external services/APIs are involved?
5. **Testing**: Any specific test requirements?

## After Gathering Requirements

1. **Design user stories** following the sizing and ordering rules
2. **Ensure each story** has:
   - Clear title
   - User story format description
   - Verifiable acceptance criteria
   - "Typecheck passes" as a criterion
3. **Write the JSON file** to the output path
4. **Save the path** to `.chief-wiggum/current-prd` for auto-detection:
   ```bash
   mkdir -p .chief-wiggum
   echo "/full/path/to/prd.json" > .chief-wiggum/current-prd
   ```

## Output Path

- Default: `.chief-wiggum/prd.json`
- Custom: Use `--file` argument
- Arguments provided: $ARGUMENTS

Begin by understanding what the user wants to build, then generate the PRD JSON.
