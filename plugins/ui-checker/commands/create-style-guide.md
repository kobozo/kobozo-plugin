---
description: Create or update comprehensive design system documentation by gathering design decisions and generating structured style guide files
---

# Create Style Guide Documentation

You are orchestrating a comprehensive style guide creation/update workflow that builds or maintains design system documentation.

## Core Mission

Create or update design system documentation by:
1. Checking for existing style guides
2. Gathering design system information from the user
3. Creating or updating comprehensive documentation
4. Generating four structured style guide files

## Workflow Overview

This command coordinates two specialized agents:
1. **style-guide-builder** - Creates new style guide documentation from scratch
2. **style-guide-updater** - Updates existing documentation with diffs

## Usage

```
/create-style-guide
```

No arguments needed - the workflow is interactive.

## Execution Phases

### Phase 1: Discovery

**Objective**: Determine if this is new creation or update

**Actions**:
1. Create todo list to track progress:
   - Check for existing style guides
   - Determine creation vs. update
   - Gather design information
   - Generate/update documents
   - Review and finalize

2. Check if style guide documentation already exists:
   - Look for `docs/style-guide/` directory
   - Check for these files:
     - `style-guide.md`
     - `tech-specs.md`
     - `ux-per-feature.md`
     - `ux-rules.md`

3. Determine workflow path:
   - **If no style guide exists**: New creation (use style-guide-builder)
   - **If style guide exists**: Update mode (use style-guide-updater)
   - **If partially exists**: Ask user whether to complete or update

### Phase 2A: New Style Guide Creation

**Objective**: Create comprehensive style guide from scratch

**Actions**:
1. Inform user that you're creating new style guide documentation

2. Launch the **style-guide-builder** agent with these instructions:

```
Please create comprehensive design system documentation for this project.

**Task**: Create a complete style guide suite in `docs/style-guide/`

**Documents to create**:
1. style-guide.md - Core design system (colors, typography, spacing, components)
2. tech-specs.md - Technical implementation details
3. ux-per-feature.md - Feature-specific UX guidelines
4. ux-rules.md - General UX principles

**Process**:

1. Interview the user to gather design system information:
   - Brand colors (primary, secondary, accent, semantic, neutrals)
   - Typography (fonts, sizes, weights, line heights)
   - Spacing system (base unit, scale)
   - Layout (container width, breakpoints, grid)
   - Components (buttons, forms, cards, navigation)
   - Visual assets (logo, icons, images)
   - Effects (shadows, border radius, transitions)
   - Accessibility requirements
   - Project context (framework, CSS approach, audience)

2. Organize the information into a cohesive design system

3. Create all four comprehensive documentation files

4. Return a summary of what was created

Please be thorough in your interview - gather all necessary information before creating the documents. Use TodoWrite to track the interview and creation process.
```

3. Wait for style-guide-builder to complete

4. Review the created documentation

5. Present summary to user:
   - Files created
   - Key design tokens defined
   - Next steps

### Phase 2B: Update Existing Style Guide

**Objective**: Update existing documentation with new information

**Actions**:
1. Inform user that style guide documentation already exists

2. Ask user what they want to update:
   ```
   Your style guide documentation already exists. What would you like to update?

   Options:
   1. Update specific sections (colors, fonts, components, etc.)
   2. Complete refresh (re-gather all information)
   3. Add new sections
   4. Review and improve existing content

   Please describe what you'd like to change.
   ```

3. Launch the **style-guide-updater** agent with these instructions:

```
Please update the existing design system documentation.

**Existing documentation**: `docs/style-guide/`

**User's update request**: {what user wants to update}

**Process**:

1. Read all existing style guide documents:
   - style-guide.md
   - tech-specs.md
   - ux-per-feature.md
   - ux-rules.md

2. Interview the user for updated/new information:
   {If updating colors}: Ask for new color values
   {If updating typography}: Ask for new font details
   {If adding sections}: Gather new content
   {If complete refresh}: Re-gather all information

3. Create detailed diffs showing:
   - What currently exists
   - What will change
   - What will be added
   - What will be removed (if any)

4. Present the diffs to the user for approval

5. After user approves:
   - Apply the changes
   - Preserve existing custom content
   - Maintain document structure
   - Ensure consistency

6. Return a summary of changes made

**IMPORTANT**: Always show diffs and get user approval before making any changes.
```

4. Wait for style-guide-updater to complete

5. Review the changes made

6. Present update summary to user:
   - What was changed
   - Impact analysis
   - Next steps

### Phase 3: Validation

**Objective**: Ensure documentation is complete and usable

**Actions**:
1. Verify all required files exist:
   - `docs/style-guide/style-guide.md`
   - `docs/style-guide/tech-specs.md`
   - `docs/style-guide/ux-per-feature.md`
   - `docs/style-guide/ux-rules.md`

2. Check that files have content (not empty)

3. Confirm with user that documentation meets their needs

### Phase 4: Next Steps Guidance

**Objective**: Help user utilize the style guide

**Actions**:
1. Provide guidance on using the style guide:

