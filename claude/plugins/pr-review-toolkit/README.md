# PR Review Toolkit

> **Official Claude Code Plugin** by Anthropic

A comprehensive pull request review system using specialized AI agents that analyze different aspects of code quality, from test coverage to error handling to type design.

**Version:** 1.0.0
**Author:** Daisy (daisy@anthropic.com)
**Official Plugin:** This is an official Claude Code plugin from Anthropic, synced from the [official plugin repository](https://github.com/anthropics/claude-code-plugins).

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Commands](#commands)
  - [review-pr](#review-pr)
- [Review Agents](#review-agents)
  - [code-reviewer](#code-reviewer)
  - [pr-test-analyzer](#pr-test-analyzer)
  - [type-design-analyzer](#type-design-analyzer)
  - [silent-failure-hunter](#silent-failure-hunter)
  - [comment-analyzer](#comment-analyzer)
  - [code-simplifier](#code-simplifier)
- [Review Aspects](#review-aspects)
- [Workflow Integration](#workflow-integration)
- [Best Practices](#best-practices)
- [Tips & Tricks](#tips--tricks)

## Overview

The PR Review Toolkit is a comprehensive code review system that uses multiple specialized AI agents to thoroughly analyze pull requests from different angles. Each agent is an expert in a specific domain - from test coverage quality to error handling patterns to type system design.

Instead of a single general-purpose review, this toolkit orchestrates multiple focused reviews that catch issues a typical code review might miss. The result is actionable, specific feedback organized by severity and category.

## Key Features

- **Multi-Agent Architecture**: Six specialized agents, each focusing on a specific aspect of code quality
- **Comprehensive Coverage**: Reviews code quality, tests, types, error handling, comments, and simplification opportunities
- **Severity-Based Prioritization**: Issues categorized as Critical (90-100), Important (80-89), or Suggestions
- **Git-Aware**: Automatically focuses on changed files from `git diff`
- **Flexible Scope**: Run all reviews or target specific aspects
- **Sequential or Parallel**: Choose between thorough sequential analysis or fast parallel execution
- **Actionable Feedback**: Every issue includes file location, specific problem, and concrete fix suggestion
- **Confidence Scoring**: Each issue rated 0-100 for confidence (only reports issues ≥80)

## Installation

This plugin is part of the official Claude Code plugin collection. To install:

1. Ensure you have Claude Code installed
2. The plugin should be automatically available in your Claude Code environment
3. Verify installation by running:
   ```
   /pr-review-toolkit:review-pr --help
   ```

## Quick Start

**Run a full PR review:**
```
/pr-review-toolkit:review-pr
```

**Review specific aspects:**
```
/pr-review-toolkit:review-pr tests errors
```

**Review only comments:**
```
/pr-review-toolkit:review-pr comments
```

**Run all reviews in parallel (faster):**
```
/pr-review-toolkit:review-pr all parallel
```

## Commands

### review-pr

Runs a comprehensive pull request review using multiple specialized agents.

**Syntax:**
```
/pr-review-toolkit:review-pr [review-aspects]
```

**Arguments:**
- `review-aspects` (optional): Space-separated list of review aspects to run
  - `comments` - Analyze code comment accuracy and maintainability
  - `tests` - Review test coverage quality and completeness
  - `errors` - Check error handling for silent failures
  - `types` - Analyze type design and invariants
  - `code` - General code review for project guidelines
  - `simplify` - Simplify code for clarity and maintainability
  - `all` - Run all applicable reviews (default)
  - `parallel` - Run reviews in parallel instead of sequential

**Examples:**

```bash
# Full review (all aspects, sequential)
/pr-review-toolkit:review-pr

# Only test coverage and error handling
/pr-review-toolkit:review-pr tests errors

# Only code comments
/pr-review-toolkit:review-pr comments

# Full review in parallel mode
/pr-review-toolkit:review-pr all parallel

# Code simplification only
/pr-review-toolkit:review-pr simplify
```

**Output Format:**

```markdown
# PR Review Summary

## Critical Issues (X found)
- [agent-name]: Issue description [file:line]
- Confidence: 95/100
- Fix: Specific recommendation

## Important Issues (X found)
- [agent-name]: Issue description [file:line]
- Confidence: 85/100
- Fix: Specific recommendation

## Suggestions (X found)
- [agent-name]: Suggestion [file:line]

## Strengths
- What's well-done in this PR

## Recommended Action
1. Fix critical issues first
2. Address important issues
3. Consider suggestions
4. Re-run review after fixes
```

**Workflow:**

1. **Determine Review Scope**: Checks git status to identify changed files
2. **Parse Arguments**: Determines which review aspects to run
3. **Identify Changed Files**: Runs `git diff --name-only` or `gh pr view`
4. **Determine Applicable Reviews**: Based on file types and changes
5. **Launch Review Agents**: Sequential or parallel execution
6. **Aggregate Results**: Combines findings from all agents
7. **Provide Action Plan**: Organized by severity with next steps

## Review Agents

### code-reviewer

Reviews code for adherence to project guidelines, style guides, and best practices.

**Specialization:** General code quality, CLAUDE.md compliance, bug detection

**Model:** Opus (highest quality)

**Focus Areas:**
- Project guidelines compliance (CLAUDE.md rules)
- Bug detection (logic errors, null handling, race conditions)
- Code quality (duplication, error handling, test coverage)
- Security vulnerabilities
- Performance problems

**Confidence Scoring:**
- 0-25: Likely false positive or pre-existing issue
- 26-50: Minor nitpick not in CLAUDE.md
- 51-75: Valid but low-impact issue
- 76-90: Important issue requiring attention
- 91-100: Critical bug or explicit CLAUDE.md violation

**Only reports issues with confidence ≥ 80**

**Use When:**
- After writing or modifying code
- Before committing changes
- Before creating pull requests
- When validating adherence to project standards

**Example Output:**
```markdown
## Critical Issues (90-100)

**src/auth/login.ts:45** - Confidence: 95/100
Missing null check on user object before accessing properties.
This violates CLAUDE.md requirement for explicit null handling.

Fix: Add null guard before accessing user.email
```

### pr-test-analyzer

Reviews test coverage quality and completeness for pull requests.

**Specialization:** Behavioral test coverage, edge cases, test quality

**Model:** Inherit (uses context-appropriate model)

**Focus Areas:**
- Behavioral coverage vs line coverage
- Critical code paths and edge cases
- Error condition testing
- Test quality and resilience
- Test maintainability (DAMP principles)

**Criticality Ratings:**
- 9-10: Critical (data loss, security, system failures)
- 7-8: Important (business logic, user-facing errors)
- 5-6: Edge cases (minor issues)
- 3-4: Nice-to-have completeness
- 1-2: Optional improvements

**Use When:**
- After creating or updating a PR with new functionality
- Before marking PR as ready for review
- When adding new features that need test coverage
- After receiving feedback about insufficient tests

**Example Output:**
```markdown
## Summary
Test coverage is generally good but missing critical error path tests.

## Critical Gaps (8-10)

**src/payment/processor.ts:122-145** - Rating: 9/10
Missing test for payment failure when gateway returns 500 error.
This could cause unhandled exceptions in production.

Suggested test:
- Verify payment failure is logged
- Verify user receives error message
- Verify transaction is rolled back
```

### type-design-analyzer

Analyzes type design for encapsulation, invariants, and maintainability.

**Specialization:** Type system design, invariant expression, encapsulation

**Model:** Inherit

**Focus Areas:**
- Invariant identification and strength
- Encapsulation quality
- Type-level guarantees
- Constructor validation
- Illegal state prevention

**Rating Dimensions (1-10):**
- **Encapsulation**: Internal details hidden, invariants protected
- **Invariant Expression**: Clarity through type structure
- **Invariant Usefulness**: Prevents real bugs, aligns with requirements
- **Invariant Enforcement**: Checked at construction, guarded mutations

**Use When:**
- When introducing new types
- During pull request creation with new data models
- When refactoring existing types
- Before finalizing API contracts

**Example Output:**
```markdown
## Type: UserAccount

### Invariants Identified
- Email must be valid format
- Username must be 3-20 characters
- Password must meet complexity requirements
- Account status must be valid enum value

### Ratings
- **Encapsulation**: 6/10
  Exposes mutable email field without validation

- **Invariant Expression**: 8/10
  Type structure clearly communicates requirements

- **Invariant Usefulness**: 9/10
  Prevents common authentication bugs

- **Invariant Enforcement**: 4/10
  Missing constructor validation for email format

### Recommended Improvements
1. Make email field private with validated setter
2. Add constructor validation for all fields
3. Use branded types for validated email
```

### silent-failure-hunter

Identifies silent failures, inadequate error handling, and inappropriate fallback behavior.

**Specialization:** Error handling, logging, fallback behavior

**Model:** Inherit

**Focus Areas:**
- Silent failures (errors without logging)
- User feedback quality
- Catch block specificity
- Fallback behavior appropriateness
- Error propagation correctness

**Core Principles:**
1. Silent failures are unacceptable
2. Users deserve actionable feedback
3. Fallbacks must be explicit and justified
4. Catch blocks must be specific
5. Mock implementations belong only in tests

**Severity Levels:**
- **CRITICAL**: Silent failure, overly broad catch block
- **HIGH**: Poor error message, unjustified fallback
- **MEDIUM**: Missing context, could be more specific

**Use When:**
- After implementing error handling
- When reviewing catch blocks or try/catch logic
- Before merging changes with fallback behavior
- When refactoring error handling code

**Example Output:**
```markdown
## CRITICAL Issues

**src/api/client.ts:78-85** - Severity: CRITICAL

Issue: Catch block catches all errors but only logs, allowing execution to continue with undefined data.

Hidden Errors: Could catch NetworkError, TimeoutError, AuthenticationError, or unexpected JavaScript errors.

User Impact: User receives no feedback about failure. App continues with undefined state causing cascading errors.

Recommendation:
```typescript
try {
  const data = await fetchData();
  return data;
} catch (error) {
  if (error instanceof NetworkError) {
    logError('NETWORK_FETCH_FAILED', error);
    showUserError('Network connection failed. Please check your connection.');
  } else if (error instanceof AuthenticationError) {
    logError('AUTH_FAILED', error);
    redirectToLogin();
  } else {
    logError('UNEXPECTED_FETCH_ERROR', error);
    showUserError('An unexpected error occurred. Please try again.');
  }
  throw error; // Propagate to caller
}
```
```

### comment-analyzer

Analyzes code comments for accuracy, completeness, and long-term maintainability.

**Specialization:** Comment quality, documentation accuracy, technical debt prevention

**Model:** Inherit

**Focus Areas:**
- Factual accuracy vs actual implementation
- Comment completeness and context
- Long-term value and maintenance burden
- Misleading or ambiguous language
- Comment rot prevention

**Review Process:**
1. **Verify Factual Accuracy**: Cross-reference claims with code
2. **Assess Completeness**: Check for sufficient context
3. **Evaluate Long-term Value**: Consider utility over codebase lifetime
4. **Identify Misleading Elements**: Find ambiguous or outdated references
5. **Suggest Improvements**: Provide specific rewrites

**Use When:**
- After adding documentation comments
- Before finalizing PR with modified comments
- When reviewing existing comments for technical debt
- After generating large docstrings

**Example Output:**
```markdown
## Summary
Analyzed 12 comments across 5 files. Found 2 critical issues, 3 improvement opportunities.

## Critical Issues

**src/cache/manager.ts:34-36**
Issue: Comment claims cache expires after 5 minutes, but code sets expiry to 300000ms (5 seconds).
Suggestion: Update comment to "Cache entries expire after 5 seconds (300000ms)" or fix the code if 5 minutes was intended.

## Improvement Opportunities

**src/utils/parser.ts:89**
Current state: Comment says "Parse the data" which restates obvious code.
Suggestion: Either explain WHY this parsing approach is used, or remove the comment entirely.

## Recommended Removals

**src/handlers/user.ts:145**
Rationale: TODO comment says "Refactor this later" but the code has already been refactored (see PR #234). Remove outdated TODO.
```

### code-simplifier

Simplifies code for clarity, consistency, and maintainability while preserving functionality.

**Specialization:** Code clarity, consistency, refactoring

**Model:** Opus (highest quality)

**Focus Areas:**
- Clarity over brevity (explicit code preferred)
- Project standards compliance (CLAUDE.md)
- Reducing unnecessary complexity
- Improving readability
- Eliminating redundant code

**Core Principles:**
1. **Preserve Functionality**: Never change what code does
2. **Apply Project Standards**: Follow CLAUDE.md conventions
3. **Enhance Clarity**: Simplify structure, improve names
4. **Maintain Balance**: Avoid over-simplification
5. **Focus Scope**: Only refine recently modified code

**Important Rules:**
- Avoid nested ternary operators (use if/else or switch)
- Choose clarity over brevity
- Prefer explicit code over compact code
- Use function keyword over arrow functions
- Add explicit return type annotations

**Use When:**
- After completing a coding task
- After writing a logical chunk of code
- After fixing bugs or implementing features
- As final polish before creating PR

**Example Output:**
```markdown
## Refinements Applied

### src/validators/email.ts

**Before:**
```typescript
const isValid = email.includes('@') ? email.split('@')[1].includes('.') ? true : false : false;
```

**After:**
```typescript
function isValid(email: string): boolean {
  if (!email.includes('@')) {
    return false;
  }

  const domain = email.split('@')[1];
  return domain.includes('.');
}
```

**Reason:** Replaced nested ternary with clear if/else structure following CLAUDE.md guidance to prefer clarity over brevity.

### Functionality Preserved
All original validation logic maintained. Same inputs produce same outputs.
```

## Review Aspects

The toolkit supports the following review aspects:

| Aspect | Agent | Focus |
|--------|-------|-------|
| `code` | code-reviewer | General code quality, CLAUDE.md compliance, bugs |
| `tests` | pr-test-analyzer | Test coverage quality, edge cases, completeness |
| `types` | type-design-analyzer | Type design, invariants, encapsulation |
| `errors` | silent-failure-hunter | Error handling, logging, silent failures |
| `comments` | comment-analyzer | Comment accuracy, documentation quality |
| `simplify` | code-simplifier | Code clarity, consistency, refactoring |
| `all` | All agents | Comprehensive review (default) |

**Applicability Rules:**

- **Always applicable**: `code` (code-reviewer)
- **If test files changed**: `tests` (pr-test-analyzer)
- **If comments/docs added**: `comments` (comment-analyzer)
- **If error handling changed**: `errors` (silent-failure-hunter)
- **If types added/modified**: `types` (type-design-analyzer)
- **After passing review**: `simplify` (code-simplifier)

## Workflow Integration

### Before Committing

```bash
# 1. Write code
# 2. Run targeted review
/pr-review-toolkit:review-pr code errors

# 3. Fix any critical issues
# 4. Commit
git commit -m "feat: Add new feature"
```

### Before Creating PR

```bash
# 1. Stage all changes
git add .

# 2. Run comprehensive review
/pr-review-toolkit:review-pr all

# 3. Address all critical and important issues
# 4. Run specific reviews again to verify
/pr-review-toolkit:review-pr tests errors

# 5. Create PR
gh pr create
```

### After PR Feedback

```bash
# 1. Make requested changes
# 2. Run targeted reviews based on feedback
/pr-review-toolkit:review-pr comments

# 3. Verify issues are resolved
# 4. Push updates
git push
```

### Continuous Integration

```bash
# Add to CI pipeline
- name: PR Review
  run: |
    /pr-review-toolkit:review-pr all
    # Fail build if critical issues found
```

## Best Practices

### 1. Run Early and Often

Run reviews **before** creating the PR, not after. Catch issues during development when context is fresh.

```bash
# Good: Review during development
/pr-review-toolkit:review-pr code

# Better: Review before committing
git add .
/pr-review-toolkit:review-pr all
```

### 2. Use Targeted Reviews

When you know the specific concern, target that aspect for faster feedback.

```bash
# Just added tests - check coverage
/pr-review-toolkit:review-pr tests

# Modified error handling - check for silent failures
/pr-review-toolkit:review-pr errors

# Added new type - check design
/pr-review-toolkit:review-pr types
```

### 3. Address Critical Issues First

Focus on critical issues (90-100 confidence) before important ones (80-89).

```markdown
Priority order:
1. Critical Issues (must fix before merge)
2. Important Issues (should fix)
3. Suggestions (nice to have)
```

### 4. Re-run After Fixes

After addressing issues, re-run the relevant review to verify fixes.

```bash
# Fixed error handling issues
/pr-review-toolkit:review-pr errors

# Verify all issues resolved
```

### 5. Combine Sequential and Parallel

- **Sequential** (default): Better for interactive development, easier to process
- **Parallel**: Better for CI/CD, faster for comprehensive checks

```bash
# Development: Sequential for easier reading
/pr-review-toolkit:review-pr

# CI/CD: Parallel for speed
/pr-review-toolkit:review-pr all parallel
```

### 6. Focus on Changed Files

Agents automatically focus on `git diff` by default. This keeps reviews relevant.

```bash
# Reviews only modified files
/pr-review-toolkit:review-pr
```

### 7. Use Simplifier Last

Run `code-simplifier` after other reviews pass to polish the code.

```bash
# 1. Fix critical issues first
/pr-review-toolkit:review-pr code tests errors

# 2. After passing, simplify
/pr-review-toolkit:review-pr simplify
```

## Tips & Tricks

### Understanding Confidence Scores

Issues are rated 0-100 for confidence. Only issues ≥80 are reported:

- **80-84**: Valid issue, low impact
- **85-89**: Important issue, should address
- **90-94**: Critical issue, must fix
- **95-100**: Certain bug or CLAUDE.md violation

### Reading Review Output

Each issue includes:
- **Location**: File path and line number
- **Description**: What's wrong and why
- **Confidence/Severity**: How important it is
- **Fix**: Specific recommendation

```markdown
**src/auth/login.ts:45** - Confidence: 95/100
Missing null check on user object.
Fix: Add null guard before accessing user.email
```

### Combining Multiple Aspects

Run multiple specific aspects together:

```bash
# Check tests and error handling together
/pr-review-toolkit:review-pr tests errors

# Check code quality and type design
/pr-review-toolkit:review-pr code types
```

### Integration with CLAUDE.md

All agents respect project-specific rules from `CLAUDE.md`:

- Import patterns and conventions
- Error handling requirements
- Testing practices
- Code style preferences
- Platform compatibility

Make sure your `CLAUDE.md` is up-to-date for best results.

### Agent Autonomy

Agents run autonomously and return detailed reports. You don't need to micromanage them - they know their specialty and will perform deep analysis.

### File and Line References

All issues include specific file:line references for easy navigation:

```bash
# Jump directly to issue in your editor
vim src/auth/login.ts +45
code --goto src/auth/login.ts:45
```

### Parallel vs Sequential Trade-offs

**Sequential (default):**
- Easier to understand and act on
- Each report is complete before next
- Better for interactive review
- Recommended for development

**Parallel:**
- Faster for comprehensive review
- Results come back together
- Better for CI/CD pipelines
- Can be overwhelming with many issues

### False Positives

Agents are calibrated to minimize false positives (only report ≥80 confidence), but they can still occur. If you disagree with an issue:

1. Review the agent's reasoning
2. Check if CLAUDE.md needs updating
3. Consider if the code could be clearer
4. Document why the code is correct if not obvious

### Customization

To customize agent behavior:
1. Update `CLAUDE.md` with project-specific rules
2. Agents automatically incorporate these guidelines
3. More specific CLAUDE.md = more accurate reviews

---

## Support and Contributing

This is an official Anthropic plugin. For issues or suggestions:

- **GitHub Issues**: [claude-code-plugins](https://github.com/anthropics/claude-code-plugins/issues)
- **Documentation**: [Claude Code Plugins](https://docs.anthropic.com/claude-code/plugins)
- **Author**: Daisy (daisy@anthropic.com)

## License

See the official Claude Code plugin repository for license information.

---

**Made with precision by Anthropic** | Version 1.0.0
