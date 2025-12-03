# ChunkHound Setup Guide

## Installation

```bash
npm install -g chunkhound
```

## Configuration

### 1. Configure Embedding Provider

ChunkHound supports OpenAI or VoyageAI for embeddings.

**OpenAI:**
```bash
export OPENAI_API_KEY=your-key-here
```

**VoyageAI:**
```bash
export VOYAGE_API_KEY=your-key-here
```

### 2. Index Your Codebase

```bash
chunkhound index /path/to/your/project
```

Options:
- `--exclude` - Patterns to exclude (default: node_modules, .git)
- `--include` - File patterns to include
- `--chunk-size` - Size of code chunks (default: 500)

### 3. Configure MCP Server

Add to `.claude/mcp.json`:

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

Or in plugin's `.claude-plugin/plugin.json`:

```json
{
  "mcpServers": {
    "ChunkHound": {
      "type": "stdio",
      "command": "chunkhound",
      "args": ["mcp", "${CLAUDE_PROJECT_DIR}"]
    }
  }
}
```

## Available MCP Tools

### mcp__ChunkHound__search_semantic

Semantic search for conceptually related code.

**Parameters:**
- `query` (string): Natural language query
- `limit` (number, optional): Max results (default: 10)

**Example:**
```
Query: "user authentication and session management"
Returns: Code chunks related to auth, even if they don't contain exact keywords
```

### mcp__ChunkHound__search_regex

Pattern-based search across indexed code.

**Parameters:**
- `pattern` (string): Regex pattern
- `limit` (number, optional): Max results

**Example:**
```
Pattern: "async function validate.*\("
Returns: All async validation functions
```

### mcp__ChunkHound__health_check

Check ChunkHound server status.

**Returns:**
- Index status
- Number of chunks indexed
- Last index time

### mcp__ChunkHound__get_stats

Get indexing statistics.

**Returns:**
- Files indexed
- Total chunks
- Languages detected
- Index size

## Troubleshooting

### "ChunkHound not found"
```bash
# Verify installation
which chunkhound

# Reinstall if needed
npm install -g chunkhound
```

### "Index not found"
```bash
# Re-index the project
chunkhound index /path/to/project
```

### "MCP connection failed"
- Check mcp.json syntax
- Verify path to project
- Restart Claude Code session

## Best Practices

1. **Re-index after major changes**
   ```bash
   chunkhound index --force /path/to/project
   ```

2. **Use project-relative paths**
   ```json
   "args": ["mcp", "${CLAUDE_PROJECT_DIR}"]
   ```

3. **Exclude generated files**
   ```bash
   chunkhound index --exclude "dist,build,*.min.js"
   ```
