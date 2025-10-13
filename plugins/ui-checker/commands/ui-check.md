---
description: Automated UI validation - starts your app, navigates to a page, captures screenshots, and analyzes compliance with your style guide, scoring on a 1-10 scale
---

# UI Style Guide Check

You are orchestrating a comprehensive UI validation workflow that tests a page against the project's style guide documentation.

## Core Mission

Validate UI implementation against design system standards by:
1. Starting the application
2. Capturing screenshots with Playwright
3. Analyzing against style guide documents
4. Scoring compliance (1-10 scale)
5. Identifying violations (anything < 8/10)
6. Providing actionable fixes

## Workflow Overview

This command coordinates two specialized agents:
1. **playwright-tester** - Handles automation and screenshot capture
2. **ui-analyzer** - Analyzes screenshots against style guides

## Usage

```
/ui-check [page-name]
```

**Examples**:
- `/ui-check dashboard` - Check the dashboard page
- `/ui-check login` - Check the login page
- `/ui-check products/detail` - Check the product detail page

## Execution Phases

### Phase 1: Initial Setup & Validation

**Objective**: Ensure prerequisites are met

**Actions**:
1. Create todo list to track progress:
   - Validate style guide exists
   - Start application
   - Capture screenshots
   - Analyze UI compliance
   - Generate report
   - Apply fixes (if needed)

2. Check if style guide documentation exists:
   - Look for `docs/style-guide/` directory
   - Verify these files exist:
     - `style-guide.md`
     - `tech-specs.md`
     - `ux-per-feature.md`
     - `ux-rules.md`
   - If missing: Inform user and suggest running `/create-style-guide` first

3. Confirm the page to test:
   - If page argument provided: Use it
   - If no argument: Ask user which page to check

### Phase 2: Launch Playwright Testing

**Objective**: Capture screenshots of the UI

**Actions**:
1. Launch the **playwright-tester** agent with these instructions:

```
Please automate UI testing for the [{page-name}] page:

1. Start the application's development server
2. Launch Playwright browser
3. Navigate to the [{page-name}] page at [URL]
4. Handle authentication if required:
   - If this page requires login, please ask the user for test credentials
   - Implement the login flow
5. Capture high-quality screenshots:
   - Full page screenshot
   - Multiple viewport sizes if applicable (mobile, tablet, desktop)
6. Save screenshots to `ui-tests/screenshots/`
7. Report back with:
   - Screenshot file paths
   - Page information
   - Any errors encountered

Return the following information:
- Screenshot file paths (I need these for analysis)
- Page URL tested
- Viewport sizes used
- Any issues encountered
```

2. Wait for playwright-tester to complete
3. Verify screenshots were created successfully

### Phase 3: UI Analysis

**Objective**: Analyze screenshots against style guide

**Actions**:
1. Launch the **ui-analyzer** agent with these instructions:

```
Please analyze the UI screenshots against our style guide documentation:

**Screenshots to analyze**:
{List screenshot paths from playwright-tester}

**Style guide location**: `docs/style-guide/`

**Page context**: [{page-name}]

Please perform a comprehensive analysis:

1. Read all style guide documents:
   - style-guide.md
   - tech-specs.md
   - ux-per-feature.md
   - ux-rules.md

2. Analyze the screenshots against the style guide:
   - Colors (primary, secondary, semantic, contrast)
   - Typography (fonts, sizes, weights, line heights)
   - Spacing (margins, padding, grid adherence)
   - Layout (container width, alignment, structure)
   - Components (buttons, forms, cards, navigation)
   - Accessibility (contrast, touch targets, focus states)

3. Score each category on a 1-10 scale

4. Identify ALL violations (anything scoring less than 8/10)

5. Provide specific, actionable recommendations for fixes

Please return a comprehensive compliance report with:
- Overall score
- Detailed scores per category
- List of all violations with priority levels
- Specific fix recommendations with code examples
- Summary of required changes
```

2. Wait for ui-analyzer to complete
3. Review the analysis report

### Phase 4: Results Presentation

**Objective**: Present findings to the user

**Actions**:
1. Display the compliance report from ui-analyzer
2. Highlight the overall score prominently
3. Emphasize violations (< 8/10) that require fixes
4. Organize findings by priority:
   - Critical issues
   - High priority issues
   - Medium priority issues
   - Low priority improvements

### Phase 5: Fix Recommendations

**Objective**: Help user address violations

