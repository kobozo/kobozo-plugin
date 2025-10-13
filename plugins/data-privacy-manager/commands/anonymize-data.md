---
description: Generate data anonymization scripts for databases and create synthetic test data
---

# Anonymize Data

Create anonymization scripts and synthetic test data for safe development and testing.

## Usage

```
/anonymize-data [target]
```

**Target options:**
- `database` - Generate database anonymization scripts
- `test-data` - Create synthetic test data
- `api` - Add anonymization middleware for API responses
- `all` - All of the above (default)

## Execution Flow

### Phase 1: Personal Data Identification
1. Launch **data-anonymizer** agent
2. Scan codebase for personal data:
   - Database schemas (models, migrations)
   - API endpoints (request/response bodies)
   - Form inputs (frontend components)
   - Configuration files (environment variables)
3. Categorize data types:
   - Direct identifiers (email, phone, SSN)
   - Quasi-identifiers (age, location, IP)
   - Sensitive attributes (health, financial)

### Phase 2: Anonymization Strategy Selection

Determine appropriate technique for each data type:

**Masking**: For display purposes
- Email addresses
- Phone numbers
- Credit cards

**Pseudonymization**: For analytics
- User IDs
- Session identifiers
- Consistent but unlinkable

**Generalization**: For aggregation
- Age → Age ranges
- Address → City/State only
- Salary → Salary bands

**Synthetic Generation**: For testing
- Complete fake records
- Realistic but not real
- Maintains relationships

### Phase 3: Script Generation

Generate database-specific anonymization scripts:

**PostgreSQL**:
- SQL function with UPDATE statements
- Preserves referential integrity
- Supports large datasets

**MongoDB**:
- JavaScript aggregation pipeline
- Bulk update operations
- Handles nested documents

**MySQL**:
- Stored procedure
- Transaction-safe
- Handles foreign keys

### Phase 4: Validation & Testing

1. Generate validation queries to verify:
   - No real emails/phones remain
   - Foreign keys intact
   - Data formats preserved
   - Statistical properties maintained

2. Provide testing instructions
3. Include rollback procedures

## Output Structure

