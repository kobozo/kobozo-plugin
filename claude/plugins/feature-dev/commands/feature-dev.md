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

## Phase 6: Quality Review

**Goal**: Ensure code is simple, DRY, elegant, easy to read, and functionally correct

**Actions**:
1. Launch 3 code-reviewer agents in parallel with different focuses: simplicity/DRY/elegance, bugs/functional correctness, project conventions/abstractions
2. Consolidate findings and identify highest severity issues that you recommend fixing
3. **Present findings to user and ask what they want to do** (fix now, fix later, or proceed as-is)
4. Address issues based on user decision

---

## Phase 7: Test Validation & Approval

**Goal**: Verify all tests pass and get user approval before committing

**Actions**:

### 7.1 Run Full Test Suite
```bash
npm test
# or appropriate test command for the project
```

### 7.2 Present Test Results
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

### 7.3 Request User Approval
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

## Phase 8: Git Commit & Push

**Goal**: Commit changes and push to repository

**ONLY EXECUTE IF USER APPROVED IN PHASE 7**

**Actions**:

### 8.1 Review Git Status
```bash
git status
```

### 8.2 Stage Changes
```bash
git add [modified files]
```

### 8.3 Create Commit
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

### 8.4 Push to Remote
```bash
git push
```

If push requires upstream:
```bash
git push -u origin [branch-name]
```

### 8.5 Confirm Success
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

## Phase 9: Summary

**Goal**: Document what was accomplished

**Actions**:
1. Mark all todos complete
2. Comprehensive summary:
   - **What was built**: Feature description and scope
   - **Key decisions made**: Architecture choices and rationale
   - **Files modified**: List with brief descriptions and commit hash
   - **Git information**:
     - Commit hash
     - Branch name
     - Push status
   - **Suggested next steps**:
     - Create pull request (if on feature branch)
     - Deploy to staging/production
     - Update project board/tickets
     - Notify team members

---
