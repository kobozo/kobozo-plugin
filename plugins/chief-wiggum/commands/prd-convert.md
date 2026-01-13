---
name: prd-convert
description: Convert a PRD markdown file to prd.json format for Chief Wiggum execution
arguments:
  - name: file
    description: Path to PRD markdown file to convert
    required: true
  - name: --output
    description: Output JSON file path (default: .chief-wiggum/prd.json)
    required: false
---

# PRD to JSON Converter

Converts existing PRDs to the prd.json format that Chief Wiggum uses for autonomous execution.

## Usage

```bash
/prd-convert docs/feature-prd.md                              # Output to .chief-wiggum/prd.json
/prd-convert docs/feature-prd.md --output tasks/auth.json     # Output to custom file
```

## Output Format

```json
{
  "project": "[Project Name]",
  "branchName": "feature/[feature-name-kebab-case]",
  "description": "[Feature description from PRD title/intro]",
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

## Story Sizing Rule

**Each story must be completable in ONE Claude Code context window.**

Right-sized stories:
- Add a database column and migration
- Add a UI component to an existing page
- Update a server action with new logic

Too big (split these):
- "Build the entire dashboard" → Split into: schema, queries, UI, filters
- "Add authentication" → Split into: schema, middleware, login UI, sessions

## Story Ordering

Stories execute in priority order. Earlier stories must not depend on later ones.

1. Schema/database changes (migrations)
2. Server actions / backend logic
3. UI components that use the backend
4. Dashboard/summary views

## Conversion Rules

1. Each user story becomes one JSON entry
2. IDs: Sequential (US-001, US-002, etc.)
3. Priority: Based on dependency order, then document order
4. **Always add**: "Typecheck passes" to every story's acceptance criteria
5. **branchName**: Derive from feature name, kebab-case, prefixed with `feature/`

## After Writing

Save the output path for auto-detection:
```bash
mkdir -p .chief-wiggum
echo "/full/path/to/output.json" > .chief-wiggum/current-prd
```

---

**Arguments provided**: $ARGUMENTS

Read the markdown PRD file, analyze its user stories, and convert them to the JSON format following the rules above. Write the output JSON file and save the path to `.chief-wiggum/current-prd`.
