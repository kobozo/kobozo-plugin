---
description: Comprehensive security audit - scans dependencies, analyzes code for vulnerabilities, and reviews authentication/authorization
---

# Security Audit

Performs comprehensive security analysis of your codebase.

## Usage

```
/security-audit
```

## Execution Flow

### Phase 1: Dependency Scanning
1. Launch **dependency-scanner** agent
2. Run npm audit, pip-audit, etc.
3. Identify vulnerable packages
4. Report critical dependencies

### Phase 2: Code Analysis
1. Launch **code-security-analyzer** agent
2. Scan for SQL injection, XSS, command injection
3. Find hardcoded secrets
4. Detect insecure cryptography

### Phase 3: Auth Review
1. Launch **auth-reviewer** agent
2. Review password hashing
3. Check session management
4. Validate authorization logic

### Phase 4: Consolidated Report
1. Combine findings from all agents
2. Prioritize by severity
3. Provide remediation roadmap

## Output

- Critical issues requiring immediate action
- High-priority vulnerabilities
- Security best practices recommendations
- Compliance notes (OWASP, GDPR, etc.)

Run before releases and regularly in development.
