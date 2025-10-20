---
description: Generate comprehensive Playwright E2E tests for any user flow or feature using Page Object Model
---

# Generate Playwright E2E Tests

Generates end-to-end Playwright tests for general user flows and features beyond authentication.

## Usage

```
/generate-playwright-e2e <feature-or-flow-description>
```

Examples:
- `/generate-playwright-e2e user registration flow`
- `/generate-playwright-e2e checkout process`
- `/generate-playwright-e2e dashboard navigation`
- `/generate-playwright-e2e file upload functionality`
- `/generate-playwright-e2e search and filtering`

## What This Command Does

This command analyzes your codebase to understand a specific user flow or feature, then generates:

1. **Page Object Model classes** for the identified pages/components
2. **Comprehensive E2E test scenarios** covering happy paths and edge cases
3. **Test fixtures and utilities** for test data and helpers
4. **Playwright configuration** if not already present
5. **Setup and usage documentation**

## When to Use This Command

Use `/generate-playwright-e2e` for:
- **User flows**: Multi-step processes (checkout, onboarding, form submissions)
- **Feature testing**: Specific functionality (search, filtering, file upload)
- **Navigation testing**: Page transitions and routing
- **Integration testing**: Multiple components working together
- **Regression testing**: Critical user paths

Use `/generate-playwright-auth-tests` instead for:
- Login/logout flows
- Authentication with OTP/2FA
- Password reset flows
- Account registration with verification

## Execution Flow

### Phase 1: Flow Analysis

**Objective**: Understand the user flow or feature

**Questions Asked**:
1. What is the starting page/URL for this flow?
2. What are the key steps in this user flow?
3. Are there any prerequisites (e.g., user must be logged in)?
4. What is the expected end state/success criteria?

**Action**: Analyze codebase to:
- Identify pages and components involved
- Map user flow steps
- Extract selectors and elements
- Identify API calls and data requirements
- Detect edge cases and error scenarios

**Output**: Flow Analysis Report

### Phase 2: Page Object Generation

**Objective**: Create Page Object Model classes

**Action**: Launch **page-object-builder** agent to:
- Generate POM classes for each page in the flow
- Create shared component page objects (modals, dropdowns, etc.)
- Build helper utilities
- Set up test fixtures

**Output**: POM structure in `tests/e2e/page-objects/`

### Phase 3: Test Generation

**Objective**: Generate comprehensive E2E tests

**Action**: Generate test files covering:
- Happy path: Successful completion of the flow
- Validation errors: Form validation, input errors
- Edge cases: Boundary conditions, empty states
- Error handling: Network errors, API failures
- Accessibility: Keyboard navigation, screen readers
- Different states: Logged in/out, different permissions

**Output**: Test files in `tests/e2e/flows/` or `tests/e2e/features/`

### Phase 4: Setup & Review

**Objective**: Ensure tests are ready to run

**Actions**:
1. Check Playwright dependencies
2. Verify authentication state setup (if required)
3. Display generated files
4. Provide setup instructions
5. Ask if user wants to run tests

## Generated File Structure

```
tests/
└── e2e/
    ├── flows/                      # User flow tests
    │   └── {flow-name}/
    │       ├── {flow-name}.spec.ts
    │       ├── {flow-name}-errors.spec.ts
    │       └── {flow-name}-accessibility.spec.ts
    ├── features/                   # Feature-specific tests
    │   └── {feature-name}/
    │       └── {feature-name}.spec.ts
    ├── page-objects/
    │   ├── {PageName}.ts           # New page objects
    │   ├── shared/                 # Shared components
    │   │   ├── Modal.ts
    │   │   ├── Dropdown.ts
    │   │   └── FileUpload.ts
    │   └── index.ts
    ├── fixtures/
    │   ├── {feature}-fixtures.ts   # Test data and helpers
    │   └── test-data.ts
    └── playwright.config.ts        # Updated config if needed
```

## Example Test: Checkout Flow

