# Performance Optimizer Plugin

Comprehensive performance analysis and optimization for modern applications - identify bottlenecks, reduce bundle sizes, and optimize database queries.

**Version:** 1.0.0
**Author:** Yannick De Backer (yannick@kobozo.eu)

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Commands](#commands)
  - [/profile-performance](#profile-performance)
  - [/optimize-bundle](#optimize-bundle)
- [Agents](#agents)
  - [Performance Analyzer](#performance-analyzer)
  - [Bundle Optimizer](#bundle-optimizer)
  - [Query Optimizer](#query-optimizer)
- [What Gets Optimized](#what-gets-optimized)
- [Performance Metrics](#performance-metrics)
- [Workflow Examples](#workflow-examples)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## Overview

The Performance Optimizer plugin provides intelligent, automated performance analysis and optimization for full-stack applications. It combines code profiling, bundle analysis, and database query optimization to identify and fix performance bottlenecks.

### Key Features

- **Full-Stack Analysis**: Code, bundles, and database queries in one comprehensive audit
- **Prioritized Recommendations**: High-impact, low-effort optimizations identified first
- **Actionable Reports**: Concrete fixes with code examples and implementation steps
- **Multi-Language Support**: Node.js, Python, React, Vue, and major databases
- **Build Tool Integration**: Works with Webpack, Vite, Rollup, esbuild, and Parcel
- **Database Support**: PostgreSQL, MySQL, MongoDB optimization

## Installation

This plugin is part of the Claude Code plugin system. To install:

```bash
# Navigate to your Claude plugins directory
cd ~/.config/claude/plugins

# Clone or copy the performance-optimizer plugin
cp -r /path/to/performance-optimizer .

# The plugin will be automatically detected by Claude Code
```

## Commands

### /profile-performance

Comprehensive performance profiling across code, bundles, and database queries.

**Usage:**
```
/profile-performance
```

**What it does:**

1. **Code Performance Analysis**
   - Identifies slow functions and algorithms
   - Detects memory leaks
   - Finds excessive re-renders (React/Vue)
   - Highlights blocking operations
   - Analyzes inefficient loops and data structures

2. **Bundle Analysis**
   - Measures total bundle size (uncompressed and gzipped)
   - Identifies large dependencies
   - Detects missing code splitting opportunities
   - Finds unused code
   - Analyzes import efficiency

3. **Database Query Analysis**
   - Identifies slow queries (>1s)
   - Detects missing indexes
   - Finds N+1 query problems
   - Analyzes inefficient ORM usage
   - Identifies sequential scans on large tables

4. **Consolidated Report**
   - Executive summary with overall metrics
   - Critical issues requiring immediate attention
   - Quick wins (low-effort, high-impact)
   - Long-term improvement roadmap

**Example Output:**

```markdown
# Performance Profile Report

## Executive Summary
- Code Bottlenecks: 8 critical, 15 high-priority
- Bundle Size: 2.4MB (can reduce to 950KB)
- Slow Queries: 12 queries >1s
- Overall Improvement Potential: 65% faster

## Critical Issues (Immediate Action Required)

### 1. Database: Missing Index on Orders Table
- Impact: 3.2s query time (3M rows scanned)
- Effort: Low (5 minutes)
- Expected Improvement: 98% faster queries
- Priority: Critical

### 2. Code: N+1 Query in User Dashboard
- Impact: 150 queries per request, 2.1s load time
- Effort: Low (30 minutes)
- Expected Improvement: 99% fewer queries
- Priority: Critical

## Quick Wins
1. Add 8 missing database indexes (-75% query time)
2. Replace moment.js with date-fns (-273KB)
3. Fix 5 N+1 query issues (-60% database load)
4. Use async/await for file operations (-500ms startup)

## Expected Results
| Metric | Current | After Optimization | Improvement |
|--------|---------|-------------------|-------------|
| Page Load Time | 8.2s | 3.1s | 62% faster |
| Bundle Size | 2.4MB | 950KB | 60% smaller |
| Database Query Time | 3.2s avg | 0.8s avg | 75% faster |
| API Response Time | 2.1s | 850ms | 60% faster |
```

**When to use:**
- Before major releases
- After adding new features
- When users report slowness
- Monthly performance checkups
- Before scaling to more users

---

### /optimize-bundle

Focused bundle optimization to reduce JavaScript bundle sizes for faster load times.

**Usage:**
```
/optimize-bundle
```

**What it does:**

1. **Bundle Analysis**
   - Detects build tool (Webpack, Vite, Rollup, esbuild, Parcel)
   - Runs appropriate bundle analyzer
   - Measures total bundle size and gzipped size
   - Identifies large dependencies and duplicates

2. **Issue Categorization**
   - **Critical** (>500KB savings): Large libraries, missing code splitting
   - **High** (100-500KB): Missing tree shaking, unused CSS
   - **Medium** (<100KB): Inefficient imports, duplicate packages

3. **Optimization Recommendations**
   - Dependency replacements (moment.js → date-fns)
   - Code splitting strategies
   - Tree shaking configuration
   - Build optimization settings

4. **Implementation Guide**
   - Step-by-step instructions
   - Before/after code examples
   - Build configuration changes
   - Testing and verification commands

**Example Output:**

```markdown
# Bundle Optimization Report

## Current State
- Total Bundle Size: 2.4MB (uncompressed)
- Gzipped: 680KB
- Load Time (3G): 8.2s
- Lighthouse Performance: 45

## Issues Found

### Critical (>500KB each)
1. moment.js - 288KB
   - Recommendation: Replace with date-fns
   - Savings: 273KB
   - Implementation time: 1 hour

2. lodash (entire library) - 543KB
   - Recommendation: Use lodash-es with tree shaking
   - Savings: ~500KB
   - Implementation time: 30 minutes

## Optimization Plan

### Immediate (Today)
```bash
# 1. Replace moment.js
npm uninstall moment
npm install date-fns

# 2. Use lodash-es
npm uninstall lodash
npm install lodash-es
```

### Expected Results
| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Bundle Size | 2.4MB | 950KB | 60% smaller |
| Load Time (3G) | 8.2s | 3.1s | 62% faster |
| Lighthouse Score | 45 | 92 | +47 points |
```

**When to use:**
- Bundle size is too large (>1MB)
- Slow load times reported
- Poor Lighthouse scores
- Before production deployment
- After adding new dependencies

## Agents

The Performance Optimizer plugin uses three specialized agents, each focusing on a specific area of performance optimization.

### Performance Analyzer

**Role:** Identifies code-level performance bottlenecks through profiling and analysis.

**Tools:** Bash, Read, Glob, Grep, TodoWrite
**Model:** Sonnet (Claude 3.5)
**Color:** Orange

**Capabilities:**

- **Profiling Tools Integration**
  - Node.js: `node --prof` profiling
  - Chrome DevTools: Lighthouse and Performance tabs
  - Python: `cProfile` analysis

- **Code Pattern Detection**
  - Inefficient algorithms (O(n²) → O(n))
  - Blocking I/O operations
  - React/Vue re-render issues
  - Memory leaks
  - Inefficient data structures

- **Performance Categorization**
  - Critical: >500ms impact
  - High: 100-500ms impact
  - Medium: <100ms impact

**Example Analysis:**

```javascript
// Bad: O(n²) complexity
for (let i = 0; i < users.length; i++) {
  for (let j = 0; j < orders.length; j++) {
    if (users[i].id === orders[j].userId) { }
  }
}

// Good: O(n) with Map
const userMap = new Map(users.map(u => [u.id, u]));
orders.forEach(o => {
  const user = userMap.get(o.userId);
});
```

---

### Bundle Optimizer

**Role:** Analyzes and reduces JavaScript bundle sizes through code splitting and dependency optimization.

**Tools:** Bash, Read, Glob, Grep, TodoWrite
**Model:** Sonnet (Claude 3.5)
**Color:** Green

**Capabilities:**

- **Build Tool Support**
  - Webpack: `webpack-bundle-analyzer`
  - Vite: `vite-bundle-visualizer`
  - Rollup: `rollup-plugin-visualizer`
  - esbuild and Parcel

- **Optimization Strategies**
  - Code splitting (route-based, dynamic imports)
  - Tree shaking configuration
  - Dependency replacement (moment → date-fns)
  - Lazy loading implementation

- **Bundle Analysis**
  - Large dependency detection
  - Duplicate package identification
  - Unused code discovery
  - Import efficiency analysis

**Common Optimizations:**

| From | To | Savings |
|------|-----|---------|
| moment.js | date-fns | 273KB (97% smaller) |
| lodash | lodash-es | ~500KB with tree shaking |
| axios | fetch API | ~13KB (native) |
| Full icon library | Individual icons | ~300KB |

---

### Query Optimizer

**Role:** Analyzes and optimizes database queries to reduce latency and improve throughput.

**Tools:** Bash, Read, Glob, Grep, TodoWrite
**Model:** Sonnet (Claude 3.5)
**Color:** Blue

**Capabilities:**

- **Database Support**
  - PostgreSQL: Slow query log, EXPLAIN ANALYZE
  - MySQL: Slow query log, EXPLAIN
  - MongoDB: Profiling and explain()

- **Issue Detection**
  - Slow queries (>1s)
  - Missing indexes (sequential scans)
  - N+1 query problems
  - Inefficient ORM usage
  - Unoptimized WHERE clauses

- **ORM Optimization**
  - Sequelize (Node.js)
  - TypeORM (TypeScript)
  - Django ORM (Python)
  - Active Record (Rails)

**Example Optimization:**

```javascript
// Bad: N+1 queries (150 queries)
const users = await User.findAll();
for (const user of users) {
  user.orders = await Order.findAll({ where: { userId: user.id } });
}

// Good: Single query with join (1 query)
const users = await User.findAll({
  include: [{ model: Order }]
});
```

**Index Recommendations:**

```sql
-- Single column index
CREATE INDEX idx_orders_status ON orders(status);

-- Composite index (order matters!)
CREATE INDEX idx_orders_user_created ON orders(user_id, created_at);

-- Partial index (index only relevant rows)
CREATE INDEX idx_active_users ON users(created_at) WHERE status = 'active';

-- Covering index (avoid table lookups)
CREATE INDEX idx_users_email_name ON users(email) INCLUDE (name, created_at);
```

## What Gets Optimized

### Code Performance

- **Algorithms**: O(n²) loops replaced with O(n) solutions
- **Blocking Operations**: Synchronous I/O converted to async/await
- **Memory Leaks**: Event listeners properly cleaned up
- **React/Vue**: Unnecessary re-renders eliminated with memoization
- **Data Structures**: Inefficient structures replaced (arrays → Maps/Sets)

### Bundle Sizes

- **Large Dependencies**: Heavy libraries replaced with lightweight alternatives
- **Code Splitting**: Routes and features lazy-loaded
- **Tree Shaking**: Unused code eliminated from bundles
- **Import Optimization**: Specific imports instead of entire libraries
- **Compression**: Gzip/Brotli compression configured

### Database Queries

- **Missing Indexes**: Strategic indexes added for common queries
- **N+1 Problems**: Eager loading replaces sequential queries
- **Query Plans**: Execution plans optimized (Index Scan vs Seq Scan)
- **ORM Efficiency**: Proper use of includes/prefetch/eager loading
- **Caching**: Query result caching for expensive operations

## Performance Metrics

The plugin tracks and reports on these key metrics:

### Loading Performance

- **Page Load Time**: Full page load duration
- **First Contentful Paint (FCP)**: Time to first content render
- **Largest Contentful Paint (LCP)**: Time to largest content render
- **Time to Interactive (TTI)**: Time until page is interactive

### Bundle Metrics

- **Total Bundle Size**: Uncompressed JavaScript size
- **Gzipped Size**: Compressed bundle size
- **Load Time on 3G**: Estimated load time on slow connections
- **Lighthouse Score**: Google Lighthouse performance score

### Database Metrics

- **Query Time**: Average and p95 query duration
- **Query Count**: Number of queries per request
- **Database Load**: CPU and connection pool usage
- **Index Hit Rate**: Percentage of queries using indexes

### Thresholds

| Metric | Good | Warning | Critical |
|--------|------|---------|----------|
| Page Load Time | <3s | 3-5s | >5s |
| Bundle Size | <1MB | 1-2MB | >2MB |
| Query Time | <100ms | 100ms-1s | >1s |
| Lighthouse Score | >90 | 70-90 | <70 |
| FCP | <1.8s | 1.8-3s | >3s |

## Workflow Examples

### Example 1: Pre-Release Performance Audit

```bash
# Run comprehensive profile before release
/profile-performance

# Review the consolidated report
# - Executive summary shows 65% improvement potential
# - 12 critical issues identified
# - Quick wins highlighted

# Implement immediate fixes
# 1. Add database indexes (5 minutes)
# 2. Replace moment.js (1 hour)
# 3. Fix N+1 queries (2 hours)

# Re-run to verify improvements
/profile-performance

# Expected results:
# - Load time: 8.2s → 3.1s
# - Bundle size: 2.4MB → 950KB
# - Database queries: 75% faster
```

### Example 2: Bundle Size Investigation

```bash
# User reports slow load times
# Focus on bundle optimization
/optimize-bundle

# Review findings:
# - moment.js: 288KB
# - lodash: 543KB
# - Admin panel: 450KB (not code-split)

# Implement optimizations
npm uninstall moment lodash
npm install date-fns lodash-es

# Update imports and add lazy loading
# See implementation guide in report

# Verify improvements
npm run build
npx vite-bundle-visualizer

# Results:
# - Bundle: 2.4MB → 950KB (60% reduction)
# - Load time: 8.2s → 3.1s
# - Lighthouse: 45 → 92
```

### Example 3: Database Performance Issue

```bash
# Dashboard loading slowly
# Use full profile to diagnose
/profile-performance

# Query optimizer identifies:
# - Missing index on orders.status (3.2s query)
# - N+1 problem in user dashboard (150 queries)

# Apply fixes:
# 1. Add database index
CREATE INDEX idx_orders_status ON orders(status);

# 2. Fix N+1 query in code
const users = await User.findAll({
  include: [{ model: Order }]
});

# Verify improvements:
# - Query time: 3.2s → 0.05s (98% faster)
# - Query count: 150 → 1 (99% reduction)
```

## Best Practices

### Performance Optimization

1. **Measure Before Optimizing**
   - Always profile first to identify real bottlenecks
   - Don't optimize based on assumptions
   - Use the performance-analyzer agent for data-driven decisions

2. **Prioritize High-Impact Changes**
   - Focus on critical issues first (>500ms impact)
   - Implement quick wins early (high impact, low effort)
   - Save long-term improvements for later sprints

3. **Test After Each Change**
   - Verify improvements with before/after metrics
   - Ensure no regressions introduced
   - Run full test suite after optimizations

4. **Monitor Continuously**
   - Run `/profile-performance` monthly
   - Track metrics over time
   - Catch performance degradation early

### Bundle Optimization

1. **Use Modern Build Tools**
   - Vite, esbuild for faster builds
   - Configure tree shaking properly
   - Enable compression (gzip/brotli)

2. **Implement Code Splitting**
   - Route-based splitting for all pages
   - Lazy load admin/dashboard features
   - Use dynamic imports for heavy libraries

3. **Choose Dependencies Wisely**
   - Check bundle size before installing (bundlephobia.com)
   - Prefer smaller alternatives (date-fns over moment)
   - Use tree-shakeable versions (lodash-es)

4. **Regular Bundle Audits**
   - Run `/optimize-bundle` after adding dependencies
   - Monitor bundle size in CI/CD
   - Set size budgets and enforce them

### Database Optimization

1. **Index Strategically**
   - Add indexes for frequent WHERE/JOIN columns
   - Use composite indexes for multi-column queries
   - Consider partial indexes for specific conditions

2. **Avoid N+1 Queries**
   - Always use eager loading for relationships
   - Profile ORM queries in development
   - Use includes/prefetch/eager loading properly

3. **Optimize Query Patterns**
   - Select only needed columns
   - Implement pagination for large datasets
   - Use query result caching for expensive operations

4. **Monitor Query Performance**
   - Enable slow query logging
   - Review execution plans regularly
   - Track query counts per request

## Troubleshooting

### Plugin Not Detecting Build Tool

**Problem:** Bundle optimizer can't identify your build tool

**Solution:**
- Ensure `package.json` has build scripts configured
- Check for `vite.config.js`, `webpack.config.js`, or `rollup.config.js`
- Manually specify build tool in project configuration

### Performance Analysis Not Finding Issues

**Problem:** Profiling completes but finds no bottlenecks

**Solution:**
- Ensure application is running with realistic data volumes
- Check if profiling tools are installed (node --prof, etc.)
- Review application logs for errors
- Run under load testing conditions

### Database Query Analysis Fails

**Problem:** Query optimizer can't access slow query logs

**Solution:**
- Enable slow query logging in database configuration
- Ensure database user has necessary permissions
- Check database version compatibility
- Manually enable profiling:

```sql
-- PostgreSQL
ALTER SYSTEM SET log_min_duration_statement = 1000;
SELECT pg_reload_conf();

-- MySQL
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;
```

### Bundle Analysis Shows No Size Issues

**Problem:** Bundle appears optimized but load times are slow

**Solution:**
- Check network performance (CDN, server response time)
- Analyze image sizes (use WebP, compression)
- Review third-party scripts (analytics, ads)
- Check for render-blocking resources

### Optimization Recommendations Too Aggressive

**Problem:** Suggested changes would require major refactoring

**Solution:**
- Start with quick wins only
- Implement changes incrementally
- Prioritize by impact-to-effort ratio
- Create a phased implementation roadmap

## See Also

- [Claude Code Documentation](https://claude.ai/docs)
- [Web Performance Best Practices](https://web.dev/performance)
- [Bundle Optimization Guide](https://webpack.js.org/guides/performance)
- [Database Indexing Strategies](https://use-the-index-luke.com/)
- [React Performance Optimization](https://react.dev/learn/render-and-commit)

---

**Need Help?**

- Issues: Report bugs or request features via your project's issue tracker
- Questions: Contact yannick@kobozo.eu
- Documentation: See individual agent files for detailed implementation notes
