---
name: Clean Code Principles
description: This skill should be used when writing or reviewing code to ensure it follows clean code principles. Apply when creating functions, classes, modules, or any code structure. Provides guidance on SOLID principles, code smells, complexity management, and maintainability. Use proactively to write better code from the start.
version: 1.0.0
---

# Clean Code Principles

Apply these principles automatically when writing code to produce maintainable, readable, and robust software.

## SOLID Principles

### Single Responsibility Principle (SRP)

A class/function should have only one reason to change.

```typescript
// GOOD: Separate responsibilities
class UserRepository {
  async save(user: User): Promise<void> { /* database ops */ }
  async findById(id: string): Promise<User> { /* database ops */ }
}

class UserValidator {
  validate(user: User): ValidationResult { /* validation logic */ }
}

class UserNotifier {
  async sendWelcomeEmail(user: User): Promise<void> { /* email logic */ }
}
```

**Signs of SRP violation:**
- Class has multiple unrelated methods
- Changes in one area require changes in unrelated areas
- Hard to name the class without using "and" or "or"

### Open/Closed Principle (OCP)

Open for extension, closed for modification.

```typescript
// GOOD: Strategy pattern for extensibility
interface PaymentStrategy {
  process(amount: number): Promise<PaymentResult>;
}

class CreditCardPayment implements PaymentStrategy {
  async process(amount: number): Promise<PaymentResult> { /* ... */ }
}

class PayPalPayment implements PaymentStrategy {
  async process(amount: number): Promise<PaymentResult> { /* ... */ }
}

// Adding new payment method doesn't modify existing code
class CryptoPayment implements PaymentStrategy {
  async process(amount: number): Promise<PaymentResult> { /* ... */ }
}
```

### Liskov Substitution Principle (LSP)

Subtypes must be substitutable for their base types.

```typescript
// GOOD: Proper inheritance
abstract class Shape {
  abstract area(): number;
}

class Rectangle extends Shape {
  constructor(private width: number, private height: number) { super(); }
  area(): number { return this.width * this.height; }
}

class Circle extends Shape {
  constructor(private radius: number) { super(); }
  area(): number { return Math.PI * this.radius ** 2; }
}
```

### Interface Segregation Principle (ISP)

Clients shouldn't depend on interfaces they don't use.

```typescript
// GOOD: Small, focused interfaces
interface Readable {
  read(): string;
}

interface Writable {
  write(data: string): void;
}

interface Seekable {
  seek(position: number): void;
}

// Classes implement only what they need
class ReadOnlyFile implements Readable {
  read(): string { /* ... */ }
}

class ReadWriteFile implements Readable, Writable {
  read(): string { /* ... */ }
  write(data: string): void { /* ... */ }
}
```

### Dependency Inversion Principle (DIP)

Depend on abstractions, not concretions.

```typescript
// GOOD: Depend on interface
interface Logger {
  log(message: string): void;
}

class UserService {
  constructor(private logger: Logger) {}

  createUser(data: UserData): User {
    this.logger.log('Creating user');
    // ...
  }
}

// Easy to swap implementations
const service = new UserService(new ConsoleLogger());
const testService = new UserService(new MockLogger());
```

## Code Smells to Avoid

### Long Methods
- Keep functions under 20 lines
- Extract helper functions for logical sections
- Each function should do one thing

### Large Classes
- Keep classes under 200-300 lines
- Split by responsibility
- Prefer composition over inheritance

### Duplicate Code
- Extract common logic to shared functions
- Use generics for type variations
- Create utility modules for cross-cutting concerns

### Long Parameter Lists
```typescript
// AVOID: Too many parameters
function createUser(name, email, age, address, phone, role) { }

// BETTER: Use object parameter
function createUser(options: CreateUserOptions) { }

// Or builder pattern for complex construction
const user = new UserBuilder()
  .withName('John')
  .withEmail('john@example.com')
  .build();
```

### Feature Envy
When a method uses more features of another class than its own, move it.

### Primitive Obsession
```typescript
// AVOID: Primitive types for domain concepts
function processOrder(customerId: string, amount: number, currency: string) { }

// BETTER: Domain objects
function processOrder(customer: Customer, money: Money) { }
```

## Complexity Guidelines

### Cyclomatic Complexity
- Keep function complexity under 10
- Extract branches to separate functions
- Use early returns to reduce nesting

```typescript
// AVOID: Deeply nested
function process(data) {
  if (data) {
    if (data.isValid) {
      if (data.hasPermission) {
        // actual logic buried
      }
    }
  }
}

// BETTER: Early returns
function process(data) {
  if (!data) return;
  if (!data.isValid) return;
  if (!data.hasPermission) return;

  // clear logic at top level
}
```

### Cognitive Complexity
- Minimize nesting depth (max 3-4 levels)
- Use descriptive variable names
- Break complex conditions into named booleans

```typescript
// AVOID: Complex condition
if (user.age >= 18 && user.country === 'US' && !user.isBanned && user.emailVerified) { }

// BETTER: Named conditions
const isAdult = user.age >= 18;
const isUSResident = user.country === 'US';
const isActiveAccount = !user.isBanned && user.emailVerified;

if (isAdult && isUSResident && isActiveAccount) { }
```

## Naming Conventions

### Functions
- Use verbs: `getUserById`, `validateEmail`, `calculateTotal`
- Be specific: `sendWelcomeEmail` not `send`
- Avoid generic names: `processData`, `handleStuff`

### Variables
- Use nouns: `user`, `orderItems`, `totalAmount`
- Plurals for collections: `users`, `items`
- Booleans with is/has/can: `isActive`, `hasPermission`, `canEdit`

### Classes
- Use nouns: `UserRepository`, `PaymentProcessor`
- Avoid suffixes like `Manager`, `Handler`, `Helper` (often indicates SRP violation)

## DRY (Don't Repeat Yourself)

Extract repeated code:

```typescript
// GOOD: Shared validation
const emailSchema = z.string().email();

// Reused across forms
const loginSchema = z.object({ email: emailSchema, password: z.string() });
const signupSchema = z.object({ email: emailSchema, password: z.string(), name: z.string() });
```

But avoid premature abstraction - wait for 3 occurrences before extracting.

## Quick Reference

### Function Checklist
- [ ] Single responsibility
- [ ] Under 20 lines
- [ ] Descriptive name
- [ ] Max 3-4 parameters
- [ ] Low cyclomatic complexity

### Class Checklist
- [ ] Single responsibility
- [ ] Under 300 lines
- [ ] Depends on abstractions
- [ ] Small, focused interfaces

### Code Quality Thresholds
| Metric | Good | Warning | Critical |
|--------|------|---------|----------|
| Function length | <20 lines | 20-50 | >50 |
| Class length | <200 lines | 200-500 | >500 |
| Cyclomatic complexity | <10 | 10-20 | >20 |
| Parameter count | <4 | 4-6 | >6 |
| Nesting depth | <3 | 3-4 | >4 |

## Additional Resources

- [Clean Code by Robert C. Martin](https://www.oreilly.com/library/view/clean-code-a/9780136083238/)
- [Refactoring by Martin Fowler](https://refactoring.com/)
