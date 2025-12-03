---
name: Brainstorming Methodology
description: This skill should be used when the user wants to explore a new feature idea, plan a major change, evaluate technology options, or needs help thinking through implementation approaches. Provides systematic research-driven brainstorming methodology for exploring ideas before coding. Use when user says "let's think about", "how should we approach", "what's the best way to", or "I'm considering".
version: 1.0.0
---

# Brainstorming Methodology

Systematic approach for exploring ideas, evaluating approaches, and planning implementations before writing code.

## When to Apply

- User wants to explore a new feature idea
- Planning a major architectural change
- Evaluating technology options
- Designing a complex system
- Need to understand problem space before coding

## The Research-First Approach

### Principle: Understand Before Implementing

1. **Research** - Learn from existing solutions
2. **Architect** - Design multiple approaches
3. **Evaluate** - Compare trade-offs
4. **Specify** - Document implementation details

## Phase 1: Research

### Problem Analysis

```markdown
## Problem Definition

**What problem are we solving?**
- Clear problem statement
- Who experiences this problem?
- What's the impact?

**Success Criteria**
- How will we know it's solved?
- What metrics matter?
- What's the minimum viable solution?

**Constraints**
- Technical limitations
- Time/resource constraints
- Compatibility requirements
```

### Existing Solutions Research

1. **Commercial Solutions**
   - What products solve this?
   - What can we learn from them?
   - What do they do well/poorly?

2. **Open Source Options**
   - Existing libraries/frameworks
   - Reference implementations
   - Community best practices

3. **Industry Patterns**
   - How do similar companies solve this?
   - What patterns are standard?
   - What are emerging trends?

### Codebase Analysis

- What related features exist?
- What patterns does the codebase use?
- What can be reused?
- What constraints does existing code create?

## Phase 2: Architecture

### Approach Evaluation

For each potential approach:

```markdown
## Approach: [Name]

**Description**
[What this approach entails]

**Pros**
- [Advantage 1]
- [Advantage 2]

**Cons**
- [Disadvantage 1]
- [Disadvantage 2]

**Complexity**: Low / Medium / High
**Risk**: Low / Medium / High
**Timeline**: [Estimate]

**Best For**
[When to choose this approach]
```

### Compare at Least 2-3 Approaches

| Criteria | Approach A | Approach B | Approach C |
|----------|------------|------------|------------|
| Complexity | Low | Medium | High |
| Scalability | Limited | Good | Excellent |
| Time to Implement | 1 week | 2 weeks | 4 weeks |
| Maintenance | Easy | Medium | Complex |
| Risk | Low | Medium | High |

### Recommendation Framework

```markdown
## Recommended Approach: [Name]

**Why this approach?**
- [Reason 1 with evidence]
- [Reason 2 with evidence]

**Trade-offs accepted**
- [Trade-off 1 and why it's acceptable]
- [Trade-off 2 and mitigation]

**Key risks and mitigations**
- Risk: [Description] → Mitigation: [Plan]
```

## Phase 3: Specification

### High-Level Design

```markdown
## System Architecture

**Components**
- Component A: [Purpose]
- Component B: [Purpose]
- Component C: [Purpose]

**Data Flow**
[How data moves through the system]

**Integration Points**
[Where this connects to existing systems]
```

### Technical Specifications

```markdown
## API Design

**Endpoints**
- POST /api/resource - Create new resource
- GET /api/resource/:id - Get resource by ID

**Request/Response**
[Schemas and examples]

## Database Changes

**New Tables**
[Schema definitions]

**Migrations**
[Migration strategy]

## Component Specifications

**[Component Name]**
- Purpose: [What it does]
- Interface: [Public API]
- Dependencies: [What it needs]
```

### Implementation Roadmap

```markdown
## Phases

### Phase 1: Foundation (Week 1)
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

### Phase 2: Core Features (Week 2-3)
- [ ] Task 4
- [ ] Task 5

### Phase 3: Integration (Week 4)
- [ ] Task 6
- [ ] Task 7

## Dependencies
- [What must happen first]

## Risks
- [Risk 1]: Mitigation
- [Risk 2]: Mitigation
```

## Brainstorming Techniques

### Mind Mapping

Start with central concept, branch out:
```
                    ┌── Authentication
                    │
        ┌── Security ── Authorization
        │           │
Feature ─┼── UX ────── User Flow
        │           │
        └── Tech ───── API Design
                    │
                    └── Database
```

### SCAMPER Method

- **S**ubstitute: What can replace current approach?
- **C**ombine: What can be merged?
- **A**dapt: What similar solutions exist?
- **M**odify: What can be changed?
- **P**ut to other uses: What else could this enable?
- **E**liminate: What's unnecessary?
- **R**earrange: What order works better?

### Six Thinking Hats

- 🎩 **White**: Facts and data
- 🔴 **Red**: Emotions and intuition
- ⚫ **Black**: Caution and risks
- 🟡 **Yellow**: Benefits and value
- 🟢 **Green**: Creativity and alternatives
- 🔵 **Blue**: Process and summary

## Output Format

When brainstorming produces clear direction:

```markdown
# Brainstorm Summary: [Feature/Idea]

## Problem
[1-2 sentence problem statement]

## Recommended Approach
[Chosen approach with brief rationale]

## Key Decisions
1. [Decision 1]: [Choice] because [reason]
2. [Decision 2]: [Choice] because [reason]

## High-Level Design
[Brief architecture overview]

## Next Steps
1. [Immediate action]
2. [Following action]

## Open Questions
- [Question needing resolution]
```

## When to Use /brainstorm Command

Use the `/brainstorm` command when you need:
- Comprehensive documentation output
- Multi-agent research workflow
- Formal specification documents
- Handoff documentation for teams

The skill provides the methodology; the command produces the artifacts.

## Quick Reference

### Research Checklist
- [ ] Problem clearly defined
- [ ] Existing solutions researched
- [ ] Codebase patterns analyzed
- [ ] Constraints identified

### Architecture Checklist
- [ ] Multiple approaches evaluated
- [ ] Trade-offs documented
- [ ] Risks identified
- [ ] Recommendation justified

### Specification Checklist
- [ ] Components defined
- [ ] Interfaces specified
- [ ] Data models designed
- [ ] Implementation phases planned
