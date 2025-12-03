# Code Expert Agent Plugin

Deep code research skill and agent powered by ChunkHound for comprehensive codebase analysis.

## Overview

This plugin provides a **skill** that teaches Claude systematic code research methodology, plus an **agent** for structured analysis. The methodology discovers existing solutions, maps architectural relationships, and identifies patterns before any coding begins - preventing duplicate implementations.

## What Changed in v2.0.0

- **Converted from command to skill**: No longer requires `/code-expert` invocation
- **Always-available methodology**: Claude automatically applies deep research when needed
- **Agent still available**: Use Task tool with `code-expert-agent:Code Expert` for structured output

## Key Features

- **Skill**: Contextual knowledge about code research methodology (always active)
- **Agent**: Structured READ-ONLY analysis with specific tool permissions
- **Discovery**: Finding existing implementations and reusable components
- **Mapping**: Tracing dependencies and architectural relationships
- **Pattern Analysis**: Identifying coding conventions and design decisions
- **Prevention**: Avoiding duplicate code and maintaining consistency

## How It Works Now

### Automatic (via Skill)

Claude automatically applies deep research methodology when you ask:
- "How is authentication implemented?"
- "Find existing validation patterns"
- "Map the payment processing flow"
- "Understand the error handling architecture"

The skill provides the systematic 5-phase research methodology without explicit invocation.

### Structured Output (via Agent)

For detailed, structured analysis, use the Task tool:
```
Use the Task tool with subagent_type="code-expert-agent:Code Expert" to research authentication architecture
```

## Prerequisites

Before using this plugin, you must have ChunkHound installed and configured:

1. **Install ChunkHound**:
   ```bash
   npm install -g chunkhound
   ```

2. **Configure embedding provider** (OpenAI or VoyageAI):
   ```bash
   export OPENAI_API_KEY=your-key-here
   # or
   export VOYAGE_API_KEY=your-key-here
   ```

3. **Index your codebase**:
   ```bash
   chunkhound index /path/to/your/project
   ```

4. **Configure MCP** in `.claude/mcp.json`:
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

## Research Methodology (5 Phases)

1. **Discovery Phase**: Context from docs, configs, entry points
2. **Code Mapping**: Structure analysis, relationship mapping
3. **Pattern Analysis**: Design patterns, coding conventions
4. **Deep Investigation**: Component-level analysis with file:line refs
5. **Search Strategy**: Semantic + regex searches with refinement

## Example Scenarios

### Feature Development
```
user: "I need to add rate limiting to the API"
Claude: [Automatically applies research methodology]
- Discovers existing middleware
- Maps current request flow
- Identifies reusable components
- Documents configuration patterns
```

### Debugging
```
user: "Payment processing is failing"
Claude: [Applies deep research]
- Traces payment entry through processing
- Maps validation and storage logic
- Documents notification systems
- Identifies integration points
```

### Refactoring
```
user: "Validation logic is scattered everywhere"
Claude: [Researches first]
- Finds all validators
- Identifies common patterns
- Maps dependencies
- Suggests consolidation opportunities
```

## MCP Tools Available

When ChunkHound is configured:

- `mcp__ChunkHound__search_semantic` - Concept discovery
- `mcp__ChunkHound__search_regex` - Pattern matching
- `mcp__ChunkHound__get_stats` - Repository statistics
- `mcp__ChunkHound__health_check` - Connection verification

## Plugin Structure

```
code-expert-agent/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   └── deep-code-research/
│       ├── SKILL.md              # Research methodology
│       └── references/
│           └── chunkhound-setup.md
├── agents/
│   └── code-expert.md            # Structured analysis agent
└── README.md
```

## Troubleshooting

### ChunkHound tools not available
1. Verify installation: `chunkhound --version`
2. Check MCP configuration path
3. Ensure project is indexed: `chunkhound stats /path/to/project`
4. Restart Claude Code

### Semantic search not working
- Verify embedding provider API key is set
- Check ChunkHound logs
- Re-index if needed: `chunkhound index --force /path/to/project`

## Best Practices

1. **Let Claude research automatically**: Don't force `/code-expert`, let the skill guide naturally
2. **Ask specific questions**: More specific = better results
3. **Use file:line references**: Leverage the specific code references provided
4. **Research before coding**: 10 minutes of research saves hours of refactoring

## Resources

- [ChunkHound Documentation](https://chunkhound.github.io/)
- [Model Context Protocol (MCP)](https://modelcontextprotocol.io/)

## Version

Current version: 2.0.0

## Author

Yannick De Backer (yannick@kobozo.eu)

## Category

Development / Code Analysis
