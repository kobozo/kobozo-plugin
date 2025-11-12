---
description: Deep code research agent for comprehensive codebase analysis before coding
---

# Code Expert

Perform comprehensive code research to discover existing solutions, map architectural relationships, and identify patterns before implementing any changes.

## Usage

```bash
/code-expert [research topic or question]
```

**Examples:**
```bash
/code-expert "How is authentication implemented in this codebase?"
/code-expert "Find all validation patterns and reusable validators"
/code-expert "Map the payment processing flow from entry to storage"
/code-expert "Analyze the error handling architecture"
```

## What This Command Does

The Code Expert agent performs READ-ONLY analysis to:

1. **Discover** existing implementations and reusable components
2. **Map** dependencies and architectural relationships
3. **Identify** coding conventions and design patterns
4. **Prevent** duplicate code by finding what already exists

## When to Use

### Before Adding Features
```
user: "I need to add rate limiting to the API"
/code-expert "Find existing rate limiting middleware and configuration patterns"
```

### Before Debugging
```
user: "Payment processing is failing"
/code-expert "Map the complete payment processing flow and identify all components"
```

### Before Refactoring
```
user: "Validation logic is scattered everywhere"
/code-expert "Find all validation patterns and suggest consolidation opportunities"
```

## Research Methodology

The agent follows a systematic 5-phase approach:

1. **Discovery Phase**
   - README and documentation review
   - Configuration file analysis
   - Entry point identification
   - Semantic search for key concepts

2. **Code Mapping**
   - Directory structure analysis
   - Component boundary identification
   - Data flow tracing
   - Interface documentation

3. **Pattern Analysis**
   - Design pattern identification
   - Coding convention recognition
   - Reusable component discovery
   - Technical debt spotting

4. **Deep Investigation**
   - Component purpose and responsibilities
   - Key functions/classes analysis
   - Dependency mapping
   - Performance considerations

5. **Search Strategy**
   - Semantic search for concepts
   - Regex search for patterns
   - Cross-reference validation
   - Iterative refinement

## Output Format

You'll receive a structured analysis including:

- **Overview**: System/feature purpose and design approach
- **Structure**: Directory layout and organization
- **Component Analysis**: Detailed breakdown with file:line references
- **Data Flow**: How data moves through the system
- **Patterns**: Consistent conventions observed
- **Integration Points**: APIs and external systems
- **Key Findings**: Actionable insights with specific code references

## Requirements

This plugin requires ChunkHound to be installed and configured:

1. **Install ChunkHound**:
   ```bash
   npm install -g chunkhound
   ```

2. **Configure embedding provider** (OpenAI or VoyageAI)

3. **Index your codebase**:
   ```bash
   chunkhound index /path/to/your/project
   ```

4. **Update MCP configuration** in `.claude/mcp.json`:
   ```json
   {
     "servers": {
       "ChunkHound": {
         "type": "stdio",
         "command": "chunkhound",
         "args": ["mcp", "/path/to/your/project"]
       }
     }
   }
   ```

## Best Practices

1. **Research First, Code Later**: Always use this before implementing changes
2. **Be Specific**: Ask about specific features or patterns
3. **Iterate**: Start broad, then narrow based on findings
4. **Use References**: Leverage the file:line references provided
5. **Prevent Duplication**: Check for existing solutions before creating new code

## Tips

- The more specific your research question, the better the analysis
- Combine with standard code exploration for comprehensive understanding
- Use the findings to inform your implementation approach
- Remember: This is READ-ONLY analysis - no code modifications

## Resources

- [ChunkHound Documentation](https://chunkhound.github.io/)
- [Code Expert Agent Guide](https://chunkhound.github.io/code-expert-agent/)

ARGUMENTS: {{ARGUMENTS}}

Use the Task tool to launch the code-expert agent with the research topic: "{{ARGUMENTS}}"