**Actions**:
1. If overall score >= 8/10:
   - Congratulate user on good compliance
   - List any minor improvements as optional
   - Mark task as complete

2. If overall score < 8/10:
   - Clearly state that rework is required
   - Ask user how they want to proceed:
     - **Option A**: Apply fixes automatically
       - You will update the code based on recommendations
     - **Option B**: Review violations first
       - User will fix manually
     - **Option C**: Generate detailed fix instructions
       - Provide step-by-step guide

3. If user chooses automatic fixes:
   - Prioritize fixes by severity
   - Update component files
   - Apply style changes
   - Re-run `/ui-check` to verify fixes

### Phase 6: Follow-up

**Objective**: Ensure issues are resolved

**Actions**:
1. If fixes were applied:
   - Offer to re-run the check to verify compliance
   - Compare before/after scores

2. Provide summary:
   - What was checked
   - What violations were found
   - What actions were taken
   - Current compliance status

3. Mark all todos as complete

## Output Example

```markdown
# UI Check: Dashboard Page

## Status: ⚠️ Requires Rework

**Overall Score**: 7.2/10

---

## Agent Reports

### 1. Playwright Testing ✅
- Application started at http://localhost:3000
- Navigated to /dashboard
- Screenshots captured:
  - `ui-tests/screenshots/dashboard-desktop-1920x1080.png`
  - `ui-tests/screenshots/dashboard-tablet-768x1024.png`
  - `ui-tests/screenshots/dashboard-mobile-375x667.png`

### 2. UI Analysis ⚠️

**Detailed Scores**:
- ✅ Colors: 9/10 (Excellent)
- ⚠️ Typography: 7/10 (Needs improvement)
- ⚠️ Spacing: 6/10 (Below standard)
- ✅ Layout: 8/10 (Good)
- ⚠️ Components: 7/10 (Needs improvement)
- ✅ Accessibility: 9/10 (Excellent)

**Violations Found**: 8

#### Critical Priority
- None

#### High Priority
1. **Typography - Heading sizes inconsistent**
   - Current: H1 is 32px, should be 48px per style guide
   - Fix: Update `.dashboard-title` to `font-size: 48px`

2. **Spacing - Card padding incorrect**
   - Current: Cards have 12px padding, should be 24px
   - Fix: Update `.card` to `padding: 24px`

#### Medium Priority
3. **Button - Border radius doesn't match**
   - Current: 4px, should be 8px
   - Fix: Update button styles to `border-radius: 8px`

{Additional violations...}

---

## Recommendations

### Immediate Actions Required
1. Fix heading typography (H1 size)
2. Correct card padding
3. Update button border radius

### Estimated Effort
- Quick fixes: ~15 minutes
- Total violations: 8 issues

---

## Next Steps

How would you like to proceed?

1. **Apply fixes automatically** - I'll update the code for you
2. **Review violations first** - I'll provide detailed instructions
3. **Manual fixes** - You'll handle the updates

Please choose an option or ask questions about specific violations.
```

## Best Practices

### Coordination
- Keep both agents informed of context
- Pass information between agents clearly
- Don't duplicate work

### Communication
- Keep user informed of progress
- Show agent outputs
- Explain next steps clearly

### Error Handling
- If playwright-tester fails: Report and suggest solutions
- If style guide missing: Suggest creating it first
- If screenshots can't be captured: Debug with user

### Thoroughness
- Don't skip violations
- Be specific about fixes
- Provide code examples
- Prioritize realistically

## Important Notes

- **Always use TodoWrite** to track progress through phases
- **Coordinate agents efficiently** - launch when needed, wait for results
- **Present results clearly** - users need to understand violations
- **Score threshold is 8/10** - anything below requires rework
- **Be actionable** - provide specific fixes, not vague suggestions
- **Offer to help** - don't just report problems, help solve them

## Edge Cases

### No Style Guide
If style guide doesn't exist:
- Inform user immediately
- Don't proceed with testing
- Suggest: `/create-style-guide` first

### Authentication Required
If page needs login:
- playwright-tester will ask for credentials
- Pass credentials securely
- Handle session management

### Multiple Pages
If user wants to check multiple pages:
- Offer to run checks sequentially
- Compare results across pages
- Generate comparative report

### Perfect Score
If all categories score 10/10:
- Celebrate!
- Suggest periodic checks
- Recommend documenting patterns

Your goal is to provide developers with clear, actionable feedback on UI compliance, making it easy to maintain design system standards across the application.
