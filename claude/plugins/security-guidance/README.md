# Security Guidance

**Version:** 1.0.0
**Author:** David Dworken (Anthropic)
**Type:** Official Claude Code Plugin

> This is an **official Claude Code plugin** from Anthropic, synced from the official Claude Code plugins repository.

## Overview

The security-guidance plugin provides real-time security warnings when editing or writing files in Claude Code. It acts as a security guard that watches for potentially dangerous code patterns and warns you before you commit security vulnerabilities.

## Table of Contents

- [Features](#features)
- [How It Works](#how-it-works)
- [Installation](#installation)
- [Security Checks](#security-checks)
- [When Warnings Appear](#when-warnings-appear)
- [Examples](#examples)
- [Best Practices](#best-practices)
- [Configuration](#configuration)

## Features

- **Proactive Security Warnings**: Alerts appear before potentially dangerous code is written
- **Pattern Detection**: Identifies common security anti-patterns (XSS, command injection, etc.)
- **Context-Aware**: Analyzes file types and code context
- **Non-Blocking**: Warnings don't prevent actions, just inform you
- **Hook-Based**: Uses Claude Code's pre-tool-use hook system
- **Zero Configuration**: Works automatically once installed

## How It Works

This plugin implements a **PreToolUse hook** that intercepts `Edit`, `Write`, and `MultiEdit` tool calls. Before Claude writes or modifies code, the security hook:

1. Analyzes the content being written
2. Checks for security-sensitive patterns
3. Examines the file type and context
4. Generates warnings if potential issues detected
5. Presents warnings to the user
6. Allows the operation to proceed (warnings are informational)

### Hook Architecture

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "python3 ${CLAUDE_PLUGIN_ROOT}/hooks/security_reminder_hook.py"
          }
        ]
      }
    ]
  }
}
```

The hook triggers on:
- **Edit**: When modifying existing files
- **Write**: When creating new files
- **MultiEdit**: When modifying multiple files

## Installation

This plugin is part of the official Claude plugins. If you have it synced in your marketplace:

```bash
/plugin install security-guidance@kobozo-plugins
```

Once installed, it works automatically with no additional configuration needed.

## Security Checks

The plugin watches for various security issues:

### Command Injection

Warns when detecting potential command injection vulnerabilities:

```javascript
// WARNING: Potential command injection
const result = exec(`git commit -m "${userInput}"`);

// Better
const result = execFile('git', ['commit', '-m', userInput]);
```

### Cross-Site Scripting (XSS)

Alerts when user input might be rendered unsafely:

```javascript
// WARNING: Potential XSS
element.innerHTML = userInput;

// Better
element.textContent = userInput;
// or
element.innerHTML = DOMPurify.sanitize(userInput);
```

### SQL Injection

Detects string concatenation in SQL queries:

```javascript
// WARNING: Potential SQL injection
const query = `SELECT * FROM users WHERE id = ${userId}`;

// Better
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

### Path Traversal

Warns about unsafe file path handling:

```javascript
// WARNING: Path traversal risk
const filePath = `/uploads/${userFilename}`;
fs.readFile(filePath);

// Better
const filePath = path.join('/uploads', path.basename(userFilename));
fs.readFile(filePath);
```

### Hardcoded Secrets

Alerts when secrets appear in code:

```javascript
// WARNING: Hardcoded secret
const API_KEY = "sk-1234567890abcdef";

// Better
const API_KEY = process.env.API_KEY;
```

### Insecure Randomness

Warns about weak random number generation for security:

```javascript
// WARNING: Insecure randomness for security
const token = Math.random().toString(36);

// Better
const crypto = require('crypto');
const token = crypto.randomBytes(32).toString('hex');
```

### Unsafe Deserialization

Detects potentially unsafe deserialization:

```python
# WARNING: Unsafe deserialization
import pickle
data = pickle.loads(user_input)

# Better
import json
data = json.loads(user_input)
```

### Missing Input Validation

Warns when user input is used without validation:

```javascript
// WARNING: Missing input validation
app.post('/user', (req, res) => {
  createUser(req.body);
});

// Better
app.post('/user', (req, res) => {
  const validated = validateUserInput(req.body);
  if (validated.isValid) {
    createUser(validated.data);
  }
});
```

## When Warnings Appear

Warnings appear when you:

1. **Edit files** containing security-sensitive code
2. **Write new files** with potential vulnerabilities
3. **Modify multiple files** in ways that could introduce security issues

### Warning Format

```
SECURITY WARNING: Potential XSS vulnerability detected

File: src/components/UserProfile.tsx
Line: 45
Issue: User input rendered directly to innerHTML

Recommendation:
- Use textContent instead of innerHTML
- Or sanitize with DOMPurify.sanitize()
- Consider using a safe templating library

This is a reminder to review security implications.
You can proceed, but please ensure this is intentional and safe.
```

## Examples

### Example 1: Command Injection Warning

```typescript
// You write:
const execCommand = (userCmd: string) => {
  return exec(`ls ${userCmd}`);
};

// Warning appears:
// SECURITY WARNING: Command Injection Risk
// This code may be vulnerable to command injection.
// Consider using execFile() with array arguments instead.
```

### Example 2: XSS Warning

```typescript
// You write:
const renderComment = (comment: string) => {
  document.getElementById('comment').innerHTML = comment;
};

// Warning appears:
// SECURITY WARNING: XSS Vulnerability
// User content rendered via innerHTML without sanitization.
// Use textContent or DOMPurify.sanitize().
```

### Example 3: SQL Injection Warning

```python
# You write:
def get_user(user_id):
    query = f"SELECT * FROM users WHERE id = {user_id}"
    return db.execute(query)

# Warning appears:
# SECURITY WARNING: SQL Injection
# Query uses string formatting with user input.
# Use parameterized queries instead.
```

### Example 4: Hardcoded Secret Warning

```javascript
// You write:
const config = {
  apiKey: 'sk-prod-1234567890',
  secretKey: 'my-secret-key'
};

// Warning appears:
// SECURITY WARNING: Hardcoded Secrets
// Secrets should not be committed to version control.
// Use environment variables or a secrets manager.
```

## Best Practices

### Responding to Warnings

1. **Read the Warning**: Understand what security issue is being flagged
2. **Assess the Context**: Is this actually a vulnerability in your use case?
3. **Apply the Fix**: If it's a real issue, use the recommended secure alternative
4. **Document If Intentional**: If the pattern is safe in your context, add a comment explaining why

### Example Response Workflow

```javascript
// Warning: Potential XSS
// Response: This is admin-only content from trusted source
// Documentation:
/**
 * SECURITY NOTE: This content comes from admin-uploaded templates
 * which are sanitized during upload. Direct innerHTML is safe here
 * because content source is trusted and pre-validated.
 */
element.innerHTML = trustedAdminContent;
```

### When to Ignore Warnings

It's okay to proceed despite warnings when:

- The input source is fully trusted (internal, validated elsewhere)
- You're using additional security layers not visible in the code
- The code is in a test/development context only
- You've reviewed and documented why the pattern is safe

### When to Fix Immediately

Always fix warnings when:

- User input is involved
- The code handles authentication or authorization
- Sensitive data (passwords, tokens, PII) is processed
- The code runs in production
- You're unsure if it's actually safe

## Configuration

The plugin requires no configuration and works automatically.

However, you can:

### Temporarily Disable

If needed, you can temporarily disable by uninstalling:

```bash
/plugin uninstall security-guidance
```

### Re-enable

```bash
/plugin install security-guidance@kobozo-plugins
```

### View Hook Details

The hook configuration is in:
```
claude/plugins/security-guidance/hooks/hooks.json
```

The security checker script is:
```
claude/plugins/security-guidance/hooks/security_reminder_hook.py
```

## Understanding False Positives

The hook uses pattern matching, which can sometimes produce false positives:

### Common False Positives

1. **Test Code**: Security warnings in test files that don't run in production
2. **Documentation**: Code examples in comments or docs
3. **Already-Sanitized**: Input that was sanitized earlier in the call chain
4. **Internal Tools**: Scripts that only run locally with trusted input

### Handling False Positives

If you frequently get false positives for specific patterns:

1. **Add Comments**: Document why the pattern is safe
2. **Refactor**: Make the security properties more obvious in the code
3. **Report**: If it's a common false positive, report it to Anthropic

## Security Principles

This plugin promotes these security principles:

1. **Defense in Depth**: Multiple layers of security
2. **Least Privilege**: Minimize access and permissions
3. **Input Validation**: Always validate and sanitize user input
4. **Secure by Default**: Use secure patterns as the default choice
5. **Fail Securely**: When errors occur, fail in a secure state

## Tips

### Tip 1: Use With Security Auditor Plugin

Combine with the security-auditor plugin for comprehensive security:

```bash
# Install both
/plugin install security-guidance@kobozo-plugins
/plugin install security-auditor@kobozo-plugins

# security-guidance: Real-time warnings while coding
# security-auditor: Comprehensive project-wide security audit
```

### Tip 2: Review Before Committing

Before committing, review any security warnings you saw:

```bash
# Review what you changed
git diff

# Were there security warnings?
# Did you address them or document why they're safe?

# Then commit
/commit
```

### Tip 3: Team Standards

Establish team standards for handling warnings:

```markdown
## Team Security Standards

1. Never ignore warnings on user-facing code
2. Document why security patterns are safe when used
3. Prefer secure alternatives even if warning is false positive
4. Code review focuses on any security-flagged changes
```

### Tip 4: Learning Tool

Use warnings as learning opportunities:

- Research why the pattern is insecure
- Learn the secure alternative
- Understand the attack vector
- Share knowledge with team

## Related Plugins

- **security-auditor**: Comprehensive security audits
- **data-privacy-manager**: GDPR and privacy compliance
- **clean-code-checker**: Code quality and smell detection

## Support

This is an official Anthropic plugin synced from the official Claude Code plugins repository.

For issues or questions:
- Check official Claude Code documentation
- Report issues to Anthropic support channels

---

**Plugin Type:** Official Anthropic Plugin
**Synced From:** Official Claude Code Plugins Repository
**Purpose:** Real-time security guidance for defensive coding
