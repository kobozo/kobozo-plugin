---
description: This skill should be used when the user asks about "internationalization", "i18n", "translations", "localization", "extract translations", "translate strings", "locale files", "multi-language", or needs help with internationalization and translation management. Provides guidance on i18n patterns and translation workflows.
---

# Internationalization Skill

Manage internationalization (i18n) with translation extraction, validation, and optimization.

## When to Use

- Setting up i18n in a project
- Extracting hardcoded strings
- Validating translation files
- Adding new languages
- Migrating existing code to i18n

## Quick Actions (Handled by Skill)

### i18n Pattern Questions
- Best practices for key naming
- Pluralization patterns
- Variable interpolation
- RTL language support
- Date/number formatting

### Translation Structure
- File organization patterns
- Namespace strategies
- Lazy loading translations

## i18n Patterns

### Key Naming Convention
```typescript
// Good: Hierarchical, descriptive
t('user.profile.editButton')
t('checkout.payment.cardNumber')
t('errors.validation.emailInvalid')

// Bad: Flat, vague
t('edit')
t('error1')
t('text')
```

### Pluralization
```typescript
// React i18next
t('items', { count: 5 })

// Translation file
{
  "items_one": "{{count}} item",
  "items_other": "{{count}} items"
}
```

### Variable Interpolation
```typescript
// Named variables (preferred)
t('welcome', { name: 'John' })
// "Welcome, {{name}}!"

// Avoid positional variables
t('message', { 0: 'John', 1: 'Admin' })
```

### Date/Time Formatting
```typescript
// Use Intl API or i18n library
const formatter = new Intl.DateTimeFormat(locale, {
  dateStyle: 'full',
  timeStyle: 'short'
});
```

## Framework Patterns

### React (react-i18next)
```typescript
import { useTranslation } from 'react-i18next';

function Component() {
  const { t } = useTranslation('namespace');
  return <h1>{t('page.title')}</h1>;
}
```

### Vue (vue-i18n)
```vue
<template>
  <h1>{{ $t('page.title') }}</h1>
</template>
```

### File Structure
```
locales/
├── en/
│   ├── common.json
│   ├── auth.json
│   └── dashboard.json
├── fr/
│   ├── common.json
│   └── ...
└── es/
    └── ...
```

## Full Workflows (Use Commands)

For comprehensive operations that require file scanning:

### Extract Translations
```
/i18n-manager:extract-translations [languages]
```
**Use when:** Need to extract hardcoded strings from code and generate translation files.

**Arguments:**
- Languages: Comma-separated locale codes (e.g., `en,fr,es,de`)
- Default: Generates for en, fr, es, de, ja, ar

### Migrate to i18n
```
/i18n-manager:migrate-to-i18n
```
**Use when:** Converting existing hardcoded strings to use i18n functions. Automatically refactors code to use translation calls.

### Validate Locales
```
/i18n-manager:validate-locales
```
**Use when:** Checking translation files for:
- Missing translations
- Inconsistent keys across locales
- Format errors
- Unused keys

## Supported Frameworks

| Framework | Library |
|-----------|---------|
| React | react-i18next, react-intl |
| Vue | vue-i18n |
| Angular | @angular/localize |
| Django | gettext |
| Rails | i18n gem |
| Flutter | flutter_localizations |

## Quick Reference

### When to Use Each Command
| Need | Command |
|------|---------|
| Extract strings from code | `/extract-translations` |
| Refactor hardcoded strings | `/migrate-to-i18n` |
| Check translation files | `/validate-locales` |
| Best practices question | Ask directly (skill handles) |

### Translation Checklist
- [ ] Keys follow naming convention
- [ ] All user-facing strings extracted
- [ ] Pluralization handled correctly
- [ ] Variables use named placeholders
- [ ] RTL languages considered
- [ ] Date/numbers use locale formatting
- [ ] No concatenated translated strings

### Common Mistakes
- Concatenating translated strings (loses word order for RTL)
- Hardcoded dates/numbers
- Missing pluralization forms
- Splitting sentences across multiple keys
- Over-nesting namespace structure
