---
description: Guided feature development with codebase understanding and architecture focus
argument-hint: Optional feature description
---

# Feature Development

You are helping a developer implement a new feature. Follow a systematic approach: understand the codebase deeply, identify and ask about all underspecified details, design elegant architectures, then implement.

## Core Principles

- **Ask clarifying questions**: Identify all ambiguities, edge cases, and underspecified behaviors. Ask specific, concrete questions rather than making assumptions. Wait for user answers before proceeding with implementation. Ask questions early (after understanding the codebase, before designing architecture).
- **Understand before acting**: Read and comprehend existing code patterns first
- **Read files identified by agents**: When launching agents, ask them to return lists of the most important files to read. After agents complete, read those files to build detailed context before proceeding.
- **Simple and elegant**: Prioritize readable, maintainable, architecturally sound code
- **Use TodoWrite**: Track all progress throughout

---

## Phase 1: Discovery

**Goal**: Understand what needs to be built

Initial request: $ARGUMENTS

**Actions**:
1. Create todo list with all phases
2. If feature unclear, ask user for:
   - What problem are they solving?
   - What should the feature do?
   - Any constraints or requirements?
3. Summarize understanding and confirm with user

---

## Phase 2: Codebase Exploration

**Goal**: Understand relevant existing code and patterns at both high and low levels

**Actions**:
1. Launch 2-3 code-explorer agents in parallel. Each agent should:
   - Trace through the code comprehensively and focus on getting a comprehensive understanding of abstractions, architecture and flow of control
   - Target a different aspect of the codebase (eg. similar features, high level understanding, architectural understanding, user experience, etc)
   - Include a list of 5-10 key files to read

   **Example agent prompts**:
   - "Find features similar to [feature] and trace through their implementation comprehensively"
   - "Map the architecture and abstractions for [feature area], tracing through the code comprehensively"
   - "Analyze the current implementation of [existing feature/area], tracing through the code comprehensively"
   - "Identify UI patterns, testing approaches, or extension points relevant to [feature]"

2. Once the agents return, please read all files identified by agents to build deep understanding
3. Present comprehensive summary of findings and patterns discovered

---

## Phase 3: Clarifying Questions

**Goal**: Fill in gaps and resolve all ambiguities before designing

**CRITICAL**: This is one of the most important phases. DO NOT SKIP.

**Actions**:
1. Review the codebase findings and original feature request
2. Identify underspecified aspects: edge cases, error handling, integration points, scope boundaries, design preferences, backward compatibility, performance needs
3. **Present all questions to the user in a clear, organized list**
4. **Wait for answers before proceeding to architecture design**

If the user says "whatever you think is best", provide your recommendation and get explicit confirmation.

---

## Phase 4: Architecture Design

**Goal**: Design multiple implementation approaches with different trade-offs

**Actions**:
1. Launch 2-3 code-architect agents in parallel with different focuses: minimal changes (smallest change, maximum reuse), clean architecture (maintainability, elegant abstractions), or pragmatic balance (speed + quality)
2. Review all approaches and form your opinion on which fits best for this specific task (consider: small fix vs large feature, urgency, complexity, team context)
3. Present to user: brief summary of each approach, trade-offs comparison, **your recommendation with reasoning**, concrete implementation differences
4. **Ask user which approach they prefer**

---

## Phase 5: Implementation

**Goal**: Build the feature

**DO NOT START WITHOUT USER APPROVAL**

**Actions**:
1. Wait for explicit user approval
2. Read all relevant files identified in previous phases
3. Implement following chosen architecture
4. Follow codebase conventions strictly
5. Write clean, well-documented code
6. Update todos as you progress

---

## Phase 6: Pre-Implementation Cleanup (Optional)

**Goal**: Clean up technical debt before adding new code

**When to use**: For features that will interact with older code areas or when codebase cleanup is desired

**Actions**:
1. **Ask user**: "Would you like to clean up dead code in related areas before implementing?"
2. If yes, use `/scan-dead-code --focus=files` for the relevant directories
3. Review findings and safely remove:
   - Orphaned files in feature area
   - Unused imports (auto-fixable)
   - Dead functions never referenced
4. Run tests to verify cleanup
5. Commit cleanup separately from feature work

**Benefits**: Cleaner canvas for new code, reduced confusion, faster builds

---

## Phase 7: Implementation

**Goal**: Build the feature

**DO NOT START WITHOUT USER APPROVAL**

**Actions**:
1. Wait for explicit user approval
2. Read all relevant files identified in previous phases
3. Implement following chosen architecture
4. Follow codebase conventions strictly
5. Write clean, well-documented code
6. Update todos as you progress

---

## Phase 8: Comprehensive Quality Review

**Goal**: Ensure code quality across multiple dimensions

**Actions**:

### 8.1 Code Quality & Correctness
1. Launch 3 code-reviewer agents in parallel:
   - Focus 1: simplicity/DRY/elegance
   - Focus 2: bugs/functional correctness
   - Focus 3: project conventions/abstractions
2. Consolidate findings

### 8.2 Security Review (if applicable)
If the feature involves:
- Authentication/authorization
- Data handling
- API endpoints
- File operations
- External integrations

**Action**: Use `/security-audit --focus=code` to scan implemented files

### 8.3 Performance Analysis (for performance-critical features)
If the feature involves:
- Database queries
- Large data processing
- API calls
- Rendering logic

