---
description: Extract translatable strings from source code and generate translation files for multiple languages
---

# Extract Translations

Extract hardcoded strings and generate i18n translation files.

## Usage

```
/extract-translations [languages]
```

**Languages** (optional): Comma-separated locale codes (e.g., `en,fr,es,de`)
- Default: Generates stub files for en, fr, es, de, ja, ar

## Execution Flow

### Phase 1: Framework Detection & String Extraction
1. Launch **translation-extractor** agent
2. Detect i18n framework (React i18next, Vue I18n, Angular, Django, Rails, Flutter)
3. Scan source files for:
   - Hardcoded strings in JSX/templates
   - Existing i18n function calls (t(), $t(), etc.)
   - Pluralization patterns
   - Variable interpolation
4. Generate translation keys using namespace strategy

### Phase 2: Translation File Generation
1. Create base language file (usually English)
2. Generate stub files for target languages
3. Format according to framework:
   - JSON (i18next, Vue I18n)
   - YAML (Rails)
   - PO (Django/gettext)
   - ARB (Flutter)

### Phase 3: Code Refactoring
1. Identify files with hardcoded strings
2. Generate refactored code with i18n calls
3. Provide before/after examples
4. Include import statements

### Phase 4: Configuration
1. Generate/update i18n configuration
2. Set up language detection
3. Configure fallback languages
4. Add namespace support

## When to Use

- Starting internationalization in existing project
- Adding new features with user-facing text
- Preparing for multi-language support
- Consolidating scattered translations

This command automates the tedious process of extracting and organizing translations.
