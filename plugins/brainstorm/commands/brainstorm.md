---
description: Research-driven brainstorming workflow - explore ideas through web research and codebase analysis, generate comprehensive implementation specifications without changing code
---

# Brainstorm

Systematically research, architect, and document feature ideas without writing code. Creates comprehensive specifications that can be handed to implementation teams.

## Usage

```bash
/brainstorm [idea or problem description]
```

**Examples:**
```bash
/brainstorm "Add real-time notifications to the app"
/brainstorm "Improve performance of search functionality"
/brainstorm "User authentication with social login"
/brainstorm "Implement file upload system with virus scanning"
```

## Workflow Overview

The brainstorming workflow consists of 5 key phases:

```mermaid
graph TB
    A[1. Research] --> B[2. Architecture]
    B --> C[3. Requirements]
    C --> D[4. Review]
    D --> E[5. Handoff Document]
```

## Phase 1: Research

**Objective**: Gather comprehensive information about the idea.

### Actions
1. **Launch idea-researcher agent** to:
   - Clarify the problem or opportunity
   - Research existing solutions
   - Explore technology landscape
   - Analyze current codebase
   - Identify challenges and opportunities

2. **Agent will research**:
   - Best practices and industry standards
   - Similar implementations and case studies
   - Technology options and comparisons
   - Current architecture patterns
   - Integration points in codebase

3. **Expected output**:
   - Comprehensive research report
   - Technology recommendations
   - Best practices summary
   - Potential challenges identified
   - Opportunities for improvement

### Research Report Contents

```markdown
# Research Report: [Feature Name]

## Executive Summary
- Problem statement
- Proposed solution concept
- Key findings

## Problem Analysis
- Detailed problem description
- Target users and their needs
- Success criteria
- Constraints

## Existing Solutions Research
- Commercial solutions analyzed
- Open source options evaluated
- Best practices identified
- Industry trends

## Technology Landscape
- Recommended technologies with rationale
- Technology comparison table
- Integration considerations

## Codebase Analysis
- Current architecture patterns
- Existing related code
- Integration points
- Code patterns to follow

## Potential Challenges
- Technical challenges with mitigations
- Implementation risks
- Team skill gaps

## Opportunities
- Quick wins identified
- Strategic improvements
- Competitive advantages

## Key Insights
- Major findings from research
- Implications for implementation
```

## Phase 2: Architecture

**Objective**: Design comprehensive solution architecture.

### Actions
1. **Launch solution-architect agent** to:
   - Analyze research findings
   - Evaluate multiple solution approaches
   - Design system architecture
   - Create technical specifications
   - Document architecture decisions (ADRs)

2. **Agent will design**:
   - High-level system architecture
   - Component architecture
   - Data architecture and schema
   - Security architecture
   - Implementation roadmap

3. **Present approaches to user**:
   - Multiple approaches with trade-offs
   - Recommended approach with rationale
   - Risk assessment
   - Timeline estimates

4. **Get user approval** of chosen approach

### Architecture Document Contents

```markdown
# Solution Architecture: [Feature Name]

## Executive Summary
- Problem being solved
- High-level solution
- Timeline estimate
- Risk level

## Approach Evaluation
- Recommended approach (detailed)
- Alternative approaches considered
- Trade-offs and rationale

## System Architecture
- High-level architecture diagram
- Component architecture
- Data architecture
- Security architecture
- Network architecture

## Technical Specifications
- API specifications
- Component specifications
- Database specifications

## Implementation Roadmap
- Phase 1: Foundation
- Phase 2: Core Features
- Phase 3: Integration
- Phase 4: Polish & Deploy

## Architecture Decisions (ADRs)
- ADR-001: [Major decision]
- ADR-002: [Another decision]
- ...

## Dependencies
- External dependencies
- Internal dependencies
- Team dependencies

## Risk Assessment
- Technical risks with mitigations
- Implementation risks with plans

## Success Criteria
- Functional requirements
- Non-functional requirements
```

## Phase 3: Requirements

**Objective**: Create implementation-ready requirements.

