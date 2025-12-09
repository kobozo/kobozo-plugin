---
description: This skill should be used when the user asks to "build feature", "implement feature", "develop feature", "add feature", "create feature", "build new functionality", "implement this", or needs help developing new features with proper architecture and OOP principles. Provides guidance on systematic feature development methodology.
---

# Feature Development Skill

Systematically develop features using a comprehensive workflow that ensures proper codebase understanding, clear architecture, and high-quality implementation.

## When to Use

- Building new features from scratch
- Implementing significant functionality
- Adding new capabilities to existing systems
- Developing features requiring multiple files/components
- Projects needing architectural planning

## Core Principles

### Object-Oriented Programming First
- **SOLID principles**: Single responsibility, Open/closed, Liskov substitution, Interface segregation, Dependency inversion
- **Design patterns**: Factory, Strategy, Observer, Decorator where appropriate
- **Composition over inheritance**: Prefer flexible composition
- **Maximum 3 levels** of inheritance depth

### Ask Before Assuming
- Identify ambiguities and edge cases early
- Ask specific, concrete questions
- Wait for answers before implementation
- Get explicit confirmation on recommendations

## Development Phases

### Phase 1: Discovery
Understand what needs to be built.

**Actions:**
- Clarify the problem being solved
- Define what the feature should do
- Identify constraints and requirements
- Summarize understanding for confirmation

### Phase 2: Codebase Exploration
Understand existing code and patterns.

**Actions:**
- Trace through similar features
- Map architecture and abstractions
- Identify UI patterns, testing approaches
- Build list of key files to understand

### Phase 3: Clarifying Questions
Fill gaps before designing.

**Critical phase - don't skip:**
- Edge cases and error handling
- Integration points and scope boundaries
- Design preferences
- Backward compatibility
- Performance requirements

### Phase 4: Code Snippet Research
Research libraries and best practices.

**Actions:**
- Research specific library APIs
- Find best practices and common patterns
- Identify OOP patterns in library usage
- Extract actionable patterns

### Phase 5: Architecture Design
Design multiple approaches with trade-offs.

**Approach Types:**
1. **Minimal changes**: Smallest change, maximum reuse
2. **Clean architecture**: Maintainability, elegant abstractions
3. **Pragmatic balance**: Speed + quality

**Actions:**
- Design 2-3 approaches
- Compare trade-offs
- Validate OOP principles
- Present recommendation

### Phase 6: Implementation
Build the feature using OOP principles.

**Complexity Heuristic:**
- **Simple** (≤5 files OR ≤2 phases): Single-agent
- **Complex** (>5 files AND >2 phases): Multi-agent

**For complex features:**
- Group by implementation phases (Foundation → Core → Infrastructure → Presentation)
- Detect file dependencies
- Create 2-3 work packages
- Launch agents in dependency order

### Phase 7: Quality Review
Ensure code is simple, DRY, and correct.

**Review focuses:**
- Simplicity/DRY/Elegance
- Bugs/Functional correctness
- OOP principles adherence
- Design pattern correctness

### Phase 8: Summary
Document what was accomplished.

## Work Package Template

For complex features, structure work like this:

```markdown
## Package A: Foundation Layer
- Files to create: interfaces, abstract classes
- Dependencies: None

## Package B: Business Logic Layer
- Files to create: concrete classes, services
- Dependencies: Package A

## Package C: UI Integration Layer
- Files to create: components, controllers
- Dependencies: Package B
```

## Decision Framework

| Situation | Approach |
|-----------|----------|
| Small fix | Minimal changes |
| New feature | Clean architecture |
| Urgent need | Pragmatic balance |
| Complex system | Multi-agent implementation |

## Invoke Full Workflow

For comprehensive feature development with full agent orchestration:

**Use the Task tool** to launch feature development agents:

1. **Codebase Exploration**: Launch `feature-dev:code-explorer` agents to trace through code
2. **Research**: Launch `feature-dev:code-snippet-researcher` for library patterns
3. **Architecture**: Launch `feature-dev:code-architect` for design approaches
4. **Implementation**: Launch `feature-dev:code-implementer` for coding
5. **Review**: Launch `feature-dev:code-reviewer` for quality review

**Example prompt for agent:**
```
Build a feature to add user notifications with email and in-app delivery.
Users should be able to configure notification preferences.
```

## Quick Reference

### SOLID Checklist
- [ ] Single Responsibility: One class, one purpose
- [ ] Open/Closed: Extend via inheritance, don't modify
- [ ] Liskov Substitution: Subtypes substitutable
- [ ] Interface Segregation: Focused interfaces
- [ ] Dependency Inversion: Depend on abstractions

### Phase Checklist
- [ ] Discovery: Problem understood
- [ ] Exploration: Codebase patterns known
- [ ] Questions: Ambiguities resolved
- [ ] Research: Library patterns found
- [ ] Architecture: Approach chosen
- [ ] Implementation: Code written
- [ ] Review: Quality verified
- [ ] Summary: Documented
