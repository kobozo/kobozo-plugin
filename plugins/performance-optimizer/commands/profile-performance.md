---
description: Comprehensive performance analysis - identify bottlenecks in code, bundles, and database queries
---

# Profile Performance

Full-stack performance profiling to identify optimization opportunities.

## Usage

```
/profile-performance
```

## Execution Flow

### Phase 1: Code Performance Analysis
1. Launch **performance-analyzer** agent
2. Analyze code for:
   - Slow functions and algorithms
   - Memory leaks
   - Excessive re-renders (React/Vue)
   - Blocking operations
   - Inefficient loops and data structures
3. Generate prioritized bottleneck report

### Phase 2: Bundle Analysis
1. Launch **bundle-optimizer** agent
2. Analyze JavaScript bundles for:
   - Bundle composition and size
   - Large dependencies
   - Missing code splitting
   - Unused code
   - Import inefficiencies
3. Provide optimization recommendations

### Phase 3: Database Query Analysis
1. Launch **query-optimizer** agent
2. Analyze database queries for:
   - Slow queries
   - Missing indexes
   - N+1 query problems
   - Inefficient ORM usage
   - Sequential scans on large tables
3. Generate index and query optimization recommendations

### Phase 4: Consolidated Report

Generate comprehensive report with:
- **Executive Summary**: Overall performance metrics and improvement potential
- **Critical Issues**: High-impact problems requiring immediate attention
- **Quick Wins**: Low-effort, high-impact optimizations
- **Long-term Improvements**: Strategic optimizations for sustained performance

## Output Structure

```markdown
# Performance Profile Report

## Executive Summary
- **Code Bottlenecks**: 8 critical, 15 high-priority
- **Bundle Size**: 2.4MB (can reduce to 950KB)
- **Slow Queries**: 12 queries >1s
- **Overall Improvement Potential**: 65% faster

## Critical Issues (Immediate Action Required)

### 1. Database: Missing Index on Orders Table
- **Impact**: 3.2s query time (3M rows scanned)
- **Effort**: Low (5 minutes)
- **Expected Improvement**: 98% faster queries
- **Priority**: Critical

### 2. Code: N+1 Query in User Dashboard
- **Impact**: 150 queries per request, 2.1s load time
- **Effort**: Low (30 minutes)
- **Expected Improvement**: 99% fewer queries
- **Priority**: Critical

### 3. Bundle: Large Dependencies
- **Impact**: 8.2s load time on 3G
- **Effort**: Medium (2 hours)
- **Expected Improvement**: 60% smaller bundle
- **Priority**: High

## Quick Wins (High Impact, Low Effort)

1. Add 8 missing database indexes (-75% query time)
2. Replace moment.js with date-fns (-273KB)
3. Fix 5 N+1 query issues (-60% database load)
4. Use async/await for file operations (-500ms startup)

## Detailed Analysis

### Code Performance
[Link to performance-analyzer report]

### Bundle Optimization
[Link to bundle-optimizer report]

### Database Queries
[Link to query-optimizer report]

## Implementation Roadmap

### Week 1: Critical Fixes
- Add database indexes
- Fix N+1 queries
- Convert blocking I/O to async

### Week 2: Bundle Optimization
- Implement code splitting
- Replace large dependencies
- Add lazy loading for routes

### Week 3: Long-term Improvements
- Add caching layer
- Implement service worker
- Optimize images (WebP)

## Expected Results

| Metric | Current | After Optimization | Improvement |
|--------|---------|-------------------|-------------|
| Page Load Time | 8.2s | 3.1s | 62% faster |
| Bundle Size | 2.4MB | 950KB | 60% smaller |
| Database Query Time | 3.2s avg | 0.8s avg | 75% faster |
| API Response Time | 2.1s | 850ms | 60% faster |
| Lighthouse Score | 45 | 92 | +47 points |
```

## When to Use

- Before major releases
- After adding new features
- When users report slowness
- Monthly performance checkups
- Before scaling to more users

This command provides a complete performance audit of your application.
