---
description: Set up complete design system with semantic tokens, Tailwind configuration, and CSS variables from your style guide
---

# Setup Design System

Initialize a complete design system with semantic design tokens, Tailwind CSS configuration, and CSS variables based on your style guide.

## Usage

```
/setup-design-system [--from-style-guide=docs/style-guide.md]
```

## Execution Flow

### Phase 1: Style Guide Analysis
1. Launch **design-system-manager** agent
2. Read project style guide
3. Extract design tokens:
   - Color palette (primary, secondary, accent, semantic colors)
   - Typography (font families, sizes, weights)
   - Spacing system (padding, margins, gaps)
   - Border radius, shadows, transitions

### Phase 2: Generate Design Tokens
1. Create `src/index.css` with CSS variables
2. Convert colors to HSL format (easier manipulation)
3. Define semantic tokens (primary, secondary, destructive, muted, etc.)
4. Set up dark mode variants
5. Add custom gradients and animations

### Phase 3: Configure Tailwind
1. Update `tailwind.config.ts`
2. Integrate design tokens with Tailwind utilities
3. Add custom plugins (tailwindcss-animate)
4. Configure content paths

### Phase 4: Create Utilities
1. Generate `lib/utils.ts` with `cn()` function
2. Create TypeScript types for design tokens
3. Add theme toggle component

## Output Files

- `src/index.css` - CSS variables and design tokens
- `tailwind.config.ts` - Tailwind configuration
- `src/lib/utils.ts` - Utility functions
- `src/types/design-system.ts` - TypeScript types
- `src/components/theme-toggle.tsx` - Dark mode toggle

This command creates a maintainable, scalable design system that makes it easy to build consistent UIs.
