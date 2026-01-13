---
description: "Start Ralph multi-agent loop in current session"
argument-hint: "PROMPT [--max-iterations N] [--completion-promise TEXT] [--skip-docs]"
allowed-tools: ["Bash(${CLAUDE_PLUGIN_ROOT}/scripts/setup-ralph-loop.sh:*)"]
hide-from-slash-command-tool: "true"
---

# Ralph Multi-Agent Loop Command

Execute the setup script to initialize the Ralph multi-agent workflow:

```!
"${CLAUDE_PLUGIN_ROOT}/scripts/setup-ralph-loop.sh" $ARGUMENTS
```

## Multi-Agent Workflow

This loop uses specialized agents in sequence:

1. **Dev Agent** - Implements the task
2. **Code Review Agent** - Reviews code quality, can reject back to Dev
3. **QA Agent** - Tests functionality, can reject back to Dev
4. **Doc Writer Agent** - Updates documentation (skipped if --skip-docs)

Each agent reads from and writes to the shared state file at `.claude/ralph-loop.local.md`.

## Options

- `--max-iterations N` - Maximum total iterations across all agents
- `--completion-promise TEXT` - Promise phrase to signal completion
- `--skip-docs` - Skip the documentation stage

## How It Works

When you try to exit, the stop hook checks the current stage and either:
- Transitions to the next agent, OR
- Sends rejection feedback back to the Dev agent

The loop continues until:
- All stages complete (including docs), OR
- Max iterations reached, OR
- Completion promise is output

CRITICAL RULE: If a completion promise is set, you may ONLY output it when the statement is completely and unequivocally TRUE. Do not output false promises to escape the loop.