```markdown
# Data Anonymization Package

## Personal Data Inventory

### Database: PostgreSQL

#### Table: users (14 columns with PII)
- **email** (Direct identifier)
  - Count: 10,523 records
  - Format: email address
  - Anonymization: Replace with `user{id}@anonymized.local`

- **first_name, last_name** (Direct identifiers)
  - Count: 10,523 records
  - Format: text
  - Anonymization: Replace with `User {id}`

- **phone** (Direct identifier)
  - Count: 8,934 records (85% have phone)
  - Format: +1-XXX-XXX-XXXX
  - Anonymization: Mask (keep last 4 digits)

- **ssn** (Direct identifier, highly sensitive)
  - Count: 3,421 records (33% have SSN)
  - Format: XXX-XX-XXXX
  - Anonymization: Remove completely

- **date_of_birth** (Quasi-identifier)
  - Count: 10,523 records
  - Format: YYYY-MM-DD
  - Anonymization: Add ±7 days random noise

- **address** (Quasi-identifier)
  - Count: 9,234 records
  - Format: Full address
  - Anonymization: Keep city/state, remove street/zip

#### Table: payment_methods (5 columns with PII)
- **card_number** (Direct identifier)
  - Count: 4,521 records
  - Anonymization: Remove completely

- **cvv** (Sensitive)
  - Count: 4,521 records
  - Anonymization: Remove completely

[Additional tables...]

---

## Anonymization Scripts

### 1. PostgreSQL Script
**File**: `scripts/anonymize_postgres.sql`

\`\`\`sql
-- ============================================
-- PostgreSQL Database Anonymization Script
-- Generated: 2024-01-15
-- Target: Production database copy
-- Estimated time: ~2 minutes (100K records)
-- ============================================

BEGIN;

-- Users table
UPDATE users
SET
  email = 'user' || id || '@anonymized.local',
  first_name = 'User',
  last_name = CAST(id AS TEXT),
  phone = CASE
    WHEN phone IS NOT NULL
    THEN '+1-555-' || LPAD(CAST(id AS TEXT), 7, '0')
    ELSE NULL
  END,
  ssn = NULL,
  date_of_birth = date_of_birth + (random() * 14 - 7) * INTERVAL '1 day';

-- Addresses table
UPDATE addresses
SET
  street = CAST(id AS TEXT) || ' Anonymous St',
  postal_code = '00000';
-- Keep: city, state (quasi-identifiers for analytics)

-- Payment methods table
UPDATE payment_methods
SET
  card_number = NULL,
  cvv = NULL,
  bank_account = NULL;

-- Session tokens (security)
DELETE FROM sessions WHERE expires_at < NOW();
UPDATE sessions SET token = md5(random()::text);

-- Analytics events (pseudonymization)
UPDATE analytics_events
SET
  ip_address = '0.0.0.0',
  user_agent = 'Anonymized';

COMMIT;

-- Verification queries
SELECT 'Users anonymized:' as status, COUNT(*) as count FROM users WHERE email LIKE '%@anonymized.local';
SELECT 'Real emails remaining:' as warning, COUNT(*) as count FROM users WHERE email NOT LIKE '%@anonymized.local';
SELECT 'SSNs remaining:' as warning, COUNT(*) as count FROM users WHERE ssn IS NOT NULL;
\`\`\`

---

### 2. MongoDB Script
**File**: `scripts/anonymize_mongodb.js`

\`\`\`javascript
// ============================================
// MongoDB Database Anonymization Script
// Generated: 2024-01-15
// Target: Production database copy
// Estimated time: ~1 minute (100K documents)
// ============================================

// Connect to database
use anonymized_db;

// Users collection
db.users.updateMany({}, [
  {
    $set: {
      email: { $concat: ['user', { $toString: '$_id' }, '@anonymized.local'] },
      firstName: 'User',
      lastName: { $toString: '$_id' },
      phone: null,
      ssn: null,
      dateOfBirth: {
        $add: [
          '$dateOfBirth',
          { $multiply: [{ $subtract: [{ $rand: {} }, 0.5] }, 7 * 24 * 60 * 60 * 1000] }
        ]
      },
      'address.street': null,
      'address.zipCode': '00000'
      // Keep: address.city, address.state
    }
  }
]);

// Payment methods
db.paymentMethods.updateMany({}, {
  $unset: {
    cardNumber: '',
    cvv: '',
    bankAccount: ''
  }
});

// Sessions (security)
db.sessions.deleteMany({ expiresAt: { $lt: new Date() } });
db.sessions.updateMany({}, [
  {
    $set: {
      token: { $function: {
        body: function() { return Math.random().toString(36); },
        args: [],
        lang: 'js'
      }}
    }
  }
]);

// Analytics
db.analyticsEvents.updateMany({}, {
  $set: {
    ipAddress: '0.0.0.0',
    userAgent: 'Anonymized'
  }
});

// Verification
print('Users anonymized:', db.users.countDocuments({ email: /@anonymized\.local$/ }));
print('Real emails remaining:', db.users.countDocuments({ email: { $not: /@anonymized\.local$/ } }));
print('SSNs remaining:', db.users.countDocuments({ ssn: { $ne: null } }));
\`\`\`

---

### 3. MySQL Script
**File**: `scripts/anonymize_mysql.sql`

\`\`\`sql
-- ============================================
-- MySQL Database Anonymization Script
-- Generated: 2024-01-15
-- Target: Production database copy
-- Estimated time: ~2 minutes (100K records)
-- ============================================

DELIMITER $$

CREATE PROCEDURE anonymize_database()
BEGIN
  -- Users
  UPDATE users
  SET
    email = CONCAT('user', id, '@anonymized.local'),
    first_name = 'User',
    last_name = CAST(id AS CHAR),
    phone = CASE
      WHEN phone IS NOT NULL
      THEN CONCAT('+1-555-', LPAD(id, 7, '0'))
      ELSE NULL
    END,
    ssn = NULL,
    date_of_birth = DATE_ADD(
      date_of_birth,
      INTERVAL FLOOR(RAND() * 14 - 7) DAY
    );

  -- Addresses
  UPDATE addresses
  SET
    street = CONCAT(id, ' Anonymous St'),
    postal_code = '00000';

  -- Payment methods
  UPDATE payment_methods
  SET
    card_number = NULL,
    cvv = NULL,
    bank_account = NULL;

  -- Sessions
  DELETE FROM sessions WHERE expires_at < NOW();

  -- Analytics
  UPDATE analytics_events
  SET
    ip_address = '0.0.0.0',
    user_agent = 'Anonymized';

  -- Verification
  SELECT 'Users anonymized' as status, COUNT(*) as count
  FROM users WHERE email LIKE '%@anonymized.local';

  SELECT 'Real emails remaining' as warning, COUNT(*) as count
  FROM users WHERE email NOT LIKE '%@anonymized.local';
END$$

DELIMITER ;

-- Execute
CALL anonymize_database();
\`\`\`

---

## Synthetic Test Data Generator

**File**: `scripts/generate_test_data.js`

\`\`\`javascript
// ============================================
// Synthetic Test Data Generator
// Uses @faker-js/faker for realistic data
// ============================================

const { faker } = require('@faker-js/faker');
const fs = require('fs');

// Generate user data
function generateUser(id) {
  return {
    id,
    email: faker.internet.email(),
    firstName: faker.person.firstName(),
    lastName: faker.person.lastName(),
    phone: faker.phone.number('+1-###-###-####'),
    dateOfBirth: faker.date.birthdate({ min: 18, max: 80, mode: 'age' }),
    address: {
      street: faker.location.streetAddress(),
      city: faker.location.city(),
      state: faker.location.state(),
      zipCode: faker.location.zipCode(),
      country: 'USA'
    },
    createdAt: faker.date.past({ years: 2 }),
    lastLogin: faker.date.recent({ days: 30 })
  };
}

// Generate 1000 synthetic users
const users = Array.from({ length: 1000 }, (_, i) => generateUser(i + 1));

// PostgreSQL INSERT statements
const sqlInserts = users.map(u => `
  INSERT INTO users (id, email, first_name, last_name, phone, date_of_birth, created_at, last_login)
  VALUES (
    ${u.id},
    '${u.email}',
    '${u.firstName}',
    '${u.lastName}',
    '${u.phone}',
    '${u.dateOfBirth.toISOString().split('T')[0]}',
    '${u.createdAt.toISOString()}',
    '${u.lastLogin.toISOString()}'
  );

  INSERT INTO addresses (user_id, street, city, state, postal_code, country)
  VALUES (
    ${u.id},
    '${u.address.street.replace(/'/g, "''")}',
    '${u.address.city}',
    '${u.address.state}',
    '${u.address.zipCode}',
    '${u.address.country}'
  );
