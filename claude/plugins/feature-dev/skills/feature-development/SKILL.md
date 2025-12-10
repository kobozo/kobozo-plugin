---
description: This skill should be used when the user asks to "build feature", "implement feature", "develop feature", "add feature", "create feature", "build new functionality", "implement this", or needs help developing new features with proper architecture and OOP principles. Provides systematic feature development methodology.
---

# Feature Development Workflow

**YOU MUST FOLLOW THIS WORKFLOW SEQUENTIALLY. DO NOT SKIP PHASES.**

When this skill is triggered, execute the following phases in order. Each phase has specific actions and stop points.

## Core Principles

- **Object-Oriented Programming First**: Use SOLID principles, design patterns, proper inheritance (max 3 levels), composition over inheritance
- **Ask Before Assuming**: Identify ambiguities early, ask specific questions, wait for answers
- **Use TodoWrite**: Track all progress throughout - this is MANDATORY

---

## Phase 1: Discovery

**Announce**: "📋 **Phase 1: Discovery** - Understanding what needs to be built"

**Actions**:
1. Create todo list with all 8 phases using TodoWrite
2. Mark Phase 1 as in_progress
3. If feature request is unclear, ask user:
   - What problem are they solving?
   - What should the feature do?
   - Any constraints or requirements?
4. Summarize your understanding of the feature

**STOP**: Present summary and wait for user confirmation before proceeding.

---

## Phase 2: Codebase Exploration

**Announce**: "🔍 **Phase 2: Codebase Exploration** - Understanding existing patterns"

**Actions**:
1. Mark Phase 2 as in_progress in TodoWrite
2. Launch 2-3 `feature-dev:code-explorer` agents in parallel. Each agent should:
   - Trace through the code comprehensively
   - Target a different aspect (similar features, architecture, UI patterns, etc.)
   - Return a list of 5-10 key files to read

   **Example agent prompts**:
   - "Find features similar to [feature] and trace through their implementation"
   - "Map the architecture and abstractions for [feature area]"
   - "Identify UI patterns, testing approaches, or extension points for [feature]"

3. **Read all key files** identified by agents to build deep understanding
4. Present comprehensive summary of findings and patterns discovered

---

## Phase 3: Clarifying Questions

**Announce**: "❓ **Phase 3: Clarifying Questions** - Resolving ambiguities"

**CRITICAL - DO NOT SKIP THIS PHASE**

**Actions**:
1. Mark Phase 3 as in_progress in TodoWrite
2. Review codebase findings and original feature request
3. Identify underspecified aspects:
   - Edge cases
   - Error handling
   - Integration points
   - Scope boundaries
   - Design preferences
   - Backward compatibility
   - Performance needs
4. **Present all questions to user in a clear, organized list**

**STOP**: Wait for user answers before proceeding. If user says "whatever you think is best", provide your recommendation and get explicit confirmation.

---

## Phase 4: Code Snippet Research

**Announce**: "📚 **Phase 4: Code Snippet Research** - Researching libraries and best practices"

**Actions**:
1. Mark Phase 4 as in_progress in TodoWrite
2. Based on codebase exploration and user answers, identify key libraries/frameworks to research
3. Launch 1-2 `feature-dev:code-snippet-researcher` agents targeting different libraries:
   - Research specific library APIs needed
   - Find best practices and common patterns
   - Identify OOP patterns in library usage

4. Review research findings and extract actionable patterns
5. Present summary: recommended patterns, critical APIs, integration approaches, gotchas

---

## Phase 5: Architecture Design

**Announce**: "🏗️ **Phase 5: Architecture Design** - Designing implementation approaches"

**Actions**:
1. Mark Phase 5 as in_progress in TodoWrite
2. Launch 2-3 `feature-dev:code-architect` agents in parallel with different focuses:
   - **Minimal changes**: Smallest change, maximum reuse
   - **Clean architecture**: Maintainability, elegant abstractions
   - **Pragmatic balance**: Speed + quality

3. Review all approaches and form your opinion on best fit

4. Present to user:
   - Brief summary of each approach
   - Trade-offs comparison
   - **Your recommendation with reasoning**
   - Concrete implementation differences

**STOP**: Ask user which approach they prefer. Wait for answer before proceeding.

---

## Phase 6: Implementation

