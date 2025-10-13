---
description: Quick dependency vulnerability scan - check for known vulnerabilities in project dependencies
---

# Dependency Check

Fast scan of dependencies for known vulnerabilities.

## Usage

```
/dependency-check
```

## Execution Flow

1. Launch **dependency-scanner** agent
2. Run security audit tools (npm audit, etc.)
3. Parse and prioritize vulnerabilities
4. Provide fix commands

## Output

- Total vulnerabilities by severity
- Critical and high-priority issues
- Commands to fix
- Outdated packages report

Quick way to check dependency security before releases.
