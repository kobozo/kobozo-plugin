---
description: Update existing API documentation when endpoints change - rescans codebase and updates OpenAPI specs and docs
---

# Update API Documentation

Updates existing API documentation to reflect code changes.

## Usage

```
/update-api-docs
```

## Execution Flow

1. Check if docs exist (docs/openapi.yaml, docs/api/)
2. Rescan codebase for endpoints (api-scanner)
3. Compare with existing OpenAPI spec
4. Show diff of changes
5. Update OpenAPI spec (openapi-generator)
6. Update markdown docs (docs-writer)
7. Report what changed

## Important

- Preserves custom edits where possible
- Shows what will change before updating
- Keeps documentation in sync with code

Use this command regularly to maintain accurate API documentation.
