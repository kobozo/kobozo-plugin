---
description: Find hardcoded strings in code and automatically refactor them to use i18n translation functions
---

# Migrate to i18n

Automatically refactor hardcoded strings to use i18n translation functions.

## Usage

```
/migrate-to-i18n [path]
```

**Path** (optional): Specific file or directory to migrate
- If omitted: Scans entire src directory
- Examples: `src/components/Header.jsx`, `src/pages/`

## Execution Flow

### Phase 1: Scan & Extract
1. Launch **translation-extractor** agent
2. Scan files for hardcoded strings:
   - JSX/TSX text content
   - HTML template strings
   - String literals in attributes (placeholder, title, alt)
   - JavaScript/TypeScript string assignments
3. Filter out:
   - Console logs
   - API endpoints
   - Class names / IDs
   - Test assertions
   - Code comments

### Phase 2: Generate Translation Keys
1. Analyze file structure and context
2. Generate semantic keys based on:
   - Component/file name
   - String purpose (button, heading, label, error, etc.)
   - Feature namespace
3. Check for duplicates and consolidate
4. Create or update translation files

### Phase 3: Refactor Source Files
1. Add import statements for i18n hooks/functions
2. Replace hardcoded strings with translation calls:
   - `"Save"` → `{t('actions.save')}`
   - `"Hello, {name}"` → `{t('greeting', { name })}`
3. Handle special cases:
   - Pluralization
   - HTML in strings (Trans component)
   - Dynamic content
4. Preserve formatting and code structure

### Phase 4: Update Translation Files
1. Add new keys to base language (English)
2. Update all locale files with new keys (empty for translation)
3. Maintain alphabetical order
4. Preserve existing translations

### Phase 5: Verification
1. Check syntax of refactored files
2. Verify all translation keys exist
3. Generate migration report
4. Provide testing checklist

## Output Structure

