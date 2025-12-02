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

**Goal**: Build the feature using functional programming principles with intelligent multi-agent coordination

**DO NOT START WITHOUT USER APPROVAL**

### Step 1: Analyze Implementation Complexity

**Determine implementation strategy:**

1. **Count implementation scope** from architecture blueprint:
   - How many files need to be created/modified?
   - How many distinct implementation phases are there?
   - Are there clear, independent work packages?

2. **Apply heuristic** to choose strategy:
   - **Simple features** (≤5 files OR ≤2 phases): Single-agent implementation
   - **Complex features** (>5 files AND >2 phases): Multi-agent implementation

### Step 2: Single-Agent Implementation (Simple Features)

**When:** ≤5 files OR ≤2 phases

**Actions**:
1. Wait for explicit user approval
2. Read all relevant files identified in previous phases
3. Implement following chosen architecture
4. Follow codebase conventions strictly
5. Write clean, well-documented code
6. Update todos as you progress

### Step 3: Multi-Agent Implementation (Complex Features)

**When:** >5 files AND >2 phases

**Actions**:

#### 3.1 Work Package Creation

**Analyze architecture blueprint to create work packages:**

1. **Group by implementation phases** from blueprint:
   - Phase 1: Foundation layer (types, pure utility functions)
   - Phase 2: Business logic layer (pure functions, composition)
   - Phase 3: Integration layer (side effects, I/O)
   - Phase 4: Presentation layer (UI components, if applicable)

2. **Detect file dependencies**:
   - Files that import each other must be in same package or sequential packages
   - Independent files can be in parallel packages
   - Shared types/interfaces should be in earliest package

3. **Create 2-3 work packages** maximum:
   - **Package A**: Foundation + core types (1 agent)
   - **Package B**: Business logic + services (1 agent, depends on A)
   - **Package C**: UI + integration (1 agent, depends on B)

4. **Present work split to user:**
```markdown
## Work Package Split Analysis

**Complexity Assessment:**
- Total files: [X]
- Implementation phases: [Y]
- Strategy: Multi-agent (parallel where possible)

**Work Packages:**

### Package A: Foundation Layer
- **Agent**: code-implementer (Agent 1)
- **Files to create**:
  - `src/types/feature.ts` - Type definitions
  - `src/lib/feature-utils.ts` - Pure utility functions
- **Files to modify**:
  - None
- **Dependencies**: None (can start immediately)
- **Estimated time**: [duration]

### Package B: Business Logic Layer
- **Agent**: code-implementer (Agent 2)
- **Files to create**:
  - `src/lib/feature-calculator.ts` - Pure business logic
  - `src/services/feature-service.ts` - Side effect wrappers
- **Files to modify**:
  - `src/services/api.ts:45` - Add new endpoint
- **Dependencies**: Package A (needs types from Agent 1)
- **Estimated time**: [duration]

### Package C: UI Integration Layer
- **Agent**: code-implementer (Agent 3)
- **Files to create**:
  - `src/components/FeaturePanel.tsx` - UI component
- **Files to modify**:
  - `src/App.tsx:120` - Integrate new component
- **Dependencies**: Package B (needs service from Agent 2)
- **Estimated time**: [duration]

**Total parallel groups**: 3 (sequential due to dependencies)
**Total estimated time**: [sum]

Proceed with this work split?
```

5. **Wait for user approval** of work split

#### 3.2 Launch Implementation Agents

**Execute work packages in dependency order:**

1. **Identify parallel groups**:
   - Group 1: Packages with no dependencies
   - Group 2: Packages depending only on Group 1
   - Group 3: Packages depending on Group 1 or 2

2. **Launch agents for each group sequentially**, but agents within group run in **parallel**:

**Group 1 Example** (parallel):
```markdown
Launch code-implementer agents in parallel:

**Agent 1 Prompt:**
You are implementing Package A: Foundation Layer

**Architecture Blueprint Section**: [paste relevant section]

**Your Work Package:**
- Files to create: `src/types/feature.ts`, `src/lib/feature-utils.ts`
- Files to modify: None
- Dependencies: None

**Integration Points:**
- Exports for Agent 2: FeatureInput, FeatureOutput types
- Exports for Agent 3: validateFeatureInput() function

Focus: Pure functions only, no side effects. Follow functional programming principles strictly.

**Important:** Report completion summary with:
1. Files created/modified
2. Exported interfaces/functions
3. Any issues encountered
```

**Agent 2 Prompt** (waits for Agent 1):
[Similar structure, references Agent 1's exports]

**Agent 3 Prompt** (waits for Agent 2):
[Similar structure, references Agent 2's exports]

3. **Monitor agent completion**:
   - Wait for all agents in current group to complete
   - Review their completion summaries
   - Verify integration points match expectations
   - Move to next group

#### 3.3 Integration Validation

**After all agents complete:**

1. **Check file conflicts**:
   - Did multiple agents modify the same file?
   - If yes: Manually review and merge changes
   - If no: Proceed to validation

2. **Verify integration points**:
   - Agent 1 exported FeatureInput type → Agent 2 imports it ✓
   - Agent 2 exported FeatureService → Agent 3 imports it ✓
   - All integration points documented in blueprint → All present ✓

3. **Run basic validation**:
   ```bash
   # Type check
   npm run typecheck

   # Build check
   npm run build
   ```

4. **Report integration status** to user

#### 3.4 Handle Issues

**If conflicts or integration failures:**

1. **File conflicts**:
   - Read both versions
   - Manually merge using functional programming principles
   - Preserve work from both agents
   - Ask user if uncertain

2. **Missing integration points**:
   - Identify which agent missed the export
   - Manually add the missing integration
   - Document what was added

3. **Type mismatches**:
   - Check architecture blueprint for intended types
   - Update types to match blueprint
   - Ensure both sides updated

### Step 4: Completion

**For both single-agent and multi-agent:**

1. **Final validation**:
   - All files from blueprint created/modified ✓
   - Functional programming principles followed ✓
   - No mutations introduced ✓
   - Tests passing (if written) ✓

2. **Update todos** to mark Phase 6 complete

3. **Prepare for Phase 7** (Quality Review)

---

## Phase 6: Quality Review

**Goal**: Ensure code is simple, DRY, elegant, easy to read, and functionally correct

**Actions**:
1. Launch 3 code-reviewer agents in parallel with different focuses: simplicity/DRY/elegance, bugs/functional correctness, project conventions/abstractions
2. Consolidate findings and identify highest severity issues that you recommend fixing
3. **Present findings to user and ask what they want to do** (fix now, fix later, or proceed as-is)
4. Address issues based on user decision

---

## Phase 7: Summary

**Goal**: Document what was accomplished

**Actions**:
1. Mark all todos complete
2. Summarize:
   - What was built
   - Key decisions made
   - Files modified
   - Suggested next steps

---
