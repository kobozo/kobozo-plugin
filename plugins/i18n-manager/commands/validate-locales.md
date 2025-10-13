---
description: Validate translation files for completeness, consistency, format errors, and quality issues across all locales
---

# Validate Locales

Comprehensive validation of translation files across all languages.

## Usage

```
/validate-locales
```

## Execution Flow

### Phase 1: Completeness Check
1. Launch **locale-validator** agent
2. Load all translation files
3. Compare against base language (usually English)
4. Calculate completion percentage per locale
5. List missing translation keys

### Phase 2: Quality Validation
1. Check placeholder consistency ({{variable}} names must match)
2. Verify pluralization rules (correct number of forms per language)
3. Detect empty or whitespace-only translations
4. Find duplicate keys across namespaces

### Phase 3: Format Validation
1. Validate JSON/YAML/PO syntax
2. Check for invalid escape sequences
3. Verify file encoding (UTF-8)
4. Detect malformed structures

### Phase 4: Optimization & Reporting
1. Launch **translation-optimizer** agent
2. Identify consolidation opportunities (duplicate strings)
3. Suggest namespace splitting for large files
4. Recommend performance optimizations
5. Generate comprehensive validation report

## When to Use

- Before deploying new translations
- After receiving translations from translators
- Quarterly quality audits
- When adding new languages
- After major feature releases

This command ensures translation quality and prevents runtime errors.
