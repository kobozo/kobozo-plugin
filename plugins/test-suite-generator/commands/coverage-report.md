---
description: Analyze test coverage and identify untested code paths that need attention
---

# Coverage Report

Generates comprehensive test coverage analysis with actionable recommendations.

## Usage

```
/coverage-report
```

## Execution Flow

### Phase 1: Run Coverage
1. Launch **coverage-analyzer** agent
2. Execute coverage tools (Jest, pytest, etc.)
3. Parse coverage reports

### Phase 2: Analysis
1. Identify untested code
2. Prioritize by criticality
3. Calculate coverage metrics

### Phase 3: Recommendations
1. List files needing tests
2. Suggest testing priorities
3. Set coverage goals
4. Provide commands to improve

## Output

- Overall coverage percentage
- Uncovered critical code
- Prioritized recommendations
- Actionable next steps

Use this regularly to maintain high test quality.
