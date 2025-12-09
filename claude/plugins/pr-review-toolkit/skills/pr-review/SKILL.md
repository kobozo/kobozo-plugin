---
description: This skill should be used when the user asks to "review my PR", "check PR quality", "PR review", "review pull request", "analyze my changes", "check my code before PR", or needs help reviewing code changes with specialized analysis. Provides guidance on comprehensive PR review methodology.
---

# PR Review Skill

Comprehensively review pull requests using specialized agents that each focus on a different aspect of code quality.

## When to Use

- Before creating a pull request
- Reviewing PR quality
- Checking specific aspects (tests, errors, types)
- Validating code before merge
- Getting comprehensive code analysis

## Review Aspects

### Available Reviewers

| Aspect | Agent | Focus |
|--------|-------|-------|
| **comments** | comment-analyzer | Comment accuracy, documentation |
| **tests** | pr-test-analyzer | Test coverage, quality |
| **errors** | silent-failure-hunter | Error handling, logging |
| **types** | type-design-analyzer | Type design, invariants |
| **code** | code-reviewer | General quality, guidelines |
| **simplify** | code-simplifier | Clarity, maintainability |

### When Each Applies

- **Always**: code-reviewer (general quality)
- **Test files changed**: pr-test-analyzer
- **Comments/docs added**: comment-analyzer
- **Error handling changed**: silent-failure-hunter
- **Types added/modified**: type-design-analyzer
- **After passing review**: code-simplifier (polish)

## Review Workflow

### Step 1: Determine Scope
- Check `git diff --name-only` for changed files
- Identify file types
- Determine applicable reviews

### Step 2: Launch Reviews
**Sequential** (default):
- Easier to understand
- Complete report before next
- Good for interactive review

**Parallel** (for speed):
- All agents simultaneously
- Faster comprehensive review
- Results come together

### Step 3: Aggregate Results
Categorize findings:
- **Critical Issues**: Must fix before merge
- **Important Issues**: Should fix
- **Suggestions**: Nice to have
- **Positive Observations**: What's good

### Step 4: Action Plan
```markdown
# PR Review Summary

## Critical Issues (N found)
- [agent-name]: Description [file:line]

## Important Issues (N found)
- [agent-name]: Description [file:line]

## Suggestions (N found)
- [agent-name]: Suggestion [file:line]

## Strengths
- What's well-done

## Recommended Action
1. Fix critical issues first
2. Address important issues
3. Consider suggestions
4. Re-run review after fixes
```

## Agent Capabilities

### comment-analyzer
- Verifies comment accuracy vs code
- Identifies comment rot
- Checks documentation completeness
- Flags misleading comments

### pr-test-analyzer
- Reviews behavioral test coverage
- Identifies critical gaps
- Evaluates test quality
- Checks edge case coverage

### silent-failure-hunter
- Finds silent failures
- Reviews catch blocks
- Checks error logging
- Validates fallback behavior

### type-design-analyzer
- Analyzes type encapsulation
- Reviews invariant expression
- Rates design quality (1-10)
- Checks usefulness and enforcement

### code-reviewer
- Checks CLAUDE.md compliance
- Detects bugs and issues
- Reviews general code quality
- Validates project guidelines

### code-simplifier
- Simplifies complex code
- Improves clarity and readability
- Applies project standards
- Preserves functionality

## Usage Patterns

### Before Committing
```
1. Write code
2. Review: code, errors aspects
3. Fix critical issues
4. Commit
```

### Before Creating PR
```
1. Stage all changes
2. Review: all aspects
3. Address critical/important issues
4. Verify with targeted reviews
5. Create PR
```

### After PR Feedback
```
1. Make requested changes
2. Run targeted reviews
3. Verify issues resolved
4. Push updates
```

## Invoke Full Workflow

For comprehensive PR review with all specialized agents:

**Use the Task tool** to launch pr-review agents:

1. **Code Quality**: Launch `pr-review-toolkit:code-reviewer` for general review
2. **Test Coverage**: Launch `pr-review-toolkit:pr-test-analyzer` for test quality
3. **Error Handling**: Launch `pr-review-toolkit:silent-failure-hunter` for error patterns
4. **Comments**: Launch `pr-review-toolkit:comment-analyzer` for documentation
5. **Types**: Launch `pr-review-toolkit:type-design-analyzer` for type design
6. **Simplify**: Launch `pr-review-toolkit:code-simplifier` for code clarity

**Example prompt for agent:**
```
Review my PR for test coverage and error handling.
Focus on the authentication module changes.
```

## Quick Reference

### Aspect Selection Guide
| Changed | Review Aspects |
|---------|----------------|
| Any code | code |
| Tests | code, tests |
| Error handling | code, errors |
| New types | code, types |
| Documentation | code, comments |
| Complex logic | code, simplify |

### Priority Order
1. Critical issues (blockers)
2. Important issues (should fix)
3. Suggestions (nice to have)
4. Simplification (polish)

### Review Checklist
- [ ] Changed files identified
- [ ] Applicable aspects determined
- [ ] Reviews launched
- [ ] Findings categorized
- [ ] Action plan created
- [ ] Issues addressed
- [ ] Re-verification complete
