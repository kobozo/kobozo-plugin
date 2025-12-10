---
description: This skill should be used when the user asks to "fix bug", "debug this", "fix this issue", "investigate bug", "troubleshoot", "find the bug", or needs help analyzing and fixing bugs in their code. Provides systematic bug fixing methodology.
---

# Bug Fixing Workflow

**YOU MUST FOLLOW THIS WORKFLOW SEQUENTIALLY. DO NOT SKIP PHASES.**

When this skill is triggered, execute the following phases in order. Each phase has specific actions and stop points.

## Core Principles

- **Ask Before Acting**: Always clarify bug details before starting
- **Understand Root Cause**: Don't just fix symptoms, find the actual cause
- **Test Thoroughly**: Test the fix, edge cases, and check for regressions
- **Use TodoWrite**: Track all progress throughout - this is MANDATORY

---

## Phase 1: Discovery

**Announce**: "🐛 **Phase 1: Discovery** - Understanding the bug"

**Actions**:
1. Create todo list with all 7 phases using TodoWrite
2. Mark Phase 1 as in_progress
3. Clarify bug description with user:
   - What is the **expected behavior**?
   - What is the **actual behavior**?
   - What are the **reproduction steps**?
   - What **error messages** appear?
   - Is it **consistent** or intermittent?
   - What **recent changes** might be related?

4. Summarize your understanding of the bug

**STOP**: Present summary and wait for user confirmation before proceeding.

---

## Phase 2: Bug Analysis

**Announce**: "🔍 **Phase 2: Bug Analysis** - Identifying root cause"

**Actions**:
1. Mark Phase 2 as in_progress in TodoWrite
2. Launch 1-2 `bug-fixer:bug-analyzer` agents to:
   - Trace execution paths from trigger to error
   - Identify root cause (not just symptoms)
   - Map affected components
   - Document error propagation
   - Identify edge cases

3. Review agent findings:
   - Root cause identification
   - Impact assessment
   - Edge cases to consider
   - Related areas to check

4. Present analysis summary:
```markdown
## Bug Analysis Summary

**Root Cause**: [Description]
**Location**: [file:line]
**Impact**: [Who/what is affected]
**Severity**: Critical/High/Medium/Low

**Edge Cases Identified**:
1. [Case 1]
2. [Case 2]
```

---

## Phase 3: Clarifying Questions

**Announce**: "❓ **Phase 3: Clarifying Questions** - Resolving ambiguities"

**CRITICAL - DO NOT SKIP THIS PHASE**

**Actions**:
1. Mark Phase 3 as in_progress in TodoWrite
2. Identify underspecified aspects:
   - How should invalid input be handled?
   - Should errors be shown to user or logged silently?
   - What error messages should users see?
   - Should these errors be logged for monitoring?
   - Are there performance considerations?

3. **Present all questions to user in a clear, organized list**

**STOP**: Wait for user answers before proceeding. If user says "whatever you think is best", provide your recommendation and get explicit confirmation.

---

## Phase 4: Fix Design

**Announce**: "🏗️ **Phase 4: Fix Design** - Designing the fix approach"

**Actions**:
1. Mark Phase 4 as in_progress in TodoWrite
2. Launch 1-2 `bug-fixer:fix-implementer` agents to:
   - Analyze codebase patterns
   - Evaluate multiple fix approaches
   - Provide implementation blueprint

3. Present fix approach options:

### Approach Options

**Option A: Minimal Fix**
- Quick, addresses immediate issue
- Low risk, minimal changes
- May not prevent similar issues

**Option B: Defensive Programming**
- Adds validation and error handling
- Prevents similar issues
- More comprehensive

**Option C: Refactoring**
- Restructures code
- Eliminates root cause
- Higher risk but cleaner

4. Present your recommendation with reasoning:
```markdown
## Recommended Approach: [Name]

**What**: [Description of changes]

**Changes**:
1. [Change 1]
2. [Change 2]

**Pros**: [Benefits]
**Cons**: [Trade-offs]

**Files to modify**:
- [file 1]
- [file 2]
```

**STOP**: Ask user which approach they prefer. Wait for answer before proceeding.