```typescript
import { test, expect } from '@playwright/test';
import { ProductPage } from '../page-objects/ProductPage';
import { CartPage } from '../page-objects/CartPage';
import { CheckoutPage } from '../page-objects/CheckoutPage';
import { OrderConfirmationPage } from '../page-objects/OrderConfirmationPage';

test.describe('E2E: Checkout Flow', () => {
  test.use({ storageState: 'tests/e2e/.auth/user.json' });

  test('should complete checkout successfully', async ({ page }) => {
    const productPage = new ProductPage(page);
    const cartPage = new CartPage(page);
    const checkoutPage = new CheckoutPage(page);
    const confirmationPage = new OrderConfirmationPage(page);

    // Step 1: Add product to cart
    await productPage.goto('/products/test-product-123');
    await productPage.selectSize('M');
    await productPage.selectColor('Blue');
    await productPage.addToCart();
    await expect(await productPage.getCartCount()).toBe('1');

    // Step 2: Navigate to cart
    await productPage.goToCart();
    await expect(await cartPage.getItemCount()).toBe(1);
    await expect(await cartPage.getTotal()).toContain('$49.99');

    // Step 3: Proceed to checkout
    await cartPage.proceedToCheckout();
    await checkoutPage.waitForCheckoutPage();

    // Step 4: Fill shipping information
    await checkoutPage.fillShippingInfo({
      fullName: 'Test User',
      address: '123 Test St',
      city: 'Testville',
      zipCode: '12345',
      country: 'United States',
    });

    // Step 5: Select shipping method
    await checkoutPage.selectShippingMethod('Standard');

    // Step 6: Fill payment information
    await checkoutPage.fillPaymentInfo({
      cardNumber: '4242424242424242',
      expiry: '12/25',
      cvv: '123',
    });

    // Step 7: Place order
    await checkoutPage.placeOrder();

    // Step 8: Verify order confirmation
    await confirmationPage.waitForConfirmation();
    await expect(page).toHaveURL(/.*order-confirmation/);
    const orderNumber = await confirmationPage.getOrderNumber();
    expect(orderNumber).toMatch(/^ORD-\d+$/);
  });

  test('should show validation errors for invalid payment', async ({ page }) => {
    const productPage = new ProductPage(page);
    const cartPage = new CartPage(page);
    const checkoutPage = new CheckoutPage(page);

    // Add product and go to checkout
    await productPage.goto('/products/test-product-123');
    await productPage.addToCart();
    await productPage.goToCart();
    await cartPage.proceedToCheckout();

    // Fill valid shipping info
    await checkoutPage.fillShippingInfo({
      fullName: 'Test User',
      address: '123 Test St',
      city: 'Testville',
      zipCode: '12345',
      country: 'United States',
    });

    // Try invalid card number
    await checkoutPage.fillPaymentInfo({
      cardNumber: '1234', // Invalid
      expiry: '12/25',
      cvv: '123',
    });

    await checkoutPage.placeOrder();

    // Should show error
    await expect(await checkoutPage.hasPaymentError()).toBe(true);
    const errorMessage = await checkoutPage.getPaymentError();
    expect(errorMessage).toContain('Invalid card number');
  });
});
```

## Example Page Object: CheckoutPage

```typescript
import { Page, Locator, expect } from '@playwright/test';

interface ShippingInfo {
  fullName: string;
  address: string;
  city: string;
  zipCode: string;
  country: string;
}

interface PaymentInfo {
  cardNumber: string;
  expiry: string;
  cvv: string;
}

export class CheckoutPage {
  readonly page: Page;

  // Shipping section
  readonly fullNameInput: Locator;
  readonly addressInput: Locator;
  readonly cityInput: Locator;
  readonly zipCodeInput: Locator;
  readonly countrySelect: Locator;

  // Shipping method
  readonly shippingMethods: Locator;

  // Payment section
  readonly cardNumberInput: Locator;
  readonly expiryInput: Locator;
  readonly cvvInput: Locator;

  // Actions
  readonly placeOrderButton: Locator;

  // Errors
  readonly paymentError: Locator;

  constructor(page: Page) {
    this.page = page;

    // Initialize shipping locators
    this.fullNameInput = page.locator('[data-testid="shipping-fullname"]');
    this.addressInput = page.locator('[data-testid="shipping-address"]');
    this.cityInput = page.locator('[data-testid="shipping-city"]');
    this.zipCodeInput = page.locator('[data-testid="shipping-zipcode"]');
    this.countrySelect = page.locator('[data-testid="shipping-country"]');

    // Shipping method
    this.shippingMethods = page.locator('[data-testid^="shipping-method-"]');

    // Payment locators
    this.cardNumberInput = page.locator('[data-testid="payment-card-number"]');
    this.expiryInput = page.locator('[data-testid="payment-expiry"]');
    this.cvvInput = page.locator('[data-testid="payment-cvv"]');

    // Action buttons
    this.placeOrderButton = page.locator('[data-testid="place-order-button"]');

    // Errors
    this.paymentError = page.locator('[data-testid="payment-error"]');
  }

  async waitForCheckoutPage() {
    await expect(this.fullNameInput).toBeVisible();
  }

  async fillShippingInfo(info: ShippingInfo) {
    await this.fullNameInput.fill(info.fullName);
    await this.addressInput.fill(info.address);
    await this.cityInput.fill(info.city);
    await this.zipCodeInput.fill(info.zipCode);
    await this.countrySelect.selectOption(info.country);
  }

  async selectShippingMethod(method: 'Standard' | 'Express' | 'Overnight') {
    const methodButton = this.page.locator(
      `[data-testid="shipping-method-${method.toLowerCase()}"]`
    );
    await methodButton.click();
  }

  async fillPaymentInfo(info: PaymentInfo) {
    await this.cardNumberInput.fill(info.cardNumber);
    await this.expiryInput.fill(info.expiry);
    await this.cvvInput.fill(info.cvv);
  }

  async placeOrder() {
    await this.placeOrderButton.click();
  }

  async hasPaymentError() {
    return await this.paymentError.isVisible();
  }

  async getPaymentError() {
    return await this.paymentError.textContent();
  }
}
```

