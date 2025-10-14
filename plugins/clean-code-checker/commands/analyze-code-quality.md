---
description: Comprehensive code quality analysis detecting code smells, SOLID violations, complexity issues, and providing refactoring roadmap
---

# Analyze Code Quality

Perform a comprehensive clean code analysis including duplication detection, code smell identification, SOLID principle validation, and complexity metrics.

## Usage

```
/analyze-code-quality [--output=report] [--focus=smells|complexity|solid]
```

**Examples:**
```
/analyze-code-quality                        # Full analysis
/analyze-code-quality --focus=smells         # Focus on code smells only
/analyze-code-quality --focus=complexity     # Focus on complexity metrics
/analyze-code-quality --output=docs/quality  # Custom output directory
```

## Execution Flow

### Phase 1: Code Duplication Analysis
1. Launch **duplication-detector** agent
2. Scan for duplicated code blocks (jscpd)
3. Calculate duplication percentage
4. Identify refactoring opportunities

**Metrics Collected:**
- Duplication percentage
- Duplicated lines count
- Duplicated blocks count
- Clone types (exact, renamed, near-miss, semantic)

### Phase 2: Code Smell Detection
1. Launch **code-smell-analyzer** agent
2. Detect common code smells:
   - Long methods/classes
   - Primitive obsession
   - Switch statements
   - Feature envy
   - Data clumps
   - Dead code
3. Identify SOLID principle violations:
   - Single Responsibility (SRP)
   - Open/Closed (OCP)
   - Liskov Substitution (LSP)
   - Interface Segregation (ISP)
   - Dependency Inversion (DIP)
4. Calculate complexity metrics:
   - Cyclomatic complexity
   - Cognitive complexity
   - Nesting depth
5. Query SonarQube MCP (if available) for additional metrics

**Metrics Collected:**
- Code smells count by type
- SOLID violations count
- Average/max cyclomatic complexity
- Technical debt ratio
- Maintainability rating

### Phase 3: Refactoring Recommendations
1. Launch **refactoring-advisor** agent
2. Prioritize issues by severity and impact
3. Generate refactoring roadmap
4. Provide step-by-step refactoring guides
5. Estimate time savings and risk

**Outputs:**
- Prioritized issue list
- Refactoring patterns for each issue
- Before/after code examples
- Sprint planning recommendations

## Analysis Thresholds

### Code Quality Grades

| Grade | Description | Criteria |
|-------|-------------|----------|
| A | Excellent | Duplication < 3%, Complexity < 10, No critical smells |
| B | Good | Duplication 3-5%, Complexity 10-15, 1-2 critical smells |
| C | Acceptable | Duplication 5-8%, Complexity 15-20, 3-5 critical smells |
| D | Poor | Duplication 8-12%, Complexity 20-30, 6-10 critical smells |
| F | Critical | Duplication > 12%, Complexity > 30, 10+ critical smells |

### Issue Severity

| Severity | Description | Examples |
|----------|-------------|----------|
| 🔴 Blocker | Prevents progress | God classes > 1000 lines, Complexity > 50 |
| 🟠 Critical | High maintenance cost | Duplication > 10%, Complexity 30-50 |
| 🟡 Major | Moderate issues | Long methods > 50 lines, Switch statements |
| 🟢 Minor | Low impact | Minor duplication < 5%, Magic numbers |
| ⚪ Info | Best practice suggestions | Formatting, naming conventions |

## Comprehensive Report

### Executive Summary
```markdown
# Code Quality Report

**Project**: MyApp
**Date**: 2025-10-14
**Files Analyzed**: 247 files (12,450 lines)

## Overall Grade: B (Good) 🟢

### Quality Metrics
- **Duplication**: 4.2% 🟡 (Target: < 3%)
- **Avg Complexity**: 8.2 ✅ (Target: < 10)
- **Code Smells**: 45 🟡 (Target: < 30)
- **Technical Debt**: 12.5 days 🟡
- **Maintainability**: B (Good)

### Highlights
✅ Low cyclomatic complexity
✅ Good test coverage (87%)
⚠️ Duplication slightly above target
⚠️ Several large classes need refactoring
```

### Detailed Issues by Category

#### 1. Code Duplication (4.2%)
```markdown
## Critical Duplications (3 issues)

### Auth Logic Duplication
**Locations**: 4 files
**Lines**: 45 × 4 = 180 duplicated lines
**Files**:
- src/services/auth.ts:120-165
- src/services/user-auth.ts:89-134
- src/services/admin-auth.ts:201-246
- src/middleware/auth.ts:45-90

**Impact**: Security risk, maintenance burden
**Priority**: 🔴 Critical
**Estimated Fix Time**: 3-4 hours

**Refactoring Strategy**: Extract Method + Shared Module
```typescript
// Extract to shared/auth-validator.ts
export class AuthValidator {
  validateToken(token: string, options: AuthOptions): ValidationResult {
    // Centralized authentication logic
  }
}
```
```

#### 2. Code Smells (45 issues)

```markdown
## Bloaters (12 issues)

### God Class: UserManager
**Location**: src/services/user-manager.ts
**Metrics**:
- Lines: 847
- Methods: 34
- Responsibilities: 6 (CRUD, validation, auth, notifications, analytics, export)

**SOLID Violation**: Single Responsibility Principle

**Refactoring**: Extract Class
- UserRepository (CRUD)
- UserValidator (validation)
- AuthService (authentication)
- NotificationService (emails)
- AnalyticsService (reporting)
- ExportService (data export)

**Impact**: High - affects 23 dependent files
**Priority**: 🟠 Critical
**Estimated Fix Time**: 8-12 hours

### Long Method: processOrder()
**Location**: src/services/order.ts:145
**Lines**: 87 lines
**Cyclomatic Complexity**: 18
**Cognitive Complexity**: 24

**Refactoring**: Extract Method
```typescript
// Before: 87-line function
function processOrder(order) {
  // validation (15 lines)
  // calculation (20 lines)
  // discounts (18 lines)
  // payment (15 lines)
  // notifications (12 lines)
  // logging (7 lines)
}

