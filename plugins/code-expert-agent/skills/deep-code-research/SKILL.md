---
name: Deep Code Research
description: This skill should be used when the user asks to "understand the codebase", "find existing implementations", "map the architecture", "research how X works", "find patterns", "prevent duplicate code", "analyze dependencies", or needs comprehensive codebase analysis before implementing features, debugging issues, or refactoring code. Provides systematic methodology for code discovery using ChunkHound semantic search.
version: 1.0.0
---

# Deep Code Research

Systematic methodology for comprehensive codebase analysis that discovers existing solutions, maps architectural relationships, and identifies patterns before coding begins.

## Purpose

Perform READ-ONLY analysis to:
- **Discover** existing implementations and reusable components
- **Map** dependencies and architectural relationships
- **Identify** coding conventions and design patterns
- **Prevent** duplicate code by finding what already exists

## When to Apply This Methodology

### Before Adding Features
```
user: "I need to add authentication to this endpoint"
→ Research existing auth middleware, patterns, and reusable components first
```

### Before Debugging
```
user: "Payment processing is failing"
→ Map the complete payment flow and identify all connected components
```

### Before Refactoring
```
user: "Validation logic is scattered everywhere"
→ Find all validation patterns and consolidation opportunities
```

## 5-Phase Research Methodology

### Phase 1: Discovery

Start broad to understand project context:

1. **Documentation Review**
   - Read README.md for project overview
   - Check docs/ directory for architecture docs
   - Find CONTRIBUTING.md for conventions

2. **Configuration Analysis**
   - Examine package.json, tsconfig.json, etc.
   - Check environment configuration patterns
   - Identify external dependencies

3. **Entry Points**
   - Locate main entry files (index.ts, main.ts, app.ts)
   - Find route definitions and API handlers
   - Identify initialization sequences

4. **Semantic Search** (if ChunkHound available)
   ```
   Use mcp__ChunkHound__search_semantic for concept searches:
   - "authentication middleware"
   - "error handling patterns"
   - "database connection management"
   ```

### Phase 2: Code Mapping

Build a mental model of the codebase:

1. **Directory Structure**
   - Map module organization
   - Identify layer boundaries (controllers, services, models)
   - Understand naming conventions

2. **Component Boundaries**
   - Identify distinct modules/packages
   - Map public interfaces vs internal implementation
   - Document cross-module dependencies

3. **Data Flow**
   - Trace request/response paths
   - Identify data transformation points
   - Map state management patterns

### Phase 3: Pattern Analysis

Recognize consistent patterns:

1. **Design Patterns**
   - Factory, Strategy, Observer patterns
   - Dependency injection approaches
   - Repository patterns for data access

2. **Coding Conventions**
   - Naming conventions (camelCase, snake_case)
   - File organization patterns
   - Import/export styles

3. **Reusable Components**
   - Utility functions and helpers
   - Shared types and interfaces
   - Common middleware

4. **Technical Debt**
   - TODO/FIXME comments
   - Inconsistent patterns
   - Deprecated approaches

### Phase 4: Deep Investigation

For each relevant component:

1. **Purpose & Responsibilities**
   - What problem does it solve?
   - What are its boundaries?

2. **Key Functions/Classes**
   - Entry points and public APIs
   - Core logic implementation
   - Helper functions

3. **Dependencies**
   - What does it depend on?
   - What depends on it?
   - External service integrations

4. **Edge Cases**
   - Error handling patterns
   - Validation logic
   - Boundary conditions

### Phase 5: Search Strategy

Effective search patterns:

1. **Semantic Search First**
   - Use natural language concepts
   - Search for functionality, not syntax
   - Example: "user authentication flow"

2. **Regex for Specifics**
   - Search for specific patterns
   - Find function/class definitions
   - Example: `function validate.*\(`

3. **Iterative Refinement**
   - Start broad, narrow based on results
   - Cross-reference multiple searches
   - Validate findings in context

## Output Format

Structure findings for clarity:

```markdown
## Overview
[System/feature purpose and design approach]

## Structure & Organization
[Directory layout and module organization]
[Key design decisions observed]

## Component Analysis

### [Component Name]
- **Purpose**: What it does and why
- **Location**: src/services/auth.ts
- **Key Elements**:
  - `AuthService` class (line 15-120)
  - `validateToken()` function (line 45)
- **Dependencies**: jwt library, UserRepository
- **Patterns**: Singleton pattern, dependency injection

## Data & Control Flow
[How data moves through relevant components]

## Patterns & Conventions
[Consistent patterns across codebase]

## Key Findings
- Existing solution at src/middleware/auth.ts:23
- Reusable validator at src/utils/validation.ts
- Consider extending AuthService rather than creating new

## Relevant Code References
- src/services/auth.ts:45-67 - Token validation logic
- src/middleware/auth.ts:12-34 - Request authentication
```

## Using ChunkHound Tools

When ChunkHound MCP is configured, use these tools:

### Semantic Search
```
mcp__ChunkHound__search_semantic
- Query: "authentication middleware implementation"
- Returns: Conceptually related code chunks
```

### Regex Search
```
mcp__ChunkHound__search_regex
- Pattern: "class.*Service"
- Returns: All service class definitions
```

### Health Check
```
mcp__ChunkHound__health_check
- Verify ChunkHound is running
- Check index status
```

## Quality Principles

1. **Always provide file:line references**
   - Not just "in the auth module"
   - But "src/services/auth.ts:45-67"

2. **Explain the 'why'**
   - Why is code organized this way?
   - What problem does this pattern solve?

3. **Connect to the task**
   - How do findings relate to current work?
   - What can be reused vs created new?

4. **Be actionable**
   - Specific recommendations
   - Clear next steps

## Best Practices

1. **Research First, Code Later**
   - Always understand before implementing
   - 10 minutes of research saves hours of refactoring

2. **Be Specific**
   - Ask about specific features or patterns
   - Narrow scope for better results

3. **Iterate**
   - Start broad, refine based on findings
   - Follow the dependency chain

4. **Prevent Duplication**
   - Check for existing solutions
   - Extend rather than recreate

5. **Document Findings**
   - Share knowledge with the team
   - Update architecture docs

## Additional Resources

### Reference Files
- **`references/chunkhound-setup.md`** - ChunkHound installation and configuration

### External Resources
- [ChunkHound Documentation](https://chunkhound.github.io/)