### Actions
1. **Launch requirements-writer agent** to:
   - Synthesize research and architecture
   - Write user stories with acceptance criteria
   - Document functional requirements
   - Define technical specifications
   - Create test scenarios

2. **Agent will create**:
   - User stories for all features
   - Detailed functional requirements
   - Complete API specifications
   - Database schema with migrations
   - Component specifications
   - Non-functional requirements
   - Edge cases and error handling
   - Comprehensive test scenarios

3. **Output will include**:
   - Implementation checklist
   - Definition of done
   - Handoff notes for teams

### Requirements Document Contents

```markdown
# Implementation Requirements: [Feature Name]

## Overview
- Feature description
- Priority level
- Timeline estimate
- Dependencies

## User Stories
- Epic level stories
- Detailed stories with acceptance criteria
- Story points and priorities

## Functional Requirements
- FR-001: [Requirement with inputs, process, outputs]
- FR-002: [Another requirement]
- ...

## Technical Specifications

### API Specifications
- Endpoint details
- Request/response schemas
- Validation rules
- Error responses
- Rate limiting

### Database Schema
- Table definitions with SQL
- Indexes and constraints
- Migration scripts

### Component Specifications
- UI components with props
- State management
- Behavior descriptions
- Styling requirements

### Service Layer
- Business logic services
- Method signatures
- Error handling
- Dependencies

## Non-Functional Requirements
- Performance targets
- Scalability requirements
- Security requirements
- Availability targets
- Usability standards

## Edge Cases & Error Handling
- All edge cases documented
- Expected behavior defined
- Error scenarios covered

## Test Scenarios
- Unit test cases
- Integration test cases
- E2E test scenarios

## Implementation Checklist
- Backend tasks
- Frontend tasks
- DevOps tasks

## Definition of Done
- Acceptance criteria checklist
- Testing requirements
- Documentation requirements
- Approval gates
```

## Phase 4: Review

**Objective**: Review and refine the specifications.

### Actions
1. **Present complete package** to user:
   - Research findings
   - Architecture design
   - Implementation requirements

2. **Gather feedback**:
   - What needs clarification?
   - What's missing?
   - What should be adjusted?

3. **Refine as needed**:
   - Update specifications
   - Add missing details
   - Adjust approach if needed

4. **Get final approval**

## Phase 5: Handoff Document

**Objective**: Create final implementation package.

### Actions
1. **Consolidate all outputs** into single handoff document

2. **Create executive summary**:
   - What we're building
   - Why we're building it
   - How we'll build it
   - When it will be done

3. **Package for handoff**:
   - Research report
   - Architecture document
   - Requirements document
   - Implementation checklist

4. **Save to documentation**:
   - Write to `./docs/brainstorm/[feature-name]/`
   - Include all diagrams and specs
   - Create README with overview

### Final Package Structure

```
./docs/brainstorm/[feature-name]/
├── README.md                    # Executive summary
├── 01-research-report.md        # Full research findings
├── 02-architecture.md           # System architecture
├── 03-requirements.md           # Implementation requirements
├── 04-api-specs.md             # API specifications
├── 05-database-schema.md       # Database design
├── 06-test-scenarios.md        # Test cases
└── diagrams/
    ├── architecture.png         # Architecture diagram
    ├── data-flow.png           # Data flow diagram
    └── component-diagram.png   # Component diagram
```

## Core Principles

### 1. Research First
- Understand the problem deeply
- Learn from existing solutions
- Identify best practices
- Know the constraints

### 2. Design Before Implementing
- Evaluate multiple approaches
- Consider trade-offs
- Document decisions
- Plan phases

### 3. Specify Comprehensively
- Write detailed requirements
- Define acceptance criteria
- Document edge cases
- Create test scenarios

### 4. No Code Changes
- This is a planning tool
- Outputs are specifications only
- Implementation happens separately
- Specifications guide developers

### 5. Collaborative
- Get user feedback frequently
- Present options with trade-offs
- Explain reasoning
- Allow course corrections

## Best Practices

