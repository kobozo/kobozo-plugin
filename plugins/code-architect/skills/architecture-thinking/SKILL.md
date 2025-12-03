---
name: Architecture Thinking
description: This skill should be used when designing systems, planning components, organizing code structure, or making architectural decisions. Apply when user asks about "how to structure", "system design", "component organization", "module boundaries", or when building features that span multiple components. Provides guidance on layered architecture, dependency management, and system decomposition.
version: 1.0.0
---

# Architecture Thinking

Apply these principles when designing systems, organizing code, or making structural decisions.

## Core Principles

### Separation of Concerns

Each component should have a single, well-defined responsibility.

```
┌─────────────────────────────────────────────┐
│                 Presentation                │  UI, Views, Controllers
├─────────────────────────────────────────────┤
│              Business Logic                 │  Services, Use Cases
├─────────────────────────────────────────────┤
│                Data Access                  │  Repositories, DAO
├─────────────────────────────────────────────┤
│                Infrastructure               │  DB, External APIs
└─────────────────────────────────────────────┘
```

### Dependency Direction

Dependencies should point inward (toward business logic):

```
UI → Services → Domain ← Repository
         ↑                    ↓
         └──── Interfaces ────┘
```

- Domain has no external dependencies
- Services depend on domain interfaces
- Infrastructure implements interfaces

### High Cohesion, Low Coupling

- **Cohesion**: Related code should be together
- **Coupling**: Components should have minimal dependencies on each other

## Common Architectures

### Layered Architecture

```
src/
├── presentation/     # Controllers, Views, DTOs
│   ├── controllers/
│   └── dto/
├── application/      # Use cases, Application services
│   └── services/
├── domain/           # Business logic, Entities
│   ├── entities/
│   └── interfaces/
└── infrastructure/   # External concerns
    ├── database/
    └── external/
```

### Feature-Based Structure

```
src/
├── features/
│   ├── auth/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── services/
│   │   └── types/
│   ├── users/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── services/
│   │   └── types/
│   └── orders/
├── shared/
│   ├── components/
│   ├── utils/
│   └── hooks/
└── core/
    ├── api/
    └── config/
```

### Clean Architecture

```
┌─────────────────────────────────────┐
│           Frameworks & Drivers       │  Web, DB, External
├─────────────────────────────────────┤
│         Interface Adapters          │  Controllers, Presenters
├─────────────────────────────────────┤
│          Use Cases                  │  Application business rules
├─────────────────────────────────────┤
│           Entities                  │  Enterprise business rules
└─────────────────────────────────────┘
```

## Design Patterns for Architecture

### Repository Pattern

Abstracts data access:

```typescript
// Interface (domain layer)
interface UserRepository {
  findById(id: string): Promise<User | null>;
  save(user: User): Promise<void>;
}

// Implementation (infrastructure layer)
class PostgresUserRepository implements UserRepository {
  async findById(id: string): Promise<User | null> {
    const row = await this.db.query('SELECT * FROM users WHERE id = $1', [id]);
    return row ? this.toUser(row) : null;
  }
}
```

### Service Layer

Orchestrates business operations:

```typescript
class OrderService {
  constructor(
    private orderRepo: OrderRepository,
    private paymentService: PaymentService,
    private notificationService: NotificationService
  ) {}

  async placeOrder(orderData: OrderData): Promise<Order> {
    const order = Order.create(orderData);
    await this.paymentService.charge(order.total);
    await this.orderRepo.save(order);
    await this.notificationService.sendConfirmation(order);
    return order;
  }
}
```

### Facade Pattern

Simplifies complex subsystems:

```typescript
class PaymentFacade {
  async processPayment(order: Order): Promise<PaymentResult> {
    // Coordinates multiple payment subsystems
    const validation = await this.validator.validate(order);
    const fraud = await this.fraudDetector.check(order);
    const result = await this.processor.charge(order);
    await this.ledger.record(result);
    return result;
  }
}
```

## Module Boundaries

### When to Split Modules

- Different rate of change
- Different teams own different parts
- Different deployment requirements
- Clear domain boundaries

### Module Interface Design

```typescript
// Public API of a module
// users/index.ts
export { UserService } from './services/UserService';
export { User, UserRole } from './types';
export type { CreateUserData, UpdateUserData } from './types';

// Internal implementation hidden
// Don't export: UserValidator, UserMapper, etc.
```

### Dependency Rules

```typescript
// GOOD: Feature depends on shared
import { Button } from '@/shared/components';

// GOOD: Feature uses core services
import { api } from '@/core/api';

// BAD: Feature depends on another feature
import { OrderService } from '@/features/orders';  // Creates coupling

// BETTER: Use shared service or events
import { eventBus } from '@/core/events';
eventBus.emit('user.created', user);
```

## API Design

### RESTful Resources

```
GET    /api/users          # List users
POST   /api/users          # Create user
GET    /api/users/:id      # Get user
PUT    /api/users/:id      # Update user
DELETE /api/users/:id      # Delete user
GET    /api/users/:id/orders  # User's orders
```

### Request/Response Design

```typescript
// Request DTOs
interface CreateUserRequest {
  email: string;
  name: string;
  role?: UserRole;
}

// Response DTOs (never expose domain entities directly)
interface UserResponse {
  id: string;
  email: string;
  name: string;
  createdAt: string;  // ISO string, not Date
}
```

## Error Handling Architecture

### Error Hierarchy

```typescript
// Base error
class AppError extends Error {
  constructor(
    message: string,
    public code: string,
    public statusCode: number = 500
  ) {
    super(message);
  }
}

// Domain errors
class ValidationError extends AppError {
  constructor(message: string) {
    super(message, 'VALIDATION_ERROR', 400);
  }
}

class NotFoundError extends AppError {
  constructor(resource: string) {
    super(`${resource} not found`, 'NOT_FOUND', 404);
  }
}
```

### Error Boundaries

```typescript
// Controller catches service errors
async function createUser(req, res) {
  try {
    const user = await userService.create(req.body);
    res.json(user);
  } catch (error) {
    if (error instanceof ValidationError) {
      res.status(400).json({ error: error.message });
    } else {
      res.status(500).json({ error: 'Internal error' });
    }
  }
}
```

## Quick Reference

### Architecture Decision Checklist

When making structural decisions:

- [ ] What's the component's single responsibility?
- [ ] What are its dependencies?
- [ ] How will it be tested in isolation?
- [ ] What's the public interface?
- [ ] How does it handle errors?
- [ ] What happens if requirements change?

### Layer Responsibilities

| Layer | Contains | Depends On |
|-------|----------|------------|
| Presentation | Controllers, Views | Application |
| Application | Use Cases, Services | Domain |
| Domain | Entities, Interfaces | Nothing |
| Infrastructure | DB, APIs | Domain interfaces |

### Common Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| God class | Does too much | Split by responsibility |
| Circular deps | A→B→A | Extract shared interface |
| Tight coupling | Hard to change | Depend on abstractions |
| Leaky abstraction | Exposes internals | Hide implementation details |

## When to Use /analyze-architecture Command

Use the `/analyze-architecture` command when you need:
- Comprehensive architecture documentation
- Dependency graphs and visualizations
- Architecture Decision Records (ADRs)
- System design documents

The skill provides thinking patterns; the command produces documentation artifacts.