## Test Scenarios Generated

For each flow/feature, tests will cover:

**Happy Path**:
- Complete flow from start to finish
- All steps execute successfully
- Expected end state reached

**Validation Errors**:
- Required field validation
- Format validation (email, phone, etc.)
- Business rule validation

**Edge Cases**:
- Empty states
- Maximum/minimum values
- Boundary conditions
- Special characters

**Error Handling**:
- Network failures
- API errors
- Timeout scenarios
- Concurrent operations

**Accessibility**:
- Keyboard navigation
- Screen reader compatibility
- Focus management
- ARIA attributes

## Prerequisites Detection

The command will detect if the flow requires:
- **Authentication**: Reuse `tests/e2e/.auth/user.json`
- **Specific user role**: Generate role-specific auth states
- **Test data**: Create fixtures for products, users, etc.
- **Database seeding**: Provide seeding script templates
- **API mocking**: Set up mock responses if needed

## Best Practices

1. **Identify the flow clearly**: Be specific about what you want to test
2. **Review generated selectors**: Update with actual data-testid values
3. **Customize test data**: Replace placeholder data with realistic values
4. **Run incrementally**: Test one scenario at a time initially
5. **Use authentication state**: Reuse login state for authenticated flows
6. **Keep tests independent**: Each test should be runnable in isolation
7. **Add visual regression**: Consider screenshot comparison for UI-heavy flows

## Running Generated Tests

```bash
# Run all E2E tests
npx playwright test tests/e2e/flows/

# Run specific flow
npx playwright test tests/e2e/flows/checkout/

# Run with UI mode
npx playwright test --ui

# Debug mode
npx playwright test --debug tests/e2e/flows/checkout/checkout.spec.ts

# Generate trace
npx playwright test --trace on
```

## Integration with CI/CD

Generated tests are CI/CD ready. Add to your pipeline:

```yaml
# .github/workflows/e2e.yml
name: E2E Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npx playwright test
      - uses: actions/upload-artifact@v3
        if: always()
        with:
          name: playwright-report
          path: playwright-report/
```

## Troubleshooting

**Tests are flaky**:
- Review wait strategies (use explicit waits)
- Check for race conditions
- Increase timeouts for slow operations
- Use `test.describe.configure({ retries: 2 })`

**Selectors not found**:
- Verify selectors match your UI
- Use Playwright Inspector: `npx playwright test --debug`
- Add data-testid attributes to your UI

**Authentication issues**:
- Ensure auth state is properly saved
- Verify token hasn't expired
- Check cookies/localStorage persistence

## Implementation Instructions

Your task as the orchestrator is to:

1. **Understand the user's request**:
   - Parse the feature/flow description
   - Ask clarifying questions if needed
   - Identify starting point and success criteria

2. **Analyze the codebase**:
   - Find relevant pages and components
   - Map the user flow
   - Identify test scenarios

3. **Generate Page Objects**:
   - Launch `page-object-builder` agent
   - Create POM classes for all pages
   - Build helper utilities

4. **Generate tests**:
   - Create test files for each scenario
   - Include happy path and error cases
   - Add accessibility tests

5. **Setup and review**:
   - Check dependencies
   - Display generated files
   - Provide setup instructions

6. **Optional execution**:
   - Offer to run tests
   - Display results
   - Help debug failures

## Success Criteria

The command is successful when:
- ✅ User flow correctly identified
- ✅ All pages mapped and Page Objects created
- ✅ Test scenarios comprehensive (happy path + errors)
- ✅ Tests use authentication state if needed
- ✅ Selectors and test data are realistic
- ✅ Tests are ready to run
- ✅ Documentation is clear

Your goal is to make E2E testing effortless by automating the entire test generation process.
