---
description: Generate comprehensive Playwright authentication tests with OTP detection and Page Object Model
---

# Generate Playwright Authentication Tests

Orchestrates the complete workflow for generating production-ready Playwright authentication tests.

## Usage

```
/generate-playwright-auth-tests [optional: base-url]
```

Examples:
- `/generate-playwright-auth-tests`
- `/generate-playwright-auth-tests http://localhost:3000`

## What This Command Does

This command analyzes your codebase to understand your authentication flow, detects OTP sources (database, email, SMS), and generates a complete Playwright test suite with:

1. **Authentication pattern detection** (simple login, OTP, 2FA, multi-step, magic links)
2. **OTP retrieval automation** (from database or email)
3. **Page Object Model classes** for maintainable tests
4. **Comprehensive test scenarios** (happy path + error cases)
5. **Authentication state persistence** for faster test execution
6. **Playwright configuration** optimized for auth testing

## Execution Flow

### Phase 1: Authentication Analysis

**Objective**: Understand your authentication system

**Action**: Launch **auth-pattern-detector** agent to:
- Detect authentication patterns in your codebase
- Identify OTP sources (database tables, email services)
- Map login flow architecture
- Extract selectors and API endpoints
- Determine technology stack

**Output**: Comprehensive authentication analysis report

### Phase 2: Page Object Model Generation

**Objective**: Create reusable Page Object classes

**Action**: Launch **page-object-builder** agent with the analysis report to:
- Generate Page Object Model classes (LoginPage, OTPPage, DashboardPage, etc.)
- Create authentication fixtures for OTP retrieval
- Set up test data configuration
- Build helper utilities

**Output**: Complete POM structure in `tests/e2e/page-objects/`

### Phase 3: Test Generation

**Objective**: Generate comprehensive Playwright tests

**Action**: Launch **playwright-auth-generator** agent to:
- Create test files for authentication flows
- Generate setup script for authentication state
- Write Playwright configuration
- Create environment configuration template
- Add package.json dependencies

**Output**: Production-ready test suite in `tests/e2e/auth/`

### Phase 4: Setup & Validation

**Objective**: Ensure everything is ready to run

**Actions**:
1. Check if Playwright is installed
   - If not: Ask user permission to run `npm install -D @playwright/test`
2. Check if Playwright browsers are installed
   - If not: Ask user permission to run `npx playwright install`
3. Verify environment variables are documented
4. Display setup instructions

### Phase 5: Review & Confirmation

**Objective**: Review generated code with user

**Actions**:
1. Show summary of generated files
2. Explain the authentication flow detected
3. Highlight any manual setup required (environment variables, test users)
4. Ask if user wants to run a test execution

### Optional Phase 6: Test Execution

**Objective**: Validate that tests run successfully

**If user confirms**:
1. Ensure dev server is running (or start it)
2. Run authentication tests: `npx playwright test tests/e2e/auth/`
3. Display results
4. Show Playwright report if tests fail

## Generated File Structure

After running this command, you'll have:

```
tests/
└── e2e/
    ├── .auth/
    │   ├── .gitignore
    │   └── README.md
    ├── auth/
    │   ├── auth.setup.ts          # Authentication state setup
    │   ├── login.spec.ts          # Login tests
    │   ├── otp.spec.ts            # OTP tests (if applicable)
    │   ├── logout.spec.ts         # Logout tests
    │   └── session.spec.ts        # Session persistence tests
    ├── page-objects/
    │   ├── LoginPage.ts           # Login page object
    │   ├── OTPPage.ts             # OTP page object (if applicable)
    │   ├── DashboardPage.ts       # Dashboard page object
    │   └── index.ts               # Exports
    ├── fixtures/
    │   ├── auth-fixtures.ts       # OTP retrieval helpers
    │   ├── email-fixtures.ts      # Email OTP (if applicable)
    │   └── test-data.ts           # Test user data
    └── playwright.config.ts       # Playwright configuration

.env.test                          # Environment variables template
package.json                       # Updated with dependencies
README.md                          # Setup and usage guide
```

## Environment Variables Required

The command will create a `.env.test` template. You'll need to configure:

```bash
# Application
BASE_URL=http://localhost:3000

# Test User
TEST_USER_EMAIL=test@example.com
TEST_USER_PASSWORD=SecurePassword123!

# Database (if OTP from database)
DATABASE_URL=postgresql://user:password@localhost:5432/testdb

# Email (if OTP from email)
IMAP_HOST=imap.gmail.com
IMAP_PORT=993
IMAP_USER=test@example.com
IMAP_PASSWORD=app-specific-password
```

