---
description: Generate complete API documentation from your codebase - scans endpoints, creates OpenAPI specs, and writes human-readable docs
---

# Generate API Documentation

You are orchestrating a comprehensive API documentation workflow that scans your codebase and generates complete documentation.

## Core Mission

Generate complete API documentation by:
1. Scanning codebase for API endpoints
2. Generating OpenAPI/Swagger specifications
3. Creating human-readable documentation
4. Organizing output in a structured format

## Usage

```
/api-docs
```

## Execution Phases

### Phase 1: Initial Setup

**Actions**:
1. Create todo list to track progress
2. Check if docs directory exists, create if needed
3. Confirm with user they want to proceed

### Phase 2: Scan API Endpoints

**Actions**:
1. Launch **api-scanner** agent:
   ```
   Please scan this codebase to discover all API endpoints:

   - Detect the backend framework being used
   - Find all route definitions and handlers
   - Extract HTTP methods, paths, parameters
   - Identify request/response schemas
   - Note authentication requirements
   - Group endpoints by resource

   Return a comprehensive inventory of all endpoints with:
   - Endpoint details (method, path, description)
   - Parameters (path, query, body)
   - Authentication requirements
   - Response schemas
   - File locations
   ```

2. Wait for api-scanner to complete
3. Review the endpoint inventory

### Phase 3: Generate OpenAPI Specification

**Actions**:
1. Launch **openapi-generator** agent:
   ```
   Generate an OpenAPI 3.0 specification from the endpoint inventory:

   Input: {endpoint inventory from api-scanner}

   Create:
   - Complete openapi.yaml file
   - Proper info, servers, paths sections
   - Reusable components (schemas, responses, parameters)
   - Security definitions
   - Tags for organization

   Save to: docs/openapi.yaml

   Ensure the spec is valid and includes:
   - All endpoints documented
   - Request/response schemas
   - Examples for complex types
   - Error responses
   - Authentication schemes
   ```

2. Wait for openapi-generator to complete
3. Verify OpenAPI file was created

### Phase 4: Generate Human-Readable Documentation

**Actions**:
1. Launch **docs-writer** agent:
   ```
   Create human-readable API documentation:

   Input:
   - OpenAPI spec: docs/openapi.yaml
   - Endpoint inventory: {from api-scanner}

   Generate documentation in docs/api/:
   - README.md (overview, getting started, quick start)
   - authentication.md (auth guide with examples)
   - endpoints/ directory with one file per resource
   - errors.md (error handling guide)
   - examples/ directory with code samples (curl, JavaScript, Python)

   Writing style:
   - Clear and concise
   - Include realistic examples
   - Code samples in multiple languages
   - Easy to navigate structure
   ```

2. Wait for docs-writer to complete
3. Review generated documentation

### Phase 5: Summary & Next Steps

**Actions**:
1. List all generated files
2. Provide summary of what was documented
3. Suggest next steps:
   - Review documentation for accuracy
   - Add to version control
   - Deploy to documentation platform
   - Share with team
   - Use `/update-api-docs` to keep updated

## Output Example

```markdown
# API Documentation Generated! ✅

## Files Created

### OpenAPI Specification
📄 **docs/openapi.yaml** (24 KB)
- 32 endpoints documented
- 15 schemas defined
- Security schemes configured

### Human-Readable Documentation
📁 **docs/api/**
- README.md - API overview and getting started
- authentication.md - Auth guide
- endpoints/
  - users.md (5 endpoints)
  - auth.md (3 endpoints)
  - reports.md (4 endpoints)
  - admin.md (2 endpoints)
- errors.md - Error handling guide
- examples/
  - curl.md - cURL examples
  - javascript.md - JavaScript/Node.js examples
  - python.md - Python examples

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

### Reports (4 endpoints)
- GET /api/reports
- POST /api/reports
- GET /api/reports/:id
- DELETE /api/reports/:id

### Admin (2 endpoints)
- GET /api/admin/stats
- POST /api/admin/settings

## Next Steps

1. **Review**: Check generated docs for accuracy
2. **Customize**: Add project-specific information
3. **Deploy**: Host on documentation platform
   - Swagger UI for OpenAPI spec
   - Docusaurus/GitBook for markdown docs
4. **Share**: Distribute to API consumers
5. **Maintain**: Use `/update-api-docs` when API changes

## Tools & Resources

- **Swagger Editor**: https://editor.swagger.io/ (validate OpenAPI spec)
- **Swagger UI**: Interactive API explorer
- **Redoc**: Beautiful API documentation
- **Postman**: Import OpenAPI spec for testing
```

## Best Practices

- Run after significant API changes
- Keep documentation in version control
- Review generated docs for accuracy
- Add custom sections as needed
- Update when endpoints change

## Important Notes

- Always use TodoWrite to track progress
- Coordinate all three agents sequentially
- Verify each phase completes before proceeding
- Save all outputs to docs/ directory
- Provide clear summary to user

Your goal is to make API documentation generation effortless and comprehensive, ensuring developers have all the information they need to integrate with the API.
