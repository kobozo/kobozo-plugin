---
description: Generate database migration scripts from schema changes - supports multiple ORMs with up/down migrations and rollback safety
---

# Generate Migration

Create safe, reversible database migration scripts.

## Usage

```
/generate-migration <change-description>
```

**Examples:**
```
/generate-migration add email_verified to users
/generate-migration rename column old_name to new_name in users
/generate-migration create posts table
/generate-migration add index on users.email
```

## Execution Flow

### Phase 1: Change Detection
1. Launch **migration-generator** agent
2. Parse change description
3. Detect migration framework:
   - Sequelize (Node.js)
   - TypeORM (TypeScript)
   - Prisma
   - Django (Python)
   - Rails (Ruby)
   - Flyway (Java)
   - Raw SQL (framework-agnostic)

### Phase 2: Migration Design
1. Determine migration type:
   - Add/remove column
   - Rename column
   - Change column type
   - Add/drop table
   - Add/remove index
   - Add/remove foreign key
   - Data transformation

2. Design zero-downtime strategy:
   - Expand-contract pattern for breaking changes
   - Concurrent index creation
   - Backfill strategies for NOT NULL
   - Blue-green for major changes

### Phase 3: Script Generation
1. Generate **up** migration (apply changes)
2. Generate **down** migration (rollback)
3. Add transaction safety
4. Include verification queries
5. Add timing estimates
6. Provide rollback procedures

### Phase 4: Safety Analysis
1. Assess impact:
   - Table lock duration
   - Affected rows
   - Downtime requirement
   - Rollback safety

2. Identify risks:
   - Data loss potential
   - Application compatibility
   - Performance degradation
   - Referential integrity

### Phase 5: Testing Instructions
1. Development testing commands
2. Staging deployment steps
3. Production deployment checklist
4. Monitoring guidelines
5. Rollback procedures

## Output Structure

