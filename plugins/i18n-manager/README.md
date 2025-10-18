# i18n-manager

**Version:** 1.1.0
**Author:** Yannick De Backer (yannick@kobozo.eu)

A comprehensive Claude Code plugin for managing internationalization and localization in software projects. Automates the extraction of translatable strings, validates translation files, optimizes i18n configuration, migrates hardcoded strings, and detects missing translations across multiple frameworks.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Commands](#commands)
  - [extract-translations](#extract-translations)
  - [validate-locales](#validate-locales)
  - [migrate-to-i18n](#migrate-to-i18n)
- [Agents](#agents)
  - [translation-extractor](#translation-extractor)
  - [locale-validator](#locale-validator)
  - [translation-optimizer](#translation-optimizer)
- [Supported Frameworks](#supported-frameworks)
- [Workflow Examples](#workflow-examples)
- [Best Practices](#best-practices)
- [Output Examples](#output-examples)

## Overview

The i18n-manager plugin streamlines the entire internationalization workflow, from initial setup to ongoing maintenance. It intelligently detects your i18n framework, extracts translatable content, validates translation quality, and optimizes performance.

Whether you're starting internationalization in an existing project or maintaining translations across multiple languages, this plugin automates tedious tasks and ensures consistency.

## Key Features

- **Framework-Agnostic**: Supports React i18next, Vue I18n, Angular, Django, Rails, Flutter, and more
- **Intelligent Extraction**: Finds hardcoded strings while filtering out non-user-facing content (console logs, API endpoints, etc.)
- **Automated Refactoring**: Replaces hardcoded strings with i18n function calls and generates proper import statements
- **Quality Validation**: Checks completeness, placeholder consistency, pluralization rules, and format errors
- **Performance Optimization**: Implements namespace splitting, lazy loading, and tree shaking
- **Comprehensive Reporting**: Generates detailed reports with actionable insights
- **Duplicate Detection**: Identifies and consolidates duplicate strings across your codebase
- **Semantic Key Generation**: Creates meaningful translation keys based on context and file structure

## Installation

```bash
# Using Claude Code plugin manager
claude plugins install i18n-manager

# Or manually clone to plugins directory
cd ~/.config/claude-code/plugins
git clone <repository-url> i18n-manager
```

## Commands

### extract-translations

Extract translatable strings from source code and generate translation files for multiple languages.

**Usage:**
```
/extract-translations [languages]
```

**Parameters:**
- `languages` (optional): Comma-separated locale codes (e.g., `en,fr,es,de`)
- Default: Generates stub files for en, fr, es, de, ja, ar

**Execution Flow:**

1. **Framework Detection & String Extraction**
   - Launches the translation-extractor agent
   - Detects i18n framework (React i18next, Vue I18n, Angular, Django, Rails, Flutter)
   - Scans source files for:
     - Hardcoded strings in JSX/templates
     - Existing i18n function calls (t(), $t(), etc.)
     - Pluralization patterns
     - Variable interpolation
   - Generates translation keys using namespace strategy

2. **Translation File Generation**
   - Creates base language file (usually English)
   - Generates stub files for target languages
   - Formats according to framework (JSON, YAML, PO, ARB)

3. **Code Refactoring**
   - Identifies files with hardcoded strings
   - Generates refactored code with i18n calls
   - Provides before/after examples
   - Includes import statements

4. **Configuration**
   - Generates/updates i18n configuration
   - Sets up language detection
   - Configures fallback languages
   - Adds namespace support

**When to Use:**
- Starting internationalization in existing project
- Adding new features with user-facing text
- Preparing for multi-language support
- Consolidating scattered translations

**Example:**
```bash
# Extract translations for English, French, and Spanish
/extract-translations en,fr,es

# Extract with default languages
/extract-translations
```

### validate-locales

Comprehensive validation of translation files across all languages for completeness, consistency, format errors, and quality issues.

**Usage:**
```
/validate-locales
```

**Execution Flow:**

1. **Completeness Check**
   - Launches the locale-validator agent
   - Loads all translation files
   - Compares against base language (usually English)
   - Calculates completion percentage per locale
   - Lists missing translation keys

2. **Quality Validation**
   - Checks placeholder consistency ({{variable}} names must match)
   - Verifies pluralization rules (correct number of forms per language)
   - Detects empty or whitespace-only translations
   - Finds duplicate keys across namespaces

3. **Format Validation**
   - Validates JSON/YAML/PO syntax
   - Checks for invalid escape sequences
   - Verifies file encoding (UTF-8)
   - Detects malformed structures

4. **Optimization & Reporting**
   - Launches the translation-optimizer agent
   - Identifies consolidation opportunities (duplicate strings)
   - Suggests namespace splitting for large files
   - Recommends performance optimizations
   - Generates comprehensive validation report

**When to Use:**
- Before deploying new translations
- After receiving translations from translators
- Quarterly quality audits
- When adding new languages
- After major feature releases

**Example:**
```bash
/validate-locales
```

### migrate-to-i18n

Automatically find hardcoded strings in code and refactor them to use i18n translation functions.

**Usage:**
```
/migrate-to-i18n [path]
```

**Parameters:**
- `path` (optional): Specific file or directory to migrate
- If omitted: Scans entire src directory
- Examples: `src/components/Header.jsx`, `src/pages/`

**Execution Flow:**

1. **Scan & Extract**
   - Launches the translation-extractor agent
   - Scans files for hardcoded strings:
     - JSX/TSX text content
     - HTML template strings
     - String literals in attributes (placeholder, title, alt)
     - JavaScript/TypeScript string assignments
   - Filters out:
     - Console logs
     - API endpoints
     - Class names / IDs
     - Test assertions
     - Code comments

2. **Generate Translation Keys**
   - Analyzes file structure and context
   - Generates semantic keys based on:
     - Component/file name
     - String purpose (button, heading, label, error, etc.)
     - Feature namespace
   - Checks for duplicates and consolidates
   - Creates or updates translation files

3. **Refactor Source Files**
   - Adds import statements for i18n hooks/functions
   - Replaces hardcoded strings with translation calls
   - Handles special cases:
     - Pluralization
     - HTML in strings (Trans component)
     - Dynamic content
   - Preserves formatting and code structure

4. **Update Translation Files**
   - Adds new keys to base language (English)
   - Updates all locale files with new keys (empty for translation)
   - Maintains alphabetical order
   - Preserves existing translations

5. **Verification**
   - Checks syntax of refactored files
   - Verifies all translation keys exist
   - Generates migration report
   - Provides testing checklist

**When to Use:**
- Converting existing project to support i18n
- After adding new features with hardcoded text
- Preparing for multi-language launch
- Cleaning up inconsistent translation usage
- Consolidating duplicate strings

**Example:**
```bash
# Migrate entire src directory
/migrate-to-i18n

# Migrate specific component
/migrate-to-i18n src/components/Header.jsx

# Migrate specific directory
/migrate-to-i18n src/pages/
```

## Agents

### translation-extractor

**Agent Name:** translation-extractor
**Model:** Claude Sonnet
**Tools:** Bash, Read, Glob, Grep, TodoWrite, Write

Specialized agent for extracting translatable strings from source code and generating translation files across multiple i18n frameworks.

**Capabilities:**

- **Framework Detection**: Automatically identifies React i18next, Vue I18n, Angular, Next.js, Django, Rails, Flutter, and iOS frameworks
- **String Extraction**: Finds hardcoded strings, existing i18n calls, and identifies context
- **Key Generation**: Creates semantic translation keys using namespace, feature-based, or semantic strategies
- **File Generation**: Produces translation files in JSON, YAML, PO, ARB, and strings formats
- **Code Refactoring**: Generates refactored code with proper i18n function calls and imports

**Extraction Patterns:**

```javascript
// Detects hardcoded strings
<h1>Welcome to our app</h1>  // → Extract: "Welcome to our app"
placeholder="Enter name"      // → Extract: "Enter name"

// Identifies existing i18n calls
t('welcome.title')           // → Key: welcome.title
$t('nav.home')              // → Key: nav.home

// Handles special cases
`Welcome, ${name}!`         // → t('welcome.user', { name })
count === 1 ? '1 item' : `${count} items`  // → Pluralization
```

### locale-validator

**Agent Name:** locale-validator
**Model:** Claude Sonnet
**Tools:** Bash, Read, Glob, Grep, TodoWrite

Expert agent for validating translation files for completeness, consistency, format errors, and quality issues.

**Validation Checks:**

1. **Completeness Check**
   - Compares all locales against base language
   - Calculates completion percentage
   - Lists missing translation keys

2. **Placeholder Consistency**
   - Verifies variable names match across languages
   - Example: `{{name}}` in English must be `{{name}}` in French, not `{{username}}`

3. **Pluralization Rules**
   - Checks correct number of plural forms per language
   - English: 2 forms (one, other)
   - French: 2 forms (one, other)
   - Arabic: 6 forms (zero, one, two, few, many, other)
   - Russian: 3 forms (one, few, other)

4. **Format Validation**
   - JSON/YAML/PO syntax validation
   - UTF-8 encoding verification
   - Invalid escape sequence detection

5. **Quality Issues**
   - Empty or whitespace-only translations
   - Duplicate keys across namespaces
   - Malformed structures

**Example Validation Report:**

```markdown
| Locale | Completeness | Issues |
|--------|--------------|--------|
| en     | 100% (342/342) | 0 ✓    |
| fr     | 89% (304/342)  | 41 ⚠️  |
| es     | 76% (260/342)  | 85 ⚠️  |
| de     | 45% (154/342)  | 191 🔴 |
```

### translation-optimizer

**Agent Name:** translation-optimizer
**Model:** Claude Sonnet
**Tools:** Bash, Read, Glob, Grep, TodoWrite, Write

Performance optimization specialist for i18n configurations, bundle size reduction, and translation loading performance.

**Optimization Strategies:**

1. **Namespace Splitting**
   - Splits large translation files into smaller namespaces
   - Enables lazy loading of translations on demand
   - Example: 500KB single file → 5 files (50KB initial, 450KB lazy)

2. **Tree Shaking**
   - Analyzes code to find used translation keys
   - Removes unused keys from translation files
   - Typical reduction: 20-30% of keys

3. **Lazy Loading**
   - Loads common translations immediately
   - Defers feature-specific translations until needed
   - Reduces initial bundle size by 80-90%

4. **Compression**
   - Configures gzip/brotli compression
   - Typical reduction: 85-90% of uncompressed size

5. **Caching Strategy**
   - Implements service worker caching
   - Configures HTTP cache headers
   - Results in instant repeat visits

**Performance Impact:**

```markdown
| Metric            | Before  | After        | Improvement |
|-------------------|---------|--------------|-------------|
| Initial Bundle    | 500KB   | 45KB (gzip)  | 91% smaller |
| First Load        | 2.3s    | 0.2s         | 91% faster  |
| Repeat Load       | 2.3s    | 0ms (cached) | Instant     |
```

## Supported Frameworks

### React i18next

```javascript
// Function calls
t('key')
t('key', { variable })
i18n.t('key')
useTranslation()
Trans component

// File pattern
locales/en/translation.json
locales/fr/translation.json
```

### Vue I18n

```javascript
// Function calls
$t('key')
$tc('key', count)
this.$t('key')
<i18n> blocks

// File pattern
locales/en.json
locales/fr.json
```

### Angular

```typescript
// Patterns
translate.get('key')
translate.instant('key')
{{ 'key' | translate }}
i18n attribute

// File pattern
assets/i18n/en.json
assets/i18n/fr.json
```

### Next.js (next-i18next)

```javascript
// Patterns
t('key')
useTranslation('namespace')
serverSideTranslations

// File pattern
public/locales/en/common.json
public/locales/fr/common.json
```

### Django

```python
# Patterns
_('string')
gettext('string')
ngettext('singular', 'plural', count)
{% trans "string" %}

# File pattern
locale/en/LC_MESSAGES/django.po
locale/fr/LC_MESSAGES/django.po
```

### Rails

```ruby
# Patterns
t('key')
I18n.t('key')
<%= t('key') %>

# File pattern
config/locales/en.yml
config/locales/fr.yml
```

### Flutter/Dart

```dart
// Patterns
AppLocalizations.of(context).key
S.of(context).key
intl messages

// File pattern
lib/l10n/app_en.arb
lib/l10n/app_fr.arb
```

### iOS (Swift)

```swift
// Patterns
NSLocalizedString("key", comment: "")
String(localized: "key")

// File pattern
en.lproj/Localizable.strings
fr.lproj/Localizable.strings
```

## Workflow Examples

### Starting i18n in Existing Project

```bash
# Step 1: Migrate existing code
/migrate-to-i18n

# Review the migration report and refactored code
# The command generates translation files and updated source files

# Step 2: Extract additional translations
/extract-translations en,fr,es,de

# Step 3: Validate the generated files
/validate-locales

# Step 4: Send translation files to translators
# Export JSON/YAML/PO files for translation

# Step 5: After receiving translations, validate again
/validate-locales
```

### Adding New Feature

```bash
# After developing a new feature with hardcoded strings
/migrate-to-i18n src/features/new-feature

# Update translation files for all languages
# Then validate
/validate-locales
```

### Regular Maintenance

```bash
# Quarterly quality audit
/validate-locales

# Fix any issues reported
# Re-run validation
/validate-locales
```

### Pre-Deployment Check

```bash
# Before releasing to production
/validate-locales

# Ensure all critical translations are complete
# Verify no format errors exist
```

## Best Practices

### 1. Use Semantic Keys

**Good:**
```json
{
  "actions": {
    "save": "Save",
    "cancel": "Cancel",
    "delete": "Delete"
  },
  "auth": {
    "login": "Log in",
    "logout": "Log out"
  }
}
```

**Bad:**
```json
{
  "key1": "Save",
  "key2": "Cancel",
  "string3": "Delete"
}
```

### 2. Organize by Feature/Component

```json
{
  "header": {
    "welcome_title": "Welcome to MyApp",
    "tagline": "The best app ever"
  },
  "footer": {
    "copyright": "© 2024 MyApp",
    "privacy": "Privacy Policy"
  }
}
```

### 3. Handle Pluralization Properly

```javascript
// React i18next
t('items.count', { count: 5 })

// Translation file
{
  "items": {
    "count_one": "{{count}} item",
    "count_other": "{{count}} items"
  }
}
```

### 4. Use Variables for Dynamic Content

```javascript
// Good
t('greeting', { name: userName })
// Translation: "Hello, {{name}}!"

// Bad - don't concatenate
`Hello, ${userName}!`
```

### 5. Never Translate Technical Content

**Don't extract:**
- Console logs: `console.log("Debug message")`
- API endpoints: `fetch('/api/users')`
- Class names: `className="btn-primary"`
- Test assertions: `expect(result).toBe("success")`
- Environment variables: `process.env.API_KEY`

**Do extract:**
- User-facing text in UI
- Button labels and headings
- Form placeholders and labels
- Error messages shown to users
- Success/info notifications

### 6. Maintain Consistency Across Languages

```json
// English
{
  "user": {
    "greeting": "Welcome, {{name}}!"
  }
}

// French - same variable name
{
  "user": {
    "greeting": "Bienvenue, {{name}} !"
  }
}

// Wrong - variable name mismatch
{
  "user": {
    "greeting": "Bienvenue, {{username}} !"  // ✗
  }
}
```

### 7. Split Large Translation Files

```javascript
// Instead of one large file
locales/en/translation.json (500KB)

// Split by feature
locales/en/common.json (50KB)      // Always loaded
locales/en/auth.json (30KB)        // Lazy load on auth pages
locales/en/dashboard.json (200KB)  // Lazy load on dashboard
locales/en/admin.json (150KB)      // Lazy load for admins
```

### 8. Regular Validation

```bash
# Run validation regularly
/validate-locales

# Quarterly audit schedule
# - Q1: Completeness check
# - Q2: Quality audit
# - Q3: Performance optimization
# - Q4: Year-end cleanup
```

### 9. Version Control Translation Files

```bash
# Keep translation files in version control
git add locales/
git commit -m "Add French translations for auth module"

# Track changes over time
# Use branches for major translation updates
```

### 10. Document Context for Translators

```json
{
  "auth": {
    "login": "Log in",  // Button text on login page
    "welcome": "Welcome back, {{name}}!",  // Greeting after successful login
    "error_invalid": "Invalid credentials"  // Error message for failed login
  }
}
```

## Output Examples

### Extract Translations Report

```markdown
# Translation Extraction Report

**Generated**: 2024-01-15 16:00
**Framework**: React i18next
**Files Scanned**: 127
**Strings Found**: 342

## Summary

- Hardcoded Strings: 215 (need translation)
- Existing i18n Keys: 127 (already translated)
- Duplicate Strings: 18 (can consolidate)
- Pluralization Needed: 23
- Variables Detected: 67

## Generated Files

### File: locales/en/translation.json

```json
{
  "nav": {
    "home": "Home",
    "about": "About Us",
    "contact": "Contact"
  },
  "auth": {
    "login": "Log in",
    "email": "Email address",
    "greeting": "Welcome, {{name}}!"
  },
  "product": {
    "add_to_cart": "Add to cart",
    "items_one": "{{count}} item",
    "items_other": "{{count}} items"
  }
}
```
```

### Migration Report

```markdown
# i18n Migration Report

**Files Scanned**: 127
**Files Modified**: 43
**Strings Migrated**: 215
**New Translation Keys**: 189 (26 duplicates consolidated)

## Modified Files

### src/components/Header.jsx

**Before**:
```javascript
export function Header() {
  return (
    <header>
      <h1>Welcome to MyApp</h1>
      <nav>
        <a href="/">Home</a>
        <a href="/about">About Us</a>
      </nav>
    </header>
  );
}
```

**After**:
```javascript
import { useTranslation } from 'react-i18next';

export function Header() {
  const { t } = useTranslation();

  return (
    <header>
      <h1>{t('header.welcome_title')}</h1>
      <nav>
        <a href="/">{t('nav.home')}</a>
        <a href="/about">{t('nav.about')}</a>
      </nav>
    </header>
  );
}
```

## Consolidation Opportunities

| Original String | Occurrences | Consolidated Key |
|----------------|-------------|------------------|
| "Save"         | 8 files     | actions.save     |
| "Cancel"       | 6 files     | actions.cancel   |
| "Loading..."   | 12 files    | common.loading   |

**Before**: 215 individual strings
**After**: 189 unique keys (26 consolidated)
**Benefit**: 12% reduction in translation work
```

### Validation Report

```markdown
# Translation Validation Report

**Validated**: 2024-01-15 16:30
**Locales**: en, fr, es, de, ar
**Total Keys**: 342

## Summary

| Locale | Completeness    | Issues |
|--------|-----------------|--------|
| en     | 100% (342/342)  | 0 ✓    |
| fr     | 89% (304/342)   | 41 ⚠️  |
| es     | 76% (260/342)   | 85 ⚠️  |
| de     | 45% (154/342)   | 191 🔴 |
| ar     | 23% (79/342)    | 267 🔴 |

## Critical Issues

### French (fr.json)

1. **Missing Translations**: 38 keys
   - auth.reset_password
   - user.profile_updated
   - [36 more...]

2. **Placeholder Mismatch**: 2 keys
   - greeting: Expected {{name}}, found {{username}}

3. **Missing Pluralization**: 1 key
   - cart.items missing items_other

## Recommendations

### Priority 1: Fix Format Errors
- de.json line 45 - Fix JSON syntax

### Priority 2: Complete Core Features
- Translate navigation and auth (high visibility)
- Current: 45% → Target: 100%
```

---

**Need Help?**

For issues, questions, or contributions, please contact:
- Email: yannick@kobozo.eu
- Plugin Version: 1.1.0

**License:** See LICENSE file for details.