---

## Phase 5: Implementation

**Announce**: "⚙️ **Phase 5: Implementation** - Implementing the fix"

**DO NOT START WITHOUT USER APPROVAL OF FIX APPROACH**

**Actions**:
1. Mark Phase 5 as in_progress in TodoWrite
2. Read all relevant files identified in analysis
3. Implement the approved fix:
   - Follow the implementation blueprint
   - Add validation and error handling as needed
   - Update types if needed
   - Follow codebase conventions

4. Write tests:
   - Unit tests for fixed functions
   - Edge case tests
   - Regression tests

5. Update todos as you progress

### Implementation Checklist
- [ ] Read existing code
- [ ] Implement validation/fix
- [ ] Add descriptive error messages
- [ ] Handle all edge cases
- [ ] Write unit tests
- [ ] Write edge case tests

---

## Phase 6: Validation

**Announce**: "✅ **Phase 6: Validation** - Verifying the fix"

**Actions**:
1. Mark Phase 6 as in_progress in TodoWrite
2. Launch 2-3 `bug-fixer:test-validator` agents to:
   - Run existing test suite
   - Test bug reproduction (should be fixed)
   - Test edge cases
   - Check for regressions
   - Review code quality

3. Consolidate validation results:
```markdown
## Validation Results

### Test Suite: ✅/❌
- Total tests: [X]
- Passing: [Y]
- Failing: [Z]

### Bug Reproduction: ✅/❌
- Original bug status: [Fixed/Still present]

### Edge Cases: ✅/❌
- [Case 1]: Handled correctly
- [Case 2]: Handled correctly

### Regressions: ✅/❌
- [Area 1]: Working
- [Area 2]: Working

### Code Quality Issues:
- [Issue 1] (Confidence: X%, Severity: Y)
- [Issue 2] (Confidence: X%, Severity: Y)
```

**STOP**: Present validation results and ask user what to do:
- Fix issues now
- Fix later
- Proceed as-is

4. Address issues based on user decision

---

## Phase 7: Summary

**Announce**: "📝 **Phase 7: Summary** - Documenting the fix"

**Actions**:
1. Mark all todos complete
2. Summarize:
```markdown
## Bug Fix Summary

### Bug Fixed
**Issue**: [Description]
**Root Cause**: [What caused it]
**Severity**: [Level]

### Solution Implemented
**Approach**: [Which approach was used]
**Files Changed**:
- [file 1] - [what changed]
- [file 2] - [what changed]

**Key Changes**:
1. [Change 1]
2. [Change 2]

### Validation Results
- ✅ All tests passing
- ✅ Bug fixed
- ✅ Edge cases handled
- ✅ No regressions

### Next Steps
1. [Deploy to staging]
2. [Monitor in production]
3. [Follow-up tasks if any]
```

---

## Common Bug Patterns

### Null/Undefined Errors
```typescript
// Bad: Implicit check
if (!user) return;

// Good: Explicit check with error
if (user === null || user === undefined) {
  throw new Error('User is required');
}
```

### Type Coercion Issues
```typescript
// Bad: Loose equality
if (value == 0) { }

// Good: Strict equality
if (value === 0) { }
```

### Async/Await Pitfalls
```typescript
// Bad: Missing await
const result = asyncFunction();

// Good: Properly awaited
const result = await asyncFunction();
```

---

## Quick Reference

### Bug Severity Levels
| Severity | Definition | Response |
|----------|------------|----------|
| Critical | System down, data loss | Immediate |
| High | Major feature broken | Same day |
| Medium | Feature degraded | This sprint |
| Low | Minor inconvenience | Backlog |

### Fix Approach Selection
| Situation | Approach |
|-----------|----------|
| Production down | Minimal fix |
| Security issue | Defensive + minimal |
| Recurring bugs | Refactoring |
| Complex logic | Defensive |

### Stop Points Summary
| After Phase | Stop For |
|-------------|----------|
| Phase 1 | Confirm bug understanding |
| Phase 3 | Answer clarifying questions |
| Phase 4 | Choose fix approach |
| Phase 6 | Address validation issues |