### Problem Definition
```markdown
## Clear Problem Statement
**Problem**: Users can't see updates in real-time, must refresh page
**Impact**: Poor UX, missed important updates, user frustration
**Goal**: Enable real-time updates without manual refresh
**Success**: Updates appear within 2 seconds, no refresh needed
```

### Research Depth
- Search multiple sources
- Check recent articles (2024-2025)
- Look for case studies
- Analyze production implementations
- Consider team capabilities

### Architecture Quality
- Show diagrams (ASCII art or Mermaid)
- Explain trade-offs clearly
- Document why decisions were made
- Consider future evolution
- Plan for failure scenarios

### Requirements Completeness
- Every user story has acceptance criteria
- Every API has request/response examples
- Every table has migration script
- Every requirement has test scenario
- Every edge case has expected behavior

## When to Use This Command

**Use /brainstorm when:**
- Exploring a new feature idea
- Major architectural change needed
- Technology choice decision required
- Understanding problem better
- Creating implementation plan
- Need comprehensive documentation

**Don't use /brainstorm when:**
- Simple bug fix (use /fix-bug)
- Minor code change
- Just want to implement immediately
- Already have detailed specs

## Output Format

The command produces a comprehensive package:

```markdown
# Brainstorm Package: [Feature Name]

## Executive Summary
**What**: [Feature description]
**Why**: [Business value]
**How**: [Approach summary]
**When**: [Timeline estimate]
**Risk**: Low/Medium/High

## Research Findings
[Link to research report]

**Key Insights**:
1. [Insight 1]
2. [Insight 2]
3. [Insight 3]

**Technology Recommendation**: [Technology] because [reasons]

## Architecture Design
[Link to architecture document]

**Approach**: [Chosen approach name]
**Components**: [List main components]
**Timeline**: [Phase breakdown]

**Key Decisions**:
- ADR-001: [Decision summary]
- ADR-002: [Decision summary]

## Implementation Requirements
[Link to requirements document]

**User Stories**: [Count] stories totaling [points] story points
**API Endpoints**: [Count] new endpoints
**Database Changes**: [Count] new tables, [count] migrations
**Test Scenarios**: [Count] unit tests, [count] integration tests

## Next Steps

### Immediate Actions
1. Review and approve specifications
2. Assign to development team
3. Create project tickets

### Implementation Phases
- **Phase 1** (Week 1-2): Foundation
- **Phase 2** (Week 3-5): Core Features
- **Phase 3** (Week 6-7): Integration
- **Phase 4** (Week 8): Polish & Deploy

### Success Metrics
- [ ] All functional requirements met
- [ ] Performance targets achieved
- [ ] Security requirements satisfied
- [ ] User acceptance testing passed

## Files Created
- ✅ Research report: `./docs/brainstorm/[feature]/01-research-report.md`
- ✅ Architecture: `./docs/brainstorm/[feature]/02-architecture.md`
- ✅ Requirements: `./docs/brainstorm/[feature]/03-requirements.md`
- ✅ API specs: `./docs/brainstorm/[feature]/04-api-specs.md`
- ✅ Database schema: `./docs/brainstorm/[feature]/05-database-schema.md`
- ✅ Test scenarios: `./docs/brainstorm/[feature]/06-test-scenarios.md`

**Ready for Implementation**: Yes ✅
```

## Tips for Users

### Provide Good Input
**Good**: "Add real-time notifications for order updates, user mentions, and system alerts. Users should see notifications within 2 seconds. Must work on web and mobile."

**Not Enough**: "Add notifications"

### Ask Questions
- "What technologies should we consider?"
- "How does this fit with our current architecture?"
- "What are the main risks?"
- "What's the simplest approach?"

### Review Thoughtfully
- Read all sections, not just summary
- Check if edge cases are covered
- Verify specs match your expectations
- Ask for clarifications
- Provide feedback

### Use the Output
- Share with development team
- Create project tickets from requirements
- Use architecture as design reference
- Use test scenarios for QA planning
- Update as implementation progresses

This command creates thorough, well-researched specifications that set implementation teams up for success.
