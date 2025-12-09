---
description: This skill should be used when the user asks to "document this", "write documentation", "add docs for", "create documentation", "generate docs", or wants help documenting any code, feature, API, architecture, or tutorial. Provides guidance on creating professional technical documentation.
---

# Documentation Skill

Create professional technical documentation for any subject: features, APIs, architecture, tutorials, or guides.

## When to Use

- User wants to document a feature, service, or module
- Creating API documentation
- Writing architecture documentation
- Building tutorials or getting-started guides
- Documenting any code or system component

## Documentation Types

### Feature Documentation
Best for explaining application features to end users or developers.

**Structure:**
- Overview and purpose
- Installation and setup
- Basic usage examples
- Configuration options
- Advanced features
- Error handling
- Troubleshooting

### API Documentation
Best for REST APIs, GraphQL, or any service interfaces.

**Structure:**
- API overview
- Authentication requirements
- Endpoints list with methods
- Request/response examples
- Status codes and errors
- Rate limiting
- SDK examples

### Architecture Documentation
Best for system design and technical documentation.

**Structure:**
- System overview
- Architecture diagrams (Mermaid)
- Component descriptions
- Data flow diagrams
- Technology stack
- Deployment architecture
- Scalability considerations

### Tutorial Documentation
Best for step-by-step learning guides.

**Structure:**
- Prerequisites
- Installation steps
- Configuration walkthrough
- First project setup
- Hello World example
- Next steps
- Common issues

### Guide Documentation
Best for how-to instructions for specific tasks.

**Structure:**
- When to use this guide
- Step-by-step instructions
- Code examples
- Best practices
- Common patterns
- Troubleshooting

## Documentation Standards

### Markdown Formatting
- Use `#` for title, `##` for sections, `###` for subsections
- Include table of contents for long documents
- Use code blocks with language specification
- Add examples for every major feature
- Include diagrams for complex concepts

### Writing Style
- Write in active voice
- Use present tense
- Be concise but comprehensive
- Include examples for everything
- Add troubleshooting sections
- Link to related documentation

### Output Location
Save documentation to `./docs/` directory:
```
./docs/
├── README.md                    # Main overview
├── features/                    # Feature docs
├── api/                         # API docs
├── architecture/                # Architecture docs
├── guides/                      # How-to guides
└── tutorials/                   # Step-by-step tutorials
```

## Quick Documentation Workflow

1. **Analyze subject**: Search for relevant code, understand functionality
2. **Determine type**: Auto-detect or ask user (feature, API, architecture, tutorial, guide)
3. **Structure content**: Use appropriate template for documentation type
4. **Write documentation**: Clear, comprehensive, with examples
5. **Save to ./docs**: Create appropriate subdirectory and filename

## Invoke Full Workflow

For comprehensive multi-phase documentation with specialized agents:

**Use the Task tool** to launch the `documentation-writer:technical-writer` agent with the subject to document. The agent will:
- Analyze the subject thoroughly
- Generate complete documentation
- Create diagrams if needed
- Save to appropriate location

**Example prompt for agent:**
```
Document the authentication system. Analyze the code, understand the flow,
and create comprehensive feature documentation with examples.
```

## Quick Reference

### Subject Detection
- **File path**: Documents that specific file/module
- **Directory**: Documents all code in directory
- **Concept**: Searches codebase for implementation
- **Function/Class**: Documents that specific component

### Best Practices
- Include working code examples
- Add diagrams for complex flows
- Document error cases
- Provide troubleshooting guidance
- Keep documentation close to code
- Update when code changes