```markdown
## Style Guide Documentation Ready! ✅

Your design system documentation is now available in `docs/style-guide/`

### What's Next?

1. **Review the Documentation**
   - Read through each file
   - Verify all information is accurate
   - Add any missing details

2. **Share with Your Team**
   - Commit to version control
   - Share the documentation location
   - Establish it as the source of truth

3. **Start Using It**
   - Reference during development
   - Use in code reviews
   - Validate implementations with `/ui-check`

4. **Keep It Updated**
   - Update when design changes
   - Document new components
   - Run `/create-style-guide` to update

### Recommended Actions

**Immediate**:
- Review all four documents for completeness
- Add any project-specific guidelines
- Include code examples if not already present

**Ongoing**:
- Run `/ui-check [page]` to validate existing pages
- Update style guide as design evolves
- Reference in pull request reviews

### Integration with UI Checks

Now that you have a style guide, you can use `/ui-check` to:
- Validate page implementations
- Score UI compliance (1-10)
- Identify violations
- Ensure consistency

Try it: `/ui-check [your-page-name]`
```

2. Mark all todos as complete

## Output Examples

### New Creation Success

```markdown
# Style Guide Creation Complete ✅

## Files Created

📄 **docs/style-guide/style-guide.md** (12.4 KB)
- Complete color palette (8 colors defined)
- Typography system (6 heading sizes, 3 body sizes)
- Spacing scale (8 values)
- 12 components documented
- Accessibility guidelines

📄 **docs/style-guide/tech-specs.md** (8.1 KB)
- Technology stack documented
- CSS variables defined
- Code examples provided
- Implementation guidelines

📄 **docs/style-guide/ux-per-feature.md** (6.2 KB)
- 5 major features covered
- Form validation patterns
- Loading and error states
- Empty state guidelines

📄 **docs/style-guide/ux-rules.md** (4.8 KB)
- Core UX principles
- Interaction patterns
- Content guidelines
- Responsive design rules

## Key Design Tokens

**Colors**: 8 (Primary, Secondary, Accent, Success, Error, Warning, Info, Neutrals)
**Typography**: Inter font family with 9 sizes
**Spacing**: 8px base unit with 8-value scale
**Components**: 12 documented (Buttons, Forms, Cards, Navigation, etc.)

## Next Steps

1. ✅ Review the documentation
2. 🔄 Share with your team
3. 🚀 Start using `/ui-check` to validate pages
4. 📝 Keep documentation updated as design evolves

Try: `/ui-check dashboard` to validate your first page!
```

### Update Success

```markdown
# Style Guide Update Complete ✅

## Changes Applied

### style-guide.md
- ✅ Updated Color Palette
  - Changed Primary: #1a73e8 → #0066cc
  - Changed Secondary: #34a853 → #00aa44
  - Added Accent: #ff6b35 (new)
- ✅ Added Typography - Font Families section
- ✅ Updated Button specifications

### tech-specs.md
- ✅ Updated CSS Variables
- ✅ Added Tailwind configuration

### ux-per-feature.md
- ⚠️ No changes needed

### ux-rules.md
- ⚠️ No changes needed

## Impact Analysis

**Components Affected**:
- Buttons (color and style changes)
- Typography (new fonts)
- All components using primary/secondary colors

**Recommended Actions**:
1. Review updated documentation
2. Update component implementations
3. Run `/ui-check` on key pages to verify compliance
4. Update design mockups/prototypes

## Testing Recommendation

Run UI checks on these pages to validate the changes:
- `/ui-check dashboard`
- `/ui-check login`
- `/ui-check profile`

Any pages scoring < 8/10 will need updates to match the new style guide.
```

## Best Practices

### Agent Coordination
- Choose the right agent based on context (builder vs. updater)
- Provide clear, complete instructions
- Pass user intent accurately

### User Experience
- Make the process interactive but efficient
- Explain what's happening at each step
- Provide clear next steps

### Documentation Quality
- Ensure comprehensive coverage
- Maintain consistency
- Keep it practical and usable

### Error Handling
- If agent fails: Report and retry with adjustments
- If user input incomplete: Ask follow-up questions
- If files can't be created: Debug permissions/paths

## Important Notes

- **Always use TodoWrite** to track progress through phases
- **Determine creation vs. update early** - it changes the entire workflow
- **Coordinate the right agent** - builder for new, updater for changes
- **Provide clear guidance** - help users understand how to use their new documentation
- **Connect to /ui-check** - emphasize how style guides enable validation
- **Encourage maintenance** - style guides should evolve with the product

## Edge Cases

### Partial Style Guide
If only some files exist:
- Ask user if they want to complete or start fresh
- Preserve existing content if completing
- Offer to migrate if starting fresh

### Empty Files
If files exist but are empty:
- Treat as new creation
- Use style-guide-builder

### Custom Sections
If existing docs have custom sections:
- style-guide-updater will preserve them
- Ensure they're not lost in updates

### Multiple Updates
If user wants to update multiple times:
- Run updater for each update
- Show cumulative changes
- Ensure consistency

### No Docs Folder
If `docs/` doesn't exist:
- Create it as part of the process
- Establish the structure

Your goal is to make creating and maintaining design system documentation easy, ensuring developers have clear guidelines for building consistent, on-brand user interfaces.
