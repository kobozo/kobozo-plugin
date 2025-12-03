---
description: Git commit workflow. Triggers when user says "commit this", "commit the changes", "push this", "create a PR", "commit and push", "make a commit", or similar git commit/push/PR requests.
---

# Git Commit Skill

This skill handles git commit, push, and PR workflows when triggered by natural language requests.

## Trigger Phrases

Activate this skill when user says:

**Commit only:**
- "commit this", "commit the changes", "make a commit", "create a commit"

**Commit + Push (NO PR):**
- "push this", "push the changes", "commit and push", "push it"

**Commit + Push + PR (only when PR explicitly mentioned):**
- "create a PR", "open a PR", "make a pull request", "submit a PR"
- "commit, push, and create PR"

**IMPORTANT**: Only create a PR when user explicitly mentions "PR" or "pull request". Push does NOT imply PR.

## Workflow: Commit Only

When user wants to **commit** (no push/PR mentioned):

### Steps
1. Check `git status` to see changes
2. Check `git diff HEAD` to understand what changed
3. Stage relevant files with `git add`
4. Create commit with descriptive message

### Commit Message Format
```
<type>(<scope>): <short description>

<optional body explaining why>

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Types**: feat, fix, refactor, docs, test, chore, style, perf

### Example
```bash
git add -A && git commit -m "$(cat <<'EOF'
feat(auth): Add password reset functionality

Implements forgot password flow with email verification.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

## Workflow: Commit + Push

When user wants to **commit and push**:

### Steps
1. Check `git status` and `git diff HEAD`
2. Check current branch with `git branch --show-current`
3. Stage and commit changes
4. Push to origin: `git push` (or `git push -u origin <branch>` if new branch)

### Example
```bash
git add -A && git commit -m "..." && git push
```

## Workflow: Commit + Push + PR

**Only when user explicitly says "PR" or "pull request":**

### Steps
1. Check if on main branch - if so, create feature branch first
2. Stage and commit changes
3. Push branch to origin
4. Create PR with `gh pr create`

### Branch Creation (if on main)
```bash
git checkout -b feature/<descriptive-name>
```

### PR Creation
```bash
gh pr create --title "feat: Description" --body "$(cat <<'EOF'
## Summary
- Change 1
- Change 2

## Test plan
- [ ] Test case 1
- [ ] Test case 2

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

## Workflow: Clean Gone Branches

When user mentions "clean branches", "remove old branches", "clean gone":

```bash
git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D
```

## Best Practices

### DO
- Write descriptive commit messages explaining WHY
- Use conventional commit format (feat/fix/refactor)
- Stage only relevant files
- Verify changes before committing with `git diff`

### DON'T
- Commit secrets, credentials, or .env files
- Use `git push --force` without explicit user request
- Amend commits that are already pushed
- Skip the Co-Authored-By footer

## Safety Checks

Before committing, verify:
- [ ] No secrets in staged files (.env, credentials, API keys)
- [ ] Changes match what user requested
- [ ] Commit message accurately describes changes

## Quick Reference

| User Says | Action |
|-----------|--------|
| "commit this" | Stage + commit |
| "commit and push" | Stage + commit + push |
| "push this" | Stage + commit + push |
| "push it" | Stage + commit + push |
| "create a PR" | Branch (if main) + commit + push + `gh pr create` |
| "open a pull request" | Branch (if main) + commit + push + `gh pr create` |
| "clean branches" | Remove [gone] branches |

**Remember**: "push" ≠ "PR". Only create PR when explicitly requested.