**Action**: Use `/profile-performance` to identify bottlenecks

### 8.4 UI/UX Validation (for UI features)
If the feature includes UI components:
- Check if style guide exists in `docs/style-guide/`
- If yes: Use `/ui-check [page-name]` to validate compliance
- If no: Consider creating one with `/create-style-guide`

### 8.5 Dead Code Introduced Check
**Action**: Quick scan with `/scan-dead-code --focus=imports` to ensure no unused imports were added

### 8.6 Present Consolidated Findings
1. Organize all findings by severity (critical → minor)
2. Highlight highest-priority issues
3. **Ask user what they want to do**: fix now, fix later, or proceed as-is
4. Address issues based on user decision

---

## Phase 9: Testing & Documentation

**Goal**: Ensure feature is tested and documented

**Actions**:

### 9.1 Test Coverage
1. Check if tests exist for new code
2. If missing: **Ask user** "Would you like me to generate tests?"
3. If yes: Use `/generate-tests` for the implemented modules
4. Run test suite and verify all pass

### 9.2 Documentation
1. Update relevant documentation:
   - README if needed
   - API docs if endpoints added
   - Architecture docs if patterns changed
2. **Ask user**: "Should I generate comprehensive feature documentation?"
3. If yes: Use documentation-writer agent to create feature docs

---

## Phase 10: Test Validation & Approval

**Goal**: Verify all tests pass and get user approval before committing

**Actions**:

### 10.1 Run Full Test Suite
```bash
npm test
# or appropriate test command for the project
```

### 10.2 Present Test Results
1. Show test summary:
   - Total tests run
   - Passed / Failed / Skipped
   - Coverage percentage
   - Duration
2. If tests fail:
   - Show failure details
   - Analyze root causes
   - **Fix issues immediately**
   - Re-run tests
   - **Repeat until all tests pass**

### 10.3 Request User Approval
Once all tests pass, present:
```
✅ All tests passing (X/X tests, Y% coverage)

Modified files:
- path/to/file1.ts (description)
- path/to/file2.tsx (description)
[...list all modified files...]

Ready to commit and push.

**Do you approve these changes?**
```

**CRITICAL**: Do NOT proceed to git operations without explicit user approval

---

## Phase 11: Git Commit & Push

**Goal**: Commit changes and push to repository

**ONLY EXECUTE IF USER APPROVED IN PHASE 10**

**Actions**:

### 11.1 Review Git Status
```bash
git status
```

### 11.2 Stage Changes
```bash
git add [modified files]
```

### 11.3 Create Commit
Follow the project's commit message conventions (check git log for style):

```bash
git commit -m "$(cat <<'EOF'
[Type]: [Brief description]

[Detailed description of what was implemented]

- Key changes made
- Components affected
- Related issue/ticket reference (if applicable)

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

**Commit Message Guidelines**:
- Type: feat, fix, refactor, docs, test, chore, perf, style
- Brief: One-line summary (<50 chars)
- Detailed: What, why, and how (not just what changed)
- Reference tickets/issues if applicable

### 11.4 Push to Remote
```bash
git push
```

If push requires upstream:
```bash
git push -u origin [branch-name]
```

### 11.5 Confirm Success
```bash
git log -1
```

Present confirmation to user:
```
✅ Changes committed and pushed successfully

Commit: [commit hash]
Branch: [branch name]
Remote: [remote URL]

Commit message:
[show commit message]
```

---

## Phase 12: Summary & Next Steps

**Goal**: Document what was accomplished and suggest improvements

**Actions**:
1. Mark all todos complete
2. Comprehensive summary:
   - **What was built**: Feature description and scope
   - **Key decisions made**: Architecture choices and rationale
   - **Files modified**: List with brief descriptions and commit hash
   - **Quality metrics**:
     - Code review findings addressed
     - Test coverage percentage
     - Performance benchmarks (if applicable)
     - Security issues (if applicable)
     - UI compliance score (if applicable)
   - **Git information**:
     - Commit hash
     - Branch name
     - Push status
   - **Technical debt**: Any shortcuts taken or future improvements needed
   - **Suggested next steps**:
     - Create pull request (if on feature branch)
     - Deploy to staging/production
     - Update project board/tickets
     - Notify team members
     - Recommended follow-up tasks
     - Areas for optimization
     - Future enhancements to consider

3. **Optional continuous monitoring setup**:
   - Suggest CI/CD integration for quality checks
   - Recommend periodic scans (security, performance, dead code)

---

## Integration with Kobozo Plugins

This enhanced feature-dev workflow integrates with:

- **dead-code-detector**: Pre-implementation cleanup and post-implementation validation
- **ui-checker**: UI compliance validation for frontend features
- **security-auditor**: Security scanning for sensitive code
- **performance-optimizer**: Performance analysis for critical features
- **test-suite-generator**: Automated test generation
- **documentation-writer**: Comprehensive feature documentation
- **clean-code-checker**: Code quality and SOLID principles validation

These integrations are **optional** and triggered based on:
- Feature type (UI, API, data processing, etc.)
- User preferences (asked during workflow)
- Risk level (security-sensitive, performance-critical, etc.)

The workflow remains fast and lightweight for simple features while providing comprehensive quality checks for complex implementations.

---
