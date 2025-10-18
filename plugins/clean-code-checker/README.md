# Clean Code Checker

A comprehensive Claude Code plugin for detecting code duplication, identifying code smells, enforcing clean code principles (SOLID, DRY), and providing actionable refactoring recommendations.

**Version**: 1.0.0
**Author**: Yannick De Backer (yannick@kobozo.eu)

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Commands](#commands)
  - [analyze-code-quality](#analyze-code-quality)
  - [detect-duplication](#detect-duplication)
- [Agents](#agents)
  - [code-smell-analyzer](#code-smell-analyzer)
  - [duplication-detector](#duplication-detector)
  - [refactoring-advisor](#refactoring-advisor)
- [What Gets Detected](#what-gets-detected)
- [SonarQube Integration](#sonarqube-integration)
- [Refactoring Recommendations](#refactoring-recommendations)
- [Quality Grades](#quality-grades)
- [CI/CD Integration](#cicd-integration)
- [Best Practices](#best-practices)

## Overview

The Clean Code Checker plugin helps maintain high code quality by systematically analyzing your codebase for common issues and providing expert guidance for improvement. It combines multiple analysis techniques including:

- **Code duplication detection** using jscpd (supports 150+ languages)
- **Code smell identification** following Martin Fowler's catalog
- **SOLID principle validation** (Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion)
- **Complexity metrics** (Cyclomatic and Cognitive complexity)
- **SonarQube integration** for enterprise-grade metrics
- **AI-powered refactoring recommendations** with before/after examples

## Key Features

### Comprehensive Analysis
- Detect duplicated code blocks (exact, renamed, near-miss, and semantic clones)
- Identify 30+ code smell types (bloaters, object-orientation abusers, change preventers, dispensables, couplers)
- Validate SOLID principles across your codebase
- Calculate cyclomatic and cognitive complexity
- Measure technical debt in developer-days

### Actionable Insights
- Prioritized issue lists by severity (Blocker, Critical, Major, Minor, Info)
- Step-by-step refactoring guides
- Before/after code examples
- Time estimates for each refactoring
- Sprint planning recommendations

### Integration Ready
- SonarQube MCP server support for historical metrics
- CI/CD pipeline integration examples
- Quality gate configuration
- Pre-commit hook templates

## Installation

### Prerequisites

1. **Claude Code** installed and configured
2. **Node.js** (for jscpd duplication detection)
3. **(Optional)** SonarQube MCP server for enhanced metrics

### Plugin Installation

1. Clone or copy the plugin to your Claude Code plugins directory:
   ```bash
   cp -r plugins/clean-code-checker ~/.claude/plugins/
   ```

2. Install required tools:
   ```bash
   # Install jscpd for duplication detection
   npm install -g jscpd

   # Install PMD CPD (alternative duplication detector)
   # Download from https://pmd.github.io/
   ```

3. **(Optional)** Configure SonarQube MCP server in your Claude Code settings:
   ```json
   {
     "mcpServers": {
       "sonarqube": {
         "package": "sonarqube-mcp-server",
         "config": {
           "serverUrl": "http://localhost:9000",
           "token": "your-sonar-token"
         }
       }
     }
   }
   ```

## Commands

### analyze-code-quality

Perform a comprehensive clean code analysis including duplication detection, code smell identification, SOLID principle validation, and complexity metrics.

**Usage:**
```bash
/analyze-code-quality [--output=report] [--focus=smells|complexity|solid]
```

**Examples:**
```bash
# Full analysis with all checks
/analyze-code-quality

# Focus on code smells only
/analyze-code-quality --focus=smells

# Focus on complexity metrics
/analyze-code-quality --focus=complexity

# Custom output directory
/analyze-code-quality --output=docs/quality
```

**What It Does:**

1. **Phase 1: Code Duplication Analysis**
   - Launches duplication-detector agent
   - Scans for duplicated code blocks using jscpd
   - Calculates duplication percentage
   - Identifies refactoring opportunities
   - Metrics: Duplication %, duplicated lines/blocks, clone types

2. **Phase 2: Code Smell Detection**
   - Launches code-smell-analyzer agent
   - Detects common code smells (long methods, large classes, primitive obsession, switch statements, etc.)
   - Identifies SOLID principle violations
   - Calculates complexity metrics (cyclomatic, cognitive, nesting depth)
   - Queries SonarQube MCP (if available) for additional metrics

3. **Phase 3: Refactoring Recommendations**
   - Launches refactoring-advisor agent
   - Prioritizes issues by severity and impact
   - Generates refactoring roadmap
   - Provides step-by-step refactoring guides with code examples
   - Estimates time savings and risk

**Output:**
- Executive summary with overall grade (A-F)
- Detailed issues by category
- SOLID violations with examples
- Complexity analysis
- Prioritized refactoring roadmap (Sprint 1, 2, 3)
- CI/CD integration examples

### detect-duplication

Scan your codebase for duplicated code blocks and receive actionable refactoring recommendations to eliminate redundancy.

**Usage:**
```bash
/detect-duplication [--threshold=3] [--min-lines=5] [--format=html|json]
```

**Examples:**
```bash
# Default: 3% threshold, 5 min lines
/detect-duplication

# Allow up to 5% duplication
/detect-duplication --threshold=5

# Detect larger blocks only
/detect-duplication --min-lines=10

# Generate HTML report
/detect-duplication --format=html
```

**What It Does:**

1. **Phase 1: Duplication Detection**
   - Launches duplication-detector agent
   - Runs jscpd analysis (supports 150+ languages)
   - Optionally queries SonarQube MCP for historical metrics
   - Identifies 4 types of clones:
     - Type 1: Exact clones
     - Type 2: Renamed clones
     - Type 3: Near-miss clones
     - Type 4: Semantic clones

2. **Phase 2: Refactoring Recommendations**
   - Launches refactoring-advisor agent
   - Analyzes each duplication cluster
   - Suggests appropriate refactoring strategy:
     - Extract Method
     - Extract Class
     - Introduce Parameter Object
     - Template Method Pattern
     - Strategy Pattern

**Output:**
- Duplication percentage and status
- List of duplicated blocks with locations
- Prioritized refactoring candidates
- Before/after code examples
- Time savings estimates
- HTML/JSON reports

## Agents

### code-smell-analyzer

**Role**: Detect code smells, SOLID principle violations, anti-patterns, and provide clean code recommendations.

**Tools**: Bash, Read, Glob, Grep, TodoWrite, Write
**Model**: Sonnet
**Color**: Yellow

**MCP Servers**: SonarQube (optional)

**Capabilities:**
- Detects 30+ code smell types across 5 categories:
  - **Bloaters**: Long methods, large classes, primitive obsession, long parameter lists
  - **Object-Orientation Abusers**: Switch statements, refused bequest, alternative classes
  - **Change Preventers**: Divergent change, shotgun surgery, parallel inheritance
  - **Dispensables**: Comments, dead code, duplicate code, lazy class
  - **Couplers**: Feature envy, inappropriate intimacy, message chains

- Validates SOLID principles:
  - **S**: Single Responsibility Principle
  - **O**: Open/Closed Principle
  - **L**: Liskov Substitution Principle
  - **I**: Interface Segregation Principle
  - **D**: Dependency Inversion Principle

- Calculates complexity metrics:
  - Cyclomatic complexity (decision points)
  - Cognitive complexity (understandability)
  - Nesting depth
  - Lines of code per function/class

**Analysis Tools:**
- ESLint with complexity rules
- SonarQube API (via MCP server)
- Custom AST analysis

### duplication-detector

**Role**: Detect code duplication across codebase using jscpd and PMD CPD, identify copy-paste code blocks, and recommend DRY refactoring.

**Tools**: Bash, Read, Glob, Grep, TodoWrite, Write
**Model**: Sonnet
**Color**: Red

**MCP Servers**: SonarQube (optional)

**Capabilities:**
- Multi-language support (150+ languages via jscpd)
- Four types of clone detection:
  - **Type 1**: Exact clones (identical except whitespace/comments)
  - **Type 2**: Renamed clones (same structure, different identifiers)
  - **Type 3**: Near-miss clones (similar logic with minor variations)
  - **Type 4**: Semantic clones (different syntax, same functionality)

- Duplication metrics:
  - Overall duplication percentage
  - Duplicated lines count
  - Duplicated blocks count
  - Duplication density by file type

**Detection Tools:**
- **jscpd**: JavaScript Copy-Paste Detector (Rabin-Karp algorithm)
- **PMD CPD**: Enterprise-grade duplication detection
- **SonarQube**: Historical duplication trends (via MCP)

**Refactoring Strategies:**
- Extract Method
- Extract Class/Module
- Template Method Pattern
- Generic Repository Pattern
- Strategy Pattern

### refactoring-advisor

**Role**: Provide step-by-step refactoring guidance, suggest design patterns, and generate refactored code following clean code principles.

**Tools**: Bash, Read, Glob, Grep, TodoWrite, Write, Edit
**Model**: Sonnet
**Color**: Blue

**Capabilities:**
- Analyzes code quality issues and prioritizes refactoring tasks
- Suggests appropriate design patterns for each problem
- Provides incremental refactoring steps with safety checks
- Generates before/after code examples
- Estimates time and risk for each refactoring

**Refactoring Strategies:**

1. **Extract Method** - For functions > 20 lines doing multiple things
2. **Replace Conditional with Polymorphism** - For switch statements and type checking
3. **Introduce Parameter Object** - For functions with > 3 parameters
4. **Replace Magic Numbers** - For literal numbers/strings in code
5. **Extract Class** - For classes with > 500 lines or mixed responsibilities

**Design Patterns:**
- Strategy Pattern (replace conditionals)
- Template Method (shared algorithm structure)
- Factory Pattern (object creation)
- Dependency Injection (SOLID compliance)
- Repository Pattern (data access)

**Safety Checklist:**
- Comprehensive test coverage
- Small, incremental changes
- Frequent commits
- Behavior preservation
- Peer code review

## What Gets Detected

### Code Smells

#### 1. Bloaters

**Long Method**
- Functions > 30 lines
- Cyclomatic complexity > 10
- Too many parameters (> 3)

**Large Class (God Class)**
- Classes > 500 lines
- Classes with > 20 methods
- Multiple responsibilities

**Primitive Obsession**
- Using primitives instead of small objects
- Missing value objects (Email, PhoneNumber, Address)

**Long Parameter List**
- Functions with > 3 parameters
- Missing parameter objects

#### 2. Object-Orientation Abusers

**Switch Statements**
- Type checking with if/else chains
- Switch statements that violate Open/Closed Principle

**Refused Bequest**
- Subclass doesn't use parent's functionality
- Violates Liskov Substitution Principle

**Alternative Classes with Different Interfaces**
- Similar classes with incompatible interfaces
- Missing common abstraction

#### 3. Change Preventers

**Divergent Change**
- One class changes for multiple reasons
- Violates Single Responsibility Principle

**Shotgun Surgery**
- Single change requires modifications in many classes
- Missing abstraction or centralization

**Parallel Inheritance Hierarchies**
- Adding subclass requires adding another subclass elsewhere

#### 4. Dispensables

**Comments Explaining Bad Code**
- Comments compensating for unclear code
- Self-documenting code preferred

**Dead Code**
- Unused variables, parameters, methods, classes
- Commented-out code

**Duplicate Code**
- Exact or near-exact code repetition
- Violates DRY principle

**Lazy Class**
- Class doing too little to justify existence

#### 5. Couplers

**Feature Envy**
- Method uses another class's data more than its own
- Should move method to where data is

**Inappropriate Intimacy**
- Classes too tightly coupled
- Accessing each other's private parts

**Message Chains**
- Long chains of method calls (a.b().c().d())
- High coupling

### SOLID Violations

**Single Responsibility Principle (SRP)**
- Class has multiple reasons to change
- Mixed concerns (database + business logic + UI)

**Open/Closed Principle (OCP)**
- Must modify class to extend functionality
- Missing polymorphism or strategy pattern

**Liskov Substitution Principle (LSP)**
- Subclass changes parent behavior unexpectedly
- Cannot substitute child for parent

**Interface Segregation Principle (ISP)**
- Fat interfaces forcing unnecessary implementations
- Clients depend on methods they don't use

**Dependency Inversion Principle (DIP)**
- High-level modules depend on low-level modules
- Missing abstractions and dependency injection

### Complexity Metrics

**Cyclomatic Complexity**
- 1-10: Simple, low risk
- 11-20: Moderate complexity
- 21-50: High complexity, hard to test
- 50+: Untestable, refactor immediately

**Cognitive Complexity**
- Measures "how hard is this to understand?"
- Penalizes nested conditions and breaks
- Higher scores = harder to comprehend

**Nesting Depth**
- Maximum depth of nested blocks
- > 3 levels considered complex

## SonarQube Integration

The plugin integrates with SonarQube via the MCP (Model Context Protocol) server to access enterprise-grade code quality metrics.

### Setup

1. Install SonarQube MCP server:
   ```bash
   npm install -g sonarqube-mcp-server
   ```

2. Configure in Claude Code:
   ```json
   {
     "mcpServers": {
       "sonarqube": {
         "package": "sonarqube-mcp-server",
         "config": {
           "serverUrl": "http://localhost:9000",
           "token": "your-sonar-token",
           "projectKey": "my-project"
         }
       }
     }
   }
   ```

### Available Metrics

**Code Quality:**
- `code_smells` - Number of code smell issues
- `bugs` - Number of bug issues
- `vulnerabilities` - Security vulnerabilities
- `security_hotspots` - Security review points

**Complexity:**
- `complexity` - Cyclomatic complexity
- `cognitive_complexity` - Cognitive complexity
- `functions` - Number of functions
- `classes` - Number of classes

**Duplication:**
- `duplicated_lines` - Number of duplicated lines
- `duplicated_blocks` - Number of duplicated blocks
- `duplicated_files` - Number of files with duplication
- `duplicated_lines_density` - Duplication percentage

**Technical Debt:**
- `sqale_index` - Technical debt in minutes
- `sqale_rating` - Maintainability rating (A-E)
- `sqale_debt_ratio` - Technical debt ratio

**Quality Gates:**
- Quality gate status (PASSED/FAILED)
- Historical trends
- Baseline comparison

## Refactoring Recommendations

### Extract Method Pattern

**When**: Function > 20 lines, doing multiple things

**Before:**
```typescript
function processOrder(order: Order) {
  // Validation (10 lines)
  // Calculation (15 lines)
  // Discounts (10 lines)
  // Payment (15 lines)
  // Notifications (10 lines)
}
```

**After:**
```typescript
function processOrder(order: Order) {
  validateOrder(order);
  const totals = calculateOrderTotals(order);
  const finalPrice = applyDiscounts(totals, order);
  processPayment(order, finalPrice);
  sendNotifications(order);
}
```

### Strategy Pattern

**When**: Switch statements, type checking

**Before:**
```typescript
class PaymentService {
  process(amount: number, method: string) {
    switch (method) {
      case 'credit_card': return this.processCreditCard(amount);
      case 'paypal': return this.processPayPal(amount);
      case 'bitcoin': return this.processBitcoin(amount);
    }
  }
}
```

**After:**
```typescript
interface PaymentStrategy {
  process(amount: number): PaymentResult;
}

class CreditCardStrategy implements PaymentStrategy { }
class PayPalStrategy implements PaymentStrategy { }
class BitcoinStrategy implements PaymentStrategy { }

class PaymentService {
  constructor(private strategy: PaymentStrategy) {}

  process(amount: number): PaymentResult {
    return this.strategy.process(amount);
  }
}
```

### Extract Class (Single Responsibility)

**When**: Class > 500 lines or multiple responsibilities

**Before:**
```typescript
class UserManager {
  // CRUD operations
  createUser() { }
  updateUser() { }

  // Validation
  validateEmail() { }
  validatePassword() { }

  // Authentication
  hashPassword() { }
  verifyPassword() { }

  // Notifications
  sendWelcomeEmail() { }

  // Analytics
  calculateUserScore() { }
}
```

**After:**
```typescript
class UserRepository {
  create() { }
  update() { }
}

class UserValidator {
  validateEmail() { }
  validatePassword() { }
}

class PasswordService {
  hash() { }
  verify() { }
}

class UserNotificationService {
  sendWelcomeEmail() { }
}

class UserAnalyticsService {
  calculateScore() { }
}

class UserService {
  constructor(
    private repository: UserRepository,
    private validator: UserValidator,
    private passwordService: PasswordService,
    private notificationService: UserNotificationService,
    private analyticsService: UserAnalyticsService
  ) {}
}
```

### Introduce Parameter Object

**When**: Function with > 3 parameters

**Before:**
```typescript
function createUser(
  firstName: string,
  lastName: string,
  email: string,
  phone: string,
  street: string,
  city: string,
  state: string,
  zipCode: string
) { }
```

**After:**
```typescript
interface UserDetails {
  personalInfo: { firstName: string; lastName: string };
  contact: { email: string; phone: string };
  address: { street: string; city: string; state: string; zipCode: string };
}

function createUser(details: UserDetails) { }
```

## Quality Grades

The plugin assigns overall quality grades based on multiple metrics:

| Grade | Description | Criteria |
|-------|-------------|----------|
| **A** | Excellent | Duplication < 3%, Complexity < 10, No critical smells |
| **B** | Good | Duplication 3-5%, Complexity 10-15, 1-2 critical smells |
| **C** | Acceptable | Duplication 5-8%, Complexity 15-20, 3-5 critical smells |
| **D** | Poor | Duplication 8-12%, Complexity 20-30, 6-10 critical smells |
| **F** | Critical | Duplication > 12%, Complexity > 30, 10+ critical smells |

### Issue Severity Levels

| Severity | Icon | Description | Examples |
|----------|------|-------------|----------|
| **Blocker** | 🔴 | Prevents progress | God classes > 1000 lines, Complexity > 50 |
| **Critical** | 🟠 | High maintenance cost | Duplication > 10%, Complexity 30-50 |
| **Major** | 🟡 | Moderate issues | Long methods > 50 lines, Switch statements |
| **Minor** | 🟢 | Low impact | Minor duplication < 5%, Magic numbers |
| **Info** | ⚪ | Suggestions | Formatting, naming conventions |

### Duplication Thresholds

| Percentage | Status | Action Required |
|------------|--------|-----------------|
| **0-3%** | ✅ Excellent | Maintain current quality |
| **3-5%** | 🟡 Acceptable | Monitor, plan refactoring |
| **5-10%** | 🟠 Needs Attention | Refactor in next sprint |
| **>10%** | 🔴 Critical | Immediate action required |

## CI/CD Integration

### GitHub Actions

```yaml
name: Code Quality Check

on: [pull_request]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Install jscpd
        run: npm install -g jscpd

      - name: Duplication Check
        run: npx jscpd src/ --threshold 3

      - name: ESLint
        run: npm run lint

      - name: SonarQube Scan
        uses: sonarsource/sonarqube-scan-action@master
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
          SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
```

### GitLab CI

```yaml
code_quality:
  stage: test
  script:
    - npm install -g jscpd
    - npx jscpd src/ --threshold 3 --format json --output ./reports
    - sonar-scanner
  artifacts:
    reports:
      codequality: reports/jscpd-report.json
  allow_failure: false
```

### Pre-commit Hook

```bash
#!/bin/bash
# .husky/pre-commit

echo "Running code quality checks..."

# Duplication check
npx jscpd src/ --threshold 5 || {
  echo "⚠️ Code duplication exceeds 5% threshold"
  echo "Run /detect-duplication for detailed report"
  exit 1
}

# ESLint
npm run lint || {
  echo "❌ ESLint errors found"
  exit 1
}

echo "✅ Code quality checks passed"
```

### Quality Gates

```properties
# sonar-project.properties
sonar.projectKey=my-project
sonar.sources=src
sonar.tests=tests

# Quality gate thresholds
sonar.qualitygate.wait=true
sonar.coverage.minimum=80%
sonar.duplicated_lines_density.maximum=3%
sonar.complexity.maximum=10
sonar.code_smells.maximum=50
```

## Best Practices

### Code Review Checklist

- [ ] No code duplication introduced (< 3%)
- [ ] Function complexity < 10
- [ ] Class size < 300 lines
- [ ] SOLID principles followed
- [ ] No new code smells introduced
- [ ] Tests added for new code
- [ ] Documentation updated

### Definition of Done

- [ ] All quality checks pass
- [ ] Code review approved by peer
- [ ] No blocker or critical issues
- [ ] Duplication within acceptable threshold
- [ ] Tests pass with > 80% coverage
- [ ] SonarQube quality gate passed

### Refactoring Culture

**Allocate Technical Debt Time**
- Reserve 20% of sprint time for refactoring
- Track technical debt as backlog items
- Measure debt reduction over time

**Rule of Three**
- First occurrence: Write it
- Second occurrence: Note it (add TODO)
- Third occurrence: Refactor it

**Incremental Improvement**
- Make small, safe refactorings daily
- Don't wait for "big refactoring sprint"
- Boy Scout Rule: Leave code cleaner than you found it

**Knowledge Sharing**
- Review duplication reports in team meetings
- Share refactoring patterns in tech talks
- Celebrate quality improvement wins
- Pair program on complex refactorings

### Refactoring Safety

**Before Refactoring:**
1. Ensure comprehensive test coverage
2. Run all tests (they should pass)
3. Commit current working state
4. Create refactoring branch

**During Refactoring:**
1. Make small, incremental changes
2. Run tests after each change
3. Commit frequently with descriptive messages
4. Don't change behavior (unless fixing bugs)

**After Refactoring:**
1. Verify all tests still pass
2. Peer code review
3. Performance testing (if critical path)
4. Update documentation

### Continuous Monitoring

**Weekly Actions:**
- Run `/analyze-code-quality` for full analysis
- Review duplication trends
- Track quality grade improvements
- Address new critical/blocker issues

**Monthly Actions:**
- Sprint retrospective on code quality
- Update team coding standards
- Review refactoring ROI
- Adjust quality gates if needed

**Quarterly Actions:**
- Comprehensive technical debt assessment
- Major refactoring initiatives
- Team training on clean code practices
- Tool and process improvements

## Example Reports

### Console Summary

```
Code Quality Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Overall Grade: B (Good) 🟢

Quality Metrics
├─ Duplication:     4.2% 🟡 (Target: < 3%)
├─ Avg Complexity:  8.2 ✅ (Target: < 10)
├─ Code Smells:     45 🟡 (Target: < 30)
├─ Technical Debt:  12.5 days 🟡
└─ Maintainability: B (Good)

Highlights
✅ Low cyclomatic complexity
✅ Good test coverage (87%)
⚠️ Duplication slightly above target
⚠️ Several large classes need refactoring

🔴 Critical Issues (3)
1. Auth logic duplication: 4 locations × 45 lines
2. God class: UserManager (847 lines, 34 methods)
3. High complexity: processOrder() (complexity: 18)

📈 Refactoring Roadmap
Sprint 1: Address critical issues → Grade improvement B → A
Sprint 2: Fix major code smells → 50% debt reduction
Sprint 3: Polish and continuous improvement

📄 Detailed report saved to: ./code-quality-report.md
```

### Duplication Report

```
Code Duplication Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Summary
Total Files:        247
Total Lines:        12,450
Duplicated Lines:   523 (4.2%)
Duplicated Blocks:  28
Status:             🟡 Needs Attention

🔴 Critical Duplications (3)
1. Authentication logic
   Locations: 4 files × 45 lines = 180 duplicated
   Impact: Security risk, maintenance burden
   Time to fix: 3-4 hours

2. Data transformation
   Locations: 3 files × 28 lines = 84 duplicated
   Impact: Business logic inconsistency
   Time to fix: 2-3 hours

💡 Recommendations
1. Extract auth logic → shared/auth-validator.ts
2. Create validation utility class
3. Apply template method pattern

📄 HTML report: ./duplication-report.html
```

## Troubleshooting

### jscpd Not Found

```bash
# Install globally
npm install -g jscpd

# Or use npx
npx jscpd src/
```

### SonarQube Connection Failed

Check MCP server configuration:
```json
{
  "mcpServers": {
    "sonarqube": {
      "package": "sonarqube-mcp-server",
      "config": {
        "serverUrl": "http://localhost:9000",
        "token": "your-valid-token"
      }
    }
  }
}
```

Verify SonarQube is running:
```bash
curl http://localhost:9000/api/system/status
```

### No Issues Detected

Possible reasons:
1. Codebase is already high quality (excellent!)
2. Analysis scope too narrow (check ignored paths)
3. Thresholds too lenient (lower thresholds for stricter checks)

Adjust configuration:
```bash
# Lower duplication threshold
/detect-duplication --threshold=2

# Analyze with stricter settings
/analyze-code-quality --focus=smells
```

## Contributing

Found a bug or have a feature request? Please open an issue or submit a pull request.

## License

See project license for details.

## See Also

- [Martin Fowler's Refactoring Catalog](https://refactoring.com/catalog/)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Clean Code by Robert C. Martin](https://www.oreilly.com/library/view/clean-code-a/9780136083238/)
- [jscpd Documentation](https://github.com/kucherenko/jscpd)
- [SonarQube Documentation](https://docs.sonarqube.org/)
