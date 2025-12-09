---
description: This skill should be used when the user asks to "generate tests", "write tests", "create test suite", "add tests for", "test coverage", "write unit tests", "create e2e tests", "playwright tests", or needs help with test generation and coverage. Provides guidance on testing strategies and test generation workflows.
---

# Test Generation Skill

Generate comprehensive test suites including unit tests, integration tests, and end-to-end tests.

## When to Use

- Generating tests for new code
- Improving test coverage
- Creating E2E tests with Playwright
- Setting up authentication tests
- Planning testing strategy

## Quick Actions (Handled by Skill)

### Testing Strategy Questions
- What should be unit vs integration tested
- Test organization patterns
- Mocking strategies
- Test data management

### Testing Best Practices
- Arrange-Act-Assert pattern
- Test naming conventions
- Edge case identification
- Flaky test prevention

## Testing Patterns

### Unit Test Structure
```typescript
describe('calculateTotal', () => {
  // Happy path
  it('should calculate total with valid items', () => {
    const items = [{ price: 10, qty: 2 }, { price: 5, qty: 1 }];
    expect(calculateTotal(items)).toBe(25);
  });

  // Edge cases
  it('should return 0 for empty array', () => {
    expect(calculateTotal([])).toBe(0);
  });

  // Error cases
  it('should throw for invalid items', () => {
    expect(() => calculateTotal(null)).toThrow();
  });
});
```

### Mocking Patterns
```typescript
// Mock module
jest.mock('./api');

// Mock implementation
jest.spyOn(service, 'fetch').mockResolvedValue(mockData);

// Mock only specific exports
jest.mock('./utils', () => ({
  ...jest.requireActual('./utils'),
  fetchData: jest.fn()
}));
```

### E2E Test Structure
```typescript
// Playwright
test('user can complete checkout', async ({ page }) => {
  await page.goto('/products');
  await page.click('[data-testid="add-to-cart"]');
  await page.click('[data-testid="checkout"]');
  await expect(page.locator('.success')).toBeVisible();
});
```

## Test Types

| Type | Scope | Speed | When to Use |
|------|-------|-------|-------------|
| Unit | Single function/class | Fast | Business logic, utilities |
| Integration | Multiple modules | Medium | API endpoints, services |
| E2E | Full user flow | Slow | Critical paths, smoke tests |

## Full Workflows (Use Commands)

For comprehensive test generation with file paths:

### Generate Tests
```
/test-suite-generator:generate-tests [file-or-module]
```
**Use when:** Need comprehensive unit/integration tests for specific code.

**Examples:**
- `/generate-tests src/services/userService.ts`
- `/generate-tests src/api/users`

### Coverage Report
```
/test-suite-generator:coverage-report
```
**Use when:** Need to analyze test coverage and identify untested code paths.

### Generate Playwright E2E
```
/test-suite-generator:generate-playwright-e2e
```
**Use when:** Need end-to-end tests for user flows using Playwright.

### Generate Auth Tests
```
/test-suite-generator:generate-playwright-auth-tests
```
**Use when:** Need authentication flow tests with OTP detection and Page Object Model.

## Coverage Strategy

### What to Test
- **Always test:** Business logic, calculations, validations
- **Usually test:** API endpoints, database operations
- **Sometimes test:** UI components, integrations
- **Rarely test:** Generated code, third-party libraries

### Coverage Targets
| Code Type | Target |
|-----------|--------|
| Business logic | 90%+ |
| API handlers | 80%+ |
| Utilities | 85%+ |
| UI components | 60%+ |

## Quick Reference

### When to Use Each Command
| Need | Command |
|------|---------|
| Unit/integration tests | `/generate-tests [path]` |
| Coverage analysis | `/coverage-report` |
| E2E tests | `/generate-playwright-e2e` |
| Auth flow tests | `/generate-playwright-auth-tests` |
| Testing advice | Ask directly (skill handles) |

### Test Naming Convention
```
should [expected behavior] when [condition]

Examples:
- should return empty array when no items match
- should throw ValidationError when email invalid
- should redirect to dashboard when login successful
```

### Edge Cases Checklist
- [ ] Empty/null inputs
- [ ] Boundary values
- [ ] Invalid types
- [ ] Large inputs
- [ ] Concurrent operations
- [ ] Network failures
- [ ] Timeout conditions
