# Data Privacy Manager Plugin

**Version**: 1.0.0
**Author**: Yannick De Backer (yannick@kobozo.eu)

A comprehensive Claude Code plugin for managing data privacy compliance, GDPR requirements, data anonymization, and privacy policy generation.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Commands](#commands)
  - [privacy-audit](#privacy-audit)
  - [anonymize-data](#anonymize-data)
- [Agents](#agents)
  - [GDPR Compliance Checker](#gdpr-compliance-checker)
  - [Privacy Policy Generator](#privacy-policy-generator)
  - [Data Anonymizer](#data-anonymizer)
- [GDPR Compliance Features](#gdpr-compliance-features)
- [Data Anonymization Techniques](#data-anonymization-techniques)
- [Workflow Examples](#workflow-examples)
- [Best Practices](#best-practices)
- [Compliance Standards](#compliance-standards)

## Overview

The Data Privacy Manager plugin helps development teams ensure their applications comply with data protection regulations including GDPR, CCPA, and PIPEDA. It provides automated auditing, documentation generation, and data anonymization capabilities to streamline privacy compliance.

### Key Features

- **Automated GDPR Compliance Audits**: Scan codebases for privacy compliance gaps
- **Privacy Documentation Generation**: Auto-generate privacy policies, cookie policies, and data processing records
- **Data Anonymization**: Create anonymization scripts for databases and synthetic test data
- **User Rights Implementation**: Verify data subject rights (access, rectification, erasure, portability)
- **Third-Party Processor Tracking**: Identify and document external data processors
- **Security Assessment**: Check encryption, authentication, and security measures
- **Risk Analysis**: Quantify compliance risks and potential regulatory fines
- **Implementation Roadmaps**: Prioritized action plans with timelines

## Installation

This plugin is part of the Kobozo Claude Code plugin collection. To use it with Claude Code:

1. Ensure the plugin directory is in your Claude Code plugins path
2. The plugin will be automatically loaded by Claude Code
3. Use the commands via slash commands in your Claude conversations

```bash
# Verify plugin is loaded
claude plugins list
```

## Commands

### privacy-audit

Comprehensive privacy compliance assessment for your application.

**Usage:**
```
/privacy-audit
```

**What it does:**

1. **GDPR Compliance Check** (Phase 1)
   - Launches the `gdpr-compliance-checker` agent
   - Audits lawful basis for data processing (Art. 6)
   - Validates consent mechanisms (Art. 7)
   - Checks data subject rights implementation (Art. 15-22)
   - Reviews data retention policies (Art. 5)
   - Assesses security measures (Art. 32)
   - Evaluates privacy by design (Art. 25)
   - Analyzes third-party processors (Art. 28)
   - Verifies breach notification procedures (Art. 33-34)

2. **Privacy Documentation Generation** (Phase 2)
   - Launches the `privacy-policy-generator` agent
   - Analyzes data collection practices
   - Identifies third-party services
   - Generates privacy policy
   - Creates cookie policy
   - Documents data processing activities (GDPR Art. 30)

3. **Consolidated Report** (Phase 3)
   - Executive summary with compliance score
   - Critical issues requiring immediate attention
   - High-priority improvements
   - Compliant areas already working
   - Generated documentation package
   - Week-by-week implementation roadmap
   - Risk assessment with potential fines

**Output:**

```markdown
# Privacy Compliance Audit Report

## Executive Summary
- Compliance Score: 6.5/10
- Critical Issues: 3
- High Priority: 7
- Documentation: Privacy policy, cookie policy, DPA records

## Critical Issues
1. Missing consent management system
2. No data export functionality
3. Plain text storage of sensitive data

## Implementation Roadmap
Week 1: Critical fixes (consent, data export, encryption)
Week 2: User rights implementation
Week 3: Security enhancements
Week 4: Documentation and training
```

**When to use:**
- Before launching in EU markets
- After adding new data collection features
- Quarterly compliance checkups
- Before fundraising or acquisition
- After receiving privacy complaints
- When preparing for ISO 27001 or SOC 2 certification

---

### anonymize-data

Generate anonymization scripts and synthetic test data for safe development and testing.

**Usage:**
```
/anonymize-data [target]
```

**Target options:**
- `database` - Generate database anonymization scripts
- `test-data` - Create synthetic test data
- `api` - Add anonymization middleware for API responses
- `all` - All of the above (default)

**What it does:**

1. **Personal Data Identification** (Phase 1)
   - Scans database schemas and models
   - Analyzes API endpoints
   - Reviews form inputs
   - Categorizes data types (direct identifiers, quasi-identifiers, sensitive attributes)

2. **Anonymization Strategy Selection** (Phase 2)
   - **Masking**: For emails, phones, credit cards
   - **Pseudonymization**: For user IDs and analytics
   - **Generalization**: For age ranges, locations, salaries
   - **Synthetic Generation**: For complete test datasets

3. **Script Generation** (Phase 3)
   - PostgreSQL anonymization functions
   - MongoDB aggregation pipelines
   - MySQL stored procedures
   - Application-level middleware
   - Test data generators

4. **Validation & Testing** (Phase 4)
   - K-anonymity validation queries
   - Format preservation checks
   - Referential integrity verification
   - Rollback procedures

**Output Files:**

```
scripts/
├── anonymize_postgres.sql      # PostgreSQL anonymization
├── anonymize_mongodb.js         # MongoDB anonymization
├── anonymize_mysql.sql          # MySQL anonymization
├── generate_test_data.js        # Synthetic data generator
├── validate_k_anonymity.sql    # K-anonymity validation
src/middleware/
└── anonymize.ts                 # API response anonymization
```

**Example output:**

```sql
-- PostgreSQL Script
UPDATE users
SET
  email = 'user' || id || '@anonymized.local',
  first_name = 'User',
  last_name = CAST(id AS TEXT),
  phone = '+1-555-' || LPAD(CAST(id AS TEXT), 7, '0'),
  ssn = NULL,
  date_of_birth = date_of_birth + (random() * 14 - 7) * INTERVAL '1 day';
```

**When to use:**
- Setting up development environment
- Creating staging database
- Sharing data with external teams
- Testing data export features
- Training machine learning models
- Compliance audits

## Agents

### GDPR Compliance Checker

**Name**: `gdpr-compliance-checker`
**Model**: Claude Sonnet
**Color**: Blue

Expert agent specializing in GDPR compliance auditing.

**Capabilities:**

1. **Lawful Basis Assessment (Art. 6)**
   - Checks for explicit consent tracking
   - Validates legitimate interest assessments
   - Reviews contractual necessity documentation

2. **Consent Management (Art. 7)**
   - Verifies consent is freely given, specific, informed
   - Checks for easy withdrawal mechanisms
   - Validates granular consent options

3. **Data Subject Rights (Art. 15-22)**
   - Right to Access: Data export functionality
   - Right to Rectification: Profile update endpoints
   - Right to Erasure: Account deletion
   - Right to Data Portability: Machine-readable exports
   - Right to Object: Opt-out mechanisms

4. **Data Retention (Art. 5)**
   - Reviews retention policies
   - Checks for automated deletion
   - Validates archival procedures

5. **Security Measures (Art. 32)**
   - Encryption at rest and in transit
   - Password hashing (bcrypt, argon2)
   - Access controls and monitoring

6. **Privacy by Design (Art. 25)**
   - Data minimization
   - Pseudonymization
   - Privacy-friendly defaults

7. **Third-Party Processors (Art. 28)**
   - Identifies external services
   - Checks for Data Processing Agreements
   - Validates data transfer mechanisms

8. **Breach Notification (Art. 33-34)**
   - Reviews incident response procedures
   - Checks notification mechanisms

**Search Patterns:**

```bash
# Find consent implementations
grep -r "consent" --include="*.js" --include="*.ts"

# Find data export endpoints
grep -r "export.*data|download.*data"

# Find encryption usage
grep -r "encrypt|crypto|cipher"
```

**Report Format:**

```markdown
# GDPR Compliance Report

## Summary
- Compliance Score: 7/10
- Critical Issues: 2
- High Priority: 5

## Critical Issues
### Missing Right to Data Portability
- Article: Art. 20 GDPR
- Risk: €20M or 4% annual turnover
- Fix: Add /api/user/data-export endpoint

## Compliant Areas
- Password hashing with bcrypt
- HTTPS enforced
- Privacy policy accessible
```

---

### Privacy Policy Generator

**Name**: `privacy-policy-generator`
**Model**: Claude Sonnet
**Color**: Purple

Expert agent for generating legally compliant privacy documentation.

**Capabilities:**

1. **Data Collection Analysis**
   - Scans forms, API endpoints, database models
   - Categorizes data types (identity, contact, financial, technical, usage, marketing)
   - Maps collection to processing purposes

2. **Purpose Assessment**
   - Service delivery (account creation, core features)
   - Communication (support, transactional emails)
   - Analytics (usage statistics, performance)
   - Marketing (newsletters, promotions)
   - Legal compliance (tax, fraud prevention)
   - Security (abuse prevention, monitoring)

3. **Third-Party Identification**
   - Analytics: Google Analytics, Mixpanel, Amplitude
   - Email: SendGrid, Mailchimp, SES
   - Payments: Stripe, PayPal, Braintree
   - Cloud: AWS, Azure, GCP
   - Authentication: Auth0, Okta, Firebase
   - Error tracking: Sentry, Bugsnag

4. **Legal Basis Determination**
   - Consent: Marketing emails, optional analytics
   - Contract: Account creation, service delivery
   - Legal obligation: Tax records, fraud prevention
   - Legitimate interest: Security, fraud detection

**Generated Documents:**

1. **Privacy Policy** (13 sections)
   - Introduction
   - Information we collect
   - How we use your information
   - Data sharing and disclosure
   - Data retention
   - Your rights (GDPR)
   - Data security
   - International data transfers
   - Children's privacy
   - Cookies and tracking
   - Do Not Track
   - Policy changes
   - Contact information

2. **Cookie Policy**
   - Essential cookies (required)
   - Analytics cookies (optional)
   - Marketing cookies (optional)
   - Management instructions

3. **Data Processing Activity Record (GDPR Art. 30)**
   - Processing activities
   - Legal bases
   - Data categories
   - Recipients
   - Retention periods
   - Security measures

**Integration Instructions:**

```javascript
// Add privacy policy route
app.get('/privacy', (req, res) => {
  res.render('privacy-policy');
});

// Cookie consent banner
<CookieConsent
  onAccept={() => initAnalytics()}
  onDecline={() => disableAnalytics()}
>
  We use cookies. See our <a href="/cookies">Cookie Policy</a>.
</CookieConsent>

// Consent tracking in database
ALTER TABLE users ADD COLUMN consent_marketing BOOLEAN DEFAULT false;
ALTER TABLE users ADD COLUMN consent_date TIMESTAMP;
```

---

### Data Anonymizer

**Name**: `data-anonymizer`
**Model**: Claude Sonnet
**Color**: Green

Expert agent for implementing data anonymization and pseudonymization techniques.

**Capabilities:**

1. **Data Masking**
   - Email: `user@example.com` → `u***@e******.com`
   - Phone: `+1-555-123-4567` → `+*-***-***-4567`
   - Credit card: `4532-1234-5678-9010` → `****-****-****-9010`

2. **Pseudonymization**
   - Consistent hashing with salt
   - Format-preserving encryption
   - Maintains relationships while unlinking identities

3. **Generalization**
   - Age binning: 27 → "18-29"
   - Location: "123 Main St, Springfield, IL 62701" → "Springfield, IL"
   - Salary ranges: $65,000 → "$50,000-$75,000"

4. **Data Perturbation**
   - Noise addition: Add ±5% to numeric values
   - Date perturbation: Add ±7 days to dates
   - Statistical property preservation

5. **Data Suppression**
   - K-anonymity enforcement (k=5 minimum)
   - Null replacement for sensitive fields
   - Record filtering

6. **Synthetic Data Generation**
   - Realistic fake data using Faker.js
   - Preserves statistical distributions
   - Maintains referential integrity

**Anonymization Techniques:**

```javascript
// Masking
function maskEmail(email) {
  const [local, domain] = email.split('@');
  return `${local[0]}${'*'.repeat(local.length-1)}@${domain}`;
}

// Pseudonymization
function pseudonymize(value, salt) {
  return crypto.createHash('sha256')
    .update(value + salt)
    .digest('hex')
    .substring(0, 16);
}

// Generalization
function generalizeAge(age) {
  if (age < 18) return '0-17';
  if (age < 30) return '18-29';
  if (age < 50) return '30-49';
  return '50+';
}

// Noise addition
function addNoise(value, percentage = 5) {
  const noise = (Math.random() - 0.5) * 2 * (value * percentage / 100);
  return Math.round(value + noise);
}

// K-anonymity
function ensureKAnonymity(records, k = 5) {
  // Group by quasi-identifiers
  // Remove groups with < k records
}
```

**Database Scripts:**

- PostgreSQL: SQL functions with UPDATE statements
- MongoDB: JavaScript aggregation pipelines
- MySQL: Stored procedures
- All preserve referential integrity and data formats

**Validation:**

```sql
-- Verify no real emails remain
SELECT COUNT(*) FROM users
WHERE email NOT LIKE '%@anonymized.local';
-- Should return 0

-- Verify k-anonymity
SELECT age_range, zip_prefix, gender, COUNT(*)
FROM users
GROUP BY age_range, zip_prefix, gender
HAVING COUNT(*) < 5;
-- Should return 0 rows
```

## GDPR Compliance Features

### Article Coverage

| Article | Requirement | Plugin Feature |
|---------|-------------|----------------|
| Art. 5 | Storage Limitation | Checks data retention policies |
| Art. 6 | Lawful Basis | Validates legal grounds for processing |
| Art. 7 | Consent | Audits consent mechanisms |
| Art. 13-14 | Information Duty | Generates privacy policies |
| Art. 15 | Right to Access | Verifies data export endpoints |
| Art. 16 | Right to Rectification | Checks profile update functionality |
| Art. 17 | Right to Erasure | Validates account deletion |
| Art. 20 | Data Portability | Ensures machine-readable exports |
| Art. 21 | Right to Object | Checks opt-out mechanisms |
| Art. 25 | Privacy by Design | Reviews data minimization |
| Art. 28 | Processors | Identifies third-party services |
| Art. 30 | Records of Processing | Generates DPA records |
| Art. 32 | Security | Audits encryption and authentication |
| Art. 33-34 | Breach Notification | Reviews incident procedures |

### Compliance Score Calculation

The plugin calculates a compliance score (0-10) based on:

- **Critical Requirements** (40% weight): Consent, user rights, security
- **High Priority** (30% weight): Documentation, retention, processors
- **Medium Priority** (20% weight): Privacy by design, monitoring
- **Low Priority** (10% weight): Best practices, optimizations

**Score Interpretation:**

- **9-10**: Fully compliant - minimal risk
- **7-8**: Mostly compliant - some improvements needed
- **5-6**: Partially compliant - significant gaps
- **3-4**: Non-compliant - high risk
- **0-2**: Critically non-compliant - immediate action required

### Risk Assessment

The plugin quantifies regulatory risks:

| Violation Tier | Max Fine | Examples |
|----------------|----------|----------|
| Tier 1 (Art. 6-9) | €20M or 4% turnover | Invalid consent, missing user rights |
| Tier 2 (Other) | €10M or 2% turnover | Inadequate security, missing DPAs |
| Warnings | No fine | Best practice violations |

## Data Anonymization Techniques

### Technique Selection Matrix

| Data Type | Recommended Technique | Use Case |
|-----------|----------------------|----------|
| Email | Masking or Pseudonymization | Display, Analytics |
| Phone | Masking (keep last 4) | Display, Validation |
| Name | Replacement (User {id}) | Development, Testing |
| SSN | Complete Removal | All environments |
| Date of Birth | Perturbation (±7 days) | Analytics, Statistics |
| Address | Generalization (city/state) | Location analytics |
| IP Address | Anonymization (0.0.0.0) | Logs, Security |
| User ID | Pseudonymization (SHA-256) | Analytics, Tracking |
| Age | Binning (ranges) | Demographics |
| Salary | Ranges | Compensation analytics |
| Metrics | Noise Addition (±5%) | Usage statistics |

### K-Anonymity

The plugin ensures k-anonymity (k=5 by default):

**Definition**: Each combination of quasi-identifiers must appear at least k times in the dataset.

**Quasi-identifiers**: Age, ZIP code, gender, occupation, etc.

**Example:**

```
Bad (k=1): Age=27, ZIP=12345, Gender=M → 1 record (identifiable)
Good (k=5): Age=25-30, ZIP=123**, Gender=M → 50 records (anonymous)
```

**Validation:**

```sql
-- Find groups violating k-anonymity
SELECT age_range, zip_prefix, gender, COUNT(*) as size
FROM users
GROUP BY age_range, zip_prefix, gender
HAVING COUNT(*) < 5;
```

**Remediation**:
- Further generalize quasi-identifiers
- Suppress records in small groups
- Add synthetic records to reach k threshold

### Differential Privacy

Add statistical noise to preserve individual privacy:

```javascript
// Add Laplace noise for differential privacy
function addLaplaceNoise(value, epsilon = 0.1) {
  const scale = 1 / epsilon;
  const u = Math.random() - 0.5;
  const noise = -scale * Math.sign(u) * Math.log(1 - 2 * Math.abs(u));
  return value + noise;
}
```

**Privacy Budget (ε)**:
- ε = 0.01: Very strong privacy
- ε = 0.1: Strong privacy (recommended)
- ε = 1.0: Moderate privacy
- ε > 1.0: Weak privacy

## Workflow Examples

### Example 1: Pre-Launch Privacy Audit

**Scenario**: Startup preparing to launch in the EU

```bash
# Step 1: Run comprehensive audit
/privacy-audit

# Output: Compliance score 6.5/10, 3 critical issues

# Step 2: Review critical issues
- Missing consent management
- No data export endpoint
- Plain text sensitive data

# Step 3: Fix critical issues (Week 1)
# Implement consent checkboxes
# Add data export API
# Encrypt sensitive fields

# Step 4: Publish documentation
# Review generated privacy policy
# Add to website at /privacy
# Implement cookie consent banner

# Step 5: Re-audit
/privacy-audit

# Output: Compliance score 8.5/10 - Ready to launch
```

**Timeline**: 1-2 weeks
**Cost savings**: Avoid €20M potential fines

---

### Example 2: Development Database Setup

**Scenario**: Need anonymized production data for staging environment

```bash
# Step 1: Generate anonymization scripts
/anonymize-data database

# Output: Scripts for PostgreSQL, MongoDB, MySQL

# Step 2: Create database copy
pg_dump production_db > backup.sql
createdb staging_db
psql staging_db < backup.sql

# Step 3: Run anonymization
psql staging_db < scripts/anonymize_postgres.sql

# Output:
# - 10,523 users anonymized
# - 0 real emails remaining
# - 0 SSNs remaining
# - K-anonymity maintained (k=5)

# Step 4: Verify
SELECT email, phone FROM users LIMIT 10;
# user1@anonymized.local, +1-555-0000001
# user2@anonymized.local, +1-555-0000002
# ...

# Step 5: Update app config
DATABASE_URL=postgresql://localhost/staging_db
```

**Benefits**:
- Safe development environment
- GDPR compliant (Art. 32)
- Realistic testing data
- No production data exposure

---

### Example 3: Synthetic Test Data Generation

**Scenario**: Need realistic test data for automated testing

```bash
# Step 1: Generate synthetic data
/anonymize-data test-data

# Output: generate_test_data.js created

# Step 2: Run generator
npm install @faker-js/faker
node scripts/generate_test_data.js

# Output:
# - Generated 1000 synthetic users
# - Files: test_data_postgres.sql, test_data_mongodb.json

# Step 3: Load into test database
psql test_db < test_data_postgres.sql

# Step 4: Verify
SELECT COUNT(*) FROM users;
# 1000

SELECT email, first_name, last_name FROM users LIMIT 5;
# john.doe@example.com, John, Doe
# jane.smith@test.com, Jane, Smith
# ...
```

**Benefits**:
- Completely synthetic (no real data)
- Realistic formats and distributions
- Consistent and repeatable tests
- No privacy concerns

---

### Example 4: Quarterly Compliance Review

**Scenario**: Scheduled compliance checkup after new features

```bash
# Step 1: Run privacy audit
/privacy-audit

# Output:
# - Compliance score: 8.0/10 (was 8.5 last quarter)
# - New issue: Analytics service added without DPA
# - New issue: Data retention policy not updated

# Step 2: Address new issues
# Sign DPA with analytics provider
# Update retention policy documentation
# Add automated cleanup for new data types

# Step 3: Update privacy policy
# Review changes since last quarter
# Update "Last Updated" date
# Notify users of material changes

# Step 4: Document changes
# Update data processing activity record
# Log compliance review in audit trail
# Schedule next review (3 months)
```

**Best practice**: Run `/privacy-audit` quarterly or after major changes

## Best Practices

### Development Workflow

1. **Before Writing Code**
   - Run `/privacy-audit` to establish baseline
   - Review GDPR requirements for feature
   - Design with privacy by default

2. **During Development**
   - Use anonymized databases (`/anonymize-data database`)
   - Minimize data collection (collect only what's needed)
   - Implement consent mechanisms early
   - Document data processing purposes

3. **Before Deployment**
   - Re-run `/privacy-audit` to check changes
   - Update privacy policy if needed
   - Test user rights (export, delete)
   - Sign DPAs with new third-party services

4. **After Deployment**
   - Monitor for privacy incidents
   - Update data processing records
   - Schedule quarterly audits
   - Train team on privacy requirements

### Privacy by Design Principles

1. **Proactive not Reactive**
   - Run audits early and often
   - Fix issues before they become violations

2. **Privacy as Default**
   - Opt-in for marketing (not opt-out)
   - Minimal data collection
   - Short retention periods

3. **Privacy Embedded in Design**
   - Encryption by default
   - Pseudonymization for analytics
   - Separate consent for different purposes

4. **Full Functionality**
   - Privacy features don't reduce usability
   - Clear user controls
   - Easy rights exercise

5. **End-to-End Security**
   - HTTPS enforced
   - Field-level encryption
   - Access controls

6. **Visibility and Transparency**
   - Clear privacy policies
   - Data processing records
   - User dashboards

7. **Respect for User Privacy**
   - Honor opt-outs immediately
   - Complete data deletion
   - No dark patterns

### Data Minimization

**Collect only what you need:**

```javascript
// Bad: Excessive collection
const user = {
  email: form.email,
  name: form.name,
  phone: form.phone,
  address: form.address,
  dateOfBirth: form.dob,
  ssn: form.ssn, // Not needed!
  ipAddress: req.ip,
  userAgent: req.headers['user-agent']
};

// Good: Minimal collection
const user = {
  email: form.email,
  name: form.name
  // Only essentials
};
```

### Consent Management

**Granular and explicit:**

```javascript
// Bad: Bundled consent
<Checkbox checked name="terms">
  I agree to everything
</Checkbox>

// Good: Granular consent
<Checkbox name="terms" required>
  I agree to Terms (required)
</Checkbox>
<Checkbox name="marketing">
  Marketing emails (optional)
</Checkbox>
<Checkbox name="analytics">
  Analytics cookies (optional)
</Checkbox>
```

### Data Retention

**Define clear retention periods:**

```javascript
const RETENTION_POLICY = {
  logs: 90,              // days
  analytics: 365,        // days
  inactiveAccounts: 730, // 2 years
  transactions: 2555     // 7 years (legal requirement)
};

// Implement automated cleanup
cron.schedule('0 0 * * *', async () => {
  await deleteExpiredLogs();
  await deleteInactiveAccounts();
});
```

### Third-Party Services

**Before integrating:**

1. Check GDPR compliance
2. Sign Data Processing Agreement
3. Verify data transfer mechanisms (SCC)
4. Document in privacy policy
5. Update data processing records

**DPA Checklist:**

- [ ] Processor committed to GDPR compliance
- [ ] Data only processed per instructions
- [ ] Confidentiality obligations
- [ ] Security measures documented
- [ ] Sub-processor notification
- [ ] Data subject rights assistance
- [ ] Deletion/return upon termination
- [ ] Audit rights

### Documentation Maintenance

**Keep documentation current:**

| Document | Update Trigger | Frequency |
|----------|---------------|-----------|
| Privacy Policy | New data collection, third-party services | As needed + annual review |
| Cookie Policy | New cookies added | As needed + annual review |
| DPA Records | New processing activities | As needed + quarterly review |
| Retention Policy | New data types | As needed + annual review |
| Security Procedures | Security changes | As needed + quarterly review |

## Compliance Standards

This plugin helps achieve compliance with:

### GDPR (General Data Protection Regulation)

**Scope**: EU residents
**Key Requirements**:
- Lawful basis for processing
- User rights (access, rectification, erasure, portability)
- Consent management
- Privacy policies
- Data protection by design
- Security measures

**Coverage**: Comprehensive (all articles)

### CCPA (California Consumer Privacy Act)

**Scope**: California residents
**Key Requirements**:
- Right to know what data is collected
- Right to delete
- Right to opt-out of data sales
- Privacy policy requirements

**Coverage**: Partial (GDPR compliance exceeds CCPA requirements)

### PIPEDA (Personal Information Protection and Electronic Documents Act)

**Scope**: Canadian businesses
**Key Requirements**:
- Consent for collection, use, disclosure
- Right to access and correct
- Safeguards for protection
- Privacy policies

**Coverage**: High overlap with GDPR

### HIPAA (Health Insurance Portability and Accountability Act)

**Scope**: US healthcare data
**Key Requirements**:
- Safe Harbor de-identification (18 identifiers)
- Minimum necessary principle
- Encryption requirements

**Coverage**: Anonymization features support Safe Harbor compliance

### ISO 27001 (Information Security)

**Scope**: Information security management
**Key Requirements**:
- Risk assessment
- Security controls
- Documentation

**Coverage**: Audit findings support ISO 27001 preparation

### SOC 2 (Service Organization Control)

**Scope**: Service providers
**Key Requirements**:
- Security controls
- Privacy controls
- Audit trail

**Coverage**: Privacy audit provides evidence for SOC 2 Trust Services Criteria

## Support

For questions, issues, or contributions:

- **Author**: Yannick De Backer
- **Email**: yannick@kobozo.eu
- **Plugin Version**: 1.0.0

## License

Part of the Kobozo Claude Code plugin collection.

---

**Disclaimer**: This plugin provides technical guidance for privacy compliance. It does not constitute legal advice. Always consult with qualified legal counsel for compliance questions specific to your jurisdiction and use case.
