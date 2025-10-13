---
description: Focused bundle optimization - analyze and reduce JavaScript bundle sizes for faster load times
---

# Optimize Bundle

Analyze and optimize JavaScript bundle sizes through targeted optimizations.

## Usage

```
/optimize-bundle
```

## Execution Flow

### Phase 1: Bundle Analysis
1. Launch **bundle-optimizer** agent
2. Detect build tool (Webpack, Vite, Rollup, esbuild, Parcel)
3. Run bundle analyzer:
   - Webpack: `webpack-bundle-analyzer`
   - Vite: `vite-bundle-visualizer`
   - Rollup: `rollup-plugin-visualizer`
4. Identify:
   - Total bundle size (uncompressed and gzipped)
   - Large dependencies
   - Duplicate dependencies
   - Unused code

### Phase 2: Issue Categorization

**Critical** (>500KB savings):
- Large libraries that can be replaced (moment.js, lodash)
- Missing code splitting for large features
- Entire icon libraries imported

**High** (100-500KB savings):
- Missing tree shaking
- Development code in production
- Unused CSS
- Non-optimized images

**Medium** (<100KB savings):
- Inefficient imports
- Duplicate packages (multiple versions)
- Missing compression

### Phase 3: Optimization Recommendations

Generate specific fixes for:
1. **Dependency Replacement**:
   - moment.js → date-fns (-273KB)
   - lodash → lodash-es + tree shaking (-500KB)
   - axios → fetch API (native)

2. **Code Splitting**:
   - Route-based splitting
   - Lazy loading for admin/dashboard
   - Dynamic imports for heavy features

3. **Tree Shaking**:
   - Use ES modules (lodash-es, not lodash)
   - Configure sideEffects in package.json
   - Check for dead code

4. **Build Configuration**:
   - Minification settings
   - Compression (gzip/brotli)
   - Source map optimization

### Phase 4: Implementation

Provide:
- Step-by-step implementation guide
- Code examples (before/after)
- Build configuration changes
- Testing commands

### Phase 5: Verification

Run build and verify:
- Bundle size reduction achieved
- No runtime errors introduced
- Load time improvements
- Lighthouse score increase

## Output Structure

```markdown
# Bundle Optimization Report

## Current State
- **Total Bundle Size**: 2.4MB (uncompressed)
- **Gzipped**: 680KB
- **Load Time (3G)**: 8.2s
- **Lighthouse Performance**: 45

## Issues Found

### Critical (>500KB each)
1. **moment.js** - 288KB
   - Used for: Date formatting in 5 files
   - Recommendation: Replace with date-fns
   - Savings: 273KB
   - Implementation time: 1 hour

2. **lodash (entire library)** - 543KB
   - Used for: 8 utility functions
   - Recommendation: Use lodash-es with tree shaking
   - Savings: ~500KB
   - Implementation time: 30 minutes

3. **Admin panel not code-split** - 450KB
   - Used by: <5% of users
   - Recommendation: Lazy load admin routes
   - Savings: 450KB for 95% of users
   - Implementation time: 1 hour

### High (100-500KB each)
4. **FontAwesome entire library** - 320KB
   - Used icons: 12 out of 1,500
   - Recommendation: Import only used icons
   - Savings: 310KB

5. **Unused CSS** - 180KB
   - Tailwind without purge
   - Recommendation: Enable PurgeCSS
   - Savings: 180KB

## Optimization Plan

### Immediate (Today)
```bash
# 1. Replace moment.js with date-fns
npm uninstall moment
npm install date-fns

# Update imports in 5 files
# src/utils/formatDate.ts
import { format, parseISO } from 'date-fns';
// ... changes

# 2. Use lodash-es
npm uninstall lodash
npm install lodash-es

# Update imports
import { debounce, throttle } from 'lodash-es';

# 3. Lazy load admin routes
// src/routes.tsx
const AdminPanel = lazy(() => import('./pages/Admin'));
```

### This Week
4. Implement route-based code splitting
5. Configure FontAwesome tree shaking
6. Enable Tailwind purge

### Expected Results
| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Bundle Size | 2.4MB | 950KB | 60% smaller |
| Gzipped | 680KB | 210KB | 69% smaller |
| Load Time (3G) | 8.2s | 3.1s | 62% faster |
| First Contentful Paint | 3.5s | 1.2s | 66% faster |
| Lighthouse Score | 45 | 92 | +47 points |

## Implementation Steps

### Step 1: Replace moment.js
\`\`\`bash
# Files affected:
# - src/utils/formatDate.ts
# - src/components/DatePicker.tsx
# - src/api/timeUtils.ts
# - src/pages/Dashboard.tsx
# - src/pages/Reports.tsx

# Before
import moment from 'moment';
const formatted = moment(date).format('YYYY-MM-DD');

# After
import { format, parseISO } from 'date-fns';
const formatted = format(parseISO(date), 'yyyy-MM-dd');
\`\`\`

### Step 2: Optimize lodash
\`\`\`javascript
// Before
import _ from 'lodash';
const unique = _.uniq(array);
const debounced = _.debounce(fn, 300);

// After
import { uniq } from 'lodash-es';
import { debounce } from 'lodash-es';
const unique = uniq(array);
const debounced = debounce(fn, 300);
\`\`\`

### Step 3: Code splitting configuration
\`\`\`javascript
// vite.config.js
export default {
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom'],
          admin: ['./src/pages/Admin']
        }
      }
    }
  }
};
\`\`\`

## Testing

\`\`\`bash
# Build and analyze
npm run build
npx vite-bundle-visualizer

# Run tests
npm test

# Check bundle size
du -sh dist/assets/*.js

# Test in browser
npm run preview
\`\`\`

## Rollback Plan

If issues occur:
\`\`\`bash
git checkout HEAD~1
npm install
npm run build
\`\`\`
```

## When to Use

- Bundle size is too large (>1MB)
- Slow load times reported
- Poor Lighthouse scores
- Before production deployment
- After adding new dependencies

This command provides focused bundle analysis and actionable optimization steps.
