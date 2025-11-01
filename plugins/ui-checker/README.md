# UI Checker Plugin

> Automated UI validation and creation - validate against style guides with Playwright, create beautiful React components with Tailwind CSS, and manage design systems following industry best practices.

**Version:** 2.0.0
**Author:** Yannick De Backer (yannick@kobozo.eu)

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [MCP Server Requirements](#mcp-server-requirements)
- [Commands](#commands)
  - [/ui-check](#ui-check)
  - [/create-style-guide](#create-style-guide)
  - [/create-component](#create-component)
  - [/setup-design-system](#setup-design-system)
- [Agents](#agents)
  - [playwright-tester](#playwright-tester)
  - [ui-analyzer](#ui-analyzer)
  - [style-guide-builder](#style-guide-builder)
  - [style-guide-updater](#style-guide-updater)
  - [component-generator](#component-generator)
  - [design-system-manager](#design-system-manager)
- [Workflow Examples](#workflow-examples)
- [Configuration](#configuration)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Advanced Usage](#advanced-usage)

---

## Overview

The UI Checker plugin is a comprehensive solution for maintaining design system consistency and accelerating UI development. It combines automated UI validation with intelligent component generation, ensuring your application adheres to your design standards while helping you build beautiful, accessible interfaces faster.

### What It Does

1. **Validates UI Implementations** - Automatically checks your pages against style guide documentation using Playwright for screenshot capture and AI-powered analysis
2. **Creates Style Guides** - Interviews you about your design decisions and generates comprehensive documentation (four-document suite)
3. **Generates Components** - Creates production-ready React + TypeScript components that follow your design system with Tailwind CSS and Shadcn UI
4. **Manages Design Systems** - Sets up semantic design tokens, Tailwind configuration, CSS variables, and supports dark mode out of the box

### Why Use It?

- **Maintain Consistency**: Ensure every page follows your design standards with automated validation
- **Catch Issues Early**: Identify design violations before they reach production with 1-10 scoring across 6 categories
- **Speed Up Development**: Generate components instead of writing them from scratch - save hours of boilerplate coding
- **Document Design Decisions**: Keep a single source of truth for your design system with version-controlled style guides
- **Enforce Standards**: Automated validation with clear scoring (1-10 scale) and actionable fix recommendations
- **Production Ready**: All generated components are TypeScript, accessible, responsive, and follow best practices

---

## Key Features

### Automated UI Validation

- **Playwright Integration**: Captures screenshots of your running application
- **Style Guide Comparison**: Analyzes screenshots against documented design standards
- **Comprehensive Scoring**: Rates compliance across colors, typography, spacing, layout, components, and accessibility
- **Actionable Feedback**: Provides specific fix recommendations with code examples
- **Violation Detection**: Flags any category scoring below 8/10 for rework

### Design System Management

- **Style Guide Creation**: Interactive interview process to document your design decisions
- **Version Control**: Update existing guides with diff-based review and approval
- **Four Document Suite**: Creates style-guide.md, tech-specs.md, ux-per-feature.md, and ux-rules.md
- **Semantic Tokens**: Sets up CSS variables and Tailwind configuration from your style guide
- **Dark Mode Support**: Automatic light/dark theme support

### Component Generation

- **React + TypeScript**: Production-ready components with full type safety
- **Tailwind CSS**: Utility-first styling with semantic design tokens
- **Shadcn UI Integration**: Built on industry-standard component patterns
- **Variant Support**: CVA (class-variance-authority) for managing component variants
- **Responsive Design**: Mobile-first approach with breakpoint support
- **Accessibility Built-In**: ARIA attributes, keyboard navigation, focus states

---

## Installation

### Prerequisites

- **Claude Code** CLI installed and configured
- **Node.js** 18+ and pnpm/npm/yarn
- **A web application project** (React/Next.js recommended for component generation)
- **Running application** (for UI validation - needs a development server)

### Install the Plugin

This plugin is part of the kobozo-plugins collection:

```bash
# Clone the kobozo-plugins repository
git clone https://github.com/yannickdb/kobozo-plugins.git

# Navigate to Claude Code plugins directory
cd ~/.config/claude/plugins

# Create a symlink or copy the ui-checker plugin
ln -s /path/to/kobozo-plugins/plugins/ui-checker ./ui-checker

# Or copy the directory
cp -r /path/to/kobozo-plugins/plugins/ui-checker ./ui-checker
```

### Verify Installation

```bash
# List installed plugins
claude plugins list

# You should see:
# ui-checker v2.0.0 - Automated UI validation and creation

# Test a command
/create-style-guide
```

---

## MCP Server Requirements

The UI Checker plugin requires the Playwright MCP server for automated browser testing and screenshot capture.

### Automatic Setup

The plugin includes automatic configuration for the Playwright MCP server in `plugin.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "pnpm",
      "args": ["dlx", "@playwright/mcp@latest"]
    }
  }
}
```

### Manual Installation (if needed)

```bash
# Install Playwright globally
pnpm add -g @playwright/test

# Install browser binaries
pnpm exec playwright install
```

### Verification

The `playwright-tester` agent will verify Playwright installation when first used and guide you through setup if needed.

---

## Commands

### /ui-check

**Description:** Automated UI validation - starts your app, navigates to a page, captures screenshots, and analyzes compliance with your style guide, scoring on a 1-10 scale.

#### Usage

```bash
/ui-check [page-name]
```

#### Examples

```bash
# Check the dashboard page
/ui-check dashboard

# Check the login page
/ui-check login

# Check a nested page
/ui-check products/detail
```

#### Workflow

1. **Prerequisites Check**: Verifies style guide documentation exists
2. **Screenshot Capture**: Launches Playwright to capture UI screenshots
3. **Analysis**: Compares screenshots against style guide requirements
4. **Scoring**: Rates compliance (1-10) across multiple categories
5. **Violation Detection**: Identifies issues scoring below 8/10
6. **Fix Recommendations**: Provides specific, actionable fixes

#### Output

```markdown
# UI Check: Dashboard Page

## Status: ⚠️ Requires Rework

**Overall Score**: 7.2/10

## Detailed Scores
- ✅ Colors: 9/10 (Excellent)
- ⚠️ Typography: 7/10 (Needs improvement)
- ⚠️ Spacing: 6/10 (Below standard)
- ✅ Layout: 8/10 (Good)
- ⚠️ Components: 7/10 (Needs improvement)
- ✅ Accessibility: 9/10 (Excellent)

## Violations Found: 8

### High Priority
1. **Typography - Heading sizes inconsistent**
   - Current: H1 is 32px, should be 48px per style guide
   - Fix: Update `.dashboard-title` to `font-size: 48px`

2. **Spacing - Card padding incorrect**
   - Current: Cards have 12px padding, should be 24px
   - Fix: Update `.card` to `padding: 24px`

[... additional violations]
```

#### Categories Analyzed

1. **Colors** (Primary, secondary, semantic, contrast)
2. **Typography** (Fonts, sizes, weights, line heights)
3. **Spacing** (Margins, padding, grid adherence)
4. **Layout** (Container width, alignment, structure)
5. **Components** (Buttons, forms, cards, navigation)
6. **Accessibility** (Contrast, touch targets, focus states)

#### Options After Check

- **Apply fixes automatically**: Let the agent update your code
- **Review violations first**: Get detailed instructions
- **Manual fixes**: Handle updates yourself

---

### /create-style-guide

**Description:** Create or update comprehensive design system documentation by gathering design decisions and generating structured style guide files.

#### Usage

```bash
/create-style-guide
```

No arguments needed - the workflow is interactive.

#### Workflow

1. **Discovery**: Checks if style guide documentation already exists
2. **Interview**: Asks about your design decisions (colors, fonts, spacing, etc.)
3. **Generation**: Creates four comprehensive documentation files
4. **Review**: Presents summary and next steps

#### Created Files

```
docs/style-guide/
├── style-guide.md       # Core design system reference
├── tech-specs.md        # Technical implementation details
├── ux-per-feature.md    # Feature-specific UX guidelines
└── ux-rules.md          # General UX principles
```

#### Interview Topics

**Brand Colors**
- Primary, secondary, accent colors
- Semantic colors (success, error, warning, info)
- Neutral colors (text, background, borders)

**Typography**
- Font families (headings, body, monospace)
- Font sizes (h1-h6, body text, captions)
- Font weights and line heights

**Spacing System**
- Base unit (4px or 8px grid)
- Spacing scale (xs, sm, md, lg, xl)

**Layout & Grid**
- Container max width
- Breakpoints (mobile, tablet, desktop)
- Grid columns and gutters

**Components**
- Buttons (variants, sizes, states)
- Forms (inputs, labels, validation)
- Cards (shadows, borders, padding)
- Navigation patterns

**Visual Assets**
- Logo usage guidelines
- Icon library
- Image guidelines

**Effects & Motion**
- Shadows (levels and definitions)
- Border radius values
- Transitions and animations

**Accessibility**
- Contrast requirements (WCAG level)
- Focus indicators
- Touch target sizes

**Project Context**
- Framework/stack (React, Vue, etc.)
- CSS approach (Tailwind, modules, etc.)
- Target audience

#### Example Output

```markdown
## Style Guide Documentation Created

### Files Created

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

📄 **docs/style-guide/ux-per-feature.md** (6.2 KB)
- 5 major features covered
- Form validation patterns
- Loading and error states

📄 **docs/style-guide/ux-rules.md** (4.8 KB)
- Core UX principles
- Interaction patterns
- Content guidelines

### Next Steps
1. Review the documentation
2. Share with your team
3. Start using `/ui-check` to validate pages
```

#### Updating Existing Style Guides

If a style guide already exists, the command will:
1. Read existing documentation
2. Ask what you want to update
3. Show diffs of proposed changes
4. Get your approval before applying changes
5. Preserve custom sections you've added

---

### /create-component

**Description:** Create beautiful, reusable React components following your style guide with Tailwind CSS and semantic design tokens.

#### Usage

```bash
/create-component <component-name> [--variant=button|card|input|form] [--with-variants]
```

#### Examples

```bash
# Create a feature card component
/create-component feature-card

# Create a card component with variant suggestions
/create-component user-profile-card --variant=card

# Create a button with multiple variants
/create-component custom-button --with-variants
```

#### Workflow

1. **Style Guide Analysis**: Reads your style guide to extract design tokens
2. **Component Generation**: Creates component with variants using CVA
3. **Integration**: Exports from `components/ui/index.ts`
4. **Documentation**: Provides usage examples and props documentation

#### Features

- **Semantic Design Tokens**: Uses `bg-primary` instead of `bg-blue-500`
- **Responsive Design**: Mobile-first with breakpoint support
- **Accessibility**: ARIA attributes, keyboard navigation, focus states
- **TypeScript**: Full type safety with interfaces
- **Variants**: Size, color, and state variants using CVA
- **Animations**: Smooth transitions and hover effects

#### Example Output

```tsx
// components/ui/feature-card.tsx
import { LucideIcon } from "lucide-react"
import { Card, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"

interface FeatureCardProps {
  icon: LucideIcon
  title: string
  description: string
  gradient?: boolean
}

export function FeatureCard({
  icon: Icon,
  title,
  description,
  gradient = false
}: FeatureCardProps) {
  return (
    <Card hover gradient={gradient}>
      <CardHeader>
        <div className="mb-4 inline-flex h-12 w-12 items-center justify-center rounded-lg bg-primary/10">
          <Icon className="h-6 w-6 text-primary" />
        </div>
        <CardTitle className="text-xl">{title}</CardTitle>
        <CardDescription>{description}</CardDescription>
      </CardHeader>
    </Card>
  )
}

// Usage
import { Zap } from "lucide-react"
import { FeatureCard } from "@/components/ui/feature-card"

<FeatureCard
  icon={Zap}
  title="Lightning Fast"
  description="Built for speed with optimized performance"
  gradient
/>
```

#### Supported Component Types

- **Buttons**: With variants (default, destructive, outline, ghost)
- **Cards**: With hover effects and gradients
- **Forms**: Inputs with labels, errors, help text
- **Navigation**: Menus, tabs, breadcrumbs
- **Data Display**: Tables, lists, badges
- **Feedback**: Alerts, toasts, modals

---

### /setup-design-system

**Description:** Set up complete design system with semantic tokens, Tailwind configuration, and CSS variables from your style guide.

#### Usage

```bash
/setup-design-system [--from-style-guide=docs/style-guide.md]
```

#### Workflow

1. **Style Guide Analysis**: Reads your style guide documentation
2. **Token Extraction**: Extracts colors, typography, spacing, etc.
3. **CSS Variables**: Generates `src/index.css` with design tokens
4. **Tailwind Config**: Updates `tailwind.config.ts` with token integration
5. **Utilities**: Creates `lib/utils.ts` and helper functions
6. **Dark Mode**: Sets up theme toggle component

#### Generated Files

```
src/
├── index.css                    # CSS variables and design tokens
├── lib/
│   └── utils.ts                 # Utility functions (cn())
├── types/
│   └── design-system.ts         # TypeScript types
└── components/
    └── theme-toggle.tsx         # Dark mode toggle

tailwind.config.ts               # Tailwind configuration
```

#### Example CSS Variables

```css
:root {
  /* Brand Colors */
  --primary: 222.2 47.4% 11.2%;
  --primary-foreground: 210 40% 98%;

  --secondary: 210 40% 96.1%;
  --secondary-foreground: 222.2 47.4% 11.2%;

  /* Semantic Colors */
  --background: 0 0% 100%;
  --foreground: 222.2 84% 4.9%;
  --destructive: 0 84.2% 60.2%;
  --muted: 210 40% 96.1%;

  /* Typography */
  --font-sans: "Inter", sans-serif;
  --font-mono: "JetBrains Mono", monospace;

  /* Spacing & Sizing */
  --radius: 0.5rem;

  /* Animations */
  --transition-fast: 150ms;
  --transition-base: 300ms;
}

.dark {
  --background: 222.2 84% 4.9%;
  --foreground: 210 40% 98%;
  /* ... dark mode overrides */
}
```

#### Benefits

- **Single Source of Truth**: All design tokens defined in one place
- **Easy Theme Switching**: Light/dark mode with CSS variables
- **Type Safety**: TypeScript types for all tokens
- **Maintainability**: Update once, changes reflect everywhere
- **Tailwind Integration**: Seamless use of design tokens in utility classes

---

## Agents

The UI Checker plugin uses six specialized agents, each focused on a specific task.

### playwright-tester

**Color:** Blue
**Model:** Sonnet
**Tools:** Bash, Read, Write, Edit, Glob, Grep, TodoWrite, WebFetch

**Purpose:** Automates UI testing with Playwright - starts applications, navigates pages, handles authentication, and captures screenshots for style guide validation.

**Key Responsibilities:**
- Start development server
- Launch Playwright browser
- Navigate to requested pages
- Handle authentication flows
- Capture high-quality screenshots
- Support multiple viewport sizes

**Workflow:**
1. Check if Playwright is installed
2. Start application development server
3. Handle authentication if required
4. Navigate to target page
5. Capture full-page screenshots
6. Save screenshots to `ui-tests/screenshots/`
7. Report screenshot paths and metadata

**Output Example:**
```markdown
## Playwright Test Execution Report

### Application Status
- Server: Running at http://localhost:3000
- Status: Ready

### Page Information
- URL: http://localhost:3000/dashboard
- Title: Dashboard - MyApp
- Viewport: 1920x1080

### Screenshots Captured
1. ui-tests/screenshots/dashboard-desktop-1920x1080.png
2. ui-tests/screenshots/dashboard-tablet-768x1024.png
3. ui-tests/screenshots/dashboard-mobile-375x667.png

### Authentication
- Required: Yes
- Status: Success
- User: test@example.com
```

---

### ui-analyzer

**Color:** Purple
**Model:** Sonnet
**Tools:** Read, Write, TodoWrite, Glob

**Purpose:** Analyzes UI screenshots against style guide documentation, scoring compliance on a 1-10 scale and identifying violations that need to be fixed.

**Key Responsibilities:**
- Read all style guide documents
- Analyze screenshots in detail
- Compare implementation vs. requirements
- Score each category (1-10 scale)
- Identify violations (< 8/10)
- Provide specific fix recommendations

**Analysis Categories:**
1. **Colors**: Brand colors, semantic colors, contrast ratios
2. **Typography**: Font families, sizes, weights, line heights
3. **Spacing**: Margins, padding, grid adherence
4. **Layout**: Container width, alignment, responsive behavior
5. **Components**: Buttons, forms, cards, navigation styles
6. **Accessibility**: WCAG compliance, touch targets, focus states

**Scoring Scale:**
- **10/10**: Perfect compliance, no issues
- **9/10**: Excellent, minor non-critical deviation
- **8/10**: Good, small improvements needed
- **7/10**: Acceptable, some violations present
- **6/10**: Below standard, multiple issues
- **5/10**: Poor, significant problems
- **1-4/10**: Major violations, requires complete rework

**Violation Priority Levels:**
- **Critical**: Branding errors, accessibility failures
- **High**: Obvious visual inconsistencies
- **Medium**: Minor spacing/alignment issues
- **Low**: Nice-to-have improvements

---

### style-guide-builder

**Color:** Green
**Model:** Sonnet
**Tools:** Write, Read, Glob, TodoWrite, WebFetch

**Purpose:** Creates comprehensive design system documentation by interviewing users about colors, fonts, and design decisions, then generating structured style guide documents.

**Key Responsibilities:**
- Interview user about design decisions
- Gather design assets (colors, fonts, logos)
- Organize information into structured documents
- Create four comprehensive style guide files

**Interview Process:**
- Brand colors (primary, secondary, accent, semantic, neutrals)
- Typography (fonts, sizes, weights, line heights)
- Spacing system (base unit, scale)
- Layout (container, grid, breakpoints)
- Components (buttons, forms, cards, navigation)
- Visual assets (logo, icons, images)
- Effects (shadows, border radius, transitions)
- Accessibility requirements
- Project context (framework, CSS approach, audience)

**Generated Documents:**

1. **style-guide.md**
   - Color palette
   - Typography system
   - Spacing scale
   - Component specifications
   - Accessibility guidelines

2. **tech-specs.md**
   - Technology stack
   - CSS variables
   - Code examples
   - Implementation guidelines

3. **ux-per-feature.md**
   - Feature-specific guidelines
   - Form validation patterns
   - Loading and error states
   - Empty state guidelines

4. **ux-rules.md**
   - Core UX principles
   - Interaction patterns
   - Content guidelines
   - Responsive design rules

---

### style-guide-updater

**Color:** Orange
**Model:** Sonnet
**Tools:** Read, Write, Edit, Glob, TodoWrite

**Purpose:** Updates existing style guide documents by comparing current content with proposed changes, showing diffs, and intelligently merging updates while preserving existing information.

**Key Responsibilities:**
- Read existing style guide documents
- Gather new/updated information from user
- Compare existing vs. proposed changes
- Show clear diffs to user
- Get approval before making changes
- Merge updates while preserving custom content

**Workflow:**
1. Read existing documentation
2. Ask user what to update
3. Generate detailed diffs
4. Present changes for approval
5. Apply approved changes
6. Validate updates
7. Provide change summary

**Diff Presentation:**
```markdown
## Proposed Changes to Style Guide Documentation

### File: style-guide.md

#### Section: Color Palette

**Change Type**: Modification

**Current Content**:
Primary Color: #1a73e8 (Blue)
Secondary Color: #34a853 (Green)

**Proposed Content**:
Primary Color: #0066cc (Deep Blue)
Secondary Color: #00aa44 (Emerald Green)
Accent Color: #ff6b35 (Coral) [NEW]

**Summary of Changes**:
- Primary color changing from #1a73e8 to #0066cc
- Secondary color changing from #34a853 to #00aa44
- Adding new Accent color #ff6b35
```

**Smart Merging:**
- Preserves custom sections added by users
- Maintains existing formatting style
- Updates cross-references if section names change
- Never deletes content without explicit approval

---

### component-generator

**Color:** Cyan
**Model:** Sonnet
**Tools:** Bash, Read, Write, Edit, Glob, Grep, TodoWrite

**Purpose:** Generate beautiful, reusable React components following style guide principles with Tailwind CSS, Shadcn UI, and design system tokens.

**Key Responsibilities:**
- Read style guide for design tokens
- Create components with variants (CVA)
- Use semantic design tokens (not hardcoded colors)
- Implement responsive design (mobile-first)
- Add accessibility features
- Generate usage examples and documentation

**Technology Stack:**
- React with TypeScript
- Tailwind CSS for styling
- Shadcn UI for base components
- Lucide React for icons
- CVA for variant management

**Design Principles:**
- **Semantic Tokens**: Use `bg-primary` not `bg-blue-500`
- **Responsive**: Mobile-first approach
- **Accessible**: ARIA, keyboard navigation, focus states
- **Composable**: Small, reusable components
- **Type-Safe**: Full TypeScript support

**Example Component:**
```tsx
import { cva, type VariantProps } from "class-variance-authority"
import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/90",
        destructive: "bg-destructive text-destructive-foreground hover:bg-destructive/90",
        outline: "border border-input bg-background hover:bg-accent",
        ghost: "hover:bg-accent hover:text-accent-foreground",
      },
      size: {
        default: "h-10 px-4 py-2",
        sm: "h-9 rounded-md px-3",
        lg: "h-11 rounded-md px-8",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {}

export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, ...props }, ref) => {
    return (
      <button
        className={cn(buttonVariants({ variant, size, className }))}
        ref={ref}
        {...props}
      />
    )
  }
)
```

---

### design-system-manager

**Color:** Purple
**Model:** Sonnet
**Tools:** Bash, Read, Write, Edit, Glob, Grep, TodoWrite

**Purpose:** Set up and manage design systems with semantic tokens, Tailwind configuration, and CSS variables following style guide principles.

**Key Responsibilities:**
- Set up semantic design tokens in CSS variables
- Configure Tailwind CSS with design system integration
- Create reusable design tokens (colors, typography, spacing)
- Ensure consistency across components
- Support light/dark mode themes

**Design Token Categories:**

1. **Color System**
   - Brand colors (primary, secondary, accent)
   - Semantic colors (success, error, warning, info)
   - UI colors (background, foreground, muted)
   - State colors (hover, active, disabled)

2. **Typography Scale**
   - Font families (sans, serif, mono)
   - Font sizes (xs, sm, base, lg, xl, 2xl, 3xl, 4xl)
   - Font weights (normal, medium, semibold, bold)
   - Line heights (tight, normal, relaxed, loose)

3. **Spacing System**
   - Based on 8px or 4px grid
   - Scale: 1, 2, 3, 4, 5, 6, 8, 10, 12, 16
   - Named spacing (xs, sm, md, lg, xl)

4. **Shadow System**
   - sm, base, md, lg, xl variants
   - Consistent elevation system

**Output Files:**
- `src/index.css` - CSS variables and design tokens
- `tailwind.config.ts` - Tailwind configuration
- `src/lib/utils.ts` - Utility functions
- `src/types/design-system.ts` - TypeScript types
- `src/components/theme-toggle.tsx` - Dark mode toggle

**Benefits:**
- Single source of truth for design tokens
- Easy theme switching (light/dark)
- Type-safe token usage
- Maintainable and scalable
- Seamless Tailwind integration

---

## Real-World Use Cases

### Use Case 1: Startup Building MVP

**Scenario**: You're building an MVP and want to establish design consistency early.

**Solution**:
1. Run `/create-style-guide` to document your brand colors, fonts, and spacing
2. Use `/setup-design-system` to generate CSS variables and Tailwind config
3. Generate UI components with `/create-component` for buttons, cards, forms
4. Validate each page with `/ui-check` as you build features
5. Ensure 8+ scores before shipping to production

**Benefits**: Consistent UI from day one, faster development with reusable components, automated validation prevents design drift.

### Use Case 2: Agency Managing Multiple Clients

**Scenario**: Design agency maintaining several client projects with different brand guidelines.

**Solution**:
1. Create separate style guides per client: `/create-style-guide`
2. Use `/setup-design-system` to generate client-specific design tokens
3. Generate branded components with `/create-component`
4. Run `/ui-check` before client reviews to catch violations
5. Update style guides as client feedback comes in

**Benefits**: Maintain multiple brand identities, catch issues before client reviews, speed up handoffs with documentation.

### Use Case 3: Enterprise Design System Team

**Scenario**: Large company standardizing design across 10+ product teams.

**Solution**:
1. Document comprehensive design system: `/create-style-guide`
2. Set up shared design tokens: `/setup-design-system`
3. Create component library: Multiple `/create-component` calls
4. Product teams use `/ui-check` in CI/CD to validate compliance
5. Design system team uses `/create-style-guide` to update standards

**Benefits**: Enforce consistency across teams, automated compliance checking, reduce design review time, keep documentation up to date.

### Use Case 4: Redesign/Rebrand Project

**Scenario**: Existing application needs a complete visual refresh.

**Solution**:
1. Document new brand guidelines: `/create-style-guide`
2. Update design system: `/setup-design-system`
3. Run `/ui-check` on existing pages to identify violations (will score low)
4. Generate new components: `/create-component` with new tokens
5. Validate updates: Re-run `/ui-check` to verify improvements
6. Track progress by watching scores increase from 4-5 to 9-10

**Benefits**: Systematic approach to redesign, clear progress metrics, identify all pages needing updates.

---

## Workflow Examples

### Example 1: New Project Setup

**Goal:** Set up a design system and create components from scratch.

```bash
# Step 1: Create style guide documentation
/create-style-guide
# Answer questions about your brand colors, fonts, spacing, etc.

# Step 2: Set up design system
/setup-design-system
# Generates CSS variables, Tailwind config, and utilities

# Step 3: Create your first component
/create-component primary-button --with-variants
# Generates a button component with variants

# Step 4: Validate a page
/ui-check homepage
# Ensures your implementation matches the style guide
```

### Example 2: Existing Project Audit

**Goal:** Validate existing pages against a style guide.

```bash
# Create or update style guide to match current design
/create-style-guide

# Check key pages
/ui-check dashboard
/ui-check login
/ui-check settings

# Review violations and apply fixes
# The agent will offer to update code automatically
```

### Example 3: Component Library Development

**Goal:** Build a complete component library.

```bash
# Set up design system first
/setup-design-system

# Create base components
/create-component button --with-variants
/create-component input
/create-component card
/create-component modal

# Create feature components
/create-component feature-card
/create-component pricing-card
/create-component testimonial-card

# Validate all components
/ui-check component-showcase
```

### Example 4: Design System Update

**Goal:** Update colors across the design system.

```bash
# Update style guide with new colors
/create-style-guide
# Select "Update specific sections" -> "Colors"

# Review diff and approve changes
# Agent shows before/after comparison

# Update design system tokens
/setup-design-system

# Validate pages against new colors
/ui-check dashboard
# Identifies components that need color updates
```

---

## Configuration

### Plugin Configuration

The plugin is configured via `plugin.json`:

```json
{
  "name": "ui-checker",
  "version": "2.0.0",
  "description": "Automated UI validation and creation",
  "author": {
    "name": "Yannick De Backer",
    "email": "yannick@kobozo.eu"
  },
  "mcpServers": {
    "playwright": {
      "command": "pnpm",
      "args": ["dlx", "@playwright/mcp@latest"]
    }
  }
}
```

### Style Guide Location

By default, style guides are created in:

```
docs/style-guide/
├── style-guide.md
├── tech-specs.md
├── ux-per-feature.md
└── ux-rules.md
```

### Screenshot Storage

Screenshots are saved to:

```
ui-tests/screenshots/
├── [page-name]-desktop-1920x1080.png
├── [page-name]-tablet-768x1024.png
└── [page-name]-mobile-375x667.png
```

### Component Output

Components are created in:

```
src/components/ui/
├── button.tsx
├── card.tsx
├── input.tsx
└── index.ts
```

---

## Best Practices

### Style Guide Creation

1. **Be Specific**: Provide exact color hex codes, font sizes, and spacing values
2. **Include Examples**: Document real use cases for each component
3. **Document Decisions**: Explain why certain choices were made
4. **Keep It Updated**: Update the style guide as your design evolves
5. **Version Control**: Commit style guide changes with code changes

### UI Validation

1. **Check Early and Often**: Run `/ui-check` during development, not just at the end
2. **Fix High Priority First**: Address critical and high-priority violations before medium/low
3. **Aim for 8+**: Scores below 8/10 require rework
4. **Test Multiple Viewports**: Check mobile, tablet, and desktop views
5. **Re-validate After Fixes**: Run `/ui-check` again after applying fixes

### Component Generation

1. **Start with Base Components**: Create button, input, card, etc. first
2. **Use Semantic Tokens**: Never hardcode colors (e.g., `bg-blue-500`)
3. **Make It Composable**: Prefer small, reusable components
4. **Type Everything**: Use TypeScript interfaces for props
5. **Document Usage**: Include examples in component files

### Design System Management

1. **Single Source of Truth**: Use CSS variables for all design tokens
2. **Plan for Dark Mode**: Set up theme support from the start
3. **Follow Naming Conventions**: Use semantic names (primary, destructive, muted)
4. **Test Both Themes**: Validate light and dark modes
5. **Keep Tokens Minimal**: Start with essentials, add as needed

---

## Troubleshooting

### Playwright Not Found

**Problem:** Error when running `/ui-check`: Playwright not installed

**Solution:**
```bash
# Install Playwright
pnpm add -D @playwright/test

# Install browser binaries
pnpm exec playwright install

# Verify installation
pnpm exec playwright --version
```

### Style Guide Not Found

**Problem:** `/ui-check` reports missing style guide

**Solution:**
```bash
# Create style guide first
/create-style-guide

# Verify files exist
ls docs/style-guide/
```

### Application Won't Start

**Problem:** Playwright can't start your application

**Solution:**
1. Check `package.json` for the correct dev script
2. Ensure port 3000 is available (or specify custom port)
3. Verify no other instance is running
4. Check for errors in your application code

### Screenshots Are Blank

**Problem:** Captured screenshots are empty or white

**Solution:**
1. Ensure page is fully loaded (check network tab)
2. Add wait time for dynamic content
3. Check if page requires authentication
4. Verify correct URL/route

### Component Generation Fails

**Problem:** Error when creating components

**Solution:**
1. Ensure `src/components/ui/` directory exists
2. Check that Tailwind CSS is installed
3. Verify style guide exists
4. Check for naming conflicts with existing components

### Dark Mode Not Working

**Problem:** Theme toggle doesn't switch colors

**Solution:**
1. Verify CSS variables are defined for `.dark` class
2. Check that `darkMode: ["class"]` is in `tailwind.config.ts`
3. Ensure theme toggle component is implemented correctly
4. Test by manually adding `.dark` class to `<html>` element

### Scoring Seems Inaccurate

**Problem:** UI analysis scores don't match expectations

**Solution:**
1. Review style guide for specificity - vague guidelines lead to subjective scoring
2. Check that screenshots show the correct page state
3. Provide additional context to the analyzer about intentional design decisions
4. Update style guide if your design has evolved

---

## Advanced Usage

### Custom Viewport Sizes

Modify the playwright-tester agent to capture custom viewport sizes:

```typescript
// In your Playwright test
const viewports = [
  { width: 1920, height: 1080, name: 'desktop' },
  { width: 768, height: 1024, name: 'tablet' },
  { width: 375, height: 667, name: 'mobile' },
  { width: 2560, height: 1440, name: 'wide' } // Custom
]
```

### Multiple Page Checks

Check multiple pages in sequence:

```bash
# Create a list of pages to check
/ui-check dashboard
/ui-check products
/ui-check checkout
/ui-check profile

# Compare results across pages
```

### Custom Component Variants

Create components with custom variant logic:

```tsx
// Request specific variants
/create-component status-badge

// Then customize the variants
const badgeVariants = cva("...", {
  variants: {
    status: {
      active: "bg-green-500 text-white",
      pending: "bg-yellow-500 text-black",
      inactive: "bg-gray-500 text-white",
      error: "bg-red-500 text-white",
    }
  }
})
```

### Automated CI/CD Integration

Integrate UI checks into your CI/CD pipeline:

```yaml
# .github/workflows/ui-check.yml
name: UI Compliance Check

on: [pull_request]

jobs:
  ui-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install dependencies
        run: pnpm install
      - name: Run UI checks
        run: |
          pnpm exec playwright install
          claude run /ui-check dashboard
          claude run /ui-check login
```

### Custom Scoring Weights

Adjust category weights based on your priorities:

```markdown
In style guide, add a "Validation Priorities" section:

## Validation Priorities
- Accessibility: Critical (must be 9+)
- Colors: High (must be 8+)
- Typography: High (must be 8+)
- Spacing: Medium (must be 7+)
- Layout: Medium (must be 7+)
- Components: Low (must be 6+)
```

### Multi-Theme Support

Set up multiple themes (not just light/dark):

```css
/* themes/corporate.css */
[data-theme="corporate"] {
  --primary: 220 90% 56%;
  --secondary: 160 60% 45%;
  /* ... */
}

/* themes/playful.css */
[data-theme="playful"] {
  --primary: 340 82% 62%;
  --secondary: 48 96% 54%;
  /* ... */
}
```

### Component Library Export

Export your component library as a package:

```bash
# After creating components
cd src/components/ui/

# Create package.json
npm init -y

# Build and publish
npm run build
npm publish
```

### Integration with Design Tools

**Figma Integration**:
- Export design tokens from Figma using plugins like "Design Tokens"
- Import tokens into your style guide: `/create-style-guide`
- Keep Figma and code in sync

**Storybook Integration**:
```bash
# After generating components
# Create stories for Storybook
npx storybook init

# Component stories are auto-generated with examples
```

**Chromatic Visual Regression**:
```yaml
# .github/workflows/visual-test.yml
- name: Run UI Check
  run: |
    claude run /ui-check dashboard

- name: Publish to Chromatic
  uses: chromaui/action@v1
```

### Performance Optimization

**Lazy Loading Components**:
```tsx
// Dynamic import for large components
const HeavyComponent = lazy(() => import('./components/ui/heavy-component'))
```

**Tree Shaking**:
- All generated components are tree-shakeable
- Import only what you need: `import { Button } from '@/components/ui'`

**Bundle Analysis**:
```bash
# Check component bundle sizes
npm run build -- --analyze
```

---

## Summary

The UI Checker plugin provides a comprehensive solution for:

- **Validation**: Automated UI compliance checking with Playwright
- **Documentation**: Style guide creation and maintenance
- **Generation**: Beautiful, accessible React components
- **Management**: Complete design system setup with semantic tokens

### Quick Start

1. **Install the plugin** from kobozo-plugins repository
2. **Create your style guide**: `/create-style-guide` - Interactive interview to document your design
3. **Set up design system**: `/setup-design-system` - Generate CSS variables and Tailwind config
4. **Generate components**: `/create-component button --with-variants` - Create production-ready components
5. **Validate your UI**: `/ui-check dashboard` - Check compliance with style guide

### Related Plugins

This plugin works well with other kobozo plugins:
- **image-generator**: Generate AI images following your style guide
- **feature-dev**: Enhanced feature development workflow
- **brainstorm**: Research and requirements gathering

### Plugin Architecture

The plugin uses a **multi-agent architecture** with specialized agents:
- **6 specialized agents** each handling specific tasks
- **Playwright MCP integration** for browser automation
- **Pure functional approach** where possible
- **TodoWrite tracking** for progress transparency

### Support

For issues, questions, or contributions:
- **Email**: yannick@kobozo.eu
- **Repository**: https://github.com/yannickdb/kobozo-plugins
- **Review**: Troubleshooting section above
- **Check**: Agent documentation for specific behaviors

### Version

**Current Version**: 2.0.0
**Last Updated**: October 2024
**Compatibility**: Claude Code latest

---

**Happy building!** 🎨 The UI Checker plugin is here to help you maintain design consistency and accelerate UI development with automated validation, intelligent component generation, and comprehensive design system management.
