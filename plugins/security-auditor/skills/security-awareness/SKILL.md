---
name: Security Awareness
description: This skill should be used when the user asks to "security audit", "check vulnerabilities", "scan dependencies", "review security", "check for security issues", "audit code security", or when writing code that handles user input, authentication, authorization, database queries, file operations, external API calls, cryptography, or any security-sensitive functionality. Provides OWASP Top 10 awareness, secure coding patterns, and vulnerability prevention guidance. Apply this knowledge proactively when writing or reviewing code.
version: 1.0.0
---

# Security Awareness

Proactive security knowledge to prevent vulnerabilities while writing code. Apply these principles automatically when handling sensitive operations.

## When to Apply

- Writing code that handles user input
- Implementing authentication or authorization
- Creating database queries
- Handling file operations
- Making external API calls
- Working with cryptography or secrets
- Processing data from untrusted sources

## OWASP Top 10 Prevention

### 1. Injection (SQL, Command, LDAP)

**Prevent SQL Injection:**
```typescript
// CORRECT: Parameterized queries
const query = 'SELECT * FROM users WHERE id = $1';
await db.query(query, [userId]);

// CORRECT: ORM with built-in protection
await User.findOne({ where: { id: userId } });
```

**Prevent Command Injection:**
```typescript
// CORRECT: Use spawn with array arguments (not shell string)
import { spawn } from 'child_process';
spawn('ls', [userPath]);

// CORRECT: Validate and sanitize input
if (!/^[a-zA-Z0-9_-]+$/.test(userPath)) {
  throw new Error('Invalid path');
}
```

### 2. Broken Authentication

**Secure Password Handling:**
```typescript
import bcrypt from 'bcrypt';
const SALT_ROUNDS = 12;

const hash = await bcrypt.hash(password, SALT_ROUNDS);
const isValid = await bcrypt.compare(password, hash);
```

**Session Security:**
```typescript
app.use(session({
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: true,       // HTTPS only
    httpOnly: true,     // No JS access
    sameSite: 'strict', // CSRF protection
    maxAge: 3600000     // 1 hour
  }
}));
```

### 3. Sensitive Data Exposure

**Never Log Sensitive Data:**
```typescript
// Log only non-sensitive identifiers
logger.info(`User login attempt: ${email}`);
// Never log passwords, tokens, or secrets
```

**Use Environment Variables:**
```typescript
const apiKey = process.env.API_KEY;
const dbPassword = process.env.DB_PASSWORD;
```

### 4. Broken Access Control

**Always Verify Authorization:**
```typescript
async function updatePost(userId: string, postId: string, data: PostData) {
  const post = await Post.findById(postId);

  if (post.authorId !== userId) {
    throw new ForbiddenError('Not authorized');
  }

  return post.update(data);
}
```

**Use Role-Based Access:**
```typescript
function requireRole(...roles: string[]) {
  return (req, res, next) => {
    if (!roles.includes(req.user.role)) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    next();
  };
}

app.delete('/admin/users/:id', requireRole('admin'), deleteUser);
```

### 5. Security Misconfiguration

**Set Security Headers:**
```typescript
import helmet from 'helmet';

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'"],
    }
  },
  hsts: { maxAge: 31536000, includeSubDomains: true }
}));
```

### 6. Cross-Site Scripting (XSS)

**Sanitize User Content:**
```typescript
import DOMPurify from 'dompurify';

// Always sanitize user-generated HTML
const clean = DOMPurify.sanitize(userInput);

// React auto-escapes by default - prefer this pattern
<div>{userContent}</div>
```

**Content Security Policy:**
```typescript
app.use(helmet.contentSecurityPolicy({
  directives: {
    scriptSrc: ["'self'"],
  }
}));
```

### 7. Insecure Deserialization

**Validate All Input:**
```typescript
import { z } from 'zod';

const UserSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  role: z.enum(['user', 'admin'])
});

const userData = UserSchema.parse(JSON.parse(input));
```

### 8. Known Vulnerabilities

**Keep Dependencies Updated:**
```bash
npm audit
npm audit fix
npx npm-check-updates
```

### 9. Insufficient Logging

**Log Security Events:**
```typescript
logger.info({
  event: 'auth_attempt',
  email: user.email,
  success: isValid,
  ip: req.ip
});

logger.warn({
  event: 'authz_failure',
  userId: req.user.id,
  resource: req.path
});
```

## Quick Security Checklist

- [ ] User input validated and sanitized
- [ ] SQL queries use parameterized statements
- [ ] Passwords hashed with bcrypt (12+ rounds)
- [ ] Sessions configured securely
- [ ] Authorization checks on all protected resources
- [ ] Sensitive data not logged
- [ ] Security headers set
- [ ] Dependencies up-to-date
- [ ] Error messages don't expose internals

## Common Patterns

### API Endpoints
```typescript
import rateLimit from 'express-rate-limit';

app.use('/api/', rateLimit({ windowMs: 15 * 60 * 1000, max: 100 }));
app.post('/api/users', validateBody(UserSchema), createUser);
app.use('/api/protected/', requireAuth);
```

### File Operations
```typescript
import path from 'path';

// Prevent path traversal
const safePath = path.normalize(userPath);
if (!safePath.startsWith(allowedDir)) {
  throw new Error('Path traversal attempt');
}

// Validate file types
const allowedMimes = ['image/jpeg', 'image/png'];
if (!allowedMimes.includes(file.mimetype)) {
  throw new Error('Invalid file type');
}
```

## Invoke Full Workflow

For comprehensive security auditing with specialized agents:

**Use the Task tool** to launch security auditor agents:

1. **Dependency Scan**: Launch `security-auditor:dependency-scanner` to check for vulnerable dependencies
2. **Code Analysis**: Launch `security-auditor:code-security-analyzer` to scan for code vulnerabilities
3. **Auth Review**: Launch `security-auditor:auth-reviewer` to review authentication/authorization

**Example prompt for agent:**
```
Run a comprehensive security audit of the codebase.
Check dependencies for vulnerabilities and analyze authentication code.
```

## Additional Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheets](https://cheatsheetseries.owasp.org/)
