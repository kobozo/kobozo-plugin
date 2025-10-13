---
description: Comprehensive privacy compliance audit - GDPR compliance check, privacy policy generation, and compliance recommendations
---

# Privacy Audit

Complete privacy compliance assessment for your application.

## Usage

```
/privacy-audit
```

## Execution Flow

### Phase 1: GDPR Compliance Check
1. Launch **gdpr-compliance-checker** agent
2. Audit for GDPR requirements:
   - Lawful basis for data processing (Art. 6)
   - Consent mechanisms (Art. 7)
   - Data subject rights implementation (Art. 15-22)
   - Data retention policies (Art. 5)
   - Security measures (Art. 32)
   - Privacy by design (Art. 25)
   - Third-party processors (Art. 28)
   - Breach notification procedures (Art. 33-34)
3. Generate compliance score and issue list

### Phase 2: Privacy Documentation Generation
1. Launch **privacy-policy-generator** agent
2. Analyze application data collection practices
3. Identify third-party data processors
4. Generate comprehensive privacy documentation:
   - Privacy Policy
   - Cookie Policy
   - Data Processing Activity Record (GDPR Art. 30)
5. Provide integration instructions

### Phase 3: Consolidated Compliance Report

Merge findings into comprehensive report with:
- **Executive Summary**: Overall compliance score, critical issues count
- **Critical Issues**: Non-compliant items requiring immediate attention
- **High Priority**: Important improvements needed
- **Compliant Areas**: What's already working well
- **Documentation Package**: Generated privacy policies ready for use
- **Implementation Roadmap**: Week-by-week action plan
- **Risk Assessment**: Potential fines and legal exposure

## Output Structure

