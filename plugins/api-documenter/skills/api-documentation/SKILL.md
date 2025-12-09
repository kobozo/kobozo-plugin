---
description: This skill should be used when the user asks to "document API", "generate API docs", "create OpenAPI spec", "document endpoints", "create API reference", "write API documentation", or needs help documenting REST APIs, GraphQL, or other service interfaces.
---

# API Documentation Skill

Generate comprehensive API documentation including OpenAPI specifications and human-readable reference guides.

## When to Use

- Documenting REST API endpoints
- Creating OpenAPI/Swagger specifications
- Writing API reference documentation
- Documenting GraphQL schemas
- Creating SDK documentation

## Documentation Components

### OpenAPI Specification
Machine-readable API definition in YAML/JSON.

**Contains:**
- API info and version
- Server endpoints
- Paths and operations
- Request/response schemas
- Security definitions
- Reusable components

### Human-Readable Docs
Developer-friendly documentation.

**Contains:**
- Getting started guide
- Authentication guide
- Endpoint reference
- Code examples
- Error handling guide

## OpenAPI Structure

### Basic Template
```yaml
openapi: 3.0.3
info:
  title: My API
  description: API description
  version: 1.0.0

servers:
  - url: https://api.example.com/v1

paths:
  /users:
    get:
      summary: List users
      responses:
        '200':
          description: Success
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/User'

components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        email:
          type: string
```

### Security Definitions
```yaml
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

security:
  - bearerAuth: []
```

## Documentation Structure

### Recommended Layout
```
docs/api/
├── README.md                # Overview and getting started
├── authentication.md        # Auth guide
├── endpoints/
│   ├── users.md            # User endpoints
│   ├── orders.md           # Order endpoints
│   └── products.md         # Product endpoints
├── errors.md               # Error handling
└── examples/
    ├── curl.md             # cURL examples
    ├── javascript.md       # JavaScript examples
    └── python.md           # Python examples
```

### Endpoint Documentation Template
```markdown
## GET /api/users

List all users with pagination.

### Authentication
Requires Bearer token.

### Query Parameters
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| page | integer | No | Page number (default: 1) |
| limit | integer | No | Items per page (default: 20) |

### Response
```json
{
  "data": [
    { "id": "1", "email": "user@example.com" }
  ],
  "meta": {
    "total": 100,
    "page": 1,
    "limit": 20
  }
}
```

### Errors
- `401`: Unauthorized
- `403`: Forbidden
```

## Best Practices

### Endpoint Naming
- Use nouns for resources: `/users`, `/orders`
- Use plural forms: `/users` not `/user`
- Nest related resources: `/users/{id}/orders`
- Use kebab-case: `/user-profiles`

### Request/Response Examples
Always include realistic examples:

```json
// Good example
{
  "id": "usr_123abc",
  "email": "john.doe@example.com",
  "name": "John Doe",
  "createdAt": "2024-01-15T10:30:00Z"
}

// Bad example (too minimal)
{
  "id": "1",
  "email": "test@test.com"
}
```

### Error Documentation
Document all error cases:

```markdown
## Error Responses

### 400 Bad Request
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request body",
    "details": [
      { "field": "email", "message": "Must be valid email" }
    ]
  }
}
```

### 401 Unauthorized
```json
{
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Invalid or expired token"
  }
}
```
```

### Code Examples
Provide examples in multiple languages:

```markdown
### Create User

**cURL**
```bash
curl -X POST https://api.example.com/v1/users \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "name": "John"}'
```

**JavaScript**
```javascript
const response = await fetch('https://api.example.com/v1/users', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({ email: 'user@example.com', name: 'John' })
});
```

**Python**
```python
import requests

response = requests.post(
    'https://api.example.com/v1/users',
    headers={'Authorization': f'Bearer {token}'},
    json={'email': 'user@example.com', 'name': 'John'}
)
```
```

## Invoke Full Workflow

For comprehensive API documentation generation:

**Use the Task tool** to launch API documentation agents:

1. **Scan Endpoints**: Launch `api-documenter:api-scanner` agent to discover all API endpoints
2. **Generate OpenAPI**: Launch `api-documenter:openapi-generator` agent to create specification
3. **Write Docs**: Launch `api-documenter:docs-writer` agent to create human-readable documentation

**Example prompt for agent:**
```
Generate complete API documentation for this codebase. Scan all endpoints,
create an OpenAPI spec, and write human-readable docs with examples.
```

## Quick Reference

### HTTP Status Codes
| Code | Meaning | When to Use |
|------|---------|-------------|
| 200 | OK | Successful GET/PUT/PATCH |
| 201 | Created | Successful POST |
| 204 | No Content | Successful DELETE |
| 400 | Bad Request | Validation errors |
| 401 | Unauthorized | Missing/invalid auth |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource doesn't exist |
| 409 | Conflict | Duplicate resource |
| 500 | Server Error | Unexpected error |

### Content Types
| Type | Use Case |
|------|----------|
| `application/json` | Most API responses |
| `multipart/form-data` | File uploads |
| `application/x-www-form-urlencoded` | HTML form data |

### Documentation Checklist
- [ ] All endpoints documented
- [ ] Authentication explained
- [ ] Request/response schemas defined
- [ ] Examples for all endpoints
- [ ] Error codes documented
- [ ] Rate limits mentioned
- [ ] Versioning strategy explained
