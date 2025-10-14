---
description: Create beautiful, reusable React components following your style guide with Tailwind CSS and semantic design tokens
---

# Create Component

Generate production-ready React components that follow your design system, style guide, and accessibility best practices.

## Usage

```
/create-component <component-name> [--variant=button|card|input|form] [--with-variants]
```

**Examples:**
```
/create-component feature-card
/create-component user-profile-card --variant=card
/create-component custom-button --with-variants
```

## Execution Flow

### Phase 1: Style Guide Analysis
1. Read project style guide (`docs/style-guide.md`)
2. Extract design tokens (colors, typography, spacing)
3. Identify component patterns and conventions

### Phase 2: Component Generation
1. Launch **component-generator** agent
2. Create component with variants using CVA (class-variance-authority)
3. Use semantic design tokens (never hardcoded colors)
4. Implement responsive design (mobile-first)
5. Add smooth transitions and animations
6. Ensure accessibility (ARIA, keyboard navigation)

### Phase 3: Integration
1. Export component from `components/ui/index.ts`
2. Create usage examples
3. Document props and variants
4. Verify style guide compliance

## Component Types

### Button Component
```tsx
<Button variant="default">Default</Button>
<Button variant="destructive">Delete</Button>
<Button variant="outline">Cancel</Button>
<Button variant="ghost">Skip</Button>
<Button size="sm|lg|icon">Sized</Button>
```

### Card Component
```tsx
<Card hover gradient>
  <CardHeader>
    <CardTitle>Title</CardTitle>
    <CardDescription>Description</CardDescription>
  </CardHeader>
  <CardContent>{children}</CardContent>
</Card>
```

### Form Input
```tsx
<Input
  label="Email"
  type="email"
  error={errors.email}
  helpText="We'll never share your email"
/>
```

This command creates components that developers love to use and perfectly match your design system.