`).join('\n');

fs.writeFileSync('test_data_postgres.sql', sqlInserts);

// MongoDB JSON
fs.writeFileSync('test_data_mongodb.json', JSON.stringify(users, null, 2));

// MySQL INSERT
fs.writeFileSync('test_data_mysql.sql', sqlInserts.replace(/RETURNING/g, ''));

console.log('Generated 1000 synthetic users');
console.log('Files: test_data_postgres.sql, test_data_mongodb.json, test_data_mysql.sql');
\`\`\`

**Usage**:
\`\`\`bash
npm install @faker-js/faker
node scripts/generate_test_data.js
\`\`\`

---

## API Anonymization Middleware

**File**: `src/middleware/anonymize.ts`

\`\`\`typescript
// Anonymization middleware for API responses
import crypto from 'crypto';

interface AnonymizationOptions {
  level: 'full' | 'partial' | 'pseudonym';
  fields?: string[];
}

export function anonymizeMiddleware(options: AnonymizationOptions = { level: 'full' }) {
  return (req, res, next) => {
    // Only apply in development/staging
    if (process.env.NODE_ENV === 'production') {
      return next();
    }

    const originalJson = res.json.bind(res);

    res.json = (data) => {
      const anonymized = anonymizeData(data, options);
      return originalJson(anonymized);
    };

    next();
  };
}

function anonymizeData(data: any, options: AnonymizationOptions): any {
  if (Array.isArray(data)) {
    return data.map(item => anonymizeData(item, options));
  }

  if (typeof data !== 'object' || data === null) {
    return data;
  }

  const result = { ...data };

  if (options.level === 'full') {
    // Full masking
    if (result.email) result.email = maskEmail(result.email);
    if (result.phone) result.phone = maskPhone(result.phone);
    if (result.ssn) result.ssn = null;
    if (result.address) {
      result.address = {
        city: result.address.city,
        state: result.address.state
        // Remove street, zip
      };
    }
  } else if (options.level === 'pseudonym') {
    // Pseudonymization
    if (result.email) result.email = pseudonymize(result.email);
    if (result.userId) result.userId = pseudonymize(result.userId);
  }

  return result;
}

function maskEmail(email: string): string {
  const [local, domain] = email.split('@');
  const maskedLocal = local[0] + '*'.repeat(Math.max(local.length - 1, 3));
  const [domainName, tld] = domain.split('.');
  const maskedDomain = domainName[0] + '*'.repeat(Math.max(domainName.length - 1, 3));
  return \`\${maskedLocal}@\${maskedDomain}.\${tld}\`;
}

function maskPhone(phone: string): string {
  return phone.replace(/\\d(?=\\d{4})/g, '*');
}

function pseudonymize(value: string): string {
  return crypto
    .createHash('sha256')
    .update(value + process.env.ANONYMIZATION_SALT)
    .digest('hex')
    .substring(0, 16);
}
\`\`\`

**Usage**:
\`\`\`typescript
// Apply to all routes
app.use(anonymizeMiddleware({ level: 'full' }));

// Or specific routes
app.get('/api/users', anonymizeMiddleware({ level: 'partial' }), getUsers);
\`\`\`

---

## Implementation Guide

### Step 1: Create Database Copy

\`\`\`bash
# PostgreSQL
pg_dump production_db > backup_prod_$(date +%Y%m%d).sql
createdb development_db
psql development_db < backup_prod_$(date +%Y%m%d).sql

# MongoDB
mongodump --uri="mongodb://prod" --out=backup_prod_$(date +%Y%m%d)
mongorestore --uri="mongodb://dev" backup_prod_$(date +%Y%m%d)

# MySQL
mysqldump -u root -p production_db > backup_prod_$(date +%Y%m%d).sql
mysql -u root -p development_db < backup_prod_$(date +%Y%m%d).sql
\`\`\`

### Step 2: Run Anonymization

\`\`\`bash
# PostgreSQL
psql development_db < scripts/anonymize_postgres.sql

# MongoDB
mongo development_db < scripts/anonymize_mongodb.js

# MySQL
mysql -u root -p development_db < scripts/anonymize_mysql.sql
\`\`\`

### Step 3: Verify Anonymization

\`\`\`sql
-- Check for real emails (should return 0)
SELECT COUNT(*) FROM users WHERE email LIKE '%@gmail.com%' OR email LIKE '%@yahoo.com%';

-- Check for SSNs (should return 0)
SELECT COUNT(*) FROM users WHERE ssn IS NOT NULL;

-- Verify format preservation
SELECT email, phone FROM users LIMIT 10;
\`\`\`

### Step 4: Update Application Config

\`\`\`javascript
// config/database.js
module.exports = {
  development: {
    database: 'development_db', // Anonymized copy
    host: 'localhost'
  },
  production: {
    database: process.env.DB_NAME,
    host: process.env.DB_HOST
  }
};
\`\`\`

---

## K-Anonymity Validation

**File**: `scripts/validate_k_anonymity.sql`

\`\`\`sql
-- Verify k-anonymity (k=5)
-- Each combination of quasi-identifiers should have at least 5 records

SELECT
  FLOOR(EXTRACT(YEAR FROM age(date_of_birth)) / 10) * 10 as age_range,
  LEFT(postal_code, 3) as zip_prefix,
  gender,
  COUNT(*) as group_size
FROM users
GROUP BY age_range, zip_prefix, gender
HAVING COUNT(*) < 5
ORDER BY group_size;

-- If this query returns rows, those groups violate k-anonymity
-- Solution: Further generalize or suppress these records
\`\`\`

---

## Rollback Procedure

If anonymization causes issues:

\`\`\`bash
# Drop anonymized database
dropdb development_db

# Restore from backup
createdb development_db
psql development_db < backup_prod_20240115.sql
\`\`\`

---

## Compliance

- ✓ GDPR Art. 25 (Data protection by design)
- ✓ GDPR Art. 32 (Security of processing)
- ✓ HIPAA Safe Harbor (18 identifiers removed)
- ✓ K-anonymity (k=5 or higher)
- ✓ Differential privacy (noise addition)

**Next Steps**: Use anonymized database for all non-production environments.
```

## When to Use

- Setting up development environment
- Creating staging database
- Sharing data with external teams
- Testing data export features
- Compliance audits
- Training machine learning models

This command generates production-ready anonymization scripts with validation.