**Announce**: "⚙️ **Phase 6: Implementation** - Building the feature"

**DO NOT START WITHOUT USER APPROVAL OF ARCHITECTURE APPROACH**

### Step 1: Analyze Complexity

**Determine implementation strategy:**

1. Count from architecture blueprint:
   - How many files need to be created/modified?
   - How many distinct implementation phases?
   - Are there clear, independent work packages?

2. **Apply heuristic**:
   - **Simple** (≤5 files OR ≤2 phases): Single-agent implementation
   - **Complex** (>5 files AND >2 phases): Multi-agent implementation

### Step 2: Single-Agent Implementation (Simple Features)

**When**: ≤5 files OR ≤2 phases

**Actions**:
1. Mark Phase 6 as in_progress
2. Read all relevant files identified in previous phases
3. Implement following chosen architecture with OOP principles:
   - Follow SOLID principles strictly
   - Apply design patterns appropriately
   - Maintain proper inheritance (max 3 levels)
   - Ensure encapsulation
4. Follow codebase conventions strictly
5. Update todos as you progress

### Step 3: Multi-Agent Implementation (Complex Features)

**When**: >5 files AND >2 phases

**Actions**:

#### 3.1 Create Work Packages

1. **Group by implementation phases**:
   - Phase A: Foundation layer (interfaces, abstract classes)
   - Phase B: Core domain layer (concrete classes, business logic)
   - Phase C: Infrastructure layer (repositories, services)
   - Phase D: Presentation layer (UI components, if applicable)

2. **Detect file dependencies**:
   - Files that import each other → same or sequential packages
   - Independent files → parallel packages
   - Shared types/interfaces → earliest package

3. **Create 2-3 work packages maximum**

4. **Present work split to user**:
```markdown
## Work Package Split

**Complexity Assessment:**
- Total files: [X]
- Implementation phases: [Y]
- Strategy: Multi-agent

**Work Packages:**

### Package A: Foundation Layer
- **Files**: [list files]
- **Dependencies**: None

### Package B: Business Logic Layer
- **Files**: [list files]
- **Dependencies**: Package A

### Package C: UI Integration Layer
- **Files**: [list files]
- **Dependencies**: Package B

Proceed with this work split?
```

**STOP**: Wait for user approval of work package split.

#### 3.2 Launch Implementation Agents

1. Launch `feature-dev:code-implementer` agents for each package in dependency order
2. Monitor agent completion
3. Review completion summaries
4. Verify integration points match expectations

#### 3.3 Integration Validation

After all agents complete:
1. Check for file conflicts
2. Verify integration points
3. Run basic validation (typecheck, build)
4. Report integration status

---

## Phase 7: Quality Review

**Announce**: "🔍 **Phase 7: Quality Review** - Ensuring code quality"

**Actions**:
1. Mark Phase 7 as in_progress in TodoWrite
2. Launch 3 `feature-dev:code-reviewer` agents in parallel with different focuses:
   - **Simplicity/DRY/Elegance**: Check for proper abstraction, composition, encapsulation
   - **Bugs/Functional Correctness**: Verify proper polymorphism, exception handling
   - **OOP Principles**: Validate SOLID adherence, design pattern correctness

3. Consolidate findings from all agents
4. Identify highest severity issues

**STOP**: Present findings to user and ask what they want to do:
- Fix now
- Fix later
- Proceed as-is

5. Address issues based on user decision

---

## Phase 8: Summary

**Announce**: "📝 **Phase 8: Summary** - Documenting what was accomplished"

**Actions**:
1. Mark all todos complete
2. Summarize:
   - What was built
   - Key decisions made
   - Files modified/created
   - OOP patterns applied
   - Suggested next steps

---

## Quick Reference

### SOLID Checklist
- [ ] Single Responsibility: One class, one purpose
- [ ] Open/Closed: Extend via inheritance, don't modify
- [ ] Liskov Substitution: Subtypes substitutable
- [ ] Interface Segregation: Focused interfaces
- [ ] Dependency Inversion: Depend on abstractions

### Stop Points Summary
| After Phase | Stop For |
|-------------|----------|
| Phase 1 | Confirm understanding |
| Phase 3 | Answer clarifying questions |
| Phase 5 | Choose architecture approach |
| Phase 6.1 | Approve work packages (complex only) |
| Phase 7 | Address review findings |
