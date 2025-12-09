---
description: This skill should be used when the user asks to "code review", "review PR", "review this pull request", "check my code", "review changes", "review my PR", or needs help reviewing code for bugs and compliance. Provides guidance on systematic code review methodology.
---

# Code Review Skill

Systematically review pull requests using multiple review perspectives to catch bugs, ensure compliance, and maintain code quality.

## When to Use

- Reviewing pull requests
- Checking code before merge
- Validating CLAUDE.md compliance
- Looking for bugs in changed code
- Reviewing code quality

## Review Methodology

### Multi-Perspective Review

A comprehensive code review examines changes from multiple angles:

1. **CLAUDE.md Compliance**: Check against project guidelines
2. **Bug Detection**: Scan for obvious bugs in changes
3. **Historical Context**: Review git blame and history
4. **PR History**: Check comments on related PRs
5. **Code Comments**: Verify compliance with in-code guidance

### Confidence Scoring

Rate each finding on a confidence scale:

| Score | Meaning | Action |
|-------|---------|--------|
| 0 | False positive | Ignore |
| 25 | Might be issue | Investigate |
| 50 | Moderate confidence | Flag as suggestion |
| 75 | Highly confident | Flag as important |
| 100 | Certain | Flag as critical |

**Only surface issues with 80+ confidence.**

### False Positive Patterns

Avoid flagging:
- Pre-existing issues
- Pedantic nitpicks
- Issues caught by linter/typecheck/CI
- General code quality (unless in CLAUDE.md)
- Explicitly silenced issues (lint ignore comments)
- Intentional functionality changes
- Issues on unmodified lines

## Review Process

### Step 1: Eligibility Check
Before reviewing, verify PR is:
- Not closed
- Not a draft
- Not automated/trivial
- Not already reviewed by you

### Step 2: Gather Context
- Identify relevant CLAUDE.md files
- Root CLAUDE.md
- Directory-specific CLAUDE.md files
- Summarize the change

### Step 3: Multi-Agent Review
Review from multiple perspectives:
- CLAUDE.md compliance
- Bug detection (shallow scan)
- Historical git context
- Previous PR comments
- Code comment compliance

### Step 4: Score Findings
For each issue:
- Assign confidence score (0-100)
- Verify against CLAUDE.md if applicable
- Filter out low-confidence issues

### Step 5: Report Results
Format findings clearly:
- Brief description
- Link to file and line (full SHA)
- Cite relevant CLAUDE.md section

## Output Format

```markdown
### Code review

Found N issues:

1. <description> (CLAUDE.md says "<...>")
   <link to file:line with full SHA>

2. <description> (bug due to <code snippet>)
   <link to file:line with full SHA>
```

Or if no issues:

```markdown
### Code review

No issues found. Checked for bugs and CLAUDE.md compliance.
```

## Link Format

```
https://github.com/owner/repo/blob/FULL_SHA/path/file.ext#L10-L15
```

Requirements:
- Full git SHA (not abbreviated)
- `#` sign after filename
- Line range: `L[start]-L[end]`
- At least 1 line context before/after

## Best Practices

### Focus on What Matters
- Large bugs over small issues
- Compliance over style
- Changed code over surrounding code
- Real issues over theoretical ones

### Avoid
- Running build/typecheck (CI handles this)
- Nitpicking style (linters handle this)
- Flagging pre-existing issues
- Commenting on unmodified lines

### Be Specific
- Link to exact file and line
- Quote relevant CLAUDE.md section
- Explain why it's an issue
- Suggest how to fix

## Invoke Full Workflow

For comprehensive code review with multi-agent analysis:

**Use the Task tool** or invoke `/code-review` command for the full multi-agent code review workflow that:
1. Checks PR eligibility
2. Gathers CLAUDE.md context
3. Runs 5 parallel review agents
4. Scores each finding
5. Filters to high-confidence issues
6. Posts formatted comment

**Example invocation:**
```
Review the PR at https://github.com/owner/repo/pull/123
```

## Quick Reference

### Review Checklist
- [ ] PR is eligible (not closed/draft)
- [ ] CLAUDE.md files identified
- [ ] Change summarized
- [ ] Multiple perspectives reviewed
- [ ] Findings scored
- [ ] Low-confidence filtered out
- [ ] Results formatted with links

### Confidence Thresholds
- **<80**: Don't report (likely false positive)
- **80-89**: Report as suggestion
- **90-100**: Report as important issue

### Common Issue Categories
- CLAUDE.md violations
- Logic bugs
- Edge case handling
- API misuse
- Security concerns
