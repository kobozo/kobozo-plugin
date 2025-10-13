---
description: Generate comprehensive test suites for your code - unit tests, integration tests, with edge cases and mocking
---

# Generate Tests

Orchestrates test generation for specified files or modules.

## Usage

```
/generate-tests [file-or-module]
```

Examples:
- `/generate-tests src/services/userService.ts`
- `/generate-tests src/api/users`

## Execution Flow

### Phase 1: Planning
1. Launch **test-strategy-planner** agent if no tests exist
2. Get recommendations for testing approach
3. Confirm strategy with user

### Phase 2: Test Generation
1. Launch **test-generator** agent with target file/module
2. Agent analyzes code and generates tests
3. Tests include:
   - Happy paths
   - Edge cases
   - Error scenarios
   - Mocks for dependencies

### Phase 3: Review & Run
1. Show generated tests to user
2. Run tests to verify they pass
3. Report coverage for new tests

## Best Practices

- Generate tests for new features before merging
- Use with `/coverage-report` to identify gaps
- Review generated tests for quality
- Customize as needed for your use case

Your goal is to make test writing effortless and comprehensive.
