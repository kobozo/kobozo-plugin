# Kobozo Plugins

Custom Claude Code plugin repository for UI development and design system management.

## Overview

This repository contains plugins that extend Claude Code with specialized workflows for building and maintaining consistent, high-quality user interfaces.

## Plugins

### UI Checker

Automated UI validation against style guides using Playwright.

**Commands**:
- `/ui-check [page-name]` - Validate UI implementation against style guide
- `/create-style-guide` - Create or update design system documentation

**Features**:
- Automated Playwright testing with screenshot capture
- Style guide compliance analysis (1-10 scoring)
- Identifies violations requiring fixes (< 8/10)
- Interactive style guide creation and updates
- Comprehensive design system documentation generation

## Installation

1. **Add this marketplace to Claude Code**:
   ```
   /plugin marketplace add /path/to/kobozo-plugins
   ```

2. **Install the ui-checker plugin**:
   ```
   /plugin install ui-checker@kobozo-plugins
   ```

## Usage

### Creating a Style Guide

First, create your design system documentation:

```
/create-style-guide
```

You'll be asked about:
- Brand colors (primary, secondary, accent, semantic)
- Typography (fonts, sizes, weights)
- Spacing system
- Layout and grid
- Component styles
- Visual assets
- UX guidelines

This creates four comprehensive documents in `docs/style-guide/`:
- `style-guide.md` - Core design system
- `tech-specs.md` - Implementation details
- `ux-per-feature.md` - Feature-specific guidelines
- `ux-rules.md` - General UX principles

### Checking UI Compliance

Once you have a style guide, validate your pages:

```
/ui-check dashboard
/ui-check login
/ui-check products/detail
```

The workflow will:
1. Start your application
2. Navigate to the page (with authentication if needed)
3. Capture screenshots
4. Analyze against your style guide
5. Score compliance (1-10 scale)
6. Identify violations (anything < 8/10)
7. Provide actionable fix recommendations

### Updating Your Style Guide

To update existing documentation:

```
/create-style-guide
```

You'll see diffs of proposed changes before they're applied, ensuring you never lose important information.

## Plugin Architecture

### Agents

**playwright-tester**
- Starts applications
- Handles navigation and authentication
- Captures high-quality screenshots
- Supports multiple viewport sizes

**ui-analyzer**
- Reads style guide documentation
- Analyzes screenshots for compliance
- Scores 6 categories: colors, typography, spacing, layout, components, accessibility
- Identifies violations with specific fixes

**style-guide-builder**
- Interviews users for design decisions
- Creates comprehensive documentation
- Generates structured style guide files
- Provides implementation guidance

**style-guide-updater**
- Updates existing documentation
- Shows diffs before applying changes
- Preserves custom content
- Ensures consistency across updates

### Commands

**ui-check**
- Orchestrates Playwright testing and UI analysis
- Coordinates agents to capture and analyze screenshots
- Presents compliance reports with actionable recommendations

**create-style-guide**
- Determines if creating new or updating existing
- Routes to appropriate agent (builder or updater)
- Validates documentation completeness

## Requirements

- Node.js project with package.json
- Playwright (will be installed if needed)
- Style guide documents in `docs/style-guide/`

## Style Guide Structure

```
docs/
└── style-guide/
    ├── style-guide.md      # Core design system reference
    ├── tech-specs.md       # Technical implementation details
    ├── ux-per-feature.md   # Feature-specific UX guidelines
    └── ux-rules.md         # General UX principles
```

## Scoring Criteria

UI compliance is scored 1-10:

- **10/10**: Perfect compliance
- **9/10**: Excellent, minor non-critical deviation
- **8/10**: Good, small improvements needed ✅ **Threshold**
- **7/10**: Acceptable, some violations present ⚠️ **Requires rework**
- **6/10**: Below standard, multiple issues
- **5/10**: Poor, significant problems
- **1-4/10**: Major violations, complete rework needed

**Anything below 8/10 requires rework.**

## Categories Analyzed

1. **Colors** - Brand colors, semantic colors, contrast ratios
2. **Typography** - Fonts, sizes, weights, line heights
3. **Spacing** - Margins, padding, grid adherence
4. **Layout** - Container width, alignment, structure
5. **Components** - Buttons, forms, cards, navigation
6. **Accessibility** - WCAG compliance, touch targets, focus states

## Example Workflow

1. **Initial Setup**:
   ```
   /create-style-guide
   ```
   Answer questions about your design system.

2. **First Check**:
   ```
   /ui-check dashboard
   ```
   Review compliance report and identified violations.

3. **Apply Fixes**:
   Choose to apply fixes automatically or manually based on recommendations.

4. **Verify**:
   ```
   /ui-check dashboard
   ```
   Confirm score is now 8/10 or higher.

5. **Ongoing**:
   - Check new pages before merging
   - Update style guide as design evolves
   - Maintain consistency across features

## Benefits

- **Consistency**: Ensure all pages match your design system
- **Quality**: Catch UI violations before they reach production
- **Documentation**: Maintain comprehensive, up-to-date style guides
- **Automation**: Reduce manual review time with automated checks
- **Collaboration**: Single source of truth for design decisions

## Support

For issues or questions:
- Owner: Yannick De Backer (yannick@kobozo.eu)
- Repository: `/home/yannick/development/kobozo-plugins`

## License

Custom plugin for Kobozo development.
