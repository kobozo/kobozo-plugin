---
description: Generate comprehensive architecture documentation including ADRs, technical specs, and component docs
---

# Generate Docs

Generate complete architecture documentation package with ADRs, component specifications, and system design documents.

## Usage

```
/generate-docs [--type=full|adr|component] [--component=<name>]
```

**Examples:**
```
/generate-docs                          # Full documentation suite
/generate-docs --type=adr               # Create new ADR template
/generate-docs --type=component --component=auth-service
```

## Execution Flow

### Full Documentation Mode (default)

#### Phase 1: Architecture Overview
1. Launch **architecture-mapper** agent
2. Generate system context documentation
3. Create C4 model diagrams (Context, Container, Component)
4. Document architectural patterns used
5. Map technology stack

**Outputs:**
- `docs/architecture/README.md` - Overview with diagrams
- `docs/architecture/system-context.md` - High-level system view
- `docs/architecture/patterns.md` - Architectural patterns documentation

#### Phase 2: Component Documentation
1. Launch **documentation-generator** agent
2. Identify all major components/services
3. Generate component documentation for each
4. Document API contracts and interfaces
5. Map component dependencies

**Outputs:**
- `docs/components/<component-name>.md` for each component
- API documentation
- Interface specifications

#### Phase 3: Data Documentation
1. Analyze data models and schemas
2. Generate entity relationship diagrams
3. Document data flows
4. Create data dictionary

**Outputs:**
- `docs/data/data-model.md` - Complete data model
- `docs/data/er-diagram.svg` - ER diagram
- `docs/data/data-flows.md` - Data flow documentation

#### Phase 4: ADR Framework Setup
1. Create ADR directory structure
2. Generate ADR template
3. Create ADR index
4. Document existing key decisions

**Outputs:**
- `docs/adr/README.md` - ADR index and guidelines
- `docs/adr/template.md` - ADR template
- `docs/adr/0001-*.md` - Initial ADRs for major decisions

### ADR Mode (--type=adr)

Create a new Architectural Decision Record:

1. Launch **documentation-generator** agent
2. Present ADR template
3. Guide user through sections
4. Generate ADR with proper numbering
5. Update ADR index

**Interactive prompts:**
- Decision title
- Context and problem statement
- Options considered
- Decision outcome
- Rationale

**Output:**
- New ADR file: `docs/adr/00XX-decision-title.md`
- Updated index: `docs/adr/README.md`

### Component Mode (--type=component)

Generate documentation for a specific component:

1. Launch **documentation-generator** agent
2. Analyze component structure
3. Extract public APIs/interfaces
4. Map dependencies
5. Generate comprehensive component doc

**Output:**
- `docs/components/<component-name>.md` with:
  - Purpose and responsibilities
  - Architecture diagram
  - API documentation
  - Dependencies
  - Configuration
  - Monitoring metrics
  - Testing approach

## Documentation Structure

```
docs/
├── README.md                          # Documentation index
├── architecture/
│   ├── README.md                      # Architecture overview
│   ├── system-context.md              # System context
│   ├── container-diagram.md           # Container architecture
│   ├── component-architecture.md      # Component details
│   ├── data-architecture.md           # Data models
│   ├── deployment.md                  # Deployment architecture
│   └── patterns.md                    # Architectural patterns
├── adr/                               # Architectural Decision Records
│   ├── README.md                      # ADR index
│   ├── template.md                    # ADR template
│   ├── 0001-use-microservices.md
│   ├── 0002-choose-react.md
│   └── 0003-use-postgresql.md
├── components/                        # Component documentation
│   ├── auth-service.md
│   ├── user-service.md
│   └── order-service.md
├── api/                               # API documentation
│   ├── rest-api.md
│   └── graphql-schema.md
├── data/                              # Data documentation
│   ├── data-model.md
│   ├── er-diagram.svg
│   └── migrations/
│       └── README.md
└── diagrams/                          # Generated diagrams
    ├── system-context.svg
    ├── container.svg
    └── components/
        └── *.svg
```

## Documentation Standards

### Markdown Formatting
- Use GitHub-flavored markdown
- Include table of contents for long docs
- Use relative links between documents
- Keep line length under 120 characters

### Diagram Standards
- Store source code (Mermaid, PlantUML, D2) in docs
- Generate SVG/PNG for viewing
- Use consistent color schemes
- Label all connections and components

### Version Control
- Commit docs with related code changes
- Use meaningful commit messages
- Tag documentation versions
- Archive deprecated docs (don't delete)

### Review Process
- Include docs in code review
- Quarterly documentation review
- Update docs before major releases
- Mark outdated sections clearly

## Templates Provided

### 1. Architecture Overview Template
- System purpose and scope
- High-level architecture diagram
- Technology stack
- Key architectural decisions
- Cross-cutting concerns

### 2. ADR Template (MADR Format)
- Context and problem statement
- Decision drivers
- Considered options (with pros/cons)
- Decision outcome
- Consequences
- Validation criteria

### 3. Component Documentation Template
- Component overview
- Responsibilities
- Architecture diagram
- API/Interface
- Dependencies
- Configuration
- Monitoring
- Testing

### 4. Data Model Template
- Entity descriptions
- Relationships
- Business rules
- Indexes and constraints
- Data retention policies

## When to Use

**Full Documentation** (`/generate-docs`):
- New project setup
- Major refactoring completion
- Before architecture review
- For onboarding materials

**ADR Mode** (`/generate-docs --type=adr`):
- Before making significant architectural decision
- To document past decisions retroactively
- When changing architectural direction

**Component Mode** (`/generate-docs --type=component`):
- New service/component created
- Major component refactoring
- API changes
- For component handoff

## Integration with Other Tools

### With /analyze-architecture
1. Run `/analyze-architecture` first to understand system
2. Then run `/generate-docs` to document findings
3. Results from analysis feed into documentation

### With API Documenter Plugin
- Generate OpenAPI specs: `/generate-api-docs`
- Then `/generate-docs` includes API docs in component documentation

### With Git
```bash
# Create docs branch
git checkout -b docs/architecture-update

# Generate docs
/generate-docs

# Review and commit
git add docs/
git commit -m "docs: Add comprehensive architecture documentation"
git push origin docs/architecture-update
```

## Best Practices

1. **Keep Docs Close to Code**
   - Store in `/docs` directory in repository
   - Update docs in same PR as code changes

2. **Make It Searchable**
   - Use consistent terminology
   - Include glossary for domain terms
   - Tag with keywords

3. **Visual First**
   - Include diagram in every major section
   - Use diagrams to explain, text to detail

4. **Living Documentation**
   - Review quarterly
   - Delete obsolete content
   - Version important documents

5. **Write for Humans**
   - Clear, concise language
   - Explain "why" not just "what"
   - Include examples

This command creates production-ready architecture documentation that helps teams understand and maintain complex systems.