## Running Generated Tests

After setup, run tests with:

```bash
# Run all auth tests
npx playwright test tests/e2e/auth/

# Run specific test file
npx playwright test tests/e2e/auth/login.spec.ts

# Run with UI
npx playwright test --ui

# Debug mode
npx playwright test --debug

# View report
npx playwright show-report
```

## Best Practices

1. **Create test users**: Set up dedicated test accounts in your database
2. **Use test email**: Use a test email account accessible via IMAP
3. **Environment isolation**: Use separate test database/environment
4. **Keep credentials secure**: Use `.env.test` and add to `.gitignore`
5. **Review generated code**: Customize selectors if needed
6. **Run locally first**: Validate tests work before CI/CD integration

## Troubleshooting

**OTP not found in database**:
- Verify `DATABASE_URL` is correct
- Check test user exists
- Ensure OTP is being created during login

**OTP not found in email**:
- Verify IMAP credentials
- Check email is being sent
- Increase timeout if email is slow

**Tests timing out**:
- Ensure dev server is running
- Check `BASE_URL` is correct
- Verify network connectivity

**Selectors not working**:
- Review generated Page Objects
- Update selectors to match your UI
- Use Playwright Inspector: `npx playwright test --debug`

## Agent Orchestration Workflow

```
User: /generate-playwright-auth-tests
  ↓
┌─────────────────────────────────────────┐
│ Phase 1: auth-pattern-detector          │
│ - Analyze authentication patterns       │
│ - Detect OTP sources                    │
│ - Map login flow                        │
└────────────┬────────────────────────────┘
             ↓ (AuthAnalysisReport)
┌─────────────────────────────────────────┐
│ Phase 2: page-object-builder            │
│ - Generate Page Object classes          │
│ - Create authentication fixtures        │
│ - Build OTP retrieval helpers           │
└────────────┬────────────────────────────┘
             ↓ (PageObjects + Fixtures)
┌─────────────────────────────────────────┐
│ Phase 3: playwright-auth-generator      │
│ - Generate test files                   │
│ - Create Playwright config              │
│ - Setup authentication state            │
└────────────┬────────────────────────────┘
             ↓ (Test Suite)
┌─────────────────────────────────────────┐
│ Phase 4: Setup & Validation             │
│ - Install dependencies                  │
│ - Verify configuration                  │
│ - Display setup instructions            │
└────────────┬────────────────────────────┘
             ↓
┌─────────────────────────────────────────┐
│ Phase 5: Review & Confirmation          │
│ - Present generated files               │
│ - Explain authentication flow           │
│ - Ask about test execution              │
└────────────┬────────────────────────────┘
             ↓ (if user confirms)
┌─────────────────────────────────────────┐
│ Optional Phase 6: Test Execution        │
│ - Run Playwright tests                  │
│ - Display results                       │
│ - Show report if failures               │
└─────────────────────────────────────────┘
```

## Implementation Instructions

Your task as the orchestrator is to:

1. **Use TodoWrite** to track each phase
2. **Launch agents sequentially** with proper inputs:
   - `auth-pattern-detector` with base URL (if provided)
   - `page-object-builder` with analysis report
   - `playwright-auth-generator` with analysis + page objects
3. **Handle agent outputs**:
   - Parse analysis report from Phase 1
   - Pass report to Phase 2 agent
   - Combine outputs for Phase 3 agent
4. **Perform setup tasks**:
   - Check dependencies
   - Offer to install if missing
   - Create directory structure
5. **Present results**:
   - Summarize what was generated
   - Highlight manual configuration needed
   - Provide clear next steps
6. **Optional execution**:
   - Ask if user wants to run tests
   - Execute and display results
   - Help debug if failures occur

## Success Criteria

The command is successful when:
- ✅ Authentication pattern correctly detected
- ✅ OTP source identified and retrieval method implemented
- ✅ Page Object Model classes generated
- ✅ Test files cover happy path and error scenarios
- ✅ Playwright configuration created
- ✅ Dependencies documented
- ✅ Setup instructions clear
- ✅ Tests run successfully (if user chooses to execute)

Your goal is to make Playwright authentication testing completely automated and effortless for the user.
