---
name: Dead Code Awareness
description: This skill should be used when editing, refactoring, or reviewing code to identify and clean up dead code. Apply when removing features, changing function signatures, or refactoring modules. Helps recognize unused imports, unreferenced functions, orphaned files, and obsolete code paths.
version: 1.0.0
---

# Dead Code Awareness

Apply these principles when editing code to avoid creating dead code and to recognize existing dead code.

## What is Dead Code?

Dead code is code that:
- Is never executed
- Is unreachable
- Has no references
- Serves no purpose

Dead code increases maintenance burden, confuses developers, and bloats bundles.

## Common Types of Dead Code

### Unused Imports

```typescript
// DEAD: Imported but never used
import { unusedFunction, usedFunction } from './utils';
import lodash from 'lodash';  // Never called

// CLEAN: Only import what you use
import { usedFunction } from './utils';
```

### Unreferenced Functions

```typescript
// DEAD: Function exists but is never called
function legacyHelper() {
  // 100 lines of code nobody calls
}

// After refactoring, check if helpers are still needed
export function processData(data) {
  return transform(data);  // Does this still call legacyHelper?
}
```

### Orphaned Files

Files that exist but are never imported anywhere:
- `src/utils/oldHelper.ts` - No imports reference it
- `src/components/DeprecatedWidget.tsx` - Removed from routes
- `src/services/legacyApi.ts` - API no longer used

### Unreachable Code

```typescript
// DEAD: Code after return
function example() {
  return result;
  console.log('Never runs');  // Unreachable
}

// DEAD: Impossible conditions
if (status === 'active' && status === 'inactive') {
  // Can never be true
}

// DEAD: Always-false conditions
const DEBUG = false;
if (DEBUG) {
  console.log('Debug info');  // Never executes in production
}
```

### Commented-Out Code

```typescript
// DEAD: Old implementation left as comments
function calculate(x) {
  // Old approach:
  // const result = x * 2;
  // if (result > 100) {
  //   return 100;
  // }
  // return result;

  return Math.min(x * 2, 100);
}
```

Remove commented code - use version control for history.

### Unused Variables

```typescript
// DEAD: Assigned but never read
const unusedConfig = loadConfig();
const activeConfig = getActiveConfig();

doSomething(activeConfig);  // unusedConfig never used
```

### Dead Exports

```typescript
// utils.ts - exports that nothing imports
export function usedHelper() { }      // Used elsewhere
export function unusedHelper() { }    // Nothing imports this
export const DEAD_CONSTANT = 42;      // Never referenced
```

## When Dead Code Appears

### After Refactoring

When you refactor, check:
- Are all imports still needed?
- Are all helper functions still called?
- Are all exports still imported?

### After Feature Removal

When removing a feature:
- Delete the feature files
- Remove imports of deleted files
- Check for orphaned helpers
- Clean up configuration

### After API Changes

When changing function signatures:
- Remove unused parameters
- Update all call sites
- Remove obsolete overloads

### After Dependency Updates

When updating libraries:
- Remove polyfills for now-native features
- Update deprecated API usage
- Remove compatibility shims

## Detection Strategies

### IDE Features
- Unused import warnings
- Unused variable highlighting
- Find all references

### Static Analysis Tools
```bash
# TypeScript/JavaScript
npx knip                    # Find unused files, exports, deps
npx ts-prune                # Find unused exports
npx eslint --rule 'no-unused-vars: error'

# Check for unused dependencies
npx depcheck
```

### Manual Checks
1. Search for function/class name
2. Check if any results are actual usages (not just definition)
3. Verify imports reference the file

## Safe Removal Checklist

Before removing code:

- [ ] **Search for references**: Use IDE "Find All References"
- [ ] **Check dynamic usage**: Search for string references (`dynamicImport('moduleName')`)
- [ ] **Check tests**: Ensure tests don't rely on the code
- [ ] **Check configs**: Look in webpack, jest, etc. configs
- [ ] **Check reflection**: Look for `Object.keys()`, `for...in` loops
- [ ] **Review exports**: Check if it's part of public API

## Patterns That Create Dead Code

### Feature Flags Without Cleanup

```typescript
// After feature is 100% rolled out, clean up:
if (featureFlags.newCheckout) {
  // New code
} else {
  // Old code - NOW DEAD
}

// Clean version:
// New code (remove flag and old branch)
```

### Copy-Paste Development

Copying code instead of extracting shared utilities leads to:
- Multiple similar functions
- Orphaned originals after modifications
- Confusion about which to use

### Premature Abstraction

```typescript
// Created "for future use" but never used
interface FuturePlugin { }
class PluginManager { }
function loadPlugins() { }

// If not used within a sprint, delete it
```

## Quick Reference

### Signs of Dead Code
- No "Find References" results
- Deprecation warnings
- TODOs that are years old
- Commented-out blocks
- Feature flags for shipped features

### Tools
| Tool | Purpose |
|------|---------|
| knip | Unused files, exports, dependencies |
| ts-prune | Unused TypeScript exports |
| depcheck | Unused npm dependencies |
| ESLint | Unused variables and imports |

### Safe Removal Steps
1. Find all references
2. Check for dynamic/reflection usage
3. Run tests
4. Remove code
5. Run tests again
6. Check bundle size reduced

## Additional Resources

- [knip](https://github.com/webpro/knip) - Find unused files, exports, and dependencies
- [ts-prune](https://github.com/nadeesha/ts-prune) - Find unused TypeScript exports
