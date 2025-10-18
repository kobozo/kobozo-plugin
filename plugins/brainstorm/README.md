# Brainstorm Plugin

A research-driven brainstorming tool that explores ideas through web research and codebase analysis, generating comprehensive implementation specifications without changing any code.

**Version:** 1.1.0
**Author:** Yannick De Backer (yannick@kobozo.eu)

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Command Documentation](#command-documentation)
- [Agent Documentation](#agent-documentation)
- [Workflow Phases](#workflow-phases)
- [Output Structure](#output-structure)
- [When to Use This Plugin](#when-to-use-this-plugin)
- [Best Practices](#best-practices)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)

---

## Overview

The Brainstorm plugin is a comprehensive planning and specification tool designed to help teams thoroughly research, architect, and document feature ideas before implementation. It creates production-ready specifications that can be handed to development teams without requiring any code changes during the brainstorming process.

Unlike traditional brainstorming tools that focus on generating ideas, this plugin emphasizes **research-driven decision making** and **comprehensive documentation**, ensuring that ideas are validated, architected, and specified before a single line of code is written.

### What Makes It Different

- **Research-First Approach**: Uses web search and codebase analysis to inform decisions
- **Multi-Agent Workflow**: Specialized agents for research, architecture, and requirements
- **No Code Changes**: Purely a planning tool - outputs specifications only
- **Production-Ready Specs**: Creates implementation-ready documentation
- **Collaborative**: Presents options and gathers feedback throughout the process

---

## Key Features

### Research Phase
- Web research for existing solutions and best practices
- Technology landscape analysis
- Codebase pattern identification
- Industry trend analysis
- Case study examination

### Architecture Phase
- Multiple approach evaluation with trade-offs
- Comprehensive system architecture design
- Component and data architecture
- Security and network architecture
- Architecture Decision Records (ADRs)
- Implementation roadmap with phases

### Requirements Phase
- User stories with acceptance criteria
- Detailed functional requirements
- Complete API specifications
- Database schema design with migrations
- UI component specifications
- Test scenarios (unit, integration, E2E)
- Implementation checklists
- Definition of Done

---

## Installation

The Brainstorm plugin is part of the Kobozo Plugins collection. To use it:

1. Ensure you have Claude Code with plugin support
2. Install the plugins repository:
   ```bash
   git clone https://github.com/kobozo/kobozo-plugins.git
   ```
3. The plugin will be automatically available as `/brainstorm`

### Requirements

- Claude Code (latest version)
- Internet connection (for web research)
- Access to your codebase for analysis

---

## Quick Start

```bash
# Basic usage
/brainstorm "Add real-time notifications to the app"

# With context
/brainstorm "Improve search performance - users complaining about slow results"

# With constraints
/brainstorm "User authentication with social login, must integrate with existing JWT system"
```

The plugin will guide you through:
1. **Research** - Gathering information about the idea
2. **Architecture** - Designing the solution (with your approval)
3. **Requirements** - Creating detailed specifications
4. **Review** - Refining based on your feedback
5. **Handoff** - Packaging complete documentation

---

## Command Documentation

### `/brainstorm [idea or problem description]`

**Description:** Systematically research, architect, and document feature ideas without writing code.

**Parameters:**
- `idea or problem description` (required) - A clear description of what you want to explore

**Examples:**

```bash
# Feature ideas
/brainstorm "Add real-time notifications to the app"
/brainstorm "Implement file upload system with virus scanning"
/brainstorm "User authentication with social login"

# Performance improvements
/brainstorm "Improve performance of search functionality"
/brainstorm "Optimize database queries for dashboard"

# Architecture changes
/brainstorm "Migrate from monolith to microservices for user service"
/brainstorm "Add caching layer to reduce database load"
```

**What Happens:**
1. The plugin launches specialized agents sequentially
2. Each agent produces detailed documentation
3. You review and approve key decisions
4. Final specifications are saved to `./docs/brainstorm/[feature-name]/`

---

## Agent Documentation

The Brainstorm plugin uses three specialized agents, each focused on a specific aspect of the planning process.

### 1. Idea Researcher

**Agent:** `brainstorm:idea-researcher`
**Model:** Opus
**Color:** Yellow
**Tools:** Glob, Grep, Read, WebSearch, WebFetch, TodoWrite

**Responsibilities:**
- Understand the problem or opportunity deeply
- Research existing solutions (commercial and open-source)
- Explore technology trends and best practices
- Analyze current codebase patterns and constraints
- Identify opportunities and potential challenges

**Research Categories:**
- **Problem Analysis**: Problem statement, target users, success criteria
- **Existing Solutions**: Libraries, frameworks, SaaS products
- **Best Practices**: Industry standards, design patterns, security
- **Technology Trends**: Modern approaches (2024-2025), emerging tech
- **Case Studies**: Real-world implementations, lessons learned
- **Codebase Analysis**: Current architecture, integration points
- **Challenges**: Technical risks, implementation hurdles

**Output:** Comprehensive research report covering all findings with evidence and sources.

**Example Searches:**
```
"user authentication best practices 2025"
"real-time notifications implementation"
"PostgreSQL vs MongoDB for [use case]"
"how to handle large file uploads"
```

---

### 2. Solution Architect

**Agent:** `brainstorm:solution-architect`
**Model:** Opus
**Color:** Green
**Tools:** Glob, Grep, Read, WebFetch, TodoWrite

**Responsibilities:**
- Analyze research findings and requirements
- Evaluate multiple solution approaches (minimum 2-3)
- Create detailed technical specifications
- Document architecture decisions (ADRs)
- Identify implementation phases and dependencies

**Architecture Coverage:**
- **High-Level Architecture**: System overview with diagrams
- **Component Architecture**: Detailed component breakdown
- **Data Architecture**: Database schema, data flow
- **Security Architecture**: Auth, authorization, encryption
- **Network Architecture**: Network topology and policies
- **API Specifications**: Endpoint details, request/response
- **Implementation Roadmap**: Phased approach with timeline

**Output:** Complete solution architecture document with multiple approaches, chosen design, and implementation plan.

**Key Deliverables:**
- Architecture diagrams (ASCII or Mermaid)
- ADRs documenting all major decisions
- Technology stack recommendations
- Risk assessment with mitigations
- Timeline estimates by phase

---

### 3. Requirements Writer

**Agent:** `brainstorm:requirements-writer`
**Model:** Opus
**Color:** Orange
**Tools:** Read, Write, TodoWrite

**Responsibilities:**
- Synthesize research findings and approved architecture
- Write clear, detailed specifications
- Define acceptance criteria and test scenarios
- Create user stories and technical tasks
- Document edge cases and error handling

**Requirements Coverage:**
- **User Stories**: Epic and detailed stories with acceptance criteria
- **Functional Requirements**: Detailed specs with inputs, process, outputs
- **API Specifications**: Complete endpoint documentation
- **Database Schema**: Tables, indexes, constraints, migrations
- **Component Specifications**: UI components with props and behavior
- **Service Layer**: Business logic with method signatures
- **Non-Functional Requirements**: Performance, security, scalability
- **Edge Cases**: All edge cases with expected behavior
- **Test Scenarios**: Unit, integration, and E2E test cases
- **Implementation Checklist**: All tasks across teams

**Output:** Implementation-ready requirements document that developers can use to build the feature.

**Quality Standards:**
- Every user story has acceptance criteria
- Every API has request/response examples
- Every table has migration script
- Every requirement has test scenario
- Every edge case has expected behavior

---

## Workflow Phases

### Phase 1: Research (Idea Researcher Agent)

**Objective:** Gather comprehensive information about the idea.

**Actions:**
1. Launch the `idea-researcher` agent via Task tool
2. Agent conducts thorough web and codebase research
3. Agent produces comprehensive research report

**Research Report Contents:**
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

**Duration:** Varies based on complexity (typically 5-15 minutes)

---

### Phase 2: Architecture (Solution Architect Agent)

**Objective:** Design comprehensive solution architecture.

**Actions:**
1. Launch the `solution-architect` agent via Task tool
2. Agent evaluates multiple approaches (2-3 alternatives)
3. Agent designs detailed architecture
4. Present approaches to user for approval
5. User selects preferred approach

**Architecture Document Contents:**
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

**Duration:** Varies based on complexity (typically 10-20 minutes)

**User Interaction:** You must approve the chosen approach before proceeding.

---

### Phase 3: Requirements (Requirements Writer Agent)

**Objective:** Create implementation-ready requirements.

**Actions:**
1. Launch the `requirements-writer` agent via Task tool
2. Agent synthesizes research and architecture
3. Agent creates detailed specifications
4. Saves outputs to `./docs/brainstorm/[feature-name]/`

**Requirements Document Contents:**
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

**Duration:** Varies based on complexity (typically 15-30 minutes)

---

### Phase 4: Review

**Objective:** Review and refine the specifications.

**Actions:**
1. Present complete package to user:
   - Research findings
   - Architecture design
   - Implementation requirements
2. Gather feedback:
   - What needs clarification?
   - What's missing?
   - What should be adjusted?
3. Refine as needed:
   - Update specifications
   - Add missing details
   - Adjust approach if needed
4. Get final approval

**User Interaction:** This is your opportunity to request changes or clarifications.

---

### Phase 5: Handoff Document

**Objective:** Create final implementation package.

**Actions:**
1. Consolidate all outputs into single handoff document
2. Create executive summary
3. Package for handoff
4. Save to documentation directory

**Final Package Structure:**
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

**Handoff Document Contents:**
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

---

## Output Structure

All documentation is saved to `./docs/brainstorm/[feature-name]/` with the following structure:

### README.md
Executive summary with:
- What we're building and why
- Key decisions and recommendations
- Timeline and risk assessment
- Links to detailed documents
- Next steps for implementation

### 01-research-report.md
Comprehensive research findings including:
- Problem analysis with target users
- Existing solutions (commercial and open-source)
- Technology landscape and recommendations
- Codebase analysis (current patterns, integration points)
- Potential challenges with mitigations
- Opportunities for improvement
- Key insights with sources

### 02-architecture.md
Detailed architecture design including:
- Executive summary (problem, solution, timeline, risk)
- Approach evaluation (recommended + alternatives)
- System architecture (high-level, component, data, security, network)
- Technical specifications (API, component, database)
- Implementation roadmap (phases with timeline)
- Architecture Decision Records (ADRs)
- Dependencies (external, internal, team)
- Risk assessment with mitigations
- Success criteria

### 03-requirements.md
Implementation-ready requirements including:
- Overview (description, priority, timeline, dependencies)
- User stories (epic and detailed with acceptance criteria)
- Functional requirements (detailed specs)
- Technical specifications (API, database, components, services)
- Non-functional requirements (performance, security, etc.)
- Edge cases and error handling
- Test scenarios (unit, integration, E2E)
- Implementation checklist
- Definition of done

### 04-api-specs.md (Optional)
Detailed API documentation if APIs are involved:
- All endpoints with full specifications
- Request/response schemas
- Validation rules
- Error responses
- Rate limiting
- Authentication/authorization
- Examples for every endpoint

### 05-database-schema.md (Optional)
Complete database design if database changes are needed:
- All table definitions with SQL
- Indexes and constraints
- Relationships
- Migration scripts
- Data validation rules
- Sample data

### 06-test-scenarios.md (Optional)
Comprehensive test documentation:
- Unit test cases with code examples
- Integration test scenarios
- E2E test journeys
- Performance test scenarios
- Security test cases

### diagrams/ (Optional)
Visual representations:
- Architecture diagrams
- Data flow diagrams
- Component diagrams
- Sequence diagrams
- Network diagrams

---

## When to Use This Plugin

### Use `/brainstorm` When:

✅ **Exploring a new feature idea**
- You have an idea but need to research feasibility
- You want to understand existing solutions
- You need to evaluate technology options

✅ **Major architectural change needed**
- Significant refactoring required
- Changing core technology stack
- Moving to new architecture pattern

✅ **Technology choice decision required**
- Comparing multiple technology options
- Need evidence-based recommendations
- Want to understand trade-offs

✅ **Understanding problem better**
- Problem is complex or unclear
- Need to research industry approaches
- Want to learn from case studies

✅ **Creating implementation plan**
- Need detailed specifications
- Want comprehensive roadmap
- Require acceptance criteria and tests

✅ **Need comprehensive documentation**
- Handoff to another team
- Creating project proposal
- Long-term reference needed

### Don't Use `/brainstorm` When:

❌ **Simple bug fix**
- Use debugging tools or `/fix-bug` instead
- Bug fixes don't need extensive research

❌ **Minor code change**
- Small tweaks don't need full workflow
- Just implement directly

❌ **Just want to implement immediately**
- If you already know exactly what to do
- When speed is more important than planning

❌ **Already have detailed specs**
- Specifications already exist
- Just need implementation

---

## Best Practices

### 1. Provide Clear Input

**Good Input:**
```bash
/brainstorm "Add real-time notifications for order updates, user mentions, and system alerts.
Users should see notifications within 2 seconds. Must work on web and mobile.
Current stack is React + Node.js + PostgreSQL."
```

**Not Enough:**
```bash
/brainstorm "Add notifications"
```

**What Makes Good Input:**
- Clear problem statement
- Target users or use cases
- Success criteria or constraints
- Relevant context (current tech stack)
- Scope indication (MVP vs full)

---

### 2. Engage Throughout the Process

**During Research Phase:**
- Ask questions about findings
- Request clarification on technologies
- Share domain knowledge
- Point out constraints

**During Architecture Phase:**
- Review all approaches presented
- Ask about trade-offs
- Challenge assumptions
- Consider team capabilities

**During Requirements Phase:**
- Verify edge cases are covered
- Check if acceptance criteria match expectations
- Request additional test scenarios
- Add missing requirements

---

### 3. Review Thoughtfully

Don't just skim the executive summary:
- Read detailed sections
- Verify edge cases are covered
- Check if specs match your mental model
- Look for missing scenarios
- Validate assumptions

Ask questions like:
- "What about [edge case]?"
- "How does this handle [scenario]?"
- "Why did we choose X over Y?"
- "What if [constraint changes]?"

---

### 4. Use Output Effectively

**For Development Teams:**
- Share complete documentation package
- Create tickets from implementation checklist
- Use test scenarios for QA planning
- Reference ADRs during implementation

**For Stakeholders:**
- Share executive summary for overview
- Use timeline for project planning
- Reference risk assessment for decision-making
- Use success criteria for validation

**For Future Reference:**
- Keep documentation up to date
- Link to actual implementation
- Document deviations from plan
- Update as requirements evolve

---

### 5. Iterate Based on Feedback

The specifications are living documents:
- Update based on implementation learnings
- Refine as requirements change
- Document new decisions as ADRs
- Keep test scenarios current

---

## Examples

### Example 1: Real-Time Notifications

**Input:**
```bash
/brainstorm "Add real-time notifications to the app. Users need to see order updates,
mentions, and system alerts within 2 seconds. Must support 10,000 concurrent users."
```

**Research Output:**
- Comparison of WebSocket vs Server-Sent Events vs Long Polling
- Analysis of Socket.io, WS library, and native WebSocket API
- Best practices from Slack, Discord, and GitHub implementations
- Current codebase architecture and integration points
- Scalability challenges and solutions

**Architecture Output:**
- Approach 1: WebSocket with Socket.io (recommended)
- Approach 2: Server-Sent Events with fallback
- Approach 3: Long polling (not recommended)
- Detailed WebSocket architecture with Redis pub/sub
- Scaling strategy for 10k concurrent connections
- ADR documenting why Socket.io over native WebSocket

**Requirements Output:**
- 8 user stories covering all notification types
- API specifications for WebSocket events
- Database schema for notification storage
- Component specs for notification UI
- Test scenarios including connection loss, reconnection, offline handling
- Performance requirements: < 2s delivery, 10k concurrent users

---

### Example 2: Search Performance Improvement

**Input:**
```bash
/brainstorm "Search is too slow - users complain about 5-10 second delays.
Database has 1 million products. Current implementation uses full-text search
on PostgreSQL with no caching."
```

**Research Output:**
- PostgreSQL full-text search optimization techniques
- Comparison of Elasticsearch, Algolia, Typesense
- Caching strategies (Redis, in-memory)
- Indexing best practices
- Case studies of search at scale

**Architecture Output:**
- Approach 1: Elasticsearch for search (recommended)
- Approach 2: PostgreSQL with better indexes + Redis caching
- Approach 3: Typesense (open-source Algolia alternative)
- Migration strategy for existing data
- ADRs for choosing Elasticsearch

**Requirements Output:**
- Performance requirements: < 200ms response time
- Database migration plan
- API changes for search endpoint
- Caching strategy with cache invalidation
- Test scenarios including edge cases (special characters, empty results, etc.)
- Rollback plan if performance doesn't improve

---

### Example 3: User Authentication with Social Login

**Input:**
```bash
/brainstorm "Add social login (Google, GitHub, Facebook) to existing
email/password authentication. Must maintain existing JWT system and user data."
```

**Research Output:**
- OAuth 2.0 flow explanation
- Passport.js vs NextAuth.js vs Auth0
- Security best practices for social login
- User account linking strategies
- Current auth implementation analysis

**Architecture Output:**
- Approach 1: Passport.js integration (recommended)
- Approach 2: Auth0 (managed service)
- OAuth 2.0 flow diagrams
- Database schema changes for social accounts
- ADRs for Passport.js over Auth0

**Requirements Output:**
- User stories for social login flow
- API endpoints for OAuth callbacks
- Database schema for social_accounts table
- Account linking requirements (existing user + new social account)
- Error handling for failed OAuth flows
- Security requirements (CSRF protection, state validation)
- Test scenarios including edge cases (email conflicts, linking, unlinking)

---

## Troubleshooting

### Issue: Research Phase Takes Too Long

**Possible Causes:**
- Complex topic requiring extensive research
- Too many similar solutions to evaluate
- Slow web search responses

**Solutions:**
- Be patient - thorough research is valuable
- Provide more context to narrow scope
- Check internet connection
- If it takes > 20 minutes, you can cancel and restart with narrower scope

---

### Issue: Architecture Phase Doesn't Present Options

**Possible Causes:**
- Only one viable approach exists
- Agent focused too quickly on single solution

**Solutions:**
- Explicitly ask: "What are alternative approaches?"
- Request specific alternatives: "What about using X instead of Y?"
- Ask about trade-offs: "What are the pros and cons?"

---

### Issue: Requirements Too Generic

**Possible Causes:**
- Insufficient detail in research/architecture phases
- Complex feature not fully specified

**Solutions:**
- Request more detail: "Can you elaborate on [specific area]?"
- Ask for examples: "Can you provide example request/response?"
- Specify missing scenarios: "What about [edge case]?"
- Ask for clarification: "How should we handle [situation]?"

---

### Issue: Output Files Not Created

**Possible Causes:**
- Agent didn't complete successfully
- File system permissions issue
- Incorrect output path

**Solutions:**
- Check `./docs/brainstorm/` directory exists
- Verify write permissions
- Ask agent to regenerate: "Can you save the documents to ./docs/brainstorm/[feature]?"

---

### Issue: Research Seems Outdated

**Possible Causes:**
- Web search returned old articles
- Technology has evolved recently

**Solutions:**
- Specify time frame: "What are the best practices in 2025?"
- Request current sources: "Search for articles from 2024-2025"
- Ask for recent case studies: "Find recent implementations"

---

### Issue: Specifications Don't Match Codebase

**Possible Causes:**
- Agent didn't analyze codebase thoroughly
- Codebase has unique patterns not detected

**Solutions:**
- Point out patterns: "We use X pattern, not Y"
- Reference existing code: "Look at how we implemented [similar feature]"
- Provide examples: "Here's how we structure services: [example]"
- Request revision: "Can you update specs to match our patterns?"

---

## Core Principles

### 1. Research First
- Understand the problem deeply before designing
- Learn from existing solutions
- Identify best practices
- Know the constraints

### 2. Design Before Implementing
- Evaluate multiple approaches
- Consider trade-offs carefully
- Document decisions with rationale
- Plan implementation in phases

### 3. Specify Comprehensively
- Write detailed requirements
- Define clear acceptance criteria
- Document all edge cases
- Create test scenarios for verification

### 4. No Code Changes
- This is a planning tool, not an implementation tool
- Outputs are specifications only
- Implementation happens separately
- Specifications guide developers

### 5. Collaborative
- Get user feedback frequently
- Present options with trade-offs
- Explain reasoning clearly
- Allow course corrections

---

## Tips for Success

### Define Problems Clearly

**Good Problem Statement:**
```
**Problem**: Users can't see updates in real-time, must refresh page
**Impact**: Poor UX, missed important updates, user frustration
**Goal**: Enable real-time updates without manual refresh
**Success**: Updates appear within 2 seconds, no refresh needed
```

### Research with Depth

- Search multiple sources
- Check recent articles (2024-2025)
- Look for case studies and production implementations
- Analyze what competitors are doing
- Consider team capabilities

### Evaluate Architecture Quality

- Request diagrams (ASCII art or Mermaid)
- Ensure trade-offs are explained clearly
- Verify decisions are documented with rationale
- Check for future evolution planning
- Validate failure scenarios are considered

### Ensure Requirements Completeness

- Every user story has acceptance criteria
- Every API has request/response examples
- Every table has migration script
- Every requirement has test scenario
- Every edge case has expected behavior

---

## Related Plugins

- **feature-dev**: Implements features based on brainstorm specifications
- **api-documenter**: Creates API documentation from implemented endpoints
- **dead-code-detector**: Identifies unused code before refactoring

---

## Support

For issues, questions, or suggestions:
- Open an issue on [GitHub](https://github.com/kobozo/kobozo-plugins/issues)
- Email: yannick@kobozo.eu

---

## License

See LICENSE file in the repository root.

---

## Changelog

### Version 1.1.0
- Enhanced research capabilities
- Improved architecture evaluation
- More comprehensive requirements documentation
- Better agent coordination

### Version 1.0.0
- Initial release
- Research, architecture, and requirements agents
- 5-phase workflow
- Comprehensive documentation output
