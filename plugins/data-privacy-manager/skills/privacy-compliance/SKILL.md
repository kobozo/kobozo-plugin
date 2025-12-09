---
description: This skill should be used when the user asks about "privacy audit", "GDPR compliance", "privacy policy", "data protection", "anonymize data", "check GDPR", "privacy requirements", or needs help with any data privacy or compliance matters. Provides guidance on GDPR, CCPA, and data protection best practices.
---

# Privacy Compliance Skill

Comprehensive guidance for data privacy compliance including GDPR, CCPA, and general data protection best practices.

## When to Use

- Auditing application for privacy compliance
- Implementing GDPR requirements
- Creating privacy policies
- Anonymizing sensitive data
- Reviewing data collection practices
- Preparing for privacy certification

## Key GDPR Requirements

### Article 5: Data Processing Principles
- **Lawfulness**: Valid legal basis for processing
- **Purpose limitation**: Clear, specific purposes
- **Data minimization**: Only collect what's needed
- **Accuracy**: Keep data accurate and up-to-date
- **Storage limitation**: Define retention periods
- **Security**: Appropriate technical measures

### Article 6: Lawful Basis for Processing
1. Consent (freely given, specific, informed)
2. Contract performance
3. Legal obligation
4. Vital interests
5. Public interest
6. Legitimate interests

### Articles 15-22: Data Subject Rights
- **Access** (Art. 15): Users can request their data
- **Rectification** (Art. 16): Users can correct errors
- **Erasure** (Art. 17): "Right to be forgotten"
- **Portability** (Art. 20): Export data in standard format
- **Objection** (Art. 21): Opt out of processing
- **Automated decisions** (Art. 22): Explanation of AI decisions

## Compliance Checklist

### Consent Management
- [ ] Consent is opt-in (not pre-checked)
- [ ] Consent is granular (separate purposes)
- [ ] Easy to withdraw consent
- [ ] Records of consent maintained

### User Rights Implementation
- [ ] Data export endpoint exists
- [ ] Account deletion functionality
- [ ] Profile update capability
- [ ] Cookie consent mechanism

### Security Measures
- [ ] Sensitive data encrypted
- [ ] Passwords properly hashed
- [ ] HTTPS enforced
- [ ] Access controls implemented
- [ ] Audit logging enabled

### Documentation
- [ ] Privacy policy published
- [ ] Cookie policy documented
- [ ] Data processing records
- [ ] Third-party processor agreements

## Common Compliance Issues

### Critical Issues
1. **Pre-checked consent boxes** - Must be opt-in
2. **No data export** - Users need portability
3. **Unencrypted sensitive data** - Encryption required
4. **No deletion mechanism** - Right to erasure
5. **Indefinite retention** - Define retention periods

### Implementation Patterns

#### User Data Export
```typescript
// Compliant data export endpoint
app.get('/api/user/data-export', auth, async (req, res) => {
  const userData = await User.findById(req.user.id)
    .select('-password -__v');
  const orders = await Order.find({ userId: req.user.id });
  const preferences = await Preferences.find({ userId: req.user.id });

  res.json({
    user: userData,
    orders,
    preferences,
    exportedAt: new Date().toISOString()
  });
});
```

#### Account Deletion
```typescript
// Compliant account deletion
app.delete('/api/user/account', auth, async (req, res) => {
  await User.findByIdAndDelete(req.user.id);
  await Order.deleteMany({ userId: req.user.id });
  await Preferences.deleteMany({ userId: req.user.id });
  await AuditLog.create({
    action: 'ACCOUNT_DELETED',
    userId: req.user.id,
    timestamp: new Date()
  });
  res.status(204).send();
});
```

#### Consent Checkbox
```jsx
// Compliant consent (not pre-checked)
<Checkbox name="marketing" checked={false}>
  I want to receive marketing emails (optional)
</Checkbox>
<Checkbox name="terms" required>
  I agree to Terms and Privacy Policy (required)
</Checkbox>
```

## Data Anonymization

### Techniques
1. **Pseudonymization**: Replace identifiers with tokens
2. **Generalization**: Reduce precision (age ranges vs exact age)
3. **Masking**: Hide portions (email: j***@example.com)
4. **Synthetic data**: Generate fake but realistic data

### When to Anonymize
- Testing environments
- Analytics and reporting
- Data sharing with third parties
- Research and development

## Invoke Full Workflow

For comprehensive privacy audit with documentation generation:

**Use the Task tool** to launch privacy-related agents:

1. **GDPR Compliance Check**: Launch `data-privacy-manager:gdpr-compliance-checker` agent to audit the codebase for GDPR requirements
2. **Data Anonymization**: Launch `data-privacy-manager:data-anonymizer` agent to generate anonymization scripts
3. **Privacy Policy**: Launch `data-privacy-manager:privacy-policy-generator` agent to create privacy documentation

**Example prompt for full audit:**
```
Conduct a comprehensive privacy audit of this application. Check GDPR compliance,
identify issues, generate privacy policy, and provide implementation roadmap.
```

## Quick Reference

### Risk Levels
- **Critical**: Missing fundamental rights (export, deletion)
- **High**: Security issues (unencrypted data)
- **Medium**: Documentation gaps (missing policy)
- **Low**: Minor improvements needed

### Potential Fines
- Up to €20M or 4% annual turnover (GDPR)
- Critical violations: Maximum penalties
- Minor violations: Warnings or lower fines

### Quick Wins
1. Fix consent checkboxes (2 hours)
2. Publish privacy policy (4 hours)
3. Implement cookie consent (4 hours)
4. Add data export endpoint (8 hours)