```markdown
# i18n Migration Report

**Files Scanned**: 127
**Files Modified**: 43
**Strings Migrated**: 215
**New Translation Keys**: 189 (26 duplicates consolidated)

---

## Summary by Category

| Category | Strings | Keys Generated |
|----------|---------|----------------|
| Navigation | 12 | 8 (4 duplicates) |
| Buttons/Actions | 45 | 32 (13 duplicates) |
| Form Labels | 38 | 38 |
| Error Messages | 23 | 18 (5 duplicates) |
| Headings | 31 | 31 |
| Descriptions | 66 | 62 (4 duplicates) |

---

## Modified Files

### src/components/Header.jsx

**Changes**: 5 strings migrated

**Before**:
\`\`\`javascript
export function Header() {
  return (
    <header>
      <h1>Welcome to MyApp</h1>
      <nav>
        <a href="/">Home</a>
        <a href="/about">About Us</a>
        <a href="/contact">Contact</a>
      </nav>
      <button>Get Started</button>
    </header>
  );
}
\`\`\`

**After**:
\`\`\`javascript
import { useTranslation } from 'react-i18next';

export function Header() {
  const { t } = useTranslation();

  return (
    <header>
      <h1>{t('header.welcome_title')}</h1>
      <nav>
        <a href="/">{t('nav.home')}</a>
        <a href="/about">{t('nav.about')}</a>
        <a href="/contact">{t('nav.contact')}</a>
      </nav>
      <button>{t('actions.get_started')}</button>
    </header>
  );
}
\`\`\`

### src/components/LoginForm.jsx

**Changes**: 8 strings migrated

**Before**:
\`\`\`javascript
export function LoginForm() {
  return (
    <form>
      <h2>Sign In</h2>
      <input type="email" placeholder="Email address" />
      <input type="password" placeholder="Password" />
      <button>Log in</button>
      <a href="/forgot">Forgot password?</a>
    </form>
  );
}
\`\`\`

**After**:
\`\`\`javascript
import { useTranslation } from 'react-i18next';

export function LoginForm() {
  const { t } = useTranslation();

  return (
    <form>
      <h2>{t('auth.sign_in')}</h2>
      <input type="email" placeholder={t('auth.email_placeholder')} />
      <input type="password" placeholder={t('auth.password_placeholder')} />
      <button>{t('auth.login')}</button>
      <a href="/forgot">{t('auth.forgot_password')}</a>
    </form>
  );
}
\`\`\`

### src/pages/Dashboard.jsx

**Changes**: 12 strings migrated, includes pluralization

**Before**:
\`\`\`javascript
export function Dashboard({ user, items }) {
  return (
    <div>
      <h1>Dashboard</h1>
      <p>Welcome back, {user.name}!</p>
      <p>You have {items.length} items in your cart.</p>
    </div>
  );
}
\`\`\`

**After**:
\`\`\`javascript
import { useTranslation } from 'react-i18next';

export function Dashboard({ user, items }) {
  const { t } = useTranslation();

  return (
    <div>
      <h1>{t('dashboard.title')}</h1>
      <p>{t('dashboard.welcome', { name: user.name })}</p>
      <p>{t('cart.items_count', { count: items.length })}</p>
    </div>
  );
}
\`\`\`

[Additional files...]

---

## Updated Translation Files

### locales/en/translation.json (updated)

**New keys added**: 189

\`\`\`json
{
  "header": {
    "welcome_title": "Welcome to MyApp"
  },
  "nav": {
    "home": "Home",
    "about": "About Us",
    "contact": "Contact"
  },
  "actions": {
    "save": "Save",
    "cancel": "Cancel",
    "delete": "Delete",
    "get_started": "Get Started",
    "login": "Log in"
  },
  "auth": {
    "sign_in": "Sign In",
    "email_placeholder": "Email address",
    "password_placeholder": "Password",
    "forgot_password": "Forgot password?",
    "login": "Log in"
  },
  "dashboard": {
    "title": "Dashboard",
    "welcome": "Welcome back, {{name}}!"
  },
  "cart": {
    "items_count_one": "You have {{count}} item in your cart.",
    "items_count_other": "You have {{count}} items in your cart."
  },
  "errors": {
    "required": "This field is required",
    "invalid_email": "Please enter a valid email",
    "min_length": "Must be at least {{count}} characters"
  }
}
\`\`\`

### locales/fr/translation.json (stub keys added)

\`\`\`json
{
  "header": {
    "welcome_title": ""  // TODO: Add French translation
  },
  "nav": {
    "home": "",
    "about": "",
    "contact": ""
  },
  "actions": {
    "save": "",
    "cancel": "",
    "delete": "",
    "get_started": "",
    "login": ""
  }
  // ... (all new keys with empty values)
}
\`\`\`

---

## Consolidation Opportunities

**Duplicate strings found and consolidated**:

| Original String | Occurrences | Consolidated Key |
|----------------|-------------|------------------|
| "Save" | 8 files | actions.save |
| "Cancel" | 6 files | actions.cancel |
| "Delete" | 4 files | actions.delete |
| "Loading..." | 12 files | common.loading |
| "Error" | 9 files | common.error |

**Before**: 215 individual strings
**After**: 189 unique keys (26 consolidated)
**Benefit**: 12% reduction in translation work

---

## Special Cases Handled

### 1. String Interpolation

**Before**:
\`\`\`javascript
const message = \`Welcome, \${userName}!\`;
\`\`\`

**After**:
\`\`\`javascript
const message = t('welcome.user', { userName });
// Translation: "Welcome, {{userName}}!"
\`\`\`

### 2. Pluralization

**Before**:
\`\`\`javascript
const text = count === 1 ? '1 item' : \`\${count} items\`;
\`\`\`

**After**:
\`\`\`javascript
const text = t('items.count', { count });
// Translations:
// "items.count_one": "{{count}} item"
// "items.count_other": "{{count}} items"
\`\`\`

### 3. HTML Content (using Trans component)

**Before**:
\`\`\`javascript
<p>
  By signing up, you agree to our <a href="/terms">Terms of Service</a>
</p>
\`\`\`

**After**:
\`\`\`javascript
import { Trans } from 'react-i18next';

<Trans i18nKey="auth.terms_agreement">
  By signing up, you agree to our <a href="/terms">Terms of Service</a>
</Trans>

// Translation:
// "auth.terms_agreement": "By signing up, you agree to our <1>Terms of Service</1>"
\`\`\`

### 4. Conditional Text

**Before**:
\`\`\`javascript
const status = isActive ? 'Active' : 'Inactive';
\`\`\`

**After**:
\`\`\`javascript
const status = t(isActive ? 'status.active' : 'status.inactive');
// Translations:
// "status.active": "Active"
// "status.inactive": "Inactive"
\`\`\`

---

## Files Not Modified (Skipped)

**Reason: No user-facing strings found**
- src/utils/api.ts (API endpoints only)
- src/config/constants.ts (configuration values)
- src/services/analytics.ts (tracking IDs)
- [18 more files]

**Reason: Already using i18n**
- src/pages/Settings.jsx (already uses t())
- src/components/ProfileCard.jsx (already uses t())
- [12 more files]

---

## Testing Checklist

### Automated Checks
- ✓ All modified files have valid syntax
- ✓ All translation keys exist in base language (en)
- ✓ Import statements added correctly
- ✓ No duplicate keys in translation files

### Manual Testing Required
- [ ] Load application in development mode
- [ ] Navigate through all modified pages/components
- [ ] Verify all text displays correctly
- [ ] Test with different languages (if available)
- [ ] Check pluralization with different counts
- [ ] Test string interpolation with various values
- [ ] Verify special characters and HTML render correctly

### Language Testing
- [ ] Switch to French (fr) - should show empty strings or fallback to English
- [ ] Switch to Spanish (es) - should show empty strings or fallback to English
- [ ] Verify language switcher works correctly

---

## Next Steps

### 1. Review Changes (This Week)
- Review all modified files
- Verify translation key naming is consistent
- Check for any missed strings

### 2. Add Translations (This Week)
- Send translation files to translators
- OR use translation services (Google Translate, DeepL)
- Update locale files with translations

### 3. Test (Before Deployment)
- Run full test suite
- Manual testing in all languages
- Check for runtime errors

### 4. Deploy
- Deploy refactored code
- Monitor for any i18n-related errors
- Verify all languages work correctly

---

## Rollback Procedure

If issues occur:

\`\`\`bash
# Revert all changes
git reset --hard HEAD~1

# Or cherry-pick specific files
git checkout HEAD~1 -- src/components/Header.jsx
\`\`\`

---

## Performance Impact

- **Bundle Size**: +15KB for i18n library (one-time cost)
- **Translation Files**: +45KB uncompressed (8KB gzipped)
- **Runtime**: Negligible (<1ms for t() calls)
- **Benefits**: Ready for multi-language support

---

## Migration Statistics

| Metric | Count |
|--------|-------|
| Total Files Scanned | 127 |
| Files Modified | 43 |
| Files Skipped (no changes) | 84 |
| Hardcoded Strings Found | 215 |
| Unique Keys Generated | 189 |
| Duplicates Consolidated | 26 |
| Translation Work Saved | 12% |
| Estimated Migration Time | 2 hours |
| Estimated Manual Time | 40 hours |
| Time Saved | 95% |
```

## When to Use

- Converting existing project to support i18n
- After adding new features with hardcoded text
- Preparing for multi-language launch
- Cleaning up inconsistent translation usage
- Consolidating duplicate strings

This command automates the tedious refactoring work and ensures consistency.
