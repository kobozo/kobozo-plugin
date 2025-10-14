---
description: Generate comprehensive documentation for any subject - features, APIs, architecture, tutorials - and save to ./docs for GitHub wiki
---

# Document This

Create professional technical documentation for any subject and save it to the `./docs` directory for use in GitHub wikis.

## Usage

```
/document-this <subject> [--type=feature|api|architecture|tutorial|guide] [--output=./docs]
```

**Examples:**
```
/document-this authentication
/document-this "user management API" --type=api
/document-this "system architecture" --type=architecture
/document-this "getting started" --type=tutorial
/document-this database-migrations --output=./docs/guides
```

## Execution Flow

### Phase 1: Subject Analysis
1. Launch **technical-writer** agent
2. Analyze the subject to be documented:
   - Search for relevant code files
   - Read implementation details
   - Understand functionality and purpose
   - Identify key features and capabilities

### Phase 2: Documentation Generation
1. Determine documentation type (auto-detect or from `--type` flag)
2. Structure content appropriately:
   - **Feature**: Overview, usage, configuration, examples
   - **API**: Endpoints, parameters, responses, examples
   - **Architecture**: System design, components, data flow, diagrams
   - **Tutorial**: Step-by-step guide with examples
   - **Guide**: How-to instructions for specific tasks

### Phase 3: Content Creation
1. Write clear, comprehensive documentation:
   - Add overview and introduction
   - Include code examples
   - Create diagrams (Mermaid) when helpful
   - Add tables for structured data
   - Include troubleshooting section
   - Add related links

### Phase 4: Save to ./docs
1. Determine appropriate file path in `./docs`
2. Create subdirectories if needed (features/, api/, guides/)
3. Generate filename from subject (kebab-case)
4. Save markdown file
5. Update main README.md if needed

## Documentation Types

### Feature Documentation

Subject: "authentication"

**Output**: `./docs/features/authentication.md`

**Content**:
- Overview of the feature
- Installation and setup
- Basic usage examples
- Configuration options
- Advanced features
- Error handling
- Security best practices
- Troubleshooting

### API Documentation

Subject: "user management API"

**Output**: `./docs/api/user-management.md`

**Content**:
- API overview
- Authentication requirements
- Endpoints list with methods
- Request/response examples
- Status codes
- Rate limiting
- Error responses
- SDKs and client libraries

### Architecture Documentation

Subject: "system architecture"

**Output**: `./docs/architecture/overview.md`

**Content**:
- System overview
- Architecture diagrams (Mermaid)
- Component descriptions
- Data flow diagrams
- Technology stack
- Deployment architecture
- Scalability considerations
- Security measures

### Tutorial Documentation

Subject: "getting started"

**Output**: `./docs/tutorials/getting-started.md`

**Content**:
- Prerequisites
- Installation steps
- Configuration walkthrough
- First project setup
- Hello World example
- Next steps
- Common issues

### Guide Documentation

Subject: "database migrations"

**Output**: `./docs/guides/database-migrations.md`

**Content**:
- When to use migrations
- Creating a migration
- Running migrations
- Rolling back
- Best practices
- Common patterns
- Troubleshooting

## Subject Detection

The agent intelligently analyzes your subject:

**If subject is a file path**:
```
/document-this src/services/auth.service.ts
→ Generates feature documentation for the authentication service
```

**If subject is a directory**:
```
/document-this src/api/
→ Generates API documentation for all endpoints in the directory
```

**If subject is a concept**:
```
/document-this "rate limiting"
→ Searches codebase for rate limiting implementation
→ Generates guide documentation
```

**If subject is a function/class**:
```
/document-this UserRepository
→ Documents the UserRepository class with methods and usage
```

## Output Structure

Documentation is organized in `./docs`:

```
./docs/
├── README.md                      # Main wiki home page
├── getting-started.md             # Quick start guide
├── features/
│   ├── authentication.md
│   ├── user-management.md
│   └── notifications.md
├── api/
│   ├── rest-api.md
│   ├── webhooks.md
│   └── graphql.md
├── architecture/
│   ├── overview.md
│   ├── data-flow.md
│   ├── deployment.md
│   └── security.md
├── guides/
│   ├── installation.md
│   ├── configuration.md
│   ├── database-migrations.md
│   └── deployment.md
├── tutorials/
│   ├── first-app.md
│   ├── authentication-setup.md
│   └── testing.md
└── troubleshooting.md
```

## Documentation Standards

### Markdown Formatting
- Use `#` for title, `##` for sections, `###` for subsections
- Include table of contents for long documents
- Use code blocks with language specification
- Add examples for every major feature
- Include diagrams for complex concepts

### GitHub Wiki Compatibility
- All relative links work in GitHub wiki
- Images stored in `./docs/images/`
- Mermaid diagrams rendered automatically
- Tables formatted correctly

### Style Guide
- Write in active voice
- Use present tense
- Be concise but comprehensive
- Include examples for everything
- Add troubleshooting sections
- Link to related documentation

## Integration with GitHub Wiki

### Method 1: Direct Clone
```bash
# Clone your wiki
git clone https://github.com/user/repo.wiki.git

# Copy docs
cp -r ./docs/* ./repo.wiki/

# Commit and push
cd repo.wiki
git add .
git commit -m "Add documentation"
git push
```

### Method 2: Wiki Submodule
```bash
# Add wiki as submodule
git submodule add https://github.com/user/repo.wiki.git wiki

# Sync docs to wiki
cp ./docs/* ./wiki/

# Commit
cd wiki
git add .
git commit -m "Update docs"
git push
```

### Method 3: GitHub Actions
```yaml
name: Sync Docs to Wiki

on:
  push:
    paths:
      - 'docs/**'

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Sync to wiki
        run: |
          git clone https://github.com/${{ github.repository }}.wiki.git wiki
          cp -r docs/* wiki/
          cd wiki
          git config user.name "GitHub Actions"
          git config user.email "actions@github.com"
          git add .
          git commit -m "Sync docs from main repo"
          git push
```

## Example Outputs

### Example 1: Feature Documentation
```bash
/document-this authentication
```

Creates `./docs/features/authentication.md` with:
- Feature overview
- Setup instructions
- Usage examples (login, logout, token refresh)
- Configuration options
- Security best practices
- Troubleshooting

### Example 2: API Documentation
```bash
/document-this "REST API" --type=api
```

Creates `./docs/api/rest-api.md` with:
- Authentication requirements
- Base URL
- All endpoints with methods, parameters, responses
- Rate limiting information
- Error codes
- SDK examples

### Example 3: Architecture Documentation
```bash
/document-this "system design" --type=architecture
```

Creates `./docs/architecture/system-design.md` with:
- Architecture diagram (Mermaid)
- Component descriptions
- Data flow visualization
- Technology stack
- Deployment setup
- Scalability notes

This command creates professional, comprehensive documentation ready for GitHub wikis.
