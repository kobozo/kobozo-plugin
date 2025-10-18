# Test Suite Generator

**Version:** 1.0.0
**Author:** Yannick De Backer (yannick@kobozo.eu)

Generate comprehensive test suites with high coverage - unit tests, integration tests, E2E tests, and detailed coverage analysis.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Commands](#commands)
  - [generate-tests](#generate-tests)
  - [coverage-report](#coverage-report)
- [Agents](#agents)
  - [test-generator](#test-generator)
  - [coverage-analyzer](#coverage-analyzer)
  - [test-strategy-planner](#test-strategy-planner)
- [Test Types](#test-types)
- [Supported Frameworks](#supported-frameworks)
- [Workflow Examples](#workflow-examples)
- [Best Practices](#best-practices)
- [Coverage Goals](#coverage-goals)

## Overview

The Test Suite Generator plugin automates the creation of comprehensive test suites for your codebase. It analyzes your code, generates appropriate tests (unit, integration, E2E), identifies coverage gaps, and provides actionable recommendations to improve test quality.

## Key Features

- **Automated Test Generation**: Creates unit, integration, and E2E tests for any code module
- **Multi-Framework Support**: Works with Jest, Vitest, pytest, RSpec, JUnit, and more
- **Coverage Analysis**: Identifies untested code and prioritizes testing efforts
- **Strategic Planning**: Recommends optimal testing approaches and tooling
- **Edge Case Detection**: Generates tests for happy paths, edge cases, and error scenarios
- **Mocking Support**: Automatically creates mocks and fixtures for dependencies
- **CI/CD Integration**: Provides recommendations for continuous testing

## Installation

This plugin is part of the Claude Code plugin system. To use it:

1. Ensure you're in a project directory
2. The plugin will be automatically available through Claude Code
3. Use the commands below to generate tests and analyze coverage

## Commands

### generate-tests

Generate comprehensive test suites for specified files or modules.

**Usage:**
```
/generate-tests [file-or-module]
```

**Examples:**
```bash
# Generate tests for a specific file
/generate-tests src/services/userService.ts

# Generate tests for an entire module
/generate-tests src/api/users

# Generate tests for a class
/generate-tests src/models/User.py
```

**Execution Flow:**

1. **Phase 1: Planning**
   - Launches the **test-strategy-planner** agent if no tests exist
   - Analyzes your project and recommends testing approach
   - Confirms strategy with you before proceeding

2. **Phase 2: Test Generation**
   - Launches the **test-generator** agent with your target file/module
   - Analyzes code structure, dependencies, and logic
   - Generates comprehensive tests including:
     - Happy path scenarios
     - Edge cases and boundary conditions
     - Error scenarios and exception handling
     - Mocks for external dependencies

3. **Phase 3: Review & Verification**
   - Shows generated tests for your review
   - Runs tests to verify they pass
   - Reports coverage metrics for the new tests

**Output:**
- Complete test files with proper imports and setup
- Organized test suites with descriptive names
- Instructions for running the tests
- Coverage information

---

### coverage-report

Analyze test coverage and identify untested code paths that need attention.

**Usage:**
```
/coverage-report
```

**Execution Flow:**

1. **Phase 1: Run Coverage**
   - Launches the **coverage-analyzer** agent
   - Executes appropriate coverage tools (Jest, pytest, go test, etc.)
   - Parses coverage reports and extracts metrics

2. **Phase 2: Analysis**
   - Identifies untested code paths
   - Calculates coverage percentages (lines, branches, functions)
   - Finds critical code without test coverage

3. **Phase 3: Recommendations**
   - Lists files needing tests, prioritized by criticality
   - Suggests specific testing priorities
   - Sets realistic coverage improvement goals
   - Provides actionable commands to improve coverage

**Output:**
- Overall coverage percentage
- Line, branch, and function coverage metrics
- List of uncovered critical code
- Prioritized recommendations (High, Medium, Low)
- Specific commands to run next

**Example Output:**
```markdown
# Test Coverage Analysis

## Summary
- Overall Coverage: 67%
- Lines: 1,234 / 1,850 (67%)
- Branches: 456 / 720 (63%)
- Functions: 123 / 180 (68%)

## Uncovered Critical Code

### High Priority (0% coverage)
1. src/auth/validateToken.ts - Authentication logic (0/45 lines)
2. src/payments/processPayment.ts - Payment processing (0/78 lines)

## Recommendations
1. Immediate: Test authentication and payment flows
2. This Sprint: Cover user API endpoints
3. Goal: Reach 80% coverage in 4 weeks
```

## Agents

### test-generator

**Model:** Sonnet
**Tools:** Read, Write, Glob, Grep, TodoWrite
**Color:** Green

The test-generator agent is an expert test engineer that writes comprehensive, meaningful test suites.

**Capabilities:**
- Generates unit tests for functions/methods
- Creates integration tests for module interactions
- Writes E2E tests for user flows
- Designs edge case and error scenario tests
- Generates mocks and fixtures for dependencies

**Test Generation Workflow:**

1. **Code Analysis**
   - Reads target file/module
   - Identifies functions, classes, and methods
   - Analyzes inputs, outputs, and side effects
   - Notes dependencies and external calls

2. **Test Planning**
   - Identifies test scenarios (happy path, edge cases, errors)
   - Determines mocking needs
   - Plans test data and fixtures

3. **Test Generation**
   - Creates tests following AAA pattern (Arrange, Act, Assert)
   - Uses descriptive test names
   - Ensures clear assertions
   - Maintains test independence

**Example Test Structure (Jest/TypeScript):**
```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create user with valid data', async () => {
      // Arrange
      const userData = { email: 'test@example.com', name: 'Test' };
      const mockRepository = {
        save: jest.fn().mockResolvedValue({ id: '1', ...userData })
      };
      const service = new UserService(mockRepository);

      // Act
      const result = await service.createUser(userData);

      // Assert
      expect(result).toEqual({ id: '1', ...userData });
      expect(mockRepository.save).toHaveBeenCalledWith(userData);
    });

    it('should throw error when email is invalid', async () => {
      const userData = { email: 'invalid', name: 'Test' };
      const service = new UserService(mockRepository);

      await expect(service.createUser(userData))
        .rejects.toThrow('Invalid email');
    });

    it('should handle database errors gracefully', async () => {
      const mockRepository = {
        save: jest.fn().mockRejectedValue(new Error('DB Error'))
      };
      const service = new UserService(mockRepository);

      await expect(service.createUser(validData))
        .rejects.toThrow('DB Error');
    });
  });
});
```

---

### coverage-analyzer

**Model:** Sonnet
**Tools:** Bash, Read, Glob, Grep, TodoWrite
**Color:** Yellow

The coverage-analyzer agent is an expert at identifying gaps in test suites and providing actionable recommendations.

**Capabilities:**
- Runs coverage tools for multiple frameworks
- Parses and interprets coverage reports
- Identifies untested code paths
- Prioritizes testing efforts by criticality
- Recommends specific coverage improvements

**Coverage Analysis Workflow:**

1. **Run Coverage Tools**
   - Executes framework-specific coverage commands
   - Generates detailed coverage reports

2. **Parse Coverage Reports**
   - Extracts line, branch, function, and statement coverage
   - Identifies files and functions with low/no coverage

3. **Identify Gaps**
   - Finds functions with 0% coverage
   - Locates critical paths without tests
   - Discovers untested error handling

4. **Prioritize**
   - **Critical**: Auth, payments, data loss risks
   - **High**: Core business logic, public APIs
   - **Medium**: Utilities, helpers, formatting
   - **Low**: Simple getters, trivial functions

5. **Provide Recommendations**
   - Lists specific files and functions to test
   - Suggests testing order
   - Sets coverage improvement goals
   - Estimates effort required

**Example Coverage Commands:**

**JavaScript/TypeScript:**
```bash
npm test -- --coverage
vitest run --coverage
```

**Python:**
```bash
pytest --cov=. --cov-report=html
coverage run -m pytest && coverage report
```

**Go:**
```bash
go test -cover ./...
go test -coverprofile=coverage.out ./...
```

---

### test-strategy-planner

**Model:** Sonnet
**Tools:** Read, Glob, Grep, TodoWrite, WebFetch
**Color:** Purple

The test-strategy-planner agent is an expert at designing comprehensive testing strategies for projects.

**Capabilities:**
- Analyzes project type and tech stack
- Recommends testing pyramid balance
- Suggests appropriate tooling
- Plans CI/CD integration
- Sets realistic coverage goals

**Strategy Planning Workflow:**

1. **Project Analysis**
   - Identifies project type (web app, API, library, CLI)
   - Analyzes tech stack and frameworks
   - Locates existing tests
   - Notes critical functionality

2. **Testing Pyramid**
   - Recommends balance of test types:
     - **Unit Tests (70%)**: Fast, isolated, many
     - **Integration Tests (20%)**: Module interactions
     - **E2E Tests (10%)**: Full user flows

3. **Test Types Needed**
   - Unit tests for functions/methods
   - Integration tests for APIs and databases
   - E2E tests for critical user journeys
   - Performance tests for load scenarios
   - Security tests for vulnerabilities

4. **Tool Recommendations**
   - Framework-specific testing tools
   - Mocking libraries
   - Coverage tools
   - E2E testing frameworks

5. **CI/CD Integration**
   - Test execution on PRs
   - Coverage thresholds
   - Parallel test execution
   - Result reporting

**Example Strategy Output:**

```markdown
# Testing Strategy

## Project Overview
- Type: Web Application
- Stack: React + Node.js + PostgreSQL
- Criticality: High (production app)

## Recommended Testing Approach

### Testing Pyramid
- Unit Tests: ~200 tests (70%)
- Integration Tests: ~60 tests (20%)
- E2E Tests: ~15 tests (10%)

### Test Types

**Unit Tests**: All utility functions, React components, business logic
**Integration Tests**: API endpoints with DB, auth flows, data validation
**E2E Tests**: User registration & login, core workflows, payment flows

### Tooling
- Unit/Integration: Jest + React Testing Library
- E2E: Playwright
- Mocking: MSW (API), jest.mock (modules)
- Coverage: Jest built-in

### Coverage Goals
- Unit Tests: 80%+ coverage
- Integration: All API endpoints
- E2E: Critical user paths
```

## Test Types

### Unit Tests

**Purpose:** Test individual functions, methods, or classes in isolation.

**Characteristics:**
- Fast execution (milliseconds)
- No external dependencies
- High test count (70% of test suite)
- Focused on single units of code

**When to Use:**
- Testing utility functions
- Validating business logic
- Testing component methods
- Verifying calculations and transformations

**Example:**
```typescript
describe('calculateDiscount', () => {
  it('should apply 10% discount for regular customers', () => {
    const result = calculateDiscount(100, 'regular');
    expect(result).toBe(90);
  });

  it('should apply 20% discount for premium customers', () => {
    const result = calculateDiscount(100, 'premium');
    expect(result).toBe(80);
  });

  it('should throw error for invalid customer type', () => {
    expect(() => calculateDiscount(100, 'invalid'))
      .toThrow('Invalid customer type');
  });
});
```

---

### Integration Tests

**Purpose:** Test how multiple modules work together.

**Characteristics:**
- Moderate execution speed
- May use test databases or APIs
- Medium test count (20% of test suite)
- Tests module interactions

**When to Use:**
- Testing API endpoints
- Validating database queries
- Testing service integrations
- Verifying data flows between modules

**Example:**
```typescript
describe('User API', () => {
  beforeEach(async () => {
    await setupTestDatabase();
  });

  it('should create user and return 201', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({ email: 'test@example.com', name: 'Test User' });

    expect(response.status).toBe(201);
    expect(response.body.id).toBeDefined();

    // Verify user was saved to database
    const user = await db.users.findOne({ id: response.body.id });
    expect(user.email).toBe('test@example.com');
  });
});
```

---

### End-to-End (E2E) Tests

**Purpose:** Test complete user workflows from start to finish.

**Characteristics:**
- Slow execution (seconds to minutes)
- Uses real browser/environment
- Low test count (10% of test suite)
- Tests critical user journeys

**When to Use:**
- Testing user registration/login flows
- Validating checkout processes
- Testing critical business workflows
- Verifying UI interactions

**Example (Playwright):**
```typescript
test('user can complete checkout', async ({ page }) => {
  // Login
  await page.goto('/login');
  await page.fill('[name="email"]', 'test@example.com');
  await page.fill('[name="password"]', 'password123');
  await page.click('button[type="submit"]');

  // Add item to cart
  await page.goto('/products');
  await page.click('[data-testid="product-1"]');
  await page.click('button:has-text("Add to Cart")');

  // Checkout
  await page.goto('/cart');
  await page.click('button:has-text("Checkout")');
  await page.fill('[name="cardNumber"]', '4242424242424242');
  await page.click('button:has-text("Complete Purchase")');

  // Verify success
  await expect(page.locator('text=Order Confirmed')).toBeVisible();
});
```

## Supported Frameworks

### JavaScript/TypeScript
- **Unit/Integration:** Jest, Vitest, Mocha
- **E2E:** Playwright, Cypress, Puppeteer
- **Mocking:** MSW, jest.mock, sinon
- **Coverage:** Jest built-in, c8, nyc

### Python
- **Unit/Integration:** pytest, unittest
- **E2E:** Selenium, Playwright
- **Mocking:** unittest.mock, pytest-mock
- **Coverage:** pytest-cov, coverage.py

### Ruby
- **Unit/Integration:** RSpec, Minitest
- **E2E:** Capybara
- **Mocking:** RSpec mocks, Mocha
- **Coverage:** SimpleCov

### Java
- **Unit/Integration:** JUnit, TestNG
- **E2E:** Selenium
- **Mocking:** Mockito, PowerMock
- **Coverage:** JaCoCo

### Go
- **Unit/Integration:** testing package
- **E2E:** Selenium, chromedp
- **Mocking:** gomock, testify
- **Coverage:** Built-in (go test -cover)

### Rust
- **Unit/Integration:** Built-in test framework
- **Mocking:** mockall
- **Coverage:** tarpaulin

## Workflow Examples

### Example 1: Starting a New Project

```bash
# Step 1: Get a testing strategy
/coverage-report

# Step 2: Generate tests for core modules
/generate-tests src/services/userService.ts
/generate-tests src/api/auth.ts
/generate-tests src/utils/validation.ts

# Step 3: Review coverage
/coverage-report

# Step 4: Fill gaps
/generate-tests src/db/migrations.ts
```

---

### Example 2: Improving Coverage for Existing Project

```bash
# Step 1: Analyze current coverage
/coverage-report

# Output identifies:
# - src/auth/validateToken.ts (0% coverage)
# - src/payments/processPayment.ts (0% coverage)

# Step 2: Generate tests for critical uncovered code
/generate-tests src/auth/validateToken.ts
/generate-tests src/payments/processPayment.ts

# Step 3: Verify improvement
/coverage-report
```

---

### Example 3: Testing a New Feature

```bash
# Before merging feature branch
/generate-tests src/features/newFeature.ts

# Review and run tests
npm test src/features/newFeature.test.ts

# Verify coverage
/coverage-report
```

## Best Practices

### 1. Follow the Testing Pyramid

Maintain proper balance:
- **70% Unit Tests**: Fast, focused, many
- **20% Integration Tests**: Module interactions
- **10% E2E Tests**: Critical user flows

### 2. Test Behavior, Not Implementation

**Bad:**
```typescript
it('should call fetchUser internally', () => {
  service.getUser(1);
  expect(service.fetchUser).toHaveBeenCalled(); // Testing implementation
});
```

**Good:**
```typescript
it('should return user data when user exists', async () => {
  const user = await service.getUser(1);
  expect(user).toEqual({ id: 1, name: 'John' }); // Testing behavior
});
```

### 3. Use Descriptive Test Names

**Bad:** `it('test user creation')`

**Good:** `it('should create user with valid email and return user ID')`

### 4. Keep Tests Independent

Each test should:
- Set up its own data
- Not depend on other tests
- Clean up after itself
- Run in any order

### 5. Test Edge Cases

Always test:
- Boundary values (0, -1, MAX_INT)
- Empty inputs (null, undefined, [], "")
- Invalid inputs
- Error conditions
- Concurrent scenarios

### 6. Mock External Dependencies

**Good mocking:**
```typescript
const mockEmailService = {
  send: jest.fn().mockResolvedValue({ success: true })
};

const userService = new UserService(mockEmailService);
```

### 7. Use AAA Pattern

**Arrange, Act, Assert:**
```typescript
it('should calculate total price', () => {
  // Arrange
  const items = [{ price: 10 }, { price: 20 }];
  const calculator = new PriceCalculator();

  // Act
  const total = calculator.calculateTotal(items);

  // Assert
  expect(total).toBe(30);
});
```

### 8. Review Generated Tests

Always review generated tests for:
- Correctness
- Completeness
- Maintainability
- Test data quality

### 9. Run Tests Before Committing

```bash
# Run all tests
npm test

# Run with coverage
npm test -- --coverage

# Run specific test file
npm test src/services/userService.test.ts
```

### 10. Integrate with CI/CD

Add to your CI pipeline:
```yaml
# .github/workflows/test.yml
name: Tests
on: [pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm install
      - run: npm test -- --coverage
      - run: |
          if [ "$(npm test -- --coverage --coverageThreshold='{"global":{"lines":80}}' | grep -o 'FAIL')" ]; then
            echo "Coverage below 80%"
            exit 1
          fi
```

## Coverage Goals

### Recommended Targets

| Code Type | Target Coverage |
|-----------|----------------|
| Critical Code (auth, payments) | 95%+ |
| Core Business Logic | 80%+ |
| API Endpoints | 80%+ |
| Utility Functions | 80%+ |
| UI Components | 70%+ |
| Simple Getters/Setters | 60%+ |

### Coverage Metrics

**Line Coverage:** Percentage of lines executed
**Branch Coverage:** Percentage of conditional branches tested
**Function Coverage:** Percentage of functions called
**Statement Coverage:** Percentage of statements executed

**Example:**
```
Overall Coverage: 82%
- Lines: 1,640 / 2,000 (82%)
- Branches: 380 / 500 (76%)
- Functions: 164 / 200 (82%)
- Statements: 1,640 / 2,000 (82%)
```

### Progressive Improvement

Start with critical code:
1. **Week 1**: Test auth and payment flows (95%+ coverage)
2. **Week 2**: Cover core business logic (80%+ coverage)
3. **Week 3**: Test API endpoints (80%+ coverage)
4. **Week 4**: Fill remaining gaps (70%+ overall)

### Maintaining Coverage

- Set coverage thresholds in CI/CD
- Block PRs that decrease coverage
- Regularly run `/coverage-report`
- Generate tests for new features before merging

---

## Summary

The Test Suite Generator plugin provides a comprehensive, automated approach to test creation and coverage analysis:

1. **Generate tests** for any file or module with `/generate-tests`
2. **Analyze coverage** and identify gaps with `/coverage-report`
3. **Plan strategy** with the test-strategy-planner agent
4. **Improve systematically** by following prioritized recommendations

With support for multiple languages and frameworks, this plugin helps you achieve high test coverage and maintain code quality across your entire codebase.

For questions or issues, contact Yannick De Backer at yannick@kobozo.eu.
