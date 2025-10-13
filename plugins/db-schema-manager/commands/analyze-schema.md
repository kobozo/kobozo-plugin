---
description: Comprehensive database schema analysis - relationship mapping, issue detection, optimization recommendations, and documentation
---

# Analyze Schema

Complete database schema analysis with optimization recommendations.

## Usage

```
/analyze-schema [database-type]
```

**Database type** (optional, auto-detected):
- `postgres` / `postgresql`
- `mysql`
- `mongodb`
- `orm` - Analyze from ORM models (Sequelize, TypeORM, Django, Rails, Prisma)

## Execution Flow

### Phase 1: Schema Discovery
1. Launch **schema-analyzer** agent
2. Detect database type and ORM framework
3. Extract schema information:
   - **Relational DBs**: Query information_schema
   - **MongoDB**: Sample collections for structure
   - **ORM Models**: Parse model files
4. Map all tables, columns, data types, constraints

### Phase 2: Relationship Analysis
1. Identify foreign key relationships
2. Determine cardinality (1:1, 1:N, M:N)
3. Detect missing foreign keys
4. Find orphaned records
5. Generate entity-relationship diagram

### Phase 3: Issue Detection
1. **Critical Issues**:
   - Missing primary keys
   - Foreign keys without indexes
   - Denormalization violations (1NF)
   - Orphaned data

2. **High Priority**:
   - Normalization issues (2NF, 3NF)
   - Inefficient data types
   - Nullable foreign keys
   - Missing composite indexes

3. **Medium Priority**:
   - Over-normalization (too many tables)
   - Unused indexes
   - Redundant indexes
   - Inconsistent naming

### Phase 4: Optimization Recommendations
1. Index suggestions:
   - Add missing indexes for foreign keys
   - Composite indexes for common queries
   - Partial indexes for filtered queries
   - Remove unused indexes

2. Schema improvements:
   - Normalization fixes
   - Data type optimizations
   - Constraint additions
   - Performance enhancements

### Phase 5: Documentation Generation
1. Create comprehensive schema documentation
2. Generate ER diagram (Mermaid format)
3. Document all relationships
4. Create data dictionary
5. Provide migration scripts for fixes

## Output Structure

