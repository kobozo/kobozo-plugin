---
description: Detect code duplication across codebase and get refactoring recommendations following DRY principles
---

# Detect Duplication

Scan your codebase for duplicated code blocks and receive actionable refactoring recommendations to eliminate redundancy.

## Usage

```
/detect-duplication [--threshold=3] [--min-lines=5] [--format=html|json]
```

**Examples:**
```
/detect-duplication                          # Default: 3% threshold, 5 min lines
/detect-duplication --threshold=5            # Allow up to 5% duplication
/detect-duplication --min-lines=10           # Detect larger blocks only
/detect-duplication --format=html            # Generate HTML report
```

## Execution Flow

### Phase 1: Duplication Detection
1. Launch **duplication-detector** agent
2. Run jscpd analysis (supports 150+ languages)
3. Optionally query SonarQube MCP server for historical metrics
4. Identify duplicated code blocks:
   - Exact clones (Type 1)
   - Renamed clones (Type 2)
   - Near-miss clones (Type 3)
   - Semantic clones (Type 4)

**Outputs:**
- Duplication percentage
- List of duplicated blocks with locations
- Prioritized refactoring candidates

### Phase 2: Refactoring Recommendations
1. Launch **refactoring-advisor** agent
2. Analyze each duplication cluster
3. Suggest appropriate refactoring strategy:
   - Extract Method
   - Extract Class
   - Introduce Parameter Object
   - Template Method Pattern
   - Strategy Pattern

**Outputs:**
- Step-by-step refactoring guide
- Code examples (before/after)
- Time savings estimates
- Risk assessment

## Detection Thresholds

### Duplication Severity

| Percentage | Status | Action Required |
|------------|--------|-----------------|
| 0-3% | ✅ Excellent | Maintain current quality |
| 3-5% | 🟡 Acceptable | Monitor, plan refactoring |
| 5-10% | 🟠 Needs Attention | Refactor in next sprint |
| >10% | 🔴 Critical | Immediate action required |

### Clone Size Priority

| Lines | Occurrences | Priority | Estimated Savings |
|-------|-------------|----------|-------------------|
| 30+ | 3+ | 🔴 Critical | 4-8 hours/clone |
| 10-30 | 3+ | 🟡 High | 2-4 hours/clone |
| 30+ | 2 | 🟡 High | 2-4 hours/clone |
| 5-10 | 5+ | 🟢 Medium | 1-2 hours/clone |
| 10-30 | 2 | 🟢 Medium | 1-2 hours/clone |
| 5-10 | 2-4 | ⚪ Low | < 1 hour/clone |

## Tools & Configuration

### jscpd Configuration
```json
{
  "threshold": 3,
  "reporters": ["html", "console", "json"],
  "ignore": [
    "**/*.test.ts",
    "**/*.spec.js",
    "**/node_modules/**",
    "**/dist/**",
    "**/*.min.js"
  ],
  "format": [
    "typescript",
    "javascript",
    "python",
    "go",
    "java",
    "csharp"
  ],
  "minLines": 5,
  "minTokens": 50,
  "maxLines": 500,
  "maxSize": "100kb"
}
```

### SonarQube Integration
If SonarQube MCP server is configured:
- Retrieve historical duplication trends
- Compare current vs baseline
- Access duplication density by file
- Check quality gate status

## Report Output

### Console Summary
```
Code Duplication Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Overall Statistics
   Total Files:        247
   Total Lines:        12,450
   Duplicated Lines:   523 (4.2%)
   Duplicated Blocks:  28
   Status:             🟡 Needs Attention

🔴 Critical Issues (3)
   1. Auth logic:      4 locations × 45 lines = 180 duplicated
   2. Validation:      3 locations × 28 lines = 84 duplicated
   3. Data transform:  3 locations × 25 lines = 75 duplicated

📈 Potential Savings
   Time:               12-18 hours of development time saved
   Maintenance:        Reduced by ~30%
   Bug Risk:           Single source of truth reduces errors

💡 Top Recommendations
   1. Extract authentication logic → shared/auth-validator.ts
   2. Create validation utility class
   3. Apply template method pattern for transformations

📄 Detailed report saved to: ./duplication-report.html
```

### HTML Report Structure
```
duplication-report/
├── index.html                    # Overview dashboard
├── duplications/
│   ├── auth-logic.html           # Detailed view per issue
│   ├── validation-logic.html
│   └── data-transform.html
├── refactoring-guide.html        # Step-by-step instructions
└── assets/
    ├── styles.css
    └── charts.js
```

## When to Use

**Regular Quality Checks**:
- Weekly code quality reviews
- Before major refactoring
- Sprint retrospectives
- Technical debt assessment

**CI/CD Integration**:
```yaml
# .github/workflows/code-quality.yml
name: Code Quality Check

on: [pull_request]

jobs:
  duplication-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Detect Duplication
        run: npx jscpd src/ --threshold 3
```

**Pre-Commit Hook**:
```bash
# .husky/pre-commit
npx jscpd src/ --threshold 5 || {
  echo "⚠️ Code duplication exceeds 5% threshold"
  echo "Run /detect-duplication for detailed report"
  exit 1
}
```

## Refactoring Workflow

After running `/detect-duplication`:

1. **Review Report**
   - Prioritize critical duplications
   - Estimate time for each refactoring

2. **Create Branch**
   ```bash
   git checkout -b refactor/eliminate-duplication
   ```

3. **Refactor Incrementally**
   - Start with highest priority
   - Run tests after each change
   - Commit frequently

4. **Verify Improvement**
   ```bash
   # Re-run detection
   /detect-duplication

   # Should show reduced duplication %
   ```

5. **Create Pull Request**
   - Include before/after metrics
   - Link to duplication report
   - Describe refactoring approach

## Best Practices

1. **Rule of Three**
   - First occurrence: Write it
   - Second occurrence: Note it
   - Third occurrence: Refactor it

2. **Don't Over-DRY**
   - Some duplication is acceptable if requirements differ
   - Premature abstraction can be worse than duplication
   - Evaluate coupling vs duplication trade-offs

3. **Continuous Monitoring**
   - Run weekly duplication scans
   - Set quality gates in CI/CD
   - Track duplication trends over time

4. **Team Alignment**
   - Review duplication reports in team meetings
   - Allocate time for refactoring in sprints
   - Celebrate duplication reduction wins

This command helps maintain a DRY (Don't Repeat Yourself) codebase by identifying duplication and guiding systematic elimination through proven refactoring techniques.
