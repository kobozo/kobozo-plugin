# Feature Development Plugin

> **Official Claude Code Plugin** - Developed and maintained by Anthropic

A comprehensive feature development workflow plugin that combines specialized AI agents for codebase exploration, architecture design, and quality review. This plugin guides you through a systematic 9-phase development process from initial concept to committed code.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Commands](#commands)
  - [feature-dev](#feature-dev)
- [Specialized Agents](#specialized-agents)
  - [code-explorer](#code-explorer)
  - [code-architect](#code-architect)
  - [code-reviewer](#code-reviewer)
- [Development Workflow](#development-workflow)
  - [Phase 1: Discovery](#phase-1-discovery)
  - [Phase 2: Codebase Exploration](#phase-2-codebase-exploration)
  - [Phase 3: Clarifying Questions](#phase-3-clarifying-questions)
  - [Phase 4: Architecture Design](#phase-4-architecture-design)
  - [Phase 5: Implementation](#phase-5-implementation)
  - [Phase 6: Quality Review](#phase-6-quality-review)
  - [Phase 7: Test Validation & Approval](#phase-7-test-validation--approval)
  - [Phase 8: Git Commit & Push](#phase-8-git-commit--push)
  - [Phase 9: Summary](#phase-9-summary)
- [Best Practices](#best-practices)
- [Plugin Information](#plugin-information)

## Overview

The Feature Development plugin transforms Claude Code into a senior developer that follows software engineering best practices. Instead of jumping straight to code, it methodically understands your codebase, asks clarifying questions, designs architecture, implements solutions, and ensures quality through automated review.

This plugin is especially valuable for:
- **Complex feature development** requiring deep codebase understanding
- **Refactoring** existing functionality with minimal risk
- **Learning unfamiliar codebases** through systematic exploration
- **Maintaining code quality** with multi-agent review processes
- **Teams** following structured development workflows

## Key Features

- **9-Phase Structured Workflow**: From discovery to git commit with clear gates between phases
- **Parallel Agent Execution**: Launch multiple specialized agents simultaneously for faster insights
- **Clarifying Questions**: Automatically identifies ambiguities and asks specific questions before coding
- **Architecture Comparison**: Presents multiple design approaches with trade-offs
- **Multi-Agent Quality Review**: Three parallel reviewers checking different quality aspects
- **Test-Driven Validation**: Ensures all tests pass before committing
- **User Approval Gates**: Never commits without explicit user confirmation
- **Todo Tracking**: Maintains progress visibility throughout development
- **Git Integration**: Automated staging, committing, and pushing with conventional commit messages

## Installation

This is an official Anthropic plugin included in the Claude Code plugins repository.

### Option 1: Via Claude Code Plugins System

If you're using the official Claude Code plugins system:

```bash
# The plugin is already available in the claude/plugins/feature-dev directory
# Simply enable it in your Claude Code configuration
```

### Option 2: Manual Installation

1. Ensure you have the plugin directory structure:
```
claude/
└── plugins/
    └── feature-dev/
        ├── .claude-plugin/
        │   └── plugin.json
        ├── commands/
        │   └── feature-dev.md
        └── agents/
            ├── code-explorer.md
            ├── code-architect.md
            └── code-reviewer.md
```

2. The plugin will be automatically detected by Claude Code

## Quick Start

Basic usage:

```bash
# Start feature development workflow
/feature-dev Add user authentication with JWT tokens

# Let the plugin guide you through:
# 1. Understanding requirements
# 2. Exploring your codebase
# 3. Asking clarifying questions
# 4. Designing architecture
# 5. Implementing the feature
# 6. Running quality reviews
# 7. Validating tests
# 8. Committing changes
```

The plugin will automatically:
- Launch specialized agents to explore your codebase
- Identify all ambiguities and ask questions
- Present architecture options for your approval
- Implement following your chosen approach
- Review code quality with multiple agents
- Run tests and wait for your approval before committing

## Commands

### feature-dev

**Description**: Guided feature development with codebase understanding and architecture focus

**Usage**:
```bash
/feature-dev <optional feature description>
```

**Arguments**:
- `feature description` (optional): Brief description of the feature to develop

**Examples**:

```bash
# With feature description
/feature-dev Add real-time notifications using WebSockets

# Without description (will prompt you)
/feature-dev
```

**What it does**:
1. Creates a comprehensive todo list tracking all 9 phases
2. Guides you through systematic feature development
3. Launches specialized agents for exploration, architecture, and review
4. Asks clarifying questions before implementation
5. Implements following approved architecture
6. Validates quality and tests
7. Commits and pushes with your approval

**Core Principles**:
- **Ask clarifying questions**: Identifies ambiguities early, asks specific questions
- **Understand before acting**: Reads existing code patterns first
- **Read files identified by agents**: Builds detailed context from agent recommendations
- **Simple and elegant**: Prioritizes readable, maintainable code
- **Use TodoWrite**: Tracks all progress throughout

## Specialized Agents

The plugin includes three specialized agents that run in parallel to provide comprehensive analysis:

### code-explorer

**Purpose**: Deeply analyzes existing codebase features by tracing execution paths and understanding patterns

**Model**: Claude Sonnet
**Color**: Yellow
**Tools**: Glob, Grep, LS, Read, NotebookRead, WebFetch, TodoWrite, WebSearch, KillShell, BashOutput

**What it does**:

**1. Feature Discovery**
- Finds entry points (APIs, UI components, CLI commands)
- Locates core implementation files
- Maps feature boundaries and configuration

**2. Code Flow Tracing**
- Follows call chains from entry to output
- Traces data transformations at each step
- Identifies dependencies and integrations
- Documents state changes and side effects

**3. Architecture Analysis**
- Maps abstraction layers (presentation → business logic → data)
- Identifies design patterns and architectural decisions
- Documents interfaces between components
- Notes cross-cutting concerns (auth, logging, caching)

**4. Implementation Details**
- Key algorithms and data structures
- Error handling and edge cases
- Performance considerations
- Technical debt or improvement areas

**Output includes**:
- Entry points with file:line references
- Step-by-step execution flow
- Key components and responsibilities
- Architecture insights and patterns
- Dependencies (external and internal)
- List of essential files to read

**Example usage in workflow**:
```
Phase 2 launches 2-3 code-explorer agents with prompts like:
- "Find features similar to user authentication and trace through their implementation"
- "Map the architecture for the API layer, tracing through the code comprehensively"
- "Analyze the current session management implementation"
```

### code-architect

**Purpose**: Designs feature architectures by analyzing existing patterns and providing comprehensive implementation blueprints

**Model**: Claude Sonnet
**Color**: Green
**Tools**: Glob, Grep, LS, Read, NotebookRead, WebFetch, TodoWrite, WebSearch, KillShell, BashOutput

**Core Process**:

**1. Codebase Pattern Analysis**
- Extracts existing patterns and conventions
- Identifies technology stack and module boundaries
- Finds CLAUDE.md guidelines
- Analyzes similar features

**2. Architecture Design**
- Makes decisive architectural choices
- Ensures seamless integration
- Designs for testability, performance, maintainability

**3. Complete Implementation Blueprint**
- Specifies every file to create or modify
- Defines component responsibilities
- Maps integration points and data flow
- Breaks implementation into clear phases

**Output includes**:
- **Patterns & Conventions Found**: With file:line references
- **Architecture Decision**: Chosen approach with rationale and trade-offs
- **Component Design**: File paths, responsibilities, dependencies, interfaces
- **Implementation Map**: Specific files and detailed change descriptions
- **Data Flow**: Complete flow from entry to output
- **Build Sequence**: Phased implementation checklist
- **Critical Details**: Error handling, state management, testing, security

**Example usage in workflow**:
```
Phase 4 launches 2-3 code-architect agents with different focuses:
- "Minimal changes approach - maximum reuse of existing code"
- "Clean architecture approach - maintainability and elegant abstractions"
- "Pragmatic balance approach - speed and quality"
```

### code-reviewer

**Purpose**: Reviews code for bugs, quality issues, and adherence to project conventions using confidence-based filtering

**Model**: Claude Sonnet
**Color**: Red
**Tools**: Glob, Grep, LS, Read, NotebookRead, WebFetch, TodoWrite, WebSearch, KillShell, BashOutput

**Review Scope**:
By default reviews unstaged changes from `git diff`, or user-specified files

**Core Responsibilities**:

**1. Project Guidelines Compliance**
- Verifies adherence to CLAUDE.md rules
- Checks import patterns and framework conventions
- Validates error handling and logging practices
- Ensures platform compatibility

**2. Bug Detection**
- Logic errors and null/undefined handling
- Race conditions and memory leaks
- Security vulnerabilities
- Performance problems

**3. Code Quality**
- Code duplication
- Missing critical error handling
- Accessibility problems
- Test coverage gaps

**Confidence Scoring**:
Each issue is rated 0-100:
- **0**: False positive or pre-existing issue
- **25**: Might be real, stylistic without explicit guideline
- **50**: Real issue but minor or infrequent
- **75**: Very likely real, impacts functionality, mentioned in guidelines
- **100**: Definitely real, will happen frequently

**Only reports issues with confidence ≥ 80** - focuses on what truly matters.

**Output includes**:
- Clear description with confidence score
- File path and line number
- Project guideline reference or bug explanation
- Concrete fix suggestion
- Issues grouped by severity (Critical vs Important)

**Example usage in workflow**:
```
Phase 6 launches 3 code-reviewer agents with different focuses:
- "Review for simplicity, DRY principles, and code elegance"
- "Review for bugs and functional correctness"
- "Review for adherence to project conventions and abstractions"
```

## Development Workflow

The plugin guides you through 9 structured phases:

### Phase 1: Discovery

**Goal**: Understand what needs to be built

**Actions**:
1. Creates todo list with all phases
2. If feature unclear, asks user for:
   - What problem are they solving?
   - What should the feature do?
   - Any constraints or requirements?
3. Summarizes understanding and confirms with user

**Example**:
```
📋 Todo List Created:
☐ Phase 1: Discovery
☐ Phase 2: Codebase Exploration
☐ Phase 3: Clarifying Questions
...

Based on your request "Add user authentication", I understand you want to:
- Enable users to log in with email/password
- Protect routes that require authentication
- Store user sessions securely

Is this correct?
```

### Phase 2: Codebase Exploration

**Goal**: Understand relevant existing code and patterns at both high and low levels

**Actions**:
1. Launches 2-3 **code-explorer** agents in parallel, each targeting different aspects:
   - Similar features and their implementation
   - Architecture and abstractions
   - Current implementation of related areas
   - UI patterns, testing approaches, extension points

2. After agents return, reads all files identified by agents to build deep understanding

3. Presents comprehensive summary of findings and patterns

**Example**:
```
🔍 Launching Explorers:

Agent 1: "Find authentication features similar to OAuth and trace implementation"
Agent 2: "Map the session management architecture"
Agent 3: "Analyze the API middleware patterns for protected routes"

📚 Key Files Identified:
- src/auth/session.ts (session management)
- src/middleware/auth.ts (route protection)
- src/api/users.ts (user endpoints)
[reads each file and summarizes patterns found]
```

### Phase 3: Clarifying Questions

**Goal**: Fill in gaps and resolve all ambiguities before designing

**CRITICAL**: This is one of the most important phases. DO NOT SKIP.

**Actions**:
1. Reviews codebase findings and original request
2. Identifies underspecified aspects:
   - Edge cases
   - Error handling
   - Integration points
   - Scope boundaries
   - Design preferences
   - Backward compatibility
   - Performance needs

3. **Presents all questions to user in organized list**
4. **Waits for answers before proceeding**

**Example**:
```
❓ Clarifying Questions:

Authentication Method:
1. Should we support OAuth providers (Google, GitHub) or only email/password?
2. Do you want multi-factor authentication (MFA)?

Session Management:
3. Should sessions expire? If so, after how long?
4. Do you want "remember me" functionality?

Security:
5. Password requirements (minimum length, complexity)?
6. Should we implement rate limiting on login attempts?

User Experience:
7. What should happen when session expires (redirect to login, modal)?
8. Do you need email verification for new accounts?

Please answer each question. If you're unsure, I can provide recommendations.
```

### Phase 4: Architecture Design

**Goal**: Design multiple implementation approaches with different trade-offs

**Actions**:
1. Launches 2-3 **code-architect** agents in parallel with different focuses:
   - **Minimal changes**: Smallest change, maximum reuse
   - **Clean architecture**: Maintainability, elegant abstractions
   - **Pragmatic balance**: Speed + quality

2. Reviews all approaches and forms opinion on which fits best

3. Presents to user:
   - Brief summary of each approach
   - Trade-offs comparison
   - **Your recommendation with reasoning**
   - Concrete implementation differences

4. **Asks user which approach they prefer**

**Example**:
```
🏗️ Architecture Options:

Approach 1: Minimal Changes
- Extend existing SessionService with password auth
- Add auth middleware to existing route handlers
- Reuse current session storage (Redis)
Pros: Fast, low risk, consistent with existing patterns
Cons: May accumulate technical debt, less flexible

Approach 2: Clean Architecture
- New AuthenticationService with separate concerns
- Dedicated auth layer with dependency injection
- Abstract session provider interface
Pros: Highly maintainable, testable, extensible
Cons: More files, longer implementation time

Approach 3: Pragmatic Balance
- New auth module following existing structure
- Middleware pattern matching current codebase
- Leverages existing services where appropriate
Pros: Good balance of speed and quality
Cons: Moderate complexity

💡 My Recommendation: Approach 3 (Pragmatic Balance)
Given this is a medium-sized feature for an existing codebase,
Approach 3 provides the best balance...

Which approach would you prefer?
```

### Phase 5: Implementation

**Goal**: Build the feature

**DO NOT START WITHOUT USER APPROVAL**

**Actions**:
1. Waits for explicit user approval
2. Reads all relevant files identified in previous phases
3. Implements following chosen architecture
4. Follows codebase conventions strictly
5. Writes clean, well-documented code
6. Updates todos as progress is made

**Example**:
```
✅ Implementing Approach 3: Pragmatic Balance

Reading files:
- src/services/session.ts
- src/middleware/index.ts
- src/types/auth.ts

Creating new files:
✓ src/services/auth.ts (authentication logic)
✓ src/middleware/auth.ts (route protection)
✓ src/types/user.ts (user types)

Modifying existing files:
✓ src/api/routes.ts (add auth routes)
✓ src/config/index.ts (add auth config)

Implementation complete.
```

### Phase 6: Quality Review

**Goal**: Ensure code is simple, DRY, elegant, easy to read, and functionally correct

**Actions**:
1. Launches 3 **code-reviewer** agents in parallel with different focuses:
   - Simplicity, DRY principles, code elegance
   - Bugs and functional correctness
   - Project conventions and abstractions

2. Consolidates findings and identifies highest severity issues

3. **Presents findings to user and asks what to do**:
   - Fix now
   - Fix later
   - Proceed as-is

4. Addresses issues based on user decision

**Example**:
```
🔍 Quality Review Results:

Critical Issues (Confidence ≥ 90):
1. Missing error handling in auth.ts:45
   - File: src/services/auth.ts:45
   - Issue: Password hashing can fail but error not caught
   - Fix: Wrap in try-catch and return proper error
   - Confidence: 95%

Important Issues (Confidence 80-89):
2. Potential timing attack in password comparison
   - File: src/services/auth.ts:78
   - Issue: Direct string comparison reveals password length
   - Fix: Use crypto.timingSafeEqual()
   - Confidence: 85%

💡 I recommend fixing both issues before proceeding.

What would you like to do?
1. Fix now
2. Fix later (I'll note in todos)
3. Proceed as-is
```

### Phase 7: Test Validation & Approval

**Goal**: Verify all tests pass and get user approval before committing

**Actions**:

**7.1 Run Full Test Suite**
```bash
npm test
# or appropriate test command for the project
```

**7.2 Present Test Results**
1. Shows test summary:
   - Total tests run
   - Passed / Failed / Skipped
   - Coverage percentage
   - Duration

2. If tests fail:
   - Shows failure details
   - Analyzes root causes
   - **Fixes issues immediately**
   - Re-runs tests
   - **Repeats until all tests pass**

**7.3 Request User Approval**
```
✅ All tests passing (45/45 tests, 87% coverage)

Modified files:
- src/services/auth.ts (authentication service with JWT)
- src/middleware/auth.ts (route protection middleware)
- src/api/routes.ts (added auth endpoints)
- src/types/user.ts (user type definitions)
- src/config/index.ts (auth configuration)

Ready to commit and push.

**Do you approve these changes?**
```

**CRITICAL**: Does NOT proceed to git operations without explicit user approval

### Phase 8: Git Commit & Push

**Goal**: Commit changes and push to repository

**ONLY EXECUTES IF USER APPROVED IN PHASE 7**

**Actions**:

**8.1 Review Git Status**
```bash
git status
```

**8.2 Stage Changes**
```bash
git add [modified files]
```

**8.3 Create Commit**
Follows project's commit message conventions:

```bash
git commit -m "feat: Add JWT-based user authentication

Implement authentication system with email/password login,
session management, and route protection middleware.

- Add AuthenticationService with JWT token generation
- Implement auth middleware for protected routes
- Add login/logout/verify endpoints
- Configure session expiration and refresh tokens

🤖 Generated with Claude Code (https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Commit Message Guidelines**:
- **Type**: feat, fix, refactor, docs, test, chore, perf, style
- **Brief**: One-line summary (<50 chars)
- **Detailed**: What, why, and how (not just what changed)
- **Reference**: Tickets/issues if applicable

**8.4 Push to Remote**
```bash
git push
# or if upstream needed:
git push -u origin [branch-name]
```

**8.5 Confirm Success**
```bash
git log -1
```

Presents confirmation:
```
✅ Changes committed and pushed successfully

Commit: a1b2c3d
Branch: feature/user-authentication
Remote: origin (git@github.com:user/repo.git)

Commit message:
feat: Add JWT-based user authentication
...
```

### Phase 9: Summary

**Goal**: Document what was accomplished

**Actions**:
1. Marks all todos complete
2. Provides comprehensive summary:
   - **What was built**: Feature description and scope
   - **Key decisions made**: Architecture choices and rationale
   - **Files modified**: List with brief descriptions and commit hash
   - **Git information**: Commit hash, branch name, push status
   - **Suggested next steps**:
     - Create pull request (if on feature branch)
     - Deploy to staging/production
     - Update project board/tickets
     - Notify team members

**Example**:
```
📝 Feature Development Summary

✅ What was built:
JWT-based user authentication system with email/password login,
session management, and protected route middleware.

✅ Key decisions made:
- Chose pragmatic balance approach for speed + quality
- Used existing Redis session store for consistency
- Implemented JWT with 1-hour expiration + refresh tokens
- Added rate limiting on login endpoints (5 attempts/min)

✅ Files modified:
- src/services/auth.ts (new - 245 lines)
- src/middleware/auth.ts (new - 78 lines)
- src/api/routes.ts (modified - added 3 endpoints)
- src/types/user.ts (new - 32 lines)
- src/config/index.ts (modified - added auth config)

✅ Git information:
Commit: a1b2c3d4e5f
Branch: feature/user-authentication
Status: Pushed to origin

✅ Suggested next steps:
1. Create pull request: feature/user-authentication → main
2. Request code review from team
3. Deploy to staging environment for testing
4. Update Jira ticket AUTH-123
5. Document API endpoints in wiki
```

## Best Practices

### When to Use This Plugin

**Ideal for**:
- Medium to large features requiring architecture planning
- Refactoring existing code with confidence
- Learning unfamiliar codebases systematically
- Projects with team review processes
- Features with many integration points

**Consider alternatives for**:
- Quick bug fixes (use `/bug-fixer` plugin)
- Simple one-file changes
- Exploratory coding / prototyping
- Emergency hotfixes

### Getting the Most Value

**1. Provide Context Upfront**
```bash
# Instead of:
/feature-dev auth

# Provide details:
/feature-dev Add JWT-based user authentication with email/password login,
session management, and protected routes. Should integrate with existing
Redis session store.
```

**2. Answer Clarifying Questions Thoroughly**
The quality of implementation depends on the quality of your answers in Phase 3. Take time to think through:
- Edge cases and error scenarios
- Integration with existing features
- Performance and scalability needs
- Security requirements

**3. Review Architecture Options Carefully**
Phase 4 presents different approaches with trade-offs. Consider:
- Project timeline and urgency
- Team familiarity with patterns
- Future extensibility needs
- Technical debt tolerance

**4. Trust the Quality Review**
The code-reviewer agents in Phase 6 catch issues you might miss. Even if you want to move fast, review the findings - they're filtered to high-confidence issues only.

**5. Validate Tests Before Approval**
Don't skip Phase 7. Broken tests often reveal integration issues or edge cases that need addressing.

### Customizing the Workflow

You can adapt the workflow by:

**Skip phases** (if you already have that information):
```
I already explored the codebase, here's what I found: ...
Let's skip to Phase 4: Architecture Design
```

**Launch agents independently**:
```
# Use agents outside the workflow
/code-explorer Find all database migration patterns in the codebase

/code-architect Design a caching layer for the API following existing patterns

/code-reviewer Review the auth implementation for security issues
```

**Adjust agent focuses**:
```
# In Phase 2, specify different exploration angles:
Launch 3 explorers focusing on:
1. Security patterns in existing auth code
2. API design patterns for REST endpoints
3. Test patterns for service layer
```

### Working with Teams

**For Individual Contributors**:
- Use Phase 3 questions as a checklist before asking team leads
- Share Phase 4 architecture options in design reviews
- Include Phase 9 summary in pull request descriptions

**For Team Leads**:
- Review agent outputs (explorers, architects, reviewers) with team
- Use architecture comparison to teach decision-making
- Adapt workflow phases to match team process

**For Code Reviews**:
- Share code-reviewer findings with PR reviewers
- Reference architectural decisions from Phase 4 in PR description
- Include test results from Phase 7 in PR

## Plugin Information

- **Name**: feature-dev
- **Version**: 1.0.0
- **Author**: Sid Bidasaria (sbidasaria@anthropic.com)
- **Organization**: Anthropic
- **Type**: Official Claude Code Plugin

**Description**: Comprehensive feature development workflow with specialized agents for codebase exploration, architecture design, and quality review

**Agents Included**:
- **code-explorer** (Yellow, Sonnet) - Codebase analysis and tracing
- **code-architect** (Green, Sonnet) - Architecture design and blueprints
- **code-reviewer** (Red, Sonnet) - Code quality and bug detection

**Key Differentiators**:
- Only official plugin with 9-phase structured workflow
- Parallel agent execution for faster insights
- Mandatory clarifying questions phase
- Architecture comparison with trade-offs
- Confidence-based issue filtering (≥80% only)
- Test validation before commit
- User approval gates at critical phases

---

**Need Help?**

- Report issues with the plugin on the Claude Code repository
- Suggest improvements or new features
- Share your workflow customizations with the community

**See Also**:
- [bug-fixer](../bug-fixer/README.md) - Quick bug fixes without full workflow
- [dead-code-detector](../dead-code-detector/README.md) - Find unused code
- [Claude Code Documentation](https://claude.ai/code)
