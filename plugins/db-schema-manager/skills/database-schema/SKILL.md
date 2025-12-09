---
description: This skill should be used when the user asks about "database schema", "analyze schema", "generate migration", "database relationships", "schema design", "add column", "create table", "database optimization", or needs help with database schema management. Provides guidance on schema analysis and migration generation.
---

# Database Schema Skill

Manage database schemas with analysis, documentation, and migration generation.

## When to Use

- Analyzing existing database schemas
- Generating database migrations
- Understanding table relationships
- Optimizing database design
- Creating new tables or columns

## Quick Actions (Handled by Skill)

### Schema Design Questions
- Table relationship patterns
- Index optimization strategies
- Normalization guidance
- Data type selection

### Migration Best Practices
- Safe vs risky migrations
- Rollback strategies
- Zero-downtime migrations
- Data backfill patterns

## Schema Analysis Patterns

### Relationship Types
| Type | Pattern | Example |
|------|---------|---------|
| One-to-One | Foreign key with unique | User → Profile |
| One-to-Many | Foreign key | User → Posts |
| Many-to-Many | Junction table | Users ↔ Roles |
| Self-referential | FK to same table | Employee → Manager |

### Index Strategy
```sql
-- Primary lookup fields
CREATE INDEX idx_users_email ON users(email);

-- Composite for multi-column queries
CREATE INDEX idx_orders_user_date ON orders(user_id, created_at);

-- Partial indexes for filtered queries
CREATE INDEX idx_active_users ON users(id) WHERE active = true;
```

### Common Issues to Check
- Missing indexes on foreign keys
- Unused indexes (write overhead)
- Missing cascade rules
- Data type mismatches across joins
- N+1 query patterns

## Migration Patterns

### Safe Migrations (Zero Downtime)
- Add column (with default)
- Add index (CONCURRENTLY)
- Add table
- Rename with alias

### Risky Migrations (Plan Carefully)
- Drop column
- Rename column without alias
- Change data type
- Add NOT NULL to existing column
- Large table alterations

### Migration Template
```sql
-- Up migration
ALTER TABLE users ADD COLUMN email_verified BOOLEAN DEFAULT false;
CREATE INDEX CONCURRENTLY idx_users_email_verified ON users(email_verified);

-- Down migration
DROP INDEX IF EXISTS idx_users_email_verified;
ALTER TABLE users DROP COLUMN email_verified;
```

## Full Workflows (Use Commands)

For comprehensive operations that require file paths or descriptions:

### Analyze Schema
```
/db-schema-manager:analyze-schema [database-type]
```
**Use when:** Need complete schema analysis with relationship mapping, issue detection, and optimization recommendations.

**Arguments:**
- `postgres` / `postgresql`
- `mysql`
- `mongodb`
- `orm` - Analyze from ORM models

### Generate Migration
```
/db-schema-manager:generate-migration <change-description>
```
**Use when:** Need to create migration scripts for schema changes.

**Examples:**
- `/generate-migration add email_verified to users`
- `/generate-migration create posts table`
- `/generate-migration add index on users.email`
- `/generate-migration rename column old_name to new_name in users`

## Supported Frameworks

| Database | Migration Tool |
|----------|---------------|
| PostgreSQL | Raw SQL, Knex |
| MySQL | Raw SQL, Knex |
| MongoDB | Mongoose |
| ORM | Sequelize, TypeORM, Prisma, Django, Rails |

## Quick Reference

### When to Use Each Command
| Need | Command |
|------|---------|
| Understand schema | `/analyze-schema` |
| Add/modify structure | `/generate-migration` |
| Best practices question | Ask directly (skill handles) |

### Migration Checklist
- [ ] Has rollback (down migration)
- [ ] Tested on staging data
- [ ] Handles existing data
- [ ] Index operations are CONCURRENT
- [ ] No table locks during peak