// After: Decomposed
function processOrder(order) {
  validateOrder(order);
  const totals = calculateOrderTotals(order);
  const finalPrice = applyDiscounts(totals, order);
  processPayment(order, finalPrice);
  sendNotifications(order);
  logOrderProcessing(order);
}
```

**Priority**: 🟡 Major
**Estimated Fix Time**: 2-3 hours
```

#### 3. SOLID Violations (15 issues)

```markdown
## Single Responsibility Principle (6 violations)

### UserService Multiple Responsibilities
**Location**: src/services/user.service.ts
**Responsibilities Identified**:
1. Database operations (save, update, delete)
2. Business logic (validate, calculate scores)
3. External API calls (send emails)
4. Data transformation (format for API)

**Fix**: Extract to separate services

## Open/Closed Principle (4 violations)

### Payment Method Switch Statement
**Location**: src/services/payment.service.ts:78
**Issue**: Must modify class to add new payment methods

**Fix**: Strategy Pattern
```typescript
interface PaymentStrategy {
  process(amount: number): PaymentResult;
}

// Add new payment methods without modifying existing code
class CryptoPayment implements PaymentStrategy { }
```

## Liskov Substitution Principle (3 violations)

### Square extends Rectangle
**Location**: src/models/shapes.ts
**Issue**: Square modifies Rectangle behavior unexpectedly

**Fix**: Use composition over inheritance

## Dependency Inversion Principle (2 violations)

### UserService depends on MySQLDatabase directly
**Fix**: Inject Database interface instead
```

#### 4. Complexity Analysis

```markdown
## High Complexity Functions

| Function | Location | Cyclomatic | Cognitive | Priority |
|----------|----------|------------|-----------|----------|
| processOrder() | order.ts:145 | 18 | 24 | 🟠 Critical |
| validateUser() | user.ts:89 | 15 | 19 | 🟡 Major |
| calculateDiscount() | discount.ts:234 | 14 | 17 | 🟡 Major |
| generateReport() | report.ts:567 | 13 | 16 | 🟡 Major |

## Complexity Distribution

```
Complexity Range | Functions | Percentage
───────────────────────────────────────
1-5   (Simple)  | 178       | 72%
6-10  (Moderate)| 52        | 21%
11-15 (Complex) | 12        | 5%
16-20 (High)    | 4         | 1.5%
20+   (Critical)| 1         | 0.5%
```

## Refactoring Roadmap

### Sprint 1: Critical Issues (2 weeks)
**Goal**: Address blocker and critical severity issues

**Tasks**:
1. ✅ Refactor UserManager god class (8-12h)
   - Extract 5 service classes
   - Update 23 dependent files
   - Add dependency injection

2. ✅ Eliminate auth logic duplication (3-4h)
   - Create shared AuthValidator
   - Update 4 files
   - Add comprehensive tests

3. ✅ Reduce processOrder() complexity (2-3h)
   - Extract 6 methods
   - Reduce complexity from 18 to 6

**Expected Outcomes**:
- Duplication: 4.2% → 2.1% (50% reduction)
- Complexity: 8.2 → 6.5 average
- Grade improvement: B → A

### Sprint 2: Major Refactoring (2 weeks)
**Goal**: Address major code smells and SOLID violations

**Tasks**:
1. Extract 3 switch statements to polymorphism (4-6h)
2. Fix remaining SRP violations (6-8h)
3. Implement dependency injection (4-6h)
4. Add interfaces to satisfy ISP (2-3h)

### Sprint 3: Minor Improvements (1 week)
**Goal**: Polish and continuous improvement

**Tasks**:
1. Replace magic numbers with constants (2-3h)
2. Remove dead code (1-2h)
3. Improve naming (1-2h)
4. Update documentation (2-3h)

### Continuous Improvements
- Weekly code quality reviews
- Pre-commit hooks for duplication check
- CI/CD quality gates
- Monthly refactoring sprints

## CI/CD Integration

### Quality Gates
```yaml
# sonar-project.properties
sonar.qualitygate.wait=true
sonar.coverage.minimum=80%
sonar.duplicated_lines_density.maximum=3%
sonar.complexity.maximum=10

# Fail build if quality gate fails
```

### GitHub Actions
```yaml
name: Code Quality

on: [pull_request]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Duplication Check
        run: npx jscpd src/ --threshold 3

      - name: ESLint
        run: npm run lint

      - name: SonarQube Scan
        uses: sonarsource/sonarqube-scan-action@master
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

## Team Recommendations

### Code Review Checklist
- [ ] No code duplication introduced
- [ ] Function complexity < 10
- [ ] Class size < 300 lines
- [ ] SOLID principles followed
- [ ] Tests added for new code

### Definition of Done
- [ ] All quality checks pass
- [ ] Code review approved
- [ ] No new code smells introduced
- [ ] Documentation updated
- [ ] Tests pass with > 80% coverage

### Refactoring Culture
- Allocate 20% of sprint time for technical debt
- Celebrate duplication reduction wins
- Share refactoring patterns in team meetings
- Pair program on complex refactorings

This command provides a complete view of code quality, helping teams maintain clean, maintainable codebases through systematic analysis and prioritized refactoring.
