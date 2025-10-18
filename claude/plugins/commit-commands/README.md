# Commit Commands

**Version:** 1.0.0
**Author:** Anthropic
**Type:** Official Claude Code Plugin

> This is an **official Claude Code plugin** from Anthropic, synced from the official Claude Code plugins repository.

## Overview

The commit-commands plugin provides convenient slash commands for common git workflow operations, streamlining the process of committing changes, pushing code, and cleaning up branches.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Commands](#commands)
  - [/commit](#commit)
  - [/commit-push-pr](#commit-push-pr)
  - [/clean_gone](#clean_gone)
- [Usage Examples](#usage-examples)
- [Best Practices](#best-practices)
- [Tips](#tips)

## Features

- **Simple Git Commits**: Create commits with a single command
- **Integrated Workflow**: Commit, push, and create PR in one step
- **Branch Cleanup**: Remove stale local branches that have been deleted on remote
- **Context-Aware**: Uses current git status and recent commits for better commit messages
- **Minimal Tool Usage**: Focused commands that do exactly what they say

## Installation

This plugin is part of the official Claude plugins. If you have it synced in your marketplace:

```bash
/plugin install commit-commands@kobozo-plugins
```

Or from the official source if available in your Claude Code installation.

## Commands

### /commit

Create a git commit based on current changes.

**Usage:**
```bash
/commit
```

**What it does:**
1. Analyzes current git status
2. Reviews staged and unstaged changes (git diff)
3. Checks current branch
4. Reviews recent commit messages (last 10)
5. Stages relevant changes
6. Creates a commit with an appropriate message

**Context Provided:**
- Current git status
- Git diff (staged and unstaged)
- Current branch name
- Recent commits (last 10)

**Example:**
```bash
# After making changes to your code
/commit

# Claude will:
# - Review your changes
# - Stage appropriate files
# - Create a commit with a meaningful message
```

**Output:**
```bash
git add src/components/Button.tsx
git commit -m "Add hover state to Button component

- Add :hover styles with transition
- Update Button props to accept hoverColor
- Add storybook example for hover state"
```

---

### /commit-push-pr

Commit changes, push to remote, and open a pull request in one command.

**Usage:**
```bash
/commit-push-pr
```

**What it does:**
1. Performs all steps from `/commit`
2. Pushes changes to remote branch
3. Opens a pull request via `gh pr create`

**Requirements:**
- GitHub CLI (`gh`) installed and authenticated
- Current branch pushed to remote (or will be pushed)
- Repository has a remote configured

**Example:**
```bash
# Complete workflow in one command
/commit-push-pr

# Claude will:
# 1. Stage and commit changes
# 2. Push to remote
# 3. Create PR with title and description
```

**Output:**
```bash
# Stage files
git add src/components/Button.tsx
git add src/components/Button.test.tsx

# Create commit
git commit -m "Add hover state to Button component"

# Push to remote
git push origin feature/button-hover

# Create PR
gh pr create --title "Add hover state to Button component" \
  --body "Implements hover state with smooth transitions..."

# Output: https://github.com/user/repo/pull/123
```

---

### /clean_gone

Clean up local branches that have been deleted on the remote.

**Usage:**
```bash
/clean_gone
```

**What it does:**
1. Identifies local branches marked as `[gone]` (deleted on remote)
2. Removes associated worktrees if any
3. Deletes the local branches
4. Provides a summary of cleaned branches

**When to use:**
- After merging pull requests that delete branches
- During regular repository maintenance
- When `git branch -vv` shows many `[gone]` branches

**Example:**
```bash
/clean_gone

# Claude will identify and remove branches like:
# - feature/old-feature [gone]
# - bugfix/issue-123 [gone]
# - experiment/try-this [gone]
```

**Output:**
```bash
# Removing worktrees for gone branches
git worktree remove /path/to/worktree/feature-old-feature

# Deleting gone branches
git branch -D feature/old-feature
git branch -D bugfix/issue-123
git branch -D experiment/try-this

# Summary
Cleaned up 3 local branches that were deleted on remote:
- feature/old-feature
- bugfix/issue-123
- experiment/try-this
```

---

## Usage Examples

### Example 1: Quick Commit

```bash
# Make some changes
vim src/components/Header.tsx

# Commit them
/commit

# Result: Commit created with appropriate message
```

### Example 2: Feature Branch Workflow

```bash
# Create feature branch
git checkout -b feature/new-dashboard

# Make changes...
# ...

# Commit, push, and create PR
/commit-push-pr

# Result: PR created at https://github.com/user/repo/pull/456
```

### Example 3: Weekly Cleanup

```bash
# Every Friday, clean up merged branches
/clean_gone

# Result:
# Cleaned up 5 local branches:
# - feature/add-auth
# - feature/update-deps
# - bugfix/fix-login
# - feature/new-api
# - hotfix/security-patch
```

### Example 4: Rapid Development Cycle

```bash
# Make changes
vim src/app.ts

# Quick commit
/commit

# Continue work...
vim src/utils.ts

# Another commit
/commit

# Ready for PR
git checkout -b feature/improvements
git rebase -i main  # Clean up commits
/commit-push-pr
```

## Best Practices

### Commit Messages

The `/commit` command analyzes your recent commits to match your project's style:

- **Conventional Commits**: If your repo uses `feat:`, `fix:`, etc., Claude will follow that pattern
- **Issue References**: If commits reference issues like `#123`, Claude will include them
- **Scope**: If commits include scope like `feat(api):`, Claude will determine appropriate scope
- **Body Format**: Claude matches multi-line commit body style from recent commits

### When to Use Each Command

**Use `/commit` when:**
- You want to commit without pushing
- You're making multiple commits before pushing
- You want to review the commit before pushing
- You're working on a local branch experiment

**Use `/commit-push-pr` when:**
- Your changes are ready for review
- You want to create a PR immediately
- You're following a trunk-based development workflow
- Your team reviews all changes via PR

**Use `/clean_gone` when:**
- After merging several PRs
- Your `git branch` output is cluttered
- Weekly/monthly repository maintenance
- Before starting new work to clean workspace

### Git Workflow Integration

These commands integrate well with common workflows:

**GitHub Flow:**
```bash
git checkout -b feature/new-feature
# ... make changes ...
/commit-push-pr
# ... address review comments ...
/commit
git push
```

**Trunk-Based Development:**
```bash
git checkout -b short-lived-branch
# ... make small changes ...
/commit-push-pr
# ... merge quickly ...
/clean_gone
```

**Gitflow:**
```bash
git checkout -b feature/big-feature
# ... multiple commits ...
/commit
/commit
/commit
# ... when ready ...
git checkout develop
git merge feature/big-feature
git push
/clean_gone
```

## Tips

### Commit Command Tips

1. **Stage Selectively Before /commit**
   ```bash
   git add -p  # Interactive staging
   /commit     # Commits only staged files
   ```

2. **Review Before Commit**
   ```bash
   git diff --staged  # Review what will be committed
   /commit
   ```

3. **Amend Last Commit**
   ```bash
   # Make additional changes
   git add .
   git commit --amend --no-edit
   ```

### PR Command Tips

1. **Draft PRs**
   ```bash
   # For work in progress
   /commit-push-pr
   # Then manually convert to draft in GitHub
   ```

2. **PR Templates**
   - The command uses `gh pr create` which respects `.github/PULL_REQUEST_TEMPLATE.md`
   - Claude will populate the template appropriately

3. **CI/CD Integration**
   - PR creation triggers CI/CD automatically
   - Review checks before merging

### Clean Gone Tips

1. **Check Before Cleaning**
   ```bash
   git branch -vv | grep '\[gone\]'  # Preview what will be cleaned
   /clean_gone
   ```

2. **Protect Important Branches**
   - The command only removes branches marked `[gone]`
   - Your current branch is never removed
   - Branches without remotes are not affected

3. **Worktree Support**
   - The command detects and removes worktrees for gone branches
   - Safe to use even with multiple worktrees

### General Tips

1. **Combine with Git Aliases**
   ```bash
   # .gitconfig
   [alias]
       st = status
       co = checkout

   # Then use:
   git co -b feature/new
   /commit
   ```

2. **Use with Pre-commit Hooks**
   - These commands work with pre-commit hooks
   - Claude respects hook failures
   - Linters and formatters run normally

3. **Error Handling**
   - If a command fails, Claude provides the error
   - You can fix the issue and retry
   - Commands are idempotent when safe

## Support

This is an official Anthropic plugin synced from the official Claude Code plugins repository.

For issues or questions:
- Check official Claude Code documentation
- Report issues to Anthropic support channels

## Related Plugins

- **feature-dev**: Comprehensive feature development workflow
- **pr-review-toolkit**: Multi-agent PR review system

---

**Plugin Type:** Official Anthropic Plugin
**Synced From:** Official Claude Code Plugins Repository
