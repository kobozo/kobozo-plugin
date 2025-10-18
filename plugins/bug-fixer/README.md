# Bug Fixer Plugin

A comprehensive bug fixing workflow plugin for Claude Code that provides systematic bug analysis, fix implementation, and validation with specialized AI agents.

## Overview

The Bug Fixer plugin implements a structured 7-phase workflow to ensure high-quality bug fixes with minimal risk of regressions. It leverages specialized AI agents to analyze bugs deeply, design robust fixes, and validate thoroughly before deployment.

**Version:** 1.0.0
**Author:** Yannick De Backer (yannick@kobozo.eu)

## Table of Contents

- [Key Features](#key-features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Commands](#commands)
- [Specialized Agents](#specialized-agents)
- [Workflow Phases](#workflow-phases)
- [Usage Examples](#usage-examples)
- [Best Practices](#best-practices)
- [Tips for Users](#tips-for-users)

## Key Features

- **Structured 7-Phase Workflow**: From discovery to deployment-ready fix
- **Specialized AI Agents**: Expert agents for analysis, implementation, and validation
- **Root Cause Analysis**: Deep code tracing to find actual causes, not just symptoms
- **Multiple Fix Approaches**: Evaluate trade-offs before implementing
- **Comprehensive Validation**: Run tests, check edge cases, detect regressions
- **Confidence-Based Reporting**: Only surface high-confidence issues (≥80%)
- **Progress Tracking**: Todo lists keep you informed throughout the process
- **Risk Assessment**: Understand impact before deploying

## Installation

This plugin is part of the kobozo-plugins collection. To use it with Claude Code:

1. Ensure you have Claude Code installed
2. Clone or download this plugin to your Claude plugins directory
3. The plugin will be automatically available in Claude Code

## Quick Start

```bash
# Fix a bug with a description
/fix-bug "TypeError when invalid discount code is used"

# Fix a bug by issue number
/fix-bug #123

# Fix a specific error
/fix-bug "Payment processing crashes on empty cart"
```

The workflow will guide you through:
1. Clarifying the bug details
2. Analyzing root causes
3. Answering clarifying questions
4. Reviewing fix approaches
5. Approving implementation
6. Validating the fix
7. Reviewing the summary

## Commands

### `/fix-bug`

Systematically analyze, fix, and validate bugs with a comprehensive workflow.

**Syntax:**
```bash
/fix-bug [bug description or issue number]
```

**Examples:**
```bash
/fix-bug "TypeError when invalid discount code is used"
/fix-bug #123
/fix-bug "Payment processing crashes on empty cart"
/fix-bug User authentication fails after password reset
```

**What It Does:**
- Creates a task plan and todo list
- Launches bug-analyzer agents for deep analysis
- Asks clarifying questions about requirements
- Launches fix-implementer agents to design solutions
- Presents multiple fix approaches with trade-offs
- Implements the approved fix
- Launches test-validator agents for comprehensive testing
- Provides detailed summary and next steps

## Specialized Agents

### Bug Analyzer Agent

**Purpose:** Deep analysis of bugs to identify root causes and understand impact.

**Model:** Claude Sonnet
**Color:** Yellow (for visibility during analysis)

**Capabilities:**
- Trace execution paths from error back to trigger
- Identify root causes through code flow analysis
- Map affected components and dependencies
- Document error propagation patterns
- Identify edge cases and boundary conditions
- Analyze stack traces and error messages

**Tools Available:**
- `Glob` - Find relevant files
- `Grep` - Search for error messages and patterns
- `Read` - Examine code in detail
- `TodoWrite` - Track analysis progress
- `WebSearch` - Research similar issues
- `Bash` - Execute diagnostic commands

**Output:**
Comprehensive bug analysis report with:
- Root cause identification
- Impact assessment
- Code flow analysis
- Edge cases to consider
- Recommended fix approach

### Fix Implementer Agent

**Purpose:** Design robust bug fixes that integrate seamlessly with existing code.

**Model:** Claude Sonnet
**Color:** Green (indicating implementation phase)

**Capabilities:**
- Analyze codebase patterns and conventions
- Evaluate multiple fix approaches
- Create detailed implementation blueprints
- Design validation and error handling strategies
- Handle edge cases comprehensively
- Assess risk and plan rollback strategies

**Tools Available:**
- `Glob` - Find related code files
- `Grep` - Discover patterns and conventions
- `Read` - Study existing implementations
- `TodoWrite` - Track implementation progress
- `WebFetch` - Research best practices
- `Bash` - Test implementation approaches

**Output:**
Detailed implementation blueprint including:
- Multiple fix approaches with trade-offs
- Specific code changes needed
- Files to modify with before/after examples
- Test strategy
- Risk assessment
- Rollback plan

### Test Validator Agent

**Purpose:** Validate bug fixes thoroughly to ensure quality and prevent regressions.

**Model:** Claude Sonnet
**Color:** Red (indicating validation/testing phase)

**Capabilities:**
- Run existing test suites
- Execute bug reproduction tests
- Test edge cases and boundary conditions
- Check for regressions in related functionality
- Review code quality with confidence scoring
- Assess performance impact

**Tools Available:**
- `Glob` - Find test files
- `Grep` - Search for related tests
- `Read` - Review test implementations
- `TodoWrite` - Track validation progress
- `Bash` - Execute test suites
- `KillShell` - Manage long-running tests

**Output:**
Comprehensive validation report with:
- Test suite results (passing/failing)
- Bug reproduction verification
- Edge case test results
- Regression analysis
- Code quality issues (≥80% confidence only)
- Performance impact assessment
- Final verdict (approved/needs work/rejected)

## Workflow Phases

### Phase 1: Discovery

**Objective:** Understand the bug and create a task plan.

**Activities:**
1. Create todo list for tracking progress
2. Clarify bug description with user
3. Gather information about:
   - Expected vs actual behavior
   - Reproduction steps
   - Error messages
   - Environment details
   - Recent changes

**Questions Asked:**
- What should happen (expected behavior)?
- What actually happens (actual behavior)?
- How can I reproduce this?
- What error messages appear?
- When does this occur (all environments, production only)?
- Does this happen every time or intermittently?
- Were there recent code changes before this started?

**Output:**
- Clear understanding of the bug
- Complete todo list for tracking
- Confirmed reproduction steps

### Phase 2: Bug Analysis

**Objective:** Deep analysis to identify root cause and impact.

**Activities:**
1. Launch 1-2 bug-analyzer agents
2. Trace execution paths backward from error
3. Identify root cause (not just symptoms)
4. Map affected components
5. Document error propagation
6. Identify edge cases

**Agent Analysis:**
- Error messages and stack traces
- Code flow from trigger to error
- Related components and dependencies
- Similar issues in codebase
- Version control history

**Output:**
- Root cause identification
- Impact assessment (direct and indirect)
- Edge cases to consider
- Related areas to check
- Component dependency map

### Phase 3: Clarifying Questions

**Objective:** Resolve uncertainties before designing fix.

**Activities:**
1. Identify underspecified aspects
2. Present questions to user in clear format
3. Wait for answers before proceeding

**Example Questions:**
- How should invalid inputs be handled?
- Should we fail silently or show error to user?
- What error message should user see?
- Should we log these errors?
- What is acceptable performance impact?

**Output:**
- Answered questions about requirements
- Clear understanding of desired behavior
- User preferences for error handling

### Phase 4: Fix Design

**Objective:** Design comprehensive fix approach with trade-offs.

**Activities:**
1. Launch 1-2 fix-implementer agents
2. Analyze codebase patterns and conventions
3. Evaluate multiple fix approaches
4. Create implementation blueprint
5. Present approaches with trade-offs
6. Get user approval

**Fix Approaches Considered:**

**Approach A: Minimal Fix**
- Quick, low risk
- Fixes immediate issue only
- May leave underlying problems

**Approach B: Defensive Programming**
- Robust, comprehensive validation
- Prevents similar issues
- More code to write and test

**Approach C: Refactoring**
- Eliminates root cause completely
- Improves code quality long-term
- Higher risk, larger scope

**Output:**
- Multiple fix approaches with pros/cons
- Recommended approach with rationale
- Detailed implementation blueprint
- Risk assessment
- Time estimate

### Phase 5: Implementation

**Objective:** Implement the approved fix.

**Activities:**
1. Wait for explicit user approval
2. Read relevant files identified in blueprint
3. Implement the fix following blueprint
4. Add validation and error handling
5. Write comprehensive tests
6. Keep user informed via todo updates

**Implementation Checklist:**
- Read existing code
- Implement validation
- Update affected functions
- Add descriptive error messages
- Handle all edge cases
- Write unit tests
- Write integration tests
- Write edge case tests

**Output:**
- Fixed code following conventions
- Comprehensive error handling
- Complete test coverage
- Updated documentation

### Phase 6: Validation

**Objective:** Thoroughly validate the fix.

**Activities:**
1. Launch 2-3 test-validator agents
2. Run existing test suite
3. Test bug reproduction
4. Test all edge cases
5. Check for regressions
6. Review code quality
7. Consolidate findings
8. Present results to user
9. Address issues per user decision

**Validation Checks:**
- All existing tests still pass
- Bug no longer reproduces
- Edge cases handled correctly
- No new bugs introduced
- Code follows conventions
- Performance unchanged
- Security maintained

**Output:**
- Test suite results summary
- Bug reproduction verification
- Edge case test results
- Regression analysis
- Code quality issues (≥80% confidence)
- Performance impact
- Final verdict

### Phase 7: Summary

**Objective:** Complete workflow and document results.

**Activities:**
1. Complete all todos in task list
2. Document what was fixed
3. Highlight key decisions
4. Suggest next steps

**Summary Includes:**
- Bug description and root cause
- Fix implemented with files changed
- Validation results
- Key decisions and trade-offs
- Next steps (deploy, monitor, follow-up)

**Output:**
- Comprehensive fix summary
- Deployment recommendation
- Monitoring suggestions
- Follow-up tasks if needed

## Usage Examples

### Example 1: Simple Bug Fix

```bash
/fix-bug "Null pointer exception in user profile"
```

**Workflow:**
1. Plugin asks for reproduction steps
2. You provide: "View any user profile with missing avatar"
3. Bug-analyzer traces code and finds missing null check
4. Fix-implementer suggests defensive programming approach
5. You approve the approach
6. Plugin implements fix with validation
7. Test-validator confirms all tests pass
8. You get deployment-ready fix

### Example 2: Complex Bug with Multiple Approaches

```bash
/fix-bug #456
```

**Workflow:**
1. Plugin reads issue #456 from your tracker
2. Bug-analyzer identifies race condition in cache
3. Plugin asks: "How critical is this? Should we prioritize safety or performance?"
4. You answer: "Safety first"
5. Fix-implementer presents 3 approaches:
   - A: Add mutex lock (safest, slower)
   - B: Atomic operations (balanced)
   - C: Eventual consistency (fastest, less safe)
6. You choose Approach A
7. Plugin implements with comprehensive locking
8. Test-validator runs concurrent tests
9. You get validated, thread-safe fix

### Example 3: Bug with Edge Cases

```bash
/fix-bug "Discount calculation wrong for some codes"
```

**Workflow:**
1. Plugin analyzes and finds validation missing
2. Bug-analyzer identifies edge cases:
   - Empty discount codes
   - Negative amounts
   - Expired codes
   - Discount exceeds total
3. Fix-implementer designs comprehensive validation
4. Plugin implements with all edge case handling
5. Test-validator creates 12 edge case tests
6. All edge cases pass validation
7. You get robust, edge-case-proof fix

## Best Practices

### For Bug Reports

**Provide Complete Information:**
- Expected vs actual behavior
- Reproduction steps (detailed)
- Error messages and stack traces
- Environment (dev/staging/production)
- Recent changes that might be related
- Frequency (always/sometimes/rare)

**Good Bug Report:**
```
Bug: Payment processing fails with invalid discount code

Expected: Show error message "Invalid discount code"
Actual: App crashes with TypeError

Steps to reproduce:
1. Add item to cart ($100)
2. Apply discount code "INVALID123"
3. Click "Checkout"
Result: App crashes

Error: TypeError: Cannot read property 'amount' of undefined
at processPayment (payment.ts:245)

Environment: Production
Frequency: Every time with invalid code
Recent changes: Discount system refactored 2 days ago
```

### For Fix Approval

**Consider Trade-offs:**
- Speed of implementation vs robustness
- Risk of regression vs thoroughness
- Short-term fix vs long-term solution
- Code complexity vs maintainability

**Ask Questions:**
- Why is this approach recommended?
- What are the risks?
- What happens if we choose a different approach?
- Can we split this into multiple phases?

**Don't Rush:**
- Take time to review the implementation blueprint
- Understand the changes being made
- Consider long-term implications
- Think about team knowledge and maintenance

### For Validation Review

**Review Test Coverage:**
- Are all edge cases covered?
- Are regression tests comprehensive?
- Is the bug reproduction test clear?
- Do tests cover both happy and error paths?

**Check Code Quality:**
- Is the fix too complex or too simple?
- Does it follow project conventions?
- Are error messages clear and helpful?
- Is the code maintainable?

**Decide on Minor Issues:**
- Can non-blocking issues be addressed later?
- Should we fix minor issues now or in follow-up?
- Are the issues worth delaying deployment?

## Tips for Users

### Getting the Most from Bug Fixer

**1. Be Specific in Bug Descriptions**
```bash
# Good
/fix-bug "Payment processing throws TypeError on line 245 when discount.amount is undefined"

# Less Good
/fix-bug "payment broken"
```

**2. Answer Questions Thoroughly**
When the plugin asks clarifying questions, provide detailed answers. This prevents back-and-forth and speeds up the fix.

**3. Review Fix Approaches Carefully**
The plugin presents multiple approaches for a reason. Consider:
- Your timeline (urgent vs planned)
- Your risk tolerance (production vs development)
- Your team's capacity (complex vs simple)

**4. Participate in Validation**
Review the validation results actively:
- Check if edge cases make sense
- Verify test coverage is appropriate
- Confirm performance impact is acceptable

**5. Use the Summary for Documentation**
The final summary is perfect for:
- Commit messages
- Pull request descriptions
- Release notes
- Team knowledge sharing

### Common Patterns

**Pattern 1: Emergency Fix**
```bash
/fix-bug "URGENT: Payment processing down in production"
# When asked for approach, choose minimal fix
# Deploy quickly, plan comprehensive fix later
```

**Pattern 2: Quality Fix**
```bash
/fix-bug "Race condition in user session management"
# Choose defensive programming approach
# Take time for comprehensive testing
# Address all edge cases
```

**Pattern 3: Preventive Fix**
```bash
/fix-bug "Potential null pointer in checkout flow"
# Choose refactoring approach
# Eliminate entire class of bugs
# Improve overall code quality
```

### Troubleshooting the Plugin

**Plugin asks too many questions:**
- Provide more detail in initial bug description
- Include reproduction steps upfront

**Agent analysis takes too long:**
- Complex bugs naturally take more time
- The thoroughness prevents future issues
- You can interrupt and provide more context

**Validation finds too many issues:**
- Only issues ≥80% confidence are reported
- Distinguish blocking vs non-blocking issues
- Minor issues can often be addressed in follow-up

**Fix seems too complex:**
- Ask the plugin to explain the approach
- Request a simpler alternative
- Consider if complexity is justified by robustness

## Core Principles

The Bug Fixer plugin follows these core principles:

### 1. Ask Before Acting
- Always clarify bug details before starting
- Get approval for fix approach before implementing
- Don't assume understanding of requirements

### 2. Understand Root Cause
- Don't just fix symptoms
- Trace back to actual root cause
- Consider why the bug was introduced

### 3. Test Thoroughly
- Test the specific bug fix
- Test edge cases comprehensively
- Check for regressions
- Run full test suite

### 4. Prevent Similar Bugs
- Add validation to prevent similar issues
- Use defensive programming techniques
- Document potential pitfalls

### 5. Track Progress
- Use todo lists to track all tasks
- Keep user informed of progress
- Mark tasks complete as you go

### 6. Be Thorough
- Don't rush to implementation
- Consider multiple approaches
- Validate comprehensively
- Document everything

## Advanced Usage

### Custom Agent Configuration

The plugin uses three specialized agents. Each can be used independently if needed:

**Bug Analysis Only:**
Launch a bug-analyzer agent manually to understand a complex issue without fixing it yet.

**Fix Design Only:**
Launch a fix-implementer agent to explore different implementation approaches for a known bug.

**Validation Only:**
Launch test-validator agents to validate an existing fix or changes.

### Integration with CI/CD

The validation phase output can be integrated into CI/CD pipelines:

1. Export validation report
2. Parse test results
3. Check confidence scores
4. Gate deployment on validation approval

### Team Workflows

**Code Review:**
Use the fix summary in pull request descriptions to provide reviewers with complete context.

**Knowledge Sharing:**
The bug analysis reports are excellent documentation for team learning.

**Post-Mortem:**
The comprehensive workflow provides all details needed for incident post-mortems.

## See Also

- [Claude Code Documentation](https://docs.anthropic.com/claude/docs)
- [Plugin Development Guide](../README.md)
- [Other Kobozo Plugins](../)

## Contributing

Found a bug in the bug-fixer? Report it to: yannick@kobozo.eu

## License

Part of the kobozo-plugins collection.

---

**Ready to fix bugs systematically?** Start with `/fix-bug "your bug description"` and let the specialized agents guide you through a comprehensive, high-quality fix process.
