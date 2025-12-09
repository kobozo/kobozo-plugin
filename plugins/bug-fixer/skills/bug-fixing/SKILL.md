---
description: This skill should be used when the user asks to "fix bug", "debug this", "fix this issue", "investigate bug", "troubleshoot", "find the bug", or needs help analyzing and fixing bugs in their code. Provides systematic bug fixing methodology.
---

# Bug Fixing Skill

Systematically analyze, fix, and validate bugs using a comprehensive workflow that ensures quality and prevents regressions.

## When to Use

- User reports a bug to investigate
- Error messages need analysis
- Code isn't behaving as expected
- Debugging complex issues
- Investigating production incidents

## Bug Fixing Workflow

### Phase 1: Understand the Bug
Before fixing, gather complete information:

**Questions to Answer:**
1. What is the **expected behavior**?
2. What is the **actual behavior**?
3. What are the **reproduction steps**?
4. What **error messages** appear?
5. Is it **consistent** or intermittent?
6. What **recent changes** might be related?

### Phase 2: Analyze Root Cause
Trace through the code to identify the actual cause:

**Analysis Steps:**
1. Read error messages and stack traces
2. Trace code flow from trigger to error
3. Identify affected components
4. Check for similar issues in codebase
5. Document edge cases discovered

**Output Template:**
```markdown
## Bug Analysis

**Root Cause**: [Description]
**Location**: [file:line]
**Impact**: [Who/what is affected]
**Severity**: Critical/High/Medium/Low

**Edge Cases Identified**:
1. [Case 1]
2. [Case 2]
```

### Phase 3: Design Fix Approach
Consider multiple approaches before implementing:

**Approach Types:**

1. **Minimal Fix**
   - Quick, addresses immediate issue
   - Low risk, minimal changes
   - May not prevent similar issues

2. **Defensive Programming**
   - Adds validation and error handling
   - Prevents similar issues
   - More comprehensive

3. **Refactoring**
   - Restructures code
   - Eliminates root cause
   - Higher risk but cleaner

**Decision Criteria:**
- Urgency of fix
- Risk tolerance
- Long-term maintainability
- Test coverage

### Phase 4: Implement Fix
Apply the chosen approach:

**Implementation Checklist:**
- [ ] Read relevant existing code
- [ ] Follow codebase conventions
- [ ] Add validation where needed
- [ ] Handle edge cases
- [ ] Write clear error messages
- [ ] Add/update tests

### Phase 5: Validate
Ensure fix works and doesn't break anything:

**Validation Steps:**
1. Run existing test suite
2. Test bug reproduction (should fail)
3. Test edge cases
4. Check for regressions
5. Review code quality

## Common Bug Patterns

### Null/Undefined Errors
```typescript
// Bad: Implicit check
if (!user) return;

// Good: Explicit check
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

### Race Conditions
```typescript
// Bad: Uncontrolled concurrent access
data.value = newValue;

// Good: Synchronized access
await mutex.runExclusive(async () => {
  data.value = newValue;
});
```

## Error Handling Patterns

### Good Error Messages
```typescript
// Bad: Vague error
throw new Error('Invalid input');

// Good: Descriptive error
throw new Error(
  `Invalid discount code '${code}': must be alphanumeric and 6-10 characters`
);
```

### Validation Pattern
```typescript
const validateOrder = (order: unknown): Order => {
  if (!order || typeof order !== 'object') {
    throw new ValidationError('Order must be an object');
  }
  if (typeof (order as any).total !== 'number') {
    throw new ValidationError('Order.total must be a number');
  }
  return order as Order;
};
```

## Testing the Fix

### Test the Bug
```typescript
it('should handle invalid discount code without crashing', () => {
  expect(() => processPayment(orderWithInvalidCode))
    .toThrow(/Invalid discount code/);
});
```

### Test Edge Cases
```typescript
it('should handle empty discount code', () => {
  expect(() => processPayment({ discountCode: '' }))
    .toThrow(ValidationError);
});

it('should handle null order', () => {
  expect(() => processPayment(null))
    .toThrow('Order is required');
});
```

### Test No Regressions
```typescript
it('should still process valid orders', () => {
  const result = processPayment(validOrder);
  expect(result.success).toBe(true);
});
```

## Invoke Full Workflow

For comprehensive bug fixing with specialized agents:

**Use the Task tool** to launch bug fixing agents:

1. **Bug Analysis**: Launch `bug-fixer:bug-analyzer` agent to trace execution paths and identify root cause
2. **Fix Design**: Launch `bug-fixer:fix-implementer` agent to design and implement the fix
3. **Validation**: Launch `bug-fixer:test-validator` agent to verify fix and check for regressions

**Example prompt for agent:**
```
Fix bug: TypeError when invalid discount code is used in payment processing.
Expected: Show error message to user.
Actual: Application crashes with TypeError.
```

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

### Debugging Checklist
- [ ] Can reproduce the bug
- [ ] Understand expected behavior
- [ ] Found root cause (not symptom)
- [ ] Considered edge cases
- [ ] Fix tested locally
- [ ] No regressions detected
