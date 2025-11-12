# Code Expert Agent Plugin

Deep code research agent powered by ChunkHound for comprehensive codebase analysis.

## Overview

The Code Expert Agent performs iterative, comprehensive analysis that discovers existing solutions, maps architectural relationships, and identifies patterns before any coding begins. This READ-ONLY agent prevents duplicate implementations by finding what already exists and understanding how it fits in your codebase.

## Key Features

- **Discovery**: Finding existing implementations and reusable components
- **Mapping**: Tracing dependencies and architectural relationships
- **Pattern Analysis**: Identifying coding conventions and design decisions
- **Prevention**: Avoiding duplicate code and maintaining consistency

## Prerequisites

Before using this plugin, you must have ChunkHound installed and configured:

1. **Install ChunkHound**:
   ```bash
   npm install -g chunkhound
   # or
   pip install chunkhound
   ```

2. **Configure ChunkHound with semantic search**:
   - Requires an embedding provider (OpenAI or VoyageAI)
   - Follow the [ChunkHound Quickstart Guide](https://chunkhound.github.io/)

3. **Index your codebase**:
   ```bash
   chunkhound index /path/to/your/project
   ```

## Installation

1. This plugin is already registered in the marketplace.json
2. Update the MCP configuration path in `.claude/mcp.json`:
   ```json
   {
     "servers": {
       "chunkhound": {
         "type": "stdio",
         "command": "chunkhound",
         "args": ["mcp", "/path/to/your/project"]
       }
     }
   }
   ```
   **Important**: Replace `/path/to/your/project` with the actual path to your project directory.

3. Restart Claude Code to load the plugin

## Usage

### Basic Usage

Instead of diving straight into implementation, use the Code Expert agent to research first:

**Before:**
```
"Add rate limiting to the API"
```

**Better:**
```
"Use code expert to research our current rate limiting approach,
find existing middleware, and understand configuration patterns
before implementation."
```

### Example Scenarios

#### Feature Development
```
user: "I need to add authentication to this new endpoint"
assistant: "Let me perform code deep research to understand our
existing authentication architecture first"
```

The agent will:
- Discover existing auth middleware
- Map authentication flow
- Identify reusable components
- Document configuration patterns

#### Debugging
```
user: "Payment processing is failing intermittently"
assistant: "I'll use code deep research to map the complete
payment flow and identify all connected components"
```

The agent will:
- Trace payment entry through processing
- Map validation and storage logic
- Document notification systems
- Identify integration points

#### Refactoring
```
user: "This validation logic is scattered everywhere"
assistant: "Let me research all validation patterns in the
codebase before we refactor"
```

The agent will:
- Find all validators
- Identify common patterns
- Map dependencies
- Suggest consolidation opportunities

## Research Methodology

The agent follows a 5-phase approach:

1. **Discovery Phase**: Context gathering from docs, configs, and entry points
2. **Code Mapping**: Structure analysis and relationship mapping
3. **Pattern Analysis**: Design patterns and coding conventions
4. **Deep Investigation**: Component-level analysis with specific references
5. **Search Strategy**: Semantic and regex searches with refinement

## Output Format

The agent provides structured analysis including:

- Overview of system/feature
- Directory structure and organization
- Component analysis with file locations
- Data and control flow mapping
- Patterns and conventions
- Integration points
- Key findings with actionable insights
- Relevant code chunks with line numbers

## MCP Tools Available

The agent has access to:

- `mcp__ChunkHound__search_semantic` - Concept and relationship discovery
- `mcp__ChunkHound__search_regex` - Pattern and syntax matching
- `mcp__ChunkHound__get_stats` - Repository statistics
- `mcp__ChunkHound__health_check` - Connection verification

Plus standard tools: Glob, Grep, Bash, Read, TodoWrite

## Troubleshooting

### Agent tools not available

If MCP tools aren't showing up:

1. Verify ChunkHound is installed:
   ```bash
   chunkhound --version
   ```

2. Check MCP configuration path is correct in `.claude/mcp.json`

3. Ensure your project is indexed:
   ```bash
   chunkhound stats /path/to/your/project
   ```

4. Restart Claude Code

### Semantic search not working

- Verify embedding provider is configured
- Check ChunkHound logs
- Ensure API keys are set for OpenAI or VoyageAI

## Best Practices

1. **Use before implementation**: Always research before coding
2. **Specific queries**: Ask about specific features or patterns
3. **Iterative refinement**: Start broad, then narrow down
4. **Read-only mindset**: Remember this agent analyzes, doesn't modify
5. **Leverage findings**: Use the specific file:line references provided

## Resources

- [ChunkHound Documentation](https://chunkhound.github.io/)
- [Code Expert Agent Guide](https://chunkhound.github.io/code-expert-agent/)
- [Model Context Protocol (MCP)](https://modelcontextprotocol.io/)

## Version

Current version: 1.0.0

## Author

Yannick De Backer (yannick@kobozo.eu)

## Category

Development / Code Analysis