```markdown
# Migration: Add Email Verification

**Generated**: 2024-01-15 14:30
**Type**: Add Column
**Framework**: Sequelize
**Database**: PostgreSQL
**Estimated Time**: 2 minutes (100K rows)

---

## Summary

Add `email_verified` boolean column to users table with default value false.

### Changes:
1. Add column: `email_verified` BOOLEAN DEFAULT false
2. Add index: `idx_users_email` UNIQUE on email column

---

## Impact Assessment

### Risk Analysis
- **Risk Level**: Low ⚠️
- **Table Lock**: <100ms (adding nullable column with default)
- **Affected Rows**: ~100,000 users
- **Downtime Required**: None (zero-downtime migration)
- **Reversible**: Yes ✓
- **Data Loss Potential**: None ✓

### Performance Impact
- **Read Operations**: No impact
- **Write Operations**: Minimal (<5ms per INSERT/UPDATE)
- **Disk Space**: +100KB (boolean column + index)

---

## Generated Migration Files

### File: `migrations/20240115143000-add-email-verified.js`

\`\`\`javascript
'use strict';

/**
 * Migration: Add email_verified column to users
 *
 * Up: Adds email_verified boolean column and unique index on email
 * Down: Removes index and column
 *
 * Estimated time: ~2 minutes for 100K rows
 * Downtime: None
 */

module.exports = {
  async up(queryInterface, Sequelize) {
    const transaction = await queryInterface.sequelize.transaction();

    try {
      console.log('Starting migration: add email_verified');

      // Step 1: Add email_verified column
      console.log('  Adding column: email_verified');
      await queryInterface.addColumn(
        'users',
        'email_verified',
        {
          type: Sequelize.BOOLEAN,
          defaultValue: false,
          allowNull: false,
          comment: 'Whether user email has been verified'
        },
        { transaction }
      );

      // Step 2: Add unique index on email
      console.log('  Creating index: idx_users_email_unique');
      await queryInterface.addIndex(
        'users',
        ['email'],
        {
          name: 'idx_users_email_unique',
          unique: true,
          transaction
        }
      );

      await transaction.commit();
      console.log('✓ Migration completed successfully');

      // Verification
      const [results] = await queryInterface.sequelize.query(
        "SELECT column_name FROM information_schema.columns WHERE table_name = 'users' AND column_name = 'email_verified'"
      );
      console.log(\`✓ Verified: email_verified column exists (\${results.length} found)\`);

    } catch (error) {
      await transaction.rollback();
      console.error('✗ Migration failed:', error.message);
      throw error;
    }
  },

  async down(queryInterface, Sequelize) {
    const transaction = await queryInterface.sequelize.transaction();

    try {
      console.log('Starting rollback: remove email_verified');

      // Step 1: Remove index
      console.log('  Dropping index: idx_users_email_unique');
      await queryInterface.removeIndex(
        'users',
        'idx_users_email_unique',
        { transaction }
      );

      // Step 2: Remove column
      console.log('  Dropping column: email_verified');
      await queryInterface.removeColumn(
        'users',
        'email_verified',
        { transaction }
      );

      await transaction.commit();
      console.log('✓ Rollback completed successfully');

    } catch (error) {
      await transaction.rollback();
      console.error('✗ Rollback failed:', error.message);
      throw error;
    }
  }
};
\`\`\`

---

## Alternative Frameworks

### TypeORM Migration

**File**: `migrations/1705329000000-AddEmailVerified.ts`

\`\`\`typescript
import { MigrationInterface, QueryRunner, TableColumn, TableIndex } from 'typeorm';

export class AddEmailVerified1705329000000 implements MigrationInterface {
  name = 'AddEmailVerified1705329000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    // Add column
    await queryRunner.addColumn(
      'users',
      new TableColumn({
        name: 'email_verified',
        type: 'boolean',
        default: false,
        isNullable: false,
        comment: 'Whether user email has been verified'
      })
    );

    // Add index
    await queryRunner.createIndex(
      'users',
      new TableIndex({
        name: 'idx_users_email_unique',
        columnNames: ['email'],
        isUnique: true
      })
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropIndex('users', 'idx_users_email_unique');
    await queryRunner.dropColumn('users', 'email_verified');
  }
}
\`\`\`

### Django Migration

**File**: `app/migrations/0002_add_email_verified.py`

\`\`\`python
from django.db import migrations, models

class Migration(migrations.Migration):
    dependencies = [
        ('app', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='email_verified',
            field=models.BooleanField(default=False),
        ),
        migrations.AddIndex(
            model_name='user',
            index=models.Index(fields=['email'], name='idx_users_email'),
        ),
    ]
\`\`\`

### Raw SQL (Framework-Agnostic)

**File**: `migrations/001_add_email_verified.up.sql`

\`\`\`sql
-- Migration: Add email_verified column
-- Generated: 2024-01-15 14:30
-- Estimated time: 2 minutes

BEGIN;

-- Add column with default
ALTER TABLE users
ADD COLUMN email_verified BOOLEAN DEFAULT false NOT NULL;

-- Add comment
COMMENT ON COLUMN users.email_verified IS 'Whether user email has been verified';

-- Add unique index (use CONCURRENTLY to avoid table lock)
CREATE UNIQUE INDEX CONCURRENTLY idx_users_email_unique ON users(email);

COMMIT;

-- Verification
SELECT COUNT(*) as verified_users
FROM users
WHERE email_verified = true;

SELECT COUNT(*) as total_users
FROM users;
\`\`\`

**File**: `migrations/001_add_email_verified.down.sql`

\`\`\`sql
-- Rollback: Remove email_verified column
BEGIN;

DROP INDEX CONCURRENTLY IF EXISTS idx_users_email_unique;
ALTER TABLE users DROP COLUMN IF EXISTS email_verified;

COMMIT;

-- Verify rollback
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'users' AND column_name = 'email_verified';
-- Should return 0 rows
\`\`\`

---

## Testing Guide

### Step 1: Development Environment

\`\`\`bash
# 1. Run migration
npx sequelize-cli db:migrate

# 2. Verify schema
psql development_db -c "\\d users"

# Expected output:
#   Column         |  Type   | Nullable | Default
# -----------------+---------+----------+---------
#   email_verified | boolean | not null | false

# 3. Verify index
psql development_db -c "\\di idx_users_email_unique"

# 4. Test with sample data
psql development_db <<SQL
INSERT INTO users (email, email_verified) VALUES
  ('test@example.com', false),
  ('verified@example.com', true);

SELECT email, email_verified FROM users ORDER BY email;
SQL

# 5. Test rollback
npx sequelize-cli db:migrate:undo

# 6. Verify rollback
psql development_db -c "\\d users"
# email_verified column should be gone

# 7. Re-apply migration
npx sequelize-cli db:migrate
\`\`\`

### Step 2: Staging Environment

\`\`\`bash
# 1. Backup staging database
pg_dump staging_db > backup_staging_$(date +%Y%m%d_%H%M%S).sql

# 2. Apply migration
NODE_ENV=staging npx sequelize-cli db:migrate

# 3. Run application tests
npm test

# 4. Check logs for errors
tail -f logs/app.log | grep -i error

# 5. Verify data integrity
psql staging_db <<SQL
-- Check for NULL values (should be 0)
SELECT COUNT(*) FROM users WHERE email_verified IS NULL;

-- Check distribution
SELECT
  email_verified,
  COUNT(*) as count
FROM users
GROUP BY email_verified;
SQL

# 6. Performance test
psql staging_db <<SQL
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'test@example.com';
-- Should use idx_users_email_unique
SQL

# 7. If issues found, rollback
NODE_ENV=staging npx sequelize-cli db:migrate:undo
\`\`\`

### Step 3: Production Deployment

\`\`\`bash
# Pre-deployment checklist:
# [ ] Tested on development ✓
# [ ] Tested on staging ✓
# [ ] Application code deployed (can handle email_verified field)
# [ ] Database backup created
# [ ] Maintenance window scheduled (optional, migration is zero-downtime)
# [ ] Team notified
# [ ] Rollback plan ready

# 1. Create backup
pg_dump production_db > backup_prod_$(date +%Y%m%d_%H%M%S).sql
# Verify backup size
ls -lh backup_prod_*.sql

# 2. Test migration on backup copy (optional but recommended)
createdb test_migration
psql test_migration < backup_prod_20240115.sql
NODE_ENV=test npx sequelize-cli db:migrate
# If successful, drop test database
dropdb test_migration

# 3. Apply migration to production
echo "Starting production migration at $(date)"
NODE_ENV=production npx sequelize-cli db:migrate
echo "Migration completed at $(date)"

# 4. Immediate verification
psql production_db <<SQL
-- Verify column exists
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'users'
  AND column_name = 'email_verified';

-- Check row count (should match total users)
SELECT COUNT(*) FROM users WHERE email_verified IS NOT NULL;
SQL

# 5. Monitor application
# - Watch for errors in logs
# - Check response times (should be unchanged)
# - Monitor database connections
# - Check for any user complaints

# 6. If issues occur, execute rollback
NODE_ENV=production npx sequelize-cli db:migrate:undo
\`\`\`

---

## Rollback Procedures

### Immediate Rollback (< 1 hour after deployment)

\`\`\`bash
# Using migration tool
npx sequelize-cli db:migrate:undo

# Or manual SQL
psql production_db <<SQL
BEGIN;
DROP INDEX CONCURRENTLY idx_users_email_unique;
ALTER TABLE users DROP COLUMN email_verified;
COMMIT;
SQL
\`\`\`

### Delayed Rollback (> 1 hour, data may exist)

\`\`\`bash
# If application has been writing to email_verified field,
# consider data preservation needs

# Option 1: Simple rollback (lose email_verified data)
npx sequelize-cli db:migrate:undo

# Option 2: Preserve data before rollback
psql production_db <<SQL
-- Export email_verified state
CREATE TEMP TABLE email_verified_backup AS
SELECT id, email_verified FROM users;

-- Save to file
\\copy (SELECT * FROM email_verified_backup) TO '/tmp/email_verified_backup.csv' CSV HEADER;
SQL

# Then rollback
npx sequelize-cli db:migrate:undo
\`\`\`

---

## Verification Queries

\`\`\`sql
-- 1. Verify column exists
SELECT
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_name = 'users'
  AND column_name = 'email_verified';

-- Expected: 1 row with type 'boolean', nullable 'NO', default 'false'

-- 2. Verify index exists
SELECT
  indexname,
  indexdef
FROM pg_indexes
WHERE tablename = 'users'
  AND indexname = 'idx_users_email_unique';

-- Expected: 1 row with CREATE UNIQUE INDEX definition

-- 3. Check data distribution
SELECT
  email_verified,
  COUNT(*) as count,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) as percentage
FROM users
GROUP BY email_verified
ORDER BY email_verified;

-- Expected: All users have email_verified = false initially

-- 4. Check for NULL values (should be 0)
SELECT COUNT(*) as null_count
FROM users
WHERE email_verified IS NULL;

-- Expected: 0

-- 5. Check for duplicate emails (should be 0 after unique index)
SELECT email, COUNT(*) as count
FROM users
GROUP BY email
HAVING COUNT(*) > 1;

-- Expected: 0 rows

-- 6. Performance check (should use index)
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'test@example.com';

-- Expected: Index Scan using idx_users_email_unique
\`\`\`

---

## Monitoring After Deployment

### Metrics to Watch

1. **Query Performance**
   \`\`\`sql
   -- Check slow queries
   SELECT query, mean_exec_time, calls
   FROM pg_stat_statements
   WHERE query LIKE '%users%'
   ORDER BY mean_exec_time DESC
   LIMIT 10;
   \`\`\`

2. **Table Size**
   \`\`\`sql
   SELECT
     pg_size_pretty(pg_total_relation_size('users')) as total_size,
     pg_size_pretty(pg_relation_size('users')) as table_size,
     pg_size_pretty(pg_indexes_size('users')) as indexes_size;
   \`\`\`

3. **Index Usage**
   \`\`\`sql
   SELECT
     indexname,
     idx_scan,
     idx_tup_read,
     idx_tup_fetch
   FROM pg_stat_user_indexes
   WHERE tablename = 'users'
   ORDER BY idx_scan DESC;
   \`\`\`

### Application Logs

\`\`\`bash
# Watch for errors related to email_verified
tail -f /var/log/app/production.log | grep -i "email_verified\\|column.*not.*exist"

# Monitor API response times
tail -f /var/log/app/access.log | awk '{print $NF}' | sort -n | tail -n 20
\`\`\`

---

## Next Steps

1. ✓ Migration files generated
2. ⏳ Test on development database
3. ⏳ Test on staging environment
4. ⏳ Update application code to use email_verified field
5. ⏳ Deploy application changes
6. ⏳ Schedule production migration
7. ⏳ Execute production migration
8. ⏳ Monitor and verify
```

## When to Use

- Adding/removing database columns
- Creating new tables
- Changing column types
- Adding/removing indexes
- Refactoring relationships
- Data transformations
- Schema normalization

This command generates production-ready migrations with comprehensive testing and rollback procedures.
