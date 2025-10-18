# Security Auditor

> Comprehensive security analysis plugin for Claude Code - scan for vulnerabilities, check dependencies, and validate authentication/authorization implementations.

**Version:** 1.0.0
**Author:** Yannick De Backer (yannick@kobozo.eu)

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Commands](#commands)
  - [security-audit](#security-audit)
  - [dependency-check](#dependency-check)
- [Agents](#agents)
  - [code-security-analyzer](#code-security-analyzer)
  - [dependency-scanner](#dependency-scanner)
  - [auth-reviewer](#auth-reviewer)
- [Security Vulnerabilities Detected](#security-vulnerabilities-detected)
- [Severity Levels](#severity-levels)
- [Workflow & Phases](#workflow--phases)
- [Output Examples](#output-examples)
- [Best Practices](#best-practices)
- [Integration & Automation](#integration--automation)

---

## Overview

The **Security Auditor** plugin provides comprehensive security analysis for your codebase. It combines automated dependency scanning, static code analysis, and authentication/authorization review to identify vulnerabilities before they reach production.

This plugin is designed for:
- Security engineers performing code reviews
- Development teams implementing security best practices
- DevOps teams integrating security into CI/CD pipelines
- Organizations maintaining compliance with security standards (OWASP, GDPR, PCI DSS)

## Key Features

- **Multi-layer Security Analysis**: Dependency scanning, code analysis, and auth review
- **Multiple Language Support**: Node.js, Python, Ruby, Go, Rust, Java, .NET, PHP
- **Industry Standards**: Aligned with OWASP Top 10 and security best practices
- **Actionable Reports**: Clear severity levels with remediation guidance
- **Fast Targeted Scans**: Quick dependency checks or comprehensive audits
- **CI/CD Ready**: Designed for automated security testing

---

## Installation

### Prerequisites

- Claude Code CLI installed
- Project with source code to audit

### Install Plugin

```bash
# Clone the plugin repository
git clone https://github.com/kobozo/kobozo-plugins.git

# Claude Code will automatically detect plugins in the ./plugins directory
cd your-project
```

### Verify Installation

```bash
# List available commands
/help
```

You should see `/security-audit` and `/dependency-check` in the available commands.

---

## Commands

### security-audit

Performs a comprehensive security audit of your entire codebase.

**Usage:**

```bash
/security-audit
```

**What it does:**

This command runs a complete security analysis in four phases:

1. **Dependency Scanning** - Identifies vulnerable packages
2. **Code Analysis** - Detects security vulnerabilities in source code
3. **Authentication Review** - Validates auth/authz implementations
4. **Consolidated Report** - Combines findings with prioritized remediation roadmap

**When to use:**

- Before major releases
- After significant code changes
- As part of security compliance audits
- During security-focused sprints
- Regularly in development (weekly/monthly)

**Output includes:**

- Critical issues requiring immediate action
- High-priority vulnerabilities with impact assessment
- Security best practices recommendations
- Compliance notes (OWASP, GDPR, PCI DSS)
- Prioritized remediation roadmap

---

### dependency-check

Fast scan of project dependencies for known vulnerabilities.

**Usage:**

```bash
/dependency-check
```

**What it does:**

Quickly scans your project dependencies using security audit tools (npm audit, pip-audit, etc.) and reports vulnerabilities with fix commands.

**When to use:**

- Quick pre-commit checks
- Before releases
- After updating dependencies
- CI/CD pipeline integration
- Daily development workflow

**Output includes:**

- Total vulnerabilities by severity
- Critical and high-priority issues
- Commands to fix vulnerabilities
- Outdated packages report
- Direct vs. transitive dependency paths

---

## Agents

The Security Auditor plugin uses three specialized agents that work together to provide comprehensive security analysis.

### code-security-analyzer

**Role:** Static code analysis for security vulnerabilities

**Model:** Sonnet
**Tools:** Glob, Grep, Read, TodoWrite
**Color:** Orange

**Analyzes:**

- SQL injection vulnerabilities
- Cross-site scripting (XSS)
- Authentication/authorization flaws
- Insecure cryptography
- Sensitive data exposure
- Security misconfigurations
- Command injection
- Path traversal
- Hardcoded secrets
- Insecure randomness
- Unvalidated redirects

**Scanning strategy:**

1. **High-Risk File Patterns**: Identifies files handling auth, database, user input, file operations
2. **Pattern Detection**: Searches for vulnerable code patterns using regex
3. **Code Review**: Deep analysis of suspicious code sections

---

### dependency-scanner

**Role:** Dependency vulnerability scanning and remediation guidance

**Model:** Sonnet
**Tools:** Bash, Read, TodoWrite, WebFetch
**Color:** Red

**Supports:**

- **Node.js**: npm, yarn, pnpm
- **Python**: pip, poetry
- **Ruby**: bundler
- **Java**: Maven, Gradle
- **Go**: go mod
- **Rust**: cargo
- **.NET**: NuGet
- **PHP**: Composer

**Workflow:**

1. **Detect Package Manager**: Identifies lock files
2. **Run Security Audits**: Executes appropriate audit tools
3. **Parse Reports**: Extracts vulnerability details
4. **Assess Severity**: Categorizes by risk level
5. **Provide Remediation**: Generates fix commands

**Output includes:**

- CVE identifiers for each vulnerability
- Current vs. fixed versions
- Direct vs. transitive dependency paths
- Breaking change warnings
- Auto-fix commands

---

### auth-reviewer

**Role:** Authentication and authorization security review

**Model:** Sonnet
**Tools:** Glob, Grep, Read, TodoWrite
**Color:** Blue

**Reviews:**

1. **Password Security**
   - Hashing algorithms (bcrypt, argon2, scrypt)
   - Salt usage
   - Work factors
   - Password requirements

2. **Session Management**
   - Secure cookies (httpOnly, secure, sameSite)
   - Session expiration
   - Session regeneration
   - Logout invalidation

3. **Token Security**
   - JWT implementation
   - Secret management
   - Expiration times
   - Signature verification

4. **Authorization Checks**
   - Access control on routes
   - Role-based access control (RBAC)
   - Resource ownership validation
   - Privilege escalation prevention

5. **Multi-Factor Authentication**
   - TOTP implementation
   - Backup codes
   - Rate limiting

6. **OAuth/SSO Integration**
   - State parameter validation
   - Token signature verification
   - PKCE for public clients
   - Redirect URI validation

---

## Security Vulnerabilities Detected

### 1. SQL Injection

**Pattern:** String concatenation in SQL queries

**Vulnerable:**
```javascript
const query = `SELECT * FROM users WHERE id = ${userId}`;
db.execute(query);
```

**Secure:**
```javascript
const query = 'SELECT * FROM users WHERE id = ?';
db.execute(query, [userId]);
```

---

### 2. Cross-Site Scripting (XSS)

**Pattern:** Unescaped user input in HTML

**Vulnerable:**
```javascript
element.innerHTML = userInput;
```

**Secure:**
```javascript
element.textContent = userInput;
// or use DOMPurify.sanitize()
```

---

### 3. Hardcoded Secrets

**Pattern:** API keys, passwords in source code

**Vulnerable:**
```javascript
const API_KEY = 'sk_live_abc123...';
const PASSWORD = 'admin123';
```

**Secure:**
```javascript
const API_KEY = process.env.API_KEY;
```

---

### 4. Insecure Cryptography

**Pattern:** Weak hashing algorithms, no salt

**Vulnerable:**
```javascript
const hash = crypto.createHash('md5').update(password).digest('hex');
```

**Secure:**
```javascript
const hash = await bcrypt.hash(password, 12);
```

---

### 5. Path Traversal

**Pattern:** User input in file paths without validation

**Vulnerable:**
```javascript
const file = req.query.file;
fs.readFile(`./uploads/${file}`);
```

**Secure:**
```javascript
const file = path.basename(req.query.file);
fs.readFile(path.join('./uploads', file));
```

---

### 6. Command Injection

**Pattern:** User input in shell commands

**Vulnerable:**
```javascript
import { exec } from 'child_process';
exec(`ls ${userInput}`); // Dangerous!
```

**Secure:**
```javascript
import { execFile } from 'child_process';
execFile('ls', [userInput]); // Safe - no shell interpretation
```

---

### 7. Insecure Randomness

**Pattern:** Math.random() for security-sensitive operations

**Vulnerable:**
```javascript
const token = Math.random().toString(36);
```

**Secure:**
```javascript
const token = crypto.randomBytes(32).toString('hex');
```

---

### 8. Unvalidated Redirects

**Pattern:** User-controlled redirect URLs

**Vulnerable:**
```javascript
res.redirect(req.query.url);
```

**Secure:**
```javascript
const allowedDomains = ['example.com', 'trusted.com'];
const url = new URL(req.query.url);
if (allowedDomains.includes(url.hostname)) {
  res.redirect(req.query.url);
}
```

---

### 9. Weak Password Hashing

**Patterns to detect:**
- MD5, SHA1, SHA256 for passwords
- Missing salt
- Low work factors

**Secure approach:**
- bcrypt with work factor 12+
- argon2 with appropriate parameters
- scrypt with proper configuration

---

### 10. Missing Authorization

**Pattern:** No access control checks on protected resources

**Vulnerable:**
```javascript
app.get('/api/users/:id', (req, res) => {
  const user = db.getUser(req.params.id); // Anyone can access
  res.json(user);
});
```

**Secure:**
```javascript
app.get('/api/users/:id', authenticateUser, (req, res) => {
  if (req.user.id !== req.params.id && !req.user.isAdmin) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  const user = db.getUser(req.params.id);
  res.json(user);
});
```

---

## Severity Levels

The Security Auditor uses a four-level severity classification system:

### Critical

**Risk:** Immediate exploitation possible, severe impact

**Examples:**
- Remote code execution
- SQL injection in authentication
- Authentication bypass
- Privilege escalation
- Exposed production secrets

**Action:** Fix immediately (same day)

---

### High

**Risk:** High likelihood of exploitation, significant impact

**Examples:**
- Cross-site scripting (XSS)
- Denial of service vulnerabilities
- Information disclosure
- Insecure cryptography
- Session management flaws

**Action:** Fix soon (within 1 week)

---

### Medium

**Risk:** Moderate likelihood or impact

**Examples:**
- Less severe vulnerabilities
- Security best practices violations
- Missing rate limiting
- Weak password requirements
- CORS misconfigurations

**Action:** Address in next update (within sprint)

---

### Low

**Risk:** Minimal security impact

**Examples:**
- Minor information disclosure
- Informational findings
- Best practice recommendations
- Code quality issues with security implications

**Action:** Monitor and address as time permits

---

## Workflow & Phases

### Phase 1: Dependency Scanning

**Agent:** dependency-scanner

**Steps:**
1. Detect package manager (npm, pip, cargo, etc.)
2. Run security audit tools
3. Parse vulnerability reports
4. Extract CVE details and severity
5. Generate fix commands

**Output:**
- Vulnerable packages with CVE IDs
- Current vs. fixed versions
- Direct vs. transitive dependencies
- Auto-fix commands

---

### Phase 2: Code Analysis

**Agent:** code-security-analyzer

**Steps:**
1. Identify high-risk files (auth, database, input handling)
2. Search for vulnerable code patterns
3. Deep analysis of suspicious code
4. Assess impact and exploitability
5. Generate remediation guidance

**Output:**
- Vulnerability locations (file:line)
- Vulnerable code snippets
- Impact assessment
- Secure code examples

---

### Phase 3: Authentication Review

**Agent:** auth-reviewer

**Steps:**
1. Locate authentication code
2. Review password hashing
3. Analyze session management
4. Check authorization logic
5. Validate token security
6. Assess OAuth/SSO implementations

**Output:**
- Authentication vulnerabilities
- Authorization flaws
- Best practice violations
- Compliance gaps

---

### Phase 4: Consolidated Report

**Steps:**
1. Combine findings from all agents
2. Remove duplicates
3. Prioritize by severity and impact
4. Generate remediation roadmap
5. Add compliance notes

**Output:**
- Executive summary
- Critical issues (fix first)
- Prioritized remediation plan
- Compliance status
- Long-term recommendations

---

## Output Examples

### Dependency Check Output

```markdown
# Dependency Security Scan

## Summary
- **Total Vulnerabilities**: 12
- **Critical**: 2
- **High**: 4
- **Medium**: 5
- **Low**: 1

## Critical Vulnerabilities (Fix Immediately)

### 1. lodash - Prototype Pollution
- **Package**: lodash
- **Current Version**: 4.17.15
- **Fixed In**: 4.17.21
- **Severity**: Critical
- **CVE**: CVE-2020-8203
- **Description**: Prototype pollution vulnerability allows attackers to modify object properties
- **Path**: Direct dependency
- **Fix**:
  ```bash
  npm install lodash@4.17.21
  ```

### 2. jsonwebtoken - Authentication Bypass
- **Package**: jsonwebtoken
- **Current Version**: 8.5.0
- **Fixed In**: 9.0.0
- **Severity**: Critical
- **CVE**: CVE-2022-23529
- **Description**: Signature verification bypass in JWT library
- **Path**: Direct dependency
- **Fix**:
  ```bash
  npm install jsonwebtoken@9.0.0
  ```
  **Note**: Breaking changes - review migration guide

## Commands to Fix

```bash
# Fix all auto-fixable vulnerabilities
npm audit fix

# Force fix (may introduce breaking changes)
npm audit fix --force

# Update specific packages
npm install lodash@4.17.21 jsonwebtoken@9.0.0
```
```

---

### Code Security Analysis Output

```markdown
# Code Security Analysis

## Summary
- **Critical Issues**: 3
- **High Risk**: 7
- **Medium Risk**: 12
- **Low Risk**: 5

## Critical Issues (Fix Immediately)

### 1. SQL Injection in User Login
- **File**: `src/auth/login.ts:45`
- **Severity**: Critical
- **Issue**: Unsanitized user input in SQL query
- **Code**:
  ```typescript
  const query = `SELECT * FROM users WHERE email = '${email}' AND password = '${password}'`;
  ```
- **Impact**: Attackers can bypass authentication or access all database data
- **Fix**: Use parameterized queries
  ```typescript
  const query = 'SELECT * FROM users WHERE email = ? AND password = ?';
  db.execute(query, [email, hashedPassword]);
  ```

### 2. Hardcoded API Key
- **File**: `src/config/api.ts:12`
- **Severity**: Critical
- **Issue**: API key committed to source control
- **Code**:
  ```typescript
  export const STRIPE_KEY = 'sk_live_abc123def456...';
  ```
- **Impact**: Anyone with repo access has production API keys
- **Fix**:
  1. Rotate the exposed key immediately
  2. Use environment variables
  3. Add to .env.example (not .env)
```

---

### Authentication Review Output

```markdown
# Authentication & Authorization Review

## Summary
- **Critical Issues**: 2
- **High Risk**: 5
- **Medium Risk**: 8
- **Compliant**: 12

## Critical Issues

### 1. Weak Password Hashing
- **File**: `src/auth/password.ts:23`
- **Issue**: Using SHA-256 instead of bcrypt
- **Risk**: Passwords vulnerable to rainbow table attacks
- **Fix**: Migrate to bcrypt with work factor 12

### 2. Missing Authorization Check
- **File**: `src/api/users.ts:45`
- **Issue**: No authorization check on user data endpoint
- **Risk**: Users can access other users' data (IDOR)
- **Fix**: Add ownership or admin check

## Best Practices Recommendations

1. Implement rate limiting on login (prevent brute force)
2. Add account lockout after failed attempts
3. Require password change on suspicious activity
4. Log authentication events
5. Consider MFA for admin accounts

## Compliance Notes

- **OWASP Top 10**: Address Broken Authentication (#2) and Broken Access Control (#1)
- **GDPR**: Ensure proper access controls for personal data
- **PCI DSS**: If handling payments, review token security
```

---

## Best Practices

### Regular Security Scanning

**Recommended schedule:**
- **Daily**: Quick dependency checks before commits
- **Weekly**: Full security audits during development
- **Pre-release**: Comprehensive audit before each release
- **Post-incident**: After security incidents or breaches
- **Quarterly**: Security compliance reviews

---

### Prioritization Strategy

1. **Critical vulnerabilities**: Fix immediately (same day)
2. **High-priority issues**: Address within 1 week
3. **Medium-priority issues**: Fix in next sprint
4. **Low-priority issues**: Address during regular maintenance

---

### Testing After Fixes

Always test after applying security fixes:

```bash
# Run tests
npm test

# Check for breaking changes
npm run build

# Manual testing of affected features
```

---

### Documentation

Document security decisions:

- Why certain fixes were deferred
- Alternative mitigations applied
- Risk acceptance for known issues
- Security exceptions and their justification

---

### Prevention

**Proactive security measures:**

1. **Code review**: Security-focused peer reviews
2. **Training**: Regular security training for developers
3. **Standards**: Establish secure coding guidelines
4. **Automation**: Integrate security checks in CI/CD
5. **Monitoring**: Track security metrics over time

---

## Integration & Automation

### CI/CD Integration

**GitHub Actions example:**

```yaml
name: Security Audit

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 0 * * 1' # Weekly on Monday

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Run dependency audit
        run: npm audit --audit-level=high

      - name: Run Claude Code security audit
        run: claude-code /security-audit
        continue-on-error: true

      - name: Upload security report
        uses: actions/upload-artifact@v3
        with:
          name: security-report
          path: security-report.md
```

---

### Pre-commit Hooks

**Using Husky:**

```json
{
  "husky": {
    "hooks": {
      "pre-commit": "npm audit --audit-level=high"
    }
  }
}
```

---

### Automated Dependency Updates

**Dependabot configuration (.github/dependabot.yml):**

```yaml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
    reviewers:
      - "security-team"
```

---

### Security Metrics Dashboard

Track security improvements over time:

- Number of vulnerabilities by severity
- Time to remediation
- Dependency freshness
- Security audit pass rate
- Coverage of security tests

---

## Troubleshooting

### Common Issues

**Issue:** Audit tools not found

**Solution:**
```bash
# Install npm audit (included with npm 6+)
npm install -g npm

# Install pip-audit
pip install pip-audit

# Install cargo-audit
cargo install cargo-audit
```

---

**Issue:** False positives

**Solution:**
- Review the specific vulnerability details
- Check if your code actually uses the vulnerable functionality
- Document decisions to defer fixes
- Consider alternative packages

---

**Issue:** Breaking changes after updates

**Solution:**
- Review package changelogs before updating
- Test in development environment first
- Use semantic versioning to understand impact
- Consider gradual rollout

---

## See Also

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [npm audit documentation](https://docs.npmjs.com/cli/v8/commands/npm-audit)
- [NIST National Vulnerability Database](https://nvd.nist.gov/)
- [Common Weakness Enumeration (CWE)](https://cwe.mitre.org/)
- [CVE Details](https://www.cvedetails.com/)

---

## Contributing

Found a security vulnerability pattern we're missing? Have ideas for improving the plugin?

- Open an issue on GitHub
- Submit a pull request
- Contact: yannick@kobozo.eu

---

## License

Copyright (c) 2025 Yannick De Backer

---

## Support

- **Email**: yannick@kobozo.eu
- **GitHub Issues**: [kobozo-plugins/issues](https://github.com/kobozo/kobozo-plugins/issues)
- **Documentation**: This README and inline command help

---

**Remember:** Security is an ongoing process, not a one-time task. Run regular audits, stay informed about new vulnerabilities, and continuously improve your security posture.
