---
description: Analyze codebase architecture and generate comprehensive documentation with dependency graphs and visualizations
---

# Analyze Architecture

Perform a complete architectural analysis of your codebase with dependency graphs, component mapping, and visual diagrams.

## Usage

```
/analyze-architecture [--output=docs/architecture] [--format=markdown|html]
```

**Examples:**
```
/analyze-architecture
/analyze-architecture --output=docs/architecture
/analyze-architecture --format=html
```

## Execution Flow

### Phase 1: Dependency Analysis
1. Launch **dependency-analyzer** agent
2. Parse codebase using AST (ast-grep, code-to-tree MCP servers)
3. Extract import/export relationships
4. Detect circular dependencies
5. Identify unused dependencies
6. Generate dependency graphs using Mermaid MCP server

**Outputs:**
- Dependency tree visualization
- Circular dependency report
- Unused dependency list
- Module relationship graph

### Phase 2: Architecture Mapping
1. Launch **architecture-mapper** agent
2. Identify architectural pattern (microservices, layered, etc.)
3. Map component boundaries and relationships
4. Generate C4 model diagrams using UML-MCP server
5. Create sequence diagrams for key flows
6. Document deployment architecture

**Outputs:**
- C4 Context diagram
- C4 Container diagram
- C4 Component diagrams
- Sequence diagrams for critical flows
- Deployment architecture diagram

### Phase 3: Documentation Generation
1. Launch **documentation-generator** agent
2. Compile analysis results
3. Generate architecture overview document
4. Create component documentation
5. Document data models and relationships

**Outputs:**
- Architecture overview (markdown)
- Component documentation
- Data model documentation
- Technology stack inventory

## MCP Servers Used

### AST Analysis
- **@ast-grep/mcp**: Pattern-based code structure analysis
- **code-to-tree**: Language-agnostic AST parsing

### Visualization
- **@longjianjiang/mermaid-mcp-server**: Dependency graphs and flow diagrams
- **uml-mcp**: UML, PlantUML, C4, D2 diagram generation
- **diagram-bridge-mcp**: Intelligent diagram rendering via Kroki

## Output Structure

```
docs/architecture/
├── README.md                    # Architecture overview with diagrams
├── dependency-analysis.md       # Dependency tree and issues
├── component-architecture.md    # Component diagrams and docs
├── data-architecture.md         # Data models and ER diagrams
├── deployment.md               # Deployment architecture
└── diagrams/
    ├── system-context.svg
    ├── container-diagram.svg
    ├── dependency-graph.svg
    └── component-*.svg
```

## Analysis Report Contents

### 1. Executive Summary
- Architecture style identified
- Total components/modules
- Critical issues found
- Recommendations

### 2. Dependency Analysis
- Module dependency graph (visual)
- Circular dependencies (with paths)
- Unused dependencies
- Missing dependencies
- Dependency depth analysis

### 3. Component Architecture
- C4 Context diagram
- C4 Container diagram
- Component relationships
- Integration points
- API contracts

### 4. Data Architecture
- Entity relationship diagram
- Database schema overview
- Data flow patterns
- Caching strategy

### 5. Recommendations
- Architecture improvements
- Refactoring opportunities
- Technical debt items
- Performance optimizations

## When to Use

- Starting work on an unfamiliar codebase
- Before major refactoring
- During architecture reviews
- For onboarding documentation
- When planning system migrations
- To identify technical debt

## Advanced Options

```
/analyze-architecture --deep            # Include file-level analysis
/analyze-architecture --focus=services  # Analyze specific directory
/analyze-architecture --with-metrics    # Include complexity metrics
```

This command creates comprehensive architecture documentation with interactive diagrams and actionable insights.