```markdown
# Database Schema Analysis Report

## Executive Summary

- **Database**: PostgreSQL 15.2
- **Tables**: 23
- **Relationships**: 31 foreign keys
- **Health Score**: 7.5/10

### Issues Found
- **Critical**: 3 (require immediate attention)
- **High Priority**: 7 (complete within 2 weeks)
- **Medium Priority**: 5 (nice to have)

### Expected Improvements
- Query performance: +60% faster
- Disk space: 45MB saved
- Maintainability: Significantly improved

---

## Schema Visualization

### Entity-Relationship Diagram

\`\`\`mermaid
erDiagram
    USERS ||--o{ POSTS : creates
    USERS ||--|| PROFILES : has
    USERS }o--o{ ROLES : has
    POSTS ||--o{ COMMENTS : receives
    POSTS }o--o{ TAGS : tagged_with

    USERS {
        int id PK
        string email UK
        string username UK
        timestamp created_at
    }

    POSTS {
        int id PK
        int user_id FK
        string title
        string slug UK
        timestamp published_at
    }

    COMMENTS {
        int id PK
        int post_id FK
        int user_id FK
        text content
    }
\`\`\`

### Table Overview

| Table | Rows | Columns | Relationships | Indexes | Issues |
|-------|------|---------|---------------|---------|--------|
| users | 10,523 | 8 | 3 outgoing | 3 | 0 ✓ |
| posts | 45,231 | 10 | 2 outgoing, 1 incoming | 4 | 1 ⚠️ |
| comments | 123,456 | 6 | 2 incoming | 2 | 2 ⚠️ |
| profiles | 10,523 | 7 | 1 incoming | 2 | 0 ✓ |
| tags | 234 | 4 | 1 outgoing | 2 | 0 ✓ |
| post_tags | 89,445 | 2 | 2 incoming | 2 | 0 ✓ |
| sessions | 3,421 | 4 | 0 | 0 | 1 🔴 |

---

## Critical Issues

### 1. Missing Primary Key on sessions
- **Impact**: Cannot uniquely identify rows, poor query performance
- **Affected Table**: `sessions` (3,421 rows)
- **Risk Level**: Critical
- **Data Integrity**: At risk
- **Fix**:
  \`\`\`sql
  ALTER TABLE sessions ADD COLUMN id SERIAL PRIMARY KEY;
  \`\`\`
- **Estimated Time**: 5 minutes
- **Rollback**: Safe (only adds column)

### 2. Foreign Key Without Index: comments.post_id
- **Impact**: Slow JOIN queries (2.3s → 50ms after fix)
- **Affected Table**: `comments` (123,456 rows)
- **Query Frequency**: 15,000 queries/day
- **Current Performance**: 2.3s average
- **Expected Performance**: <50ms (98% faster)
- **Fix**:
  \`\`\`sql
  CREATE INDEX idx_comments_post_id ON comments(post_id);
  \`\`\`
- **Estimated Time**: 30 seconds
- **Downtime**: None (CONCURRENTLY flag)

### 3. Denormalization: users.phone1, phone2, phone3
- **Impact**: Violates First Normal Form, inflexible design
- **Affected Table**: `users`
- **Problem**: Repeating groups prevent flexible phone number management
- **Fix**:
  \`\`\`sql
  -- Create normalized table
  CREATE TABLE phone_numbers (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    phone VARCHAR(20) NOT NULL,
    phone_type VARCHAR(20) DEFAULT 'primary',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );

  -- Migrate data
  INSERT INTO phone_numbers (user_id, phone, phone_type)
  SELECT id, phone1, 'primary' FROM users WHERE phone1 IS NOT NULL
  UNION ALL
  SELECT id, phone2, 'secondary' FROM users WHERE phone2 IS NOT NULL
  UNION ALL
  SELECT id, phone3, 'tertiary' FROM users WHERE phone3 IS NOT NULL;

  -- Add index
  CREATE INDEX idx_phone_numbers_user ON phone_numbers(user_id);

  -- Drop old columns (in separate migration after app update)
  ALTER TABLE users DROP COLUMN phone1, DROP COLUMN phone2, DROP COLUMN phone3;
  \`\`\`
- **Estimated Time**: 2 hours (includes application changes)
- **Migration Required**: Yes (application code must be updated)

---

## High Priority Issues

### 4. Transitive Dependency: order_items.product_name
- **Impact**: Violates Third Normal Form
- **Table**: `order_items`
- **Problem**: product_name depends on product_id, not the primary key
- **Normalization**: 2NF → 3NF
- **Fix**: Remove product_name, join with products table

### 5. Inefficient Data Type: country_code
- **Table**: `users`
- **Current**: VARCHAR(255)
- **Optimal**: CHAR(2)
- **Waste**: ~250 bytes per row × 10,523 rows = 2.6MB
- **Fix**:
  \`\`\`sql
  ALTER TABLE users ALTER COLUMN country_code TYPE CHAR(2);
  \`\`\`

### 6. Nullable Foreign Key: posts.user_id
- **Problem**: Posts without authors (orphaned data)
- **Found**: 15 orphaned posts
- **Fix**:
  \`\`\`sql
  -- Clean up orphaned posts
  DELETE FROM posts WHERE user_id IS NULL;

  -- Add NOT NULL constraint
  ALTER TABLE posts ALTER COLUMN user_id SET NOT NULL;
  \`\`\`

### 7. Missing Composite Index
- **Query**: `SELECT * FROM orders WHERE user_id = ? AND status = ?`
- **Frequency**: 10,000/day
- **Current Time**: 450ms
- **Expected Time**: 5ms (99% faster)
- **Fix**:
  \`\`\`sql
  CREATE INDEX idx_orders_user_status ON orders(user_id, status);
  \`\`\`

[Issues 8-10...]

---

## Medium Priority Issues

### 11. Unused Indexes
- `idx_users_created_at` - 0 scans in 30 days
- `idx_posts_slug` - 12 scans (rarely used)
- Recommendation: Drop to improve write performance

### 12. Redundant Indexes
- `idx_orders_user_status` covers `idx_orders_user`
- Keep composite, drop single-column index

### 13. Large Table: user_settings (47 columns)
- Suggests multiple concerns in one table
- Recommendation: Split into user_preferences, user_privacy, user_integrations

---

## Normalization Assessment

| Normal Form | Compliant Tables | Percentage | Status |
|-------------|------------------|------------|--------|
| 1NF (Atomic values) | 21/23 | 91% | ⚠️ Good |
| 2NF (No partial dependencies) | 19/23 | 83% | ⚠️ Fair |
| 3NF (No transitive dependencies) | 17/23 | 74% | ⚠️ Fair |

### Violations

**1NF Violations**:
- `users` table: phone1, phone2, phone3 (repeating groups)
- `products` table: JSON array in variants column

**2NF Violations**:
- `order_items`: product_name depends only on product_id (partial dependency)

**3NF Violations**:
- `employees`: department_name depends on department_id (transitive dependency)
- `order_items`: product details depend on product_id

---

## Relationship Analysis

### Well-Designed Relationships ✓

1. **users → posts** (1:N)
   - Foreign key: ✓ posts.user_id → users.id
   - Index: ✓ idx_posts_user_id
   - Cascade: ✓ ON DELETE CASCADE
   - Integrity: ✓ No orphaned posts

2. **users ↔ roles** (M:N)
   - Junction: ✓ user_roles with composite PK
   - Indexes: ✓ Both FKs indexed
   - Integrity: ✓ No orphaned associations

### Problematic Relationships ✗

3. **comments → posts** (N:1)
   - Foreign key: ✓ Defined
   - Index: ✗ Missing on post_id
   - Performance: ✗ Slow queries (2.3s)

4. **Polymorphic: likes**
   - Type: commentable_id + commentable_type
   - Problem: No database-level referential integrity
   - Risk: Orphaned likes possible
   - Recommendation: Use separate tables

---

## Index Optimization Plan

### Add Missing Indexes (High Impact)

\`\`\`sql
-- Foreign key indexes
CREATE INDEX CONCURRENTLY idx_comments_post_id ON comments(post_id);
CREATE INDEX CONCURRENTLY idx_reactions_post_id ON reactions(post_id);
CREATE INDEX CONCURRENTLY idx_order_items_order_id ON order_items(order_id);

-- Composite indexes for common queries
CREATE INDEX CONCURRENTLY idx_orders_user_status ON orders(user_id, status);
CREATE INDEX CONCURRENTLY idx_posts_user_created ON posts(user_id, created_at DESC);

-- Partial indexes
CREATE INDEX CONCURRENTLY idx_active_users ON users(last_login) WHERE status = 'active';
\`\`\`

**Expected Impact**: +60% faster queries

### Remove Unused Indexes

\`\`\`sql
DROP INDEX CONCURRENTLY idx_users_created_at;  -- 0 scans
DROP INDEX CONCURRENTLY idx_posts_old_slug;    -- Replaced by idx_posts_slug
\`\`\`

**Expected Impact**: +15% faster writes, 45MB disk space saved

---

## Performance Projections

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Avg Query Time | 320ms | 95ms | 70% faster |
| Comments Load | 2,300ms | 45ms | 98% faster |
| Orders Query | 450ms | 5ms | 99% faster |
| Write Performance | Baseline | +15% | Fewer indexes |
| Database Size | 2.4GB | 2.35GB | 50MB saved |
| Index Efficiency | 73% | 95% | +22 points |

---

## Generated Documentation

### File: `docs/database-schema.md`
Complete schema documentation including:
- Entity-Relationship Diagram (Mermaid)
- Table definitions with all columns
- Relationship map with cardinality
- Index list with usage statistics
- Data dictionary with business logic

### File: `docs/database-migrations.md`
SQL migration scripts for all recommended fixes

---

## Implementation Roadmap

### Week 1: Critical Fixes (Priority 1)

**Day 1**:
- Add primary key to sessions table
- Estimated time: 1 hour

**Day 2-3**:
- Add missing foreign key indexes
- Estimated time: 2 hours
- Performance impact: +50% faster queries

**Day 4-5**:
- Fix denormalization (phone numbers)
- Estimated time: 8 hours (includes app changes)

**Week 1 Result**: Compliance score → 8.0/10

### Week 2: High Priority (Priority 2)

- Add composite indexes
- Fix 3NF violations
- Add NOT NULL constraints
- Fix data type inefficiencies

**Week 2 Result**: Compliance score → 9.0/10

### Week 3: Optimization

- Drop unused indexes
- Implement partial indexes
- Split large tables
- Add covering indexes

**Week 3 Result**: Compliance score → 9.5/10

---

## Migration Scripts Generated

All SQL scripts available in:
- `migrations/critical/*.sql` - Critical fixes
- `migrations/high-priority/*.sql` - High priority improvements
- `migrations/optimization/*.sql` - Optimization changes

Each migration includes:
- ✓ Up migration (apply changes)
- ✓ Down migration (rollback)
- ✓ Verification queries
- ✓ Rollback procedures

---

## Testing Checklist

- [ ] Review analysis with database administrator
- [ ] Test migrations on development database
- [ ] Verify no breaking changes to application
- [ ] Benchmark query performance before/after
- [ ] Test migrations on staging database
- [ ] Create database backup before production
- [ ] Schedule maintenance window if needed
- [ ] Execute migrations on production
- [ ] Monitor application for issues
- [ ] Verify performance improvements

---

## Next Steps

1. **This Week**: Review report with team
2. **Week 1**: Implement critical fixes
3. **Week 2**: Apply high-priority improvements
4. **Week 3**: Optimize and monitor
5. **Ongoing**: Re-run analysis quarterly
```

## When to Use

- New project database design review
- Pre-deployment schema validation
- Performance troubleshooting
- Database refactoring planning
- Quarterly health checks
- Before major migrations
- Technical debt assessment

This command provides complete schema analysis with actionable recommendations and implementation plans.