```markdown
# Privacy Compliance Audit Report

## Executive Summary

### Compliance Score: 6.5/10

- **GDPR Compliance**: 65% (Partially Compliant)
- **Critical Issues**: 3 (require immediate attention)
- **High Priority**: 7 (complete within 30 days)
- **Medium Priority**: 5 (complete within 90 days)
- **Documentation Status**: Missing privacy policy, cookie policy

### Risk Level: MEDIUM-HIGH
Potential regulatory fines: Up to €20M or 4% annual turnover for critical violations.

---

## Critical Issues (Immediate Action Required)

### 1. Missing Consent Management System
- **Regulation**: GDPR Art. 7 (Consent)
- **Finding**: Pre-checked consent boxes in signup form (`src/components/Signup.tsx:45`)
- **Risk**: Critical - Invalid consent mechanism
- **Impact**: All marketing activities may be non-compliant
- **Estimated Fine Risk**: €10M or 2% turnover
- **Fix Timeline**: 1 week
- **Implementation**:
  ```javascript
  // Current (non-compliant)
  <Checkbox name="marketing" checked={true}>
    I agree to receive marketing emails
  </Checkbox>

  // Required (compliant)
  <Checkbox name="marketing" checked={false}>
    I want to receive marketing emails (optional)
  </Checkbox>
  <Checkbox name="terms" required>
    I agree to Terms and Privacy Policy (required)
  </Checkbox>
  ```

### 2. No Data Export Functionality
- **Regulation**: GDPR Art. 20 (Data Portability)
- **Finding**: No endpoint for users to export their data
- **Risk**: Critical - Missing fundamental user right
- **Impact**: Users cannot exercise right to data portability
- **Estimated Fine Risk**: €20M or 4% turnover
- **Fix Timeline**: 2 weeks
- **Implementation**: See code example in gdpr-compliance-checker report

### 3. Plain Text Storage of Sensitive Data
- **Regulation**: GDPR Art. 32 (Security)
- **Finding**: SSN stored without encryption (`src/models/User.ts:67`)
- **Risk**: Critical - Inadequate security measures
- **Impact**: Data breach could expose sensitive personal data
- **Estimated Fine Risk**: €10M or 2% turnover
- **Fix Timeline**: 1 week
- **Implementation**: Implement field-level encryption

---

## High Priority Issues

### 4. Indefinite Data Retention
- **Regulation**: GDPR Art. 5(1)(e) (Storage Limitation)
- **Fix Timeline**: 2 weeks

### 5. No Account Deletion Mechanism
- **Regulation**: GDPR Art. 17 (Right to Erasure)
- **Fix Timeline**: 2 weeks

### 6. Missing Privacy Policy
- **Regulation**: GDPR Art. 13 (Information to be provided)
- **Fix Timeline**: 1 week
- **Solution**: Privacy policy generated (see below)

### 7. No Cookie Consent Banner
- **Regulation**: GDPR Art. 7, ePrivacy Directive
- **Fix Timeline**: 1 week

[Additional issues 8-10...]

---

## Compliant Areas ✓

1. ✓ Password hashing with bcrypt (`src/services/auth.ts:23`)
2. ✓ HTTPS enforced in production (`src/server.ts:12`)
3. ✓ Profile update endpoints exist (`src/routes/user.ts:45`)
4. ✓ Email verification implemented
5. ✓ Rate limiting on authentication endpoints

---

## Generated Documentation

### Privacy Policy
- **Status**: Generated ✓
- **Location**: `docs/privacy-policy.md`
- **Length**: 3,500 words
- **Sections**: 13 (Introduction, Data Collection, Usage, Sharing, Retention, Rights, Security, etc.)
- **Compliance**: GDPR, CCPA, PIPEDA
- **Action Required**:
  1. Review with legal counsel
  2. Customize company-specific details
  3. Publish to website at `/privacy`
  4. Link from footer and signup form

### Cookie Policy
- **Status**: Generated ✓
- **Location**: `docs/cookie-policy.md`
- **Cookies Documented**: 8 (3 essential, 3 analytics, 2 marketing)
- **Action Required**:
  1. Verify all cookies are documented
  2. Publish to website at `/cookies`
  3. Implement cookie consent banner

### Data Processing Activities Record
- **Status**: Generated ✓
- **Location**: `docs/data-processing-activities.md`
- **Activities Documented**: 5
- **Compliance**: GDPR Art. 30
- **Action Required**: Keep updated as processing activities change

---

## Third-Party Data Processors Identified

| Service | Purpose | Location | Compliance | DPA Status |
|---------|---------|----------|------------|------------|
| AWS | Hosting | USA | ISO 27001 | ⚠️ Needs review |
| Google Analytics | Analytics | USA | Privacy Shield | ✓ Active |
| SendGrid | Email | USA | GDPR compliant | ⚠️ Needs signing |
| Stripe | Payments | USA | PCI-DSS | ✓ Active |
| Sentry | Error tracking | USA | GDPR compliant | ✓ Active |
| Auth0 | Authentication | USA | ISO 27001 | ⚠️ Needs review |

**Action Required**:
1. Sign Data Processing Agreements with all processors
2. Verify Standard Contractual Clauses for US transfers
3. Document processors in privacy policy (already included in generated policy)

---

## Implementation Roadmap

### Week 1: Critical Fixes (Priority 1)
**Goal**: Address critical compliance gaps

- [ ] Day 1-2: Fix consent checkboxes in signup form
- [ ] Day 3-4: Implement data export endpoint
- [ ] Day 5: Encrypt sensitive fields (SSN, payment info)
- [ ] Day 5: Review and publish privacy policy
- [ ] **Expected Impact**: Compliance score → 7.5/10

### Week 2: High Priority (Priority 2)
**Goal**: Implement user rights and documentation

- [ ] Implement account deletion endpoint
- [ ] Add data retention policy and automated cleanup
- [ ] Implement cookie consent banner
- [ ] Add marketing opt-out mechanisms
- [ ] Sign DPAs with third-party processors
- [ ] **Expected Impact**: Compliance score → 8.5/10

### Week 3: Medium Priority
**Goal**: Enhance security and monitoring

- [ ] Implement breach detection and notification procedures
- [ ] Add privacy-friendly analytics (IP anonymization)
- [ ] Conduct security audit
- [ ] Create incident response plan
- [ ] **Expected Impact**: Compliance score → 9.0/10

### Week 4: Documentation and Training
**Goal**: Long-term compliance

- [ ] Appoint Data Protection Officer (if required)
- [ ] Train development team on GDPR
- [ ] Conduct Data Protection Impact Assessment
- [ ] Implement privacy by design review process
- [ ] **Expected Impact**: Compliance score → 9.5/10

---

## Risk Assessment

### Current State
- **Compliance Level**: Partially Compliant (65%)
- **Critical Violations**: 3
- **Maximum Potential Fine**: €20M or 4% annual turnover
- **Likelihood of Enforcement**: Medium (depends on complaints)

### After Week 1 Fixes
- **Compliance Level**: Mostly Compliant (75%)
- **Critical Violations**: 0
- **Maximum Potential Fine**: €10M or 2% turnover
- **Likelihood of Enforcement**: Low

### After Full Implementation (4 weeks)
- **Compliance Level**: Fully Compliant (95%)
- **Critical Violations**: 0
- **Maximum Potential Fine**: Minimal (minor violations only)
- **Likelihood of Enforcement**: Very Low

---

## Quick Wins (High Impact, Low Effort)

1. **Fix consent checkboxes** (2 hours)
   - Remove pre-checked state
   - Add granular options
   - Impact: Critical compliance gap resolved

2. **Publish privacy policy** (4 hours)
   - Review generated policy
   - Customize details
   - Add to website
   - Impact: Transparency requirement met

3. **Implement cookie consent** (4 hours)
   - Add react-cookie-consent library
   - Configure options
   - Impact: ePrivacy compliance

4. **Add data export** (8 hours)
   - Create /api/user/data-export endpoint
   - Return JSON with all user data
   - Impact: Fundamental user right implemented

**Total Time**: 18 hours (2-3 days)
**Compliance Improvement**: 6.5/10 → 8.0/10

---

## Monitoring and Maintenance

### Ongoing Requirements
1. **Quarterly audits**: Re-run /privacy-audit every 3 months
2. **Policy updates**: Review privacy policy annually
3. **DPA renewals**: Track and renew processor agreements
4. **Training**: Annual GDPR training for developers
5. **Incident response**: Test breach notification procedures

### Triggers for Re-audit
- New data collection fields
- New third-party integrations
- New countries/jurisdictions
- Regulatory changes
- Data breaches or incidents

---

## Next Steps

1. **Immediate**: Review this report with leadership and legal counsel
2. **This Week**: Begin Week 1 implementation (critical fixes)
3. **This Month**: Complete Weeks 1-4 implementation roadmap
4. **Ongoing**: Establish quarterly audit schedule

## Contact

For questions about this report or implementation support:
- Data Protection Officer: [dpo@example.com]
- Legal Counsel: [legal@example.com]
- Development Lead: [dev@example.com]
```

## When to Use

- Before launching in EU markets
- After adding new data collection features
- Quarterly compliance checkups
- Before fundraising or acquisition
- After receiving privacy complaints
- When preparing for certification (ISO 27001, SOC 2)

This command provides complete privacy compliance assessment with actionable next steps.
