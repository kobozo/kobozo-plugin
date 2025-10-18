# API Documenter Plugin

Automatically generate and maintain comprehensive API documentation with OpenAPI/Swagger specifications and human-readable markdown docs.

**Version:** 1.0.0
**Author:** Yannick De Backer (yannick@kobozo.eu)

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Commands](#commands)
  - [/api-docs](#api-docs)
  - [/update-api-docs](#update-api-docs)
- [Agents](#agents)
  - [api-scanner](#api-scanner)
  - [openapi-generator](#openapi-generator)
  - [docs-writer](#docs-writer)
- [Workflow](#workflow)
- [Output Structure](#output-structure)
- [Supported Frameworks](#supported-frameworks)
- [API Types Supported](#api-types-supported)
- [Usage Examples](#usage-examples)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Advanced Usage](#advanced-usage)
- [Tools & Resources](#tools--resources)

---

## Overview

The API Documenter plugin is a comprehensive documentation generation system for Claude Code that scans your codebase, discovers API endpoints, and generates professional documentation automatically.

It combines three specialized agents that work together to:
1. **Scan** your codebase to discover all API endpoints
2. **Generate** OpenAPI 3.0/Swagger specifications
3. **Write** beautiful, human-readable documentation

This plugin eliminates the tedious work of maintaining API documentation manually and ensures your docs stay in sync with your code.

---

## Key Features

- **Automatic Endpoint Discovery**: Scans your codebase to find all API routes and handlers
- **Multi-Framework Support**: Works with 15+ backend frameworks (Express, NestJS, FastAPI, Spring Boot, and more)
- **OpenAPI 3.0 Generation**: Creates standards-compliant OpenAPI/Swagger specifications
- **Human-Readable Docs**: Generates markdown documentation with examples
- **Code Examples**: Includes examples in multiple languages (curl, JavaScript, Python)
- **Authentication Documentation**: Automatically documents security schemes (JWT, OAuth2, API keys)
- **Error Handling Guide**: Documents error responses and troubleshooting
- **Incremental Updates**: Update existing docs when your API changes with diff preview
- **Organized Output**: Creates well-structured documentation ready for GitHub wikis, GitBook, or Docusaurus
- **Schema Extraction**: Identifies TypeScript types, Zod schemas, Pydantic models
- **Validation**: Ensures OpenAPI spec is valid and lint-free

---

## Installation

This plugin is included in the kobozo-plugins collection.

```bash
/plugin install api-documenter@kobozo-plugins
```

Or use directly in any Claude Code session:

```bash
/api-docs
```

---

## Commands

### /api-docs

Generate complete API documentation from scratch by scanning your entire codebase.

**Usage:**
```bash
/api-docs
```

**What it does:**
1. Creates a todo list to track progress
2. Checks/creates the `docs/` directory
3. Scans your codebase for API endpoints
4. Generates an OpenAPI specification (`docs/openapi.yaml`)
5. Creates human-readable documentation in `docs/api/`
6. Provides a summary of generated files

**When to use:**
- First-time documentation generation
- Complete documentation refresh
- Starting a new project
- Major API refactoring

**Output:**
```
docs/
├── openapi.yaml                    # OpenAPI 3.0 specification
└── api/
    ├── README.md                   # API overview and getting started
    ├── authentication.md           # Authentication guide
    ├── endpoints/
    │   ├── users.md               # User endpoints
    │   ├── auth.md                # Auth endpoints
    │   └── ...                    # Other resources
    ├── errors.md                   # Error handling guide
    └── examples/
        ├── curl.md                # cURL examples
        ├── javascript.md          # JavaScript/Node.js examples
        └── python.md              # Python examples
```

**Execution Phases:**

1. **Initial Setup**: Create todo list, verify/create docs directory, confirm with user
2. **Scan API Endpoints**: Launch api-scanner agent to discover all endpoints
3. **Generate OpenAPI Spec**: Launch openapi-generator to create specification
4. **Generate Documentation**: Launch docs-writer to create human-readable docs
5. **Summary & Next Steps**: List generated files and suggest next actions

---

### /update-api-docs

Update existing API documentation to reflect code changes.

**Usage:**
```bash
/update-api-docs
```

**What it does:**
1. Checks if existing documentation exists
2. Rescans codebase for endpoint changes
3. Compares with existing OpenAPI spec
4. Shows a diff of what changed (new/modified/deleted endpoints)
5. Updates OpenAPI specification
6. Updates markdown documentation
7. Reports what was modified

**When to use:**
- After adding new endpoints
- After modifying existing endpoints
- Regular maintenance updates
- Before releases

**Features:**
- Preserves custom edits where possible
- Shows changes before updating
- Incremental updates only modify what changed
- Keeps documentation in sync with code

---

## Agents

The API Documenter plugin uses three specialized agents that work together:

### api-scanner

**Model:** Sonnet
**Color:** Cyan
**Tools:** Glob, Grep, Read, TodoWrite, WebFetch

**Purpose:** Scans your codebase to discover and analyze all API endpoints.

**Capabilities:**
- Detects backend framework automatically (Express, NestJS, FastAPI, Spring Boot, etc.)
- Finds all route definitions and handlers
- Extracts HTTP methods (GET, POST, PUT, PATCH, DELETE, etc.)
- Identifies route parameters and query parameters
- Discovers request/response schemas
- Analyzes authentication/authorization requirements
- Identifies middleware and handlers
- Groups endpoints by resource
- Follows imports to find nested routes

**Supported Frameworks:**

**Node.js:**
- Express.js
- Fastify
- NestJS (with decorators)
- Hono
- Next.js API routes (App Router & Pages Router)

**Python:**
- Django / Django REST Framework
- Flask
- FastAPI

**Ruby:**
- Rails API
- Sinatra

**Java:**
- Spring Boot

**C#:**
- ASP.NET Core

**Go:**
- Gin
- Echo

**Rust:**
- Axum
- Actix

**Scanning Workflow:**

1. **Framework Detection**: Identifies frameworks from package.json, requirements.txt, etc.
2. **Endpoint Discovery**: Finds all route definitions using framework-specific patterns
3. **Endpoint Analysis**: Extracts detailed information (paths, methods, parameters, schemas)
4. **Schema Extraction**: Identifies TypeScript interfaces, Zod schemas, Pydantic models
5. **Grouping & Organization**: Groups endpoints by resource and base path

**Output:** Comprehensive endpoint inventory with:
- Endpoint details (method, path, description)
- Parameters (path, query, body)
- Authentication requirements
- Response schemas
- File locations
- Recommendations for improvements

---

### openapi-generator

**Model:** Sonnet
**Color:** Blue
**Tools:** Read, Write, Edit, TodoWrite

**Purpose:** Generates OpenAPI 3.0/Swagger specifications from discovered endpoints.

**Capabilities:**
- Creates complete OpenAPI 3.0 specifications
- Defines proper info, servers, paths sections
- Creates reusable components (schemas, responses, parameters)
- Configures security definitions (JWT, OAuth2, API keys)
- Adds tags for organization
- Includes examples for all endpoints
- Validates specification structure
- Supports both YAML (recommended) and JSON formats

**OpenAPI Structure Generated:**

```yaml
openapi: 3.0.3
info:
  title: API Title
  version: 1.0.0
  description: API description
  contact: {...}
  license: {...}
servers:
  - url: https://api.example.com
    description: Production
paths:
  /api/users:
    get: {...}
    post: {...}
components:
  schemas: {...}
  responses: {...}
  parameters: {...}
  securitySchemes: {...}
tags: [...]
```

**Generation Phases:**

1. **Input Analysis**: Read endpoint inventory from api-scanner
2. **Info Section**: Define API metadata (title, version, description)
3. **Servers Section**: Define base URLs for environments
4. **Paths Section**: Document all endpoints with parameters and responses
5. **Components Section**: Create reusable schemas, responses, parameters
6. **Tags**: Organize endpoints by resource
7. **Validation**: Ensure spec is valid and lint-free

**Output:** Standards-compliant OpenAPI specification ready for:
- Swagger UI
- Redoc
- Postman import
- Client SDK generation
- API testing tools

---

### docs-writer

**Model:** Sonnet
**Color:** Green
**Tools:** Read, Write, Edit, TodoWrite

**Purpose:** Creates beautiful, human-readable API documentation from OpenAPI specs.

**Capabilities:**
- Transforms OpenAPI specs into markdown
- Writes clear, concise documentation
- Includes realistic examples
- Provides code samples in multiple languages (curl, JavaScript, Python)
- Creates getting started guides
- Documents authentication flows
- Explains error handling
- Organizes docs by resource

**Documentation Structure:**

```markdown
docs/api/
├── README.md              # Overview and getting started
├── authentication.md      # Authentication guide
├── endpoints/
│   ├── users.md          # User endpoints documentation
│   ├── auth.md           # Authentication endpoints
│   └── ...
├── errors.md              # Error handling guide
└── examples/              # Code examples
    ├── curl.md
    ├── javascript.md
    └── python.md
```

**Writing Style:**
- Clear and concise language
- Examples-first approach
- Consistent markdown formatting
- Working code samples
- Visual aids (tables, lists, code blocks)
- Easy navigation structure

**Writing Phases:**

1. **Overview Documentation**: Create README.md with introduction and quick start
2. **Authentication Guide**: Document how to obtain and use credentials
3. **Endpoint Documentation**: Create detailed reference for each endpoint
4. **Error Handling**: Document error codes and troubleshooting

**Output Formats:**
- Markdown files ready for:
  - GitHub wikis
  - GitBook
  - Docusaurus
  - MkDocs
  - Static site generators

---

## Workflow

The API documentation generation follows a structured workflow:

```mermaid
graph TB
    Start[/api-docs] --> Setup[Phase 1: Initial Setup]
    Setup --> Scanner[Phase 2: api-scanner Agent]
    Scanner --> Analyze[Discover & Analyze Endpoints]
    Analyze --> Inventory[Generate Endpoint Inventory]
    Inventory --> OpenAPI[Phase 3: openapi-generator Agent]
    OpenAPI --> Spec[Create OpenAPI 3.0 Spec]
    Spec --> Docs[Phase 4: docs-writer Agent]
    Docs --> Markdown[Generate Markdown Docs]
    Markdown --> Summary[Phase 5: Summary & Next Steps]
```

### Detailed Workflow

**Phase 1: Initial Setup**
1. Create todo list to track progress
2. Check if `docs/` directory exists, create if needed
3. Confirm with user to proceed

**Phase 2: Scan API Endpoints**
1. Launch **api-scanner** agent
2. Detect backend framework from project files
3. Scan for all route definitions using framework-specific patterns
4. Extract endpoint details, parameters, schemas
5. Identify authentication requirements
6. Group endpoints by resource
7. Return comprehensive endpoint inventory

**Phase 3: Generate OpenAPI Specification**
1. Launch **openapi-generator** agent
2. Receive endpoint inventory from scanner
3. Create OpenAPI 3.0 structure (info, servers, paths)
4. Define reusable components (schemas, responses, parameters)
5. Add security definitions (JWT, OAuth2, API keys)
6. Include examples and descriptions
7. Validate specification structure
8. Save to `docs/openapi.yaml`

**Phase 4: Generate Human-Readable Documentation**
1. Launch **docs-writer** agent
2. Read OpenAPI specification
3. Create documentation structure in `docs/api/`
4. Write overview and getting started guide (README.md)
5. Document authentication flow (authentication.md)
6. Create endpoint reference docs (endpoints/*.md)
7. Add code examples in multiple languages (examples/*.md)
8. Document error handling (errors.md)

**Phase 5: Summary & Next Steps**
1. List all generated files with sizes
2. Provide summary of what was documented
3. Suggest next steps:
   - Review documentation for accuracy
   - Add to version control
   - Deploy to documentation platform
   - Share with team
   - Use `/update-api-docs` to keep updated

---

## Output Structure

The plugin generates a well-organized documentation structure:

```
docs/
├── openapi.yaml                    # OpenAPI 3.0 specification
└── api/
    ├── README.md                   # API overview and getting started
    ├── authentication.md           # Authentication guide
    ├── endpoints/
    │   ├── users.md               # User endpoints documentation
    │   ├── auth.md                # Authentication endpoints
    │   ├── reports.md             # Report endpoints
    │   └── admin.md               # Admin endpoints
    ├── errors.md                   # Error handling guide
    └── examples/
        ├── curl.md                # cURL examples
        ├── javascript.md          # JavaScript/Node.js examples
        └── python.md              # Python examples
```

### File Descriptions

**openapi.yaml**
- Standards-compliant OpenAPI 3.0 specification
- Can be imported into Swagger UI, Postman, Redoc
- Used for client SDK generation
- Serves as machine-readable API contract
- Includes all endpoints, schemas, security definitions

**api/README.md**
- API overview and introduction
- Base URL configuration
- Quick start guide with basic example
- Links to detailed documentation sections
- Authentication overview

**api/authentication.md**
- How to obtain API credentials
- Token formats and usage (JWT, OAuth2, API keys)
- Authentication examples in multiple languages
- Token refresh process
- Security best practices

**api/endpoints/*.md**
- One file per resource/domain
- Complete endpoint reference for each resource
- Request/response examples
- Parameter documentation (path, query, body)
- Status codes and errors
- Realistic code samples

**api/errors.md**
- Common error codes (400, 401, 403, 404, 500, etc.)
- Error response format
- Troubleshooting guide
- Best practices for error handling

**api/examples/*.md**
- Working code examples
- Multiple language support (curl, JavaScript, Python)
- Copy-paste ready snippets
- Real-world usage patterns
- Authentication examples

---

## Supported Frameworks

The plugin automatically detects and supports the following frameworks:

### Node.js / TypeScript

**Express.js**
```javascript
app.get('/api/users', handler)
app.post('/api/users', handler)
router.get('/users/:id', handler)
```

**Fastify**
```javascript
fastify.get('/api/users', handler)
fastify.post('/api/users', handler)
```

**NestJS**
```typescript
@Controller('users')
export class UsersController {
  @Get(':id')
  @UseGuards(AuthGuard)
  findOne() {}
}
```

**Hono**
```typescript
app.get('/api/users', (c) => {})
app.post('/api/users', (c) => {})
```

**Next.js API Routes**
```typescript
// App Router: app/api/users/route.ts
export async function GET(request: Request) {}

// Pages Router: pages/api/users.ts
export default function handler(req, res) {}
```

### Python

**Django / Django REST Framework**
```python
path('api/users/', views.user_list)
path('api/users/<int:pk>/', views.user_detail)
```

**Flask**
```python
@app.route('/api/users', methods=['GET', 'POST'])
def users():
    pass
```

**FastAPI**
```python
@app.get("/api/users/{user_id}")
@app.post("/api/users")
async def create_user():
    pass
```

### Java

**Spring Boot**
```java
@RestController
@RequestMapping("/api")
public class UserController {
    @GetMapping("/users")
    @PostMapping("/users")
}
```

### C#

**ASP.NET Core**
```csharp
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase {
    [HttpGet]
    [HttpPost]
}
```

### Go

**Gin**
```go
r.GET("/api/users", handler)
r.POST("/api/users", handler)
```

**Echo**
```go
e.GET("/api/users", handler)
e.POST("/api/users", handler)
```

### Ruby

**Rails API**
```ruby
Rails.application.routes.draw do
  resources :users
end
```

**Sinatra**
```ruby
get '/api/users' do
  # handler
end
```

### Rust

**Axum**
```rust
Router::new()
    .route("/api/users", get(list_users))
    .route("/api/users", post(create_user))
```

**Actix**
```rust
HttpServer::new(|| {
    App::new()
        .route("/api/users", web::get().to(list_users))
})
```

---

## API Types Supported

### REST APIs

**Full Support:**
- RESTful route conventions
- Resource-based endpoints
- CRUD operations (Create, Read, Update, Delete)
- Query parameters (pagination, filtering, sorting)
- Path parameters (IDs, slugs)
- Request/response bodies (JSON, XML)
- Status codes (200, 201, 400, 401, 403, 404, 500)
- Authentication (JWT, OAuth2, API keys)

### GraphQL APIs

**Detection:**
- GraphQL schema definitions
- Resolvers and types
- Queries and mutations
- Subscriptions

**Documentation:**
- Schema documentation
- Query examples
- Mutation examples
- Type definitions

### WebSocket APIs

**Detection:**
- WebSocket endpoint registration
- Socket.io routes
- Event handlers

**Documentation:**
- Connection setup
- Event documentation
- Message formats

### gRPC APIs

**Detection:**
- Protocol buffer definitions (.proto files)
- Service definitions
- RPC methods

**Documentation:**
- Service documentation
- Method signatures
- Message types

---

## Usage Examples

### Example 1: Generate Documentation for Express.js API

**Command:**
```bash
/api-docs
```

**Expected Output:**
```markdown
# API Documentation Generated!

## Files Created

### OpenAPI Specification
📄 docs/openapi.yaml (24 KB)
- 32 endpoints documented
- 15 schemas defined
- Security schemes configured

### Human-Readable Documentation
📁 docs/api/
- README.md - API overview
- authentication.md - JWT auth guide
- endpoints/
  - users.md (5 endpoints)
  - auth.md (3 endpoints)
  - posts.md (8 endpoints)
  - comments.md (6 endpoints)
- errors.md - Error handling
- examples/
  - curl.md
  - javascript.md
  - python.md

## Endpoints Documented

**Total**: 32 endpoints across 4 resources

### Users (5 endpoints)
- GET /api/users - List users
- POST /api/users - Create user
- GET /api/users/:id - Get user
- PUT /api/users/:id - Update user
- DELETE /api/users/:id - Delete user

### Authentication (3 endpoints)
- POST /api/auth/login
- POST /api/auth/logout
- POST /api/auth/refresh

## Next Steps

1. Review generated docs for accuracy
2. Customize with project-specific information
3. Deploy to documentation platform (Swagger UI, Docusaurus)
4. Share with team and API consumers
5. Use `/update-api-docs` to keep documentation in sync
```

---

### Example 2: Update Documentation After Changes

**Scenario:** You added two new endpoints to your posts API.

**Command:**
```bash
/update-api-docs
```

**Expected Output:**
```markdown
# API Documentation Updated

## Changes Detected

### New Endpoints (2)
- POST /api/posts/:id/publish
- POST /api/posts/:id/unpublish

### Modified Endpoints (1)
- GET /api/posts/:id
  - Added query parameter: include_comments (boolean)

### Unchanged Endpoints (30)
No changes detected

## Files Updated
- docs/openapi.yaml
- docs/api/endpoints/posts.md
- docs/api/examples/javascript.md

## Summary
- Added 2 new endpoints
- Modified 1 endpoint
- Updated 3 documentation files
- Preserved custom edits in README.md
```

---

### Example 3: Generated Endpoint Documentation

**Sample from `docs/api/endpoints/users.md`:**

```markdown
# User Endpoints

## GET /api/users

List all users with pagination support.

**Authentication:** Required (Bearer token)

**Query Parameters:**
- `page` (integer, optional): Page number (default: 1, min: 1)
- `limit` (integer, optional): Items per page (default: 10, min: 1, max: 100)
- `role` (string, optional): Filter by role (admin, user, guest)
- `search` (string, optional): Search by name or email

**Example Request (cURL):**
```bash
curl -X GET "https://api.example.com/v1/users?page=1&limit=20&role=admin" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

**Example Request (JavaScript):**
```javascript
const response = await fetch('https://api.example.com/v1/users?page=1&limit=20', {
  headers: {
    'Authorization': `Bearer ${accessToken}`
  }
});
const data = await response.json();
```

**Example Request (Python):**
```python
import requests

response = requests.get(
    'https://api.example.com/v1/users',
    params={'page': 1, 'limit': 20},
    headers={'Authorization': f'Bearer {access_token}'}
)
data = response.json()
```

**Response (200 OK):**
```json
{
  "users": [
    {
      "id": "user_123abc",
      "email": "john@example.com",
      "name": "John Doe",
      "role": "admin",
      "createdAt": "2024-01-15T10:30:00Z"
    }
  ],
  "total": 150,
  "page": 1,
  "limit": 20,
  "totalPages": 8
}
```

**Error Responses:**
- `400 Bad Request`: Invalid pagination parameters
- `401 Unauthorized`: Missing or invalid authentication token
- `500 Internal Server Error`: Server error

---

## POST /api/users

Create a new user account.

**Authentication:** Required (Admin role)

**Request Body:**
```json
{
  "email": "string (required, email format)",
  "name": "string (required, 1-100 chars)",
  "password": "string (required, min 8 chars)",
  "role": "string (optional, default: user)"
}
```

**Example Request (cURL):**
```bash
curl -X POST "https://api.example.com/v1/users" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "newuser@example.com",
    "name": "Jane Smith",
    "password": "securepass123",
    "role": "user"
  }'
```

**Response (201 Created):**
```json
{
  "id": "user_456def",
  "email": "newuser@example.com",
  "name": "Jane Smith",
  "role": "user",
  "createdAt": "2024-01-15T14:20:00Z"
}
```

**Error Responses:**
- `400 Bad Request`: Validation errors
- `401 Unauthorized`: Missing or invalid token
- `403 Forbidden`: Insufficient permissions (not admin)
- `409 Conflict`: Email already exists
- `500 Internal Server Error`: Server error
```

---

## Best Practices

### When to Run Documentation Generation

**Initial Setup:**
- Generate baseline documentation when starting a project
- Create docs before API goes public
- Document during development, not just at the end

**Regular Updates:**
- After adding new endpoints
- After modifying existing endpoints
- Before releases
- During code reviews
- When onboarding new team members

**Maintenance:**
- Weekly or bi-weekly documentation reviews
- After major refactoring
- When deprecating endpoints

### Documentation Maintenance

1. **Review for Accuracy**
   - Verify generated docs match implementation
   - Test all code examples
   - Ensure schemas are complete

2. **Customize Descriptions**
   - Add project-specific context
   - Explain business logic
   - Document edge cases

3. **Enhance Examples**
   - Add real-world use cases
   - Include error handling examples
   - Show authentication flow

4. **Keep in Version Control**
   - Commit docs with code changes
   - Review docs in pull requests
   - Track documentation changes

5. **Deploy to Platform**
   - Use Swagger UI for interactive exploration
   - Deploy to GitBook or Docusaurus
   - Host on documentation platform

6. **Update Regularly**
   - Run `/update-api-docs` when API changes
   - Automate with CI/CD if possible
   - Keep docs in sync with code

### Enhancing Generated Documentation

After generation, you can enhance documentation by adding:

- **Conceptual Guides**: Explain API design philosophy
- **Tutorials**: Step-by-step guides for common tasks
- **Authentication Setup**: Detailed credential setup instructions
- **Rate Limiting**: Document quotas and limits
- **Versioning**: Explain API versioning strategy
- **Changelog**: Track API changes over time
- **Migration Guides**: Help users upgrade between versions
- **SDK Guides**: Document client library usage
- **Best Practices**: Share API usage best practices
- **Performance Tips**: Optimization recommendations

### Integration with Tools

**Swagger UI** - Interactive API Explorer

```bash
# Host locally
docker run -p 8080:8080 \
  -e SWAGGER_JSON=/docs/openapi.yaml \
  -v $(pwd)/docs:/docs \
  swaggerapi/swagger-ui

# Or use npx
npx swagger-ui-watcher docs/openapi.yaml
```

**Redoc** - Beautiful API Documentation

```bash
# Generate static HTML
npx redoc-cli bundle docs/openapi.yaml -o docs/api.html

# Serve locally
npx redoc-cli serve docs/openapi.yaml
```

**Postman** - API Testing

1. Open Postman
2. Import → File → Select `docs/openapi.yaml`
3. Auto-generates collection with all endpoints
4. Use for testing and development

**OpenAPI Generator** - Client SDK Generation

```bash
# TypeScript/Axios client
npx @openapitools/openapi-generator-cli generate \
  -i docs/openapi.yaml \
  -g typescript-axios \
  -o ./sdk/typescript

# Python client
npx @openapitools/openapi-generator-cli generate \
  -i docs/openapi.yaml \
  -g python \
  -o ./sdk/python

# Go client
npx @openapitools/openapi-generator-cli generate \
  -i docs/openapi.yaml \
  -g go \
  -o ./sdk/go
```

### CI/CD Integration

**Validate OpenAPI Spec in CI:**

```yaml
# .github/workflows/api-docs.yml
name: API Documentation

on: [push, pull_request]

jobs:
  validate-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Validate OpenAPI Spec
        uses: char0n/swagger-editor-validate@v1
        with:
          swagger-editor-url: https://editor.swagger.io
          definition-file: docs/openapi.yaml

      - name: Check for API changes
        run: |
          git diff --name-only | grep -E 'routes|controllers' && \
          git diff --name-only | grep 'docs/openapi.yaml' || \
          (echo "API changed but docs not updated" && exit 1)
```

**Auto-deploy Documentation:**

```yaml
# Deploy to GitHub Pages
- name: Deploy Redoc
  run: |
    npx redoc-cli bundle docs/openapi.yaml -o public/index.html

- name: Deploy to GitHub Pages
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./public
```

---

## Troubleshooting

### Issue: No Endpoints Found

**Problem:** api-scanner reports 0 endpoints discovered

**Possible Causes:**
- Wrong directory (not in project root)
- Unsupported framework
- Non-standard route definitions
- Routes in unexpected locations

**Solutions:**

1. **Verify you're in the correct directory:**
   ```bash
   pwd  # Should be project root
   ls   # Should see package.json, src/, etc.
   ```

2. **Check if framework is supported:**
   - Review [Supported Frameworks](#supported-frameworks)
   - Check package.json dependencies
   - Verify framework version

3. **Check route file locations:**
   ```bash
   # Look for route files
   find . -name "*route*" -o -name "*controller*"
   ```

4. **Manually specify entry points:**
   - Tell the scanner which files to check
   - Provide custom search patterns

---

### Issue: Incomplete Endpoint Documentation

**Problem:** Some endpoints missing parameters or schemas

**Possible Causes:**
- Missing type definitions
- No validation schemas
- Implicit parameters
- Undocumented endpoints

**Solutions:**

1. **Add TypeScript types:**
   ```typescript
   interface UserRequest {
     email: string;
     name: string;
     password: string;
   }

   app.post('/users', (req: Request<{}, {}, UserRequest>) => {})
   ```

2. **Use validation libraries:**
   ```typescript
   // Zod
   const userSchema = z.object({
     email: z.string().email(),
     name: z.string().min(1).max(100),
     password: z.string().min(8)
   });

   // Joi
   const userSchema = Joi.object({
     email: Joi.string().email().required(),
     name: Joi.string().min(1).max(100).required()
   });
   ```

3. **Add JSDoc comments:**
   ```javascript
   /**
    * Create a new user
    * @param {Object} req.body
    * @param {string} req.body.email - User email
    * @param {string} req.body.name - User name
    */
   app.post('/users', handler)
   ```

4. **Use OpenAPI decorators (NestJS):**
   ```typescript
   @ApiProperty({ description: 'User email', example: 'user@example.com' })
   email: string;
   ```

---

### Issue: Authentication Not Detected

**Problem:** Security schemes not recognized in documentation

**Possible Causes:**
- Custom auth middleware
- Non-standard auth patterns
- Auth defined outside route files

**Solutions:**

1. **Use standard auth middleware:**
   ```javascript
   // Express + JWT
   const auth = require('express-jwt');
   app.use(auth({ secret: process.env.JWT_SECRET }));
   ```

2. **Add OpenAPI security decorators:**
   ```typescript
   // NestJS
   @UseGuards(AuthGuard('jwt'))
   @ApiBearerAuth()
   @Controller('users')
   ```

3. **Document in middleware chain:**
   ```javascript
   app.get('/users', authenticate, authorize('admin'), handler);
   ```

4. **Manually specify in OpenAPI spec after generation:**
   ```yaml
   # docs/openapi.yaml
   security:
     - bearerAuth: []
   ```

---

### Issue: OpenAPI Validation Errors

**Problem:** Generated spec fails validation in Swagger Editor

**Possible Causes:**
- Circular schema references
- Invalid $ref paths
- Missing required fields
- Type mismatches

**Solutions:**

1. **Check for circular references:**
   ```yaml
   # Bad: User references Post which references User
   User:
     posts:
       type: array
       items:
         $ref: '#/components/schemas/Post'

   # Good: Use simpler references
   User:
     postIds:
       type: array
       items:
         type: string
   ```

2. **Verify $ref paths:**
   ```yaml
   # Ensure paths are correct
   $ref: '#/components/schemas/User'  # Correct
   $ref: '#/schemas/User'             # Wrong
   ```

3. **Validate with online tools:**
   - https://editor.swagger.io/
   - https://apitools.dev/swagger-parser/online/

4. **Re-run generation:**
   ```bash
   /api-docs
   ```

---

### Issue: Documentation Out of Sync

**Problem:** Docs don't reflect recent code changes

**Solution:**
```bash
/update-api-docs
```

**Prevention Strategies:**

1. **Set up CI/CD detection:**
   ```yaml
   # GitHub Actions
   - name: Check API changes
     run: |
       if git diff --name-only ${{ github.event.before }} ${{ github.sha }} | grep -E 'routes|controllers'; then
         if ! git diff --name-only ${{ github.event.before }} ${{ github.sha }} | grep 'docs/openapi.yaml'; then
           echo "API changed but docs not updated"
           exit 1
         fi
       fi
   ```

2. **Add pre-commit hooks:**
   ```bash
   # .git/hooks/pre-commit
   #!/bin/bash
   if git diff --cached --name-only | grep -E 'routes|controllers'; then
     echo "API files changed. Consider running /update-api-docs"
   fi
   ```

3. **Schedule regular reviews:**
   - Weekly documentation audits
   - Include in sprint planning
   - Review during code reviews

---

### Issue: Custom Edits Overwritten

**Problem:** Manual documentation changes lost during update

**Solutions:**

1. **Add custom content in separate files:**
   ```markdown
   # docs/api/custom/
   ├── getting-started-guide.md
   ├── advanced-usage.md
   └── faq.md
   ```

2. **Use OpenAPI extensions:**
   ```yaml
   # Custom fields preserved in spec
   x-custom-field: "value"
   x-internal-notes: "For internal use only"
   ```

3. **Document customizations:**
   ```yaml
   # CUSTOMIZATION: Added custom rate limit
   x-rate-limit: 100
   ```

4. **Use version control:**
   ```bash
   # Review changes before committing
   git diff docs/
   ```

---

## Advanced Usage

### Custom OpenAPI Extensions

Extend OpenAPI spec with custom fields:

```yaml
# docs/openapi.yaml
paths:
  /api/users:
    get:
      x-rate-limit: 100              # Custom rate limit
      x-cache-duration: 300          # Cache TTL in seconds
      x-internal-only: false         # Public vs internal
      x-requires-approval: false     # Admin approval needed
      x-deprecated-date: "2024-12-31"
```

### Multi-Version API Documentation

Document multiple API versions:

**Approach 1: Separate Directories**
```bash
# Generate v1 docs
/api-docs
mv docs docs-v1

# Switch to v2 branch
git checkout v2-api

# Generate v2 docs
/api-docs
mv docs docs-v2

# Maintain both versions
docs-v1/
docs-v2/
```

**Approach 2: Versioned Paths**
```yaml
# Single OpenAPI spec with versioned paths
paths:
  /v1/users:
    get: {...}
  /v2/users:
    get: {...}
```

### Monorepo Support

Document multiple APIs in a monorepo:

```bash
# Document each service separately
cd services/user-service
/api-docs
mv docs ../../docs/user-api

cd ../order-service
/api-docs
mv docs ../../docs/order-api

cd ../payment-service
/api-docs
mv docs ../../docs/payment-api

# Final structure:
docs/
├── user-api/
│   ├── openapi.yaml
│   └── api/
├── order-api/
│   ├── openapi.yaml
│   └── api/
└── payment-api/
    ├── openapi.yaml
    └── api/
```

### Custom Documentation Templates

Override default templates:

```bash
# Create custom templates
docs/templates/
├── endpoint-template.md
├── auth-template.md
└── example-template.md

# Reference in docs-writer prompts
```

### Automated SDK Generation

Generate client SDKs automatically:

```bash
# package.json
{
  "scripts": {
    "generate-clients": "npm run generate:typescript && npm run generate:python",
    "generate:typescript": "openapi-generator-cli generate -i docs/openapi.yaml -g typescript-axios -o sdk/typescript",
    "generate:python": "openapi-generator-cli generate -i docs/openapi.yaml -g python -o sdk/python"
  }
}
```

### Documentation Hosting

**Option 1: GitHub Pages**
```bash
# Deploy Redoc to GitHub Pages
npx redoc-cli bundle docs/openapi.yaml -o index.html
# Commit to gh-pages branch
```

**Option 2: Docusaurus**
```bash
# Install Docusaurus
npx create-docusaurus@latest docs-site classic

# Copy docs
cp -r docs/api/* docs-site/docs/

# Configure sidebar
# docs-site/sidebars.js
```

**Option 3: GitBook**
```bash
# Initialize GitBook
gitbook init

# Copy docs
cp -r docs/api/* ./

# Build
gitbook build
```

---

## Tools & Resources

### Validation & Editing

- **Swagger Editor**: https://editor.swagger.io/ - Validate and edit OpenAPI specs
- **OpenAPI CLI**: https://github.com/Redocly/openapi-cli - Command-line validator
- **Spectral**: https://stoplight.io/open-source/spectral - OpenAPI linter

### Documentation Rendering

- **Swagger UI**: https://swagger.io/tools/swagger-ui/ - Interactive API explorer
- **Redoc**: https://redoc.ly/ - Beautiful API documentation
- **RapiDoc**: https://mrin9.github.io/RapiDoc/ - Custom element for OpenAPI
- **Stoplight Elements**: https://stoplight.io/open-source/elements - Beautiful API docs

### Testing & Development

- **Postman**: https://www.postman.com/ - Import OpenAPI specs for testing
- **Insomnia**: https://insomnia.rest/ - API client with OpenAPI support
- **HTTPie**: https://httpie.io/ - Command-line HTTP client

### Client SDK Generation

- **OpenAPI Generator**: https://openapi-generator.tech/ - Generate clients in 50+ languages
- **Swagger Codegen**: https://swagger.io/tools/swagger-codegen/ - Generate server stubs and clients
- **Fern**: https://buildwithfern.com/ - Modern SDK generator

### Documentation Platforms

- **GitHub Wiki**: Built-in wiki for repositories
- **GitBook**: https://www.gitbook.com/ - Beautiful documentation hosting
- **Docusaurus**: https://docusaurus.io/ - Facebook's documentation framework
- **MkDocs**: https://www.mkdocs.org/ - Python-based documentation
- **ReadTheDocs**: https://readthedocs.org/ - Free documentation hosting
- **Slate**: https://github.com/slatedocs/slate - API documentation generator

### OpenAPI Learning Resources

- **OpenAPI Specification**: https://spec.openapis.org/oas/v3.0.3
- **OpenAPI Guide**: https://swagger.io/docs/specification/about/
- **OpenAPI Map**: https://openapi-map.apihandyman.io/ - Visual guide
- **Best Practices**: https://swagger.io/blog/api-documentation/best-practices-in-api-documentation/
- **Examples**: https://github.com/OAI/OpenAPI-Specification/tree/main/examples

---

## See Also

- [documentation-writer](../documentation-writer/README.md) - General technical documentation
- [code-architect](../code-architect/README.md) - Architecture documentation and diagrams
- [brainstorm](../brainstorm/README.md) - Research-driven design and specifications

---

## Support

For issues, questions, or contributions:

- **Plugin Issues**: Report in kobozo-plugins repository
- **Feature Requests**: Open an issue with enhancement tag
- **Documentation Bugs**: Submit corrections via pull request
- **General Questions**: Discussions in kobozo-plugins repository

---

## License

This plugin is part of the kobozo-plugins collection. Check the repository root for license information.

---

**Last Updated:** 2025-10-18

**Happy Documenting!** Generate comprehensive API documentation effortlessly and keep it in sync with your codebase.
