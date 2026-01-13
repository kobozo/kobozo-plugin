# Ralph Wiggum Plugin

Implementation of the Ralph Wiggum technique for iterative, self-referential AI development loops in Claude Code.

## What is Ralph?

Ralph is a development methodology based on continuous AI agent loops. As Geoffrey Huntley describes it: **"Ralph is a Bash loop"** - a simple `while true` that repeatedly feeds an AI agent a prompt file, allowing it to iteratively improve its work until completion.

The technique is named after Ralph Wiggum from The Simpsons, embodying the philosophy of persistent iteration despite setbacks.

## Multi-Agent Workflow

This plugin now supports a **multi-agent workflow** with specialized agents:

```
┌─────┐    ┌─────────────┐    ┌─────┐    ┌──────┐
│ Dev │───▶│ Code Review │───▶│ QA  │───▶│ Docs │──▶ Done
└─────┘    └─────────────┘    └─────┘    └──────┘
    ▲            │                │
    │            │ reject         │ reject
    └────────────┴────────────────┘
          (targeted feedback)
```

**How it works:**
1. **Dev Agent** - Implements the task
2. **Code Review Agent** - Reviews for quality, can reject with specific issues
3. **QA Agent** - Tests functionality, can reject with test failures
4. **Doc Writer Agent** - Updates documentation (optional with `--skip-docs`)

Each agent can send targeted feedback back to the Dev agent, who addresses specific issues without restarting the entire task.

### Core Concept

This plugin implements Ralph using a **Stop hook** that intercepts Claude's exit attempts:

```bash
# You run ONCE:
/ralph-loop "Your task description" --completion-promise "DONE"

# Then Claude Code automatically:
# 1. Dev Agent works on the task
# 2. Tries to exit → Stop hook routes to Code Review Agent
# 3. Code Review approves or rejects with feedback
# 4. If rejected, Dev Agent addresses specific issues
# 5. Repeat through all stages until complete
```

The loop happens **inside your current session** - you don't need external bash loops. The Stop hook in `hooks/stop-hook.sh` creates the self-referential feedback loop and routes to appropriate agents.

This creates a **self-referential feedback loop** where:
- The prompt never changes between iterations
- Claude's previous work persists in files
- Each iteration sees modified files and git history
- Agents communicate via a shared state file
- Reviewers provide specific, actionable feedback

## Quick Start

```bash
/ralph-loop "Build a REST API for todos. Requirements: CRUD operations, input validation, tests. Output <promise>COMPLETE</promise> when done." --completion-promise "COMPLETE" --max-iterations 50
```

Claude will:
- Implement the API iteratively
- Run tests and see failures
- Fix bugs based on test output
- Iterate until all requirements met
- Output the completion promise when done

## Commands

### /ralph-loop

Start a Ralph loop in your current session.

**Usage:**
```bash
/ralph-loop "<prompt>" --max-iterations <n> --completion-promise "<text>"
```

**Options:**
- `--max-iterations <n>` - Stop after N iterations (default: unlimited)
- `--completion-promise <text>` - Phrase that signals completion
- `--skip-docs` - Skip the documentation stage

## State File

The multi-agent workflow uses a state file at `.claude/ralph-loop.local.md` with YAML frontmatter:

```yaml
---
active: true
iteration: 1
stage: dev
current_agent: dev-agent
feedback_history: []
---

## Original Task
Your task description here
```

**Stages:** `dev` → `code-review` → `qa` → `docs` → `complete`

Agents transition between stages by updating the state file. Rejections add entries to `feedback_history` with specific issues to address.

### /cancel-ralph

Cancel the active Ralph loop.

**Usage:**
```bash
/cancel-ralph
```

## Prompt Writing Best Practices

### 1. Clear Completion Criteria

❌ Bad: "Build a todo API and make it good."

✅ Good:
```markdown
Build a REST API for todos.

When complete:
- All CRUD endpoints working
- Input validation in place
- Tests passing (coverage > 80%)
- README with API docs
- Output: <promise>COMPLETE</promise>
```

### 2. Incremental Goals

❌ Bad: "Create a complete e-commerce platform."

✅ Good:
```markdown
Phase 1: User authentication (JWT, tests)
Phase 2: Product catalog (list/search, tests)
Phase 3: Shopping cart (add/remove, tests)

Output <promise>COMPLETE</promise> when all phases done.
```

### 3. Self-Correction

❌ Bad: "Write code for feature X."

✅ Good:
```markdown
Implement feature X following TDD:
1. Write failing tests
2. Implement feature
3. Run tests
4. If any fail, debug and fix
5. Refactor if needed
6. Repeat until all green
7. Output: <promise>COMPLETE</promise>
```

### 4. Escape Hatches

Always use `--max-iterations` as a safety net to prevent infinite loops on impossible tasks:

```bash
# Recommended: Always set a reasonable iteration limit
/ralph-loop "Try to implement feature X" --max-iterations 20

# In your prompt, include what to do if stuck:
# "After 15 iterations, if not complete:
#  - Document what's blocking progress
#  - List what was attempted
#  - Suggest alternative approaches"
```

**Note**: The `--completion-promise` uses exact string matching, so you cannot use it for multiple completion conditions (like "SUCCESS" vs "BLOCKED"). Always rely on `--max-iterations` as your primary safety mechanism.

## Philosophy

Ralph embodies several key principles:

### 1. Iteration > Perfection
Don't aim for perfect on first try. Let the loop refine the work.

### 2. Failures Are Data
"Deterministically bad" means failures are predictable and informative. Use them to tune prompts.

### 3. Operator Skill Matters
Success depends on writing good prompts, not just having a good model.

### 4. Persistence Wins
Keep trying until success. The loop handles retry logic automatically.

## When to Use Ralph

**Good for:**
- Well-defined tasks with clear success criteria
- Tasks requiring iteration and refinement (e.g., getting tests to pass)
- Greenfield projects where you can walk away
- Tasks with automatic verification (tests, linters)

**Not good for:**
- Tasks requiring human judgment or design decisions
- One-shot operations
- Tasks with unclear success criteria
- Production debugging (use targeted debugging instead)

## Real-World Results

- Successfully generated 6 repositories overnight in Y Combinator hackathon testing
- One $50k contract completed for $297 in API costs
- Created entire programming language ("cursed") over 3 months using this approach

## Learn More

- Original technique: https://ghuntley.com/ralph/
- Ralph Orchestrator: https://github.com/mikeyobrien/ralph-orchestrator

## For Help

Run `/help` in Claude Code for detailed command reference and examples.
