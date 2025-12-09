---
description: This skill should be used when the user asks to "create component", "set up design system", "create style guide", "check UI", "design tokens", "component library", "UI validation", "style guide check", or needs help with design systems and UI component creation. Provides guidance on design systems and UI validation workflows.
---

# UI Design System Skill

Manage design systems with style guides, component generation, and UI validation.

## When to Use

- Creating React components with design tokens
- Setting up or updating design systems
- Creating style guides
- Validating UI against style guide
- Managing Tailwind CSS configuration

## Quick Actions (Handled by Skill)

### Design System Questions
- Color token naming conventions
- Typography scale patterns
- Spacing system design
- Component variant strategies

### Component Best Practices
- Accessibility requirements
- Responsive design patterns
- State handling in components
- Composition vs inheritance

## Design Token Patterns

### Color Tokens
```css
:root {
  /* Semantic tokens (use these) */
  --color-text-primary: var(--gray-900);
  --color-text-secondary: var(--gray-600);
  --color-bg-primary: var(--white);
  --color-bg-accent: var(--blue-50);

  /* Primitive tokens (don't use directly) */
  --gray-900: #1a1a1a;
  --gray-600: #4a4a4a;
  --blue-50: #eff6ff;
}
```

### Typography Scale
```css
:root {
  --text-xs: 0.75rem;    /* 12px */
  --text-sm: 0.875rem;   /* 14px */
  --text-base: 1rem;     /* 16px */
  --text-lg: 1.125rem;   /* 18px */
  --text-xl: 1.25rem;    /* 20px */
  --text-2xl: 1.5rem;    /* 24px */
}
```

### Spacing Scale
```css
:root {
  --space-1: 0.25rem;  /* 4px */
  --space-2: 0.5rem;   /* 8px */
  --space-3: 0.75rem;  /* 12px */
  --space-4: 1rem;     /* 16px */
  --space-6: 1.5rem;   /* 24px */
  --space-8: 2rem;     /* 32px */
}
```

## Component Patterns

### Component Structure
```tsx
interface ButtonProps {
  variant?: 'primary' | 'secondary' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  children: React.ReactNode;
  onClick?: () => void;
  disabled?: boolean;
}

export function Button({
  variant = 'primary',
  size = 'md',
  children,
  ...props
}: ButtonProps) {
  return (
    <button
      className={cn(
        baseStyles,
        variantStyles[variant],
        sizeStyles[size]
      )}
      {...props}
    >
      {children}
    </button>
  );
}
```

### Variant Pattern (CVA)
```typescript
import { cva, type VariantProps } from 'class-variance-authority';

const button = cva('base-classes', {
  variants: {
    intent: {
      primary: 'bg-blue-500 text-white',
      secondary: 'bg-gray-200 text-gray-800',
    },
    size: {
      sm: 'px-2 py-1 text-sm',
      md: 'px-4 py-2 text-base',
    },
  },
  defaultVariants: {
    intent: 'primary',
    size: 'md',
  },
});
```

## Full Workflows (Use Commands)

For comprehensive operations:

### Create Style Guide
```
/ui-checker:create-style-guide
```
**Use when:** Creating or updating design system documentation. Interactive process to gather design decisions.

### Setup Design System
```
/ui-checker:setup-design-system
```
**Use when:** Setting up complete design system with semantic tokens, Tailwind configuration, and CSS variables from your style guide.

### Create Component
```
/ui-checker:create-component <name> [--variant=button|card|input|form]
```
**Use when:** Generating production-ready React components that follow your design system.

**Examples:**
- `/create-component feature-card`
- `/create-component user-profile-card --variant=card`
- `/create-component custom-button --with-variants`

### UI Check
```
/ui-checker:ui-check
```
**Use when:** Validating UI against style guide. Starts app, captures screenshots, analyzes compliance, scores 1-10.

## Style Guide Structure

```
docs/
├── style-guide.md           # Main style guide
├── components/
│   ├── buttons.md          # Button documentation
│   ├── forms.md            # Form patterns
│   └── cards.md            # Card patterns
└── tokens/
    ├── colors.md           # Color palette
    ├── typography.md       # Type scale
    └── spacing.md          # Spacing system
```

## Quick Reference

### When to Use Each Command
| Need | Command |
|------|---------|
| Document design decisions | `/create-style-guide` |
| Set up tokens & config | `/setup-design-system` |
| Generate components | `/create-component` |
| Validate implementation | `/ui-check` |
| Design questions | Ask directly (skill handles) |

### Component Checklist
- [ ] Uses semantic color tokens
- [ ] Follows spacing scale
- [ ] Has keyboard navigation
- [ ] Has aria labels
- [ ] Responsive at all breakpoints
- [ ] Handles loading/error states
- [ ] Has TypeScript types
- [ ] Has variants for different contexts

### Design Token Hierarchy
1. **Primitive tokens**: Raw values (colors, sizes)
2. **Semantic tokens**: Purpose-based (text-primary, bg-accent)
3. **Component tokens**: Component-specific (button-bg, card-shadow)

Use semantic tokens in components, not primitives.
