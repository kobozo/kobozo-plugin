---
description: This skill should be used when the user asks to "add feature flag", "set up feature flags", "toggle feature", "add feature toggle", "initialize feature flags", "create feature flag", or needs help managing feature flags in their application. Provides guidance on feature flag patterns and implementation.
---

# Feature Flags Skill

Implement and manage feature flags for controlled feature rollouts, A/B testing, and safe deployments.

## When to Use

- Adding a new feature flag
- Setting up feature flag system
- Implementing gradual rollouts
- A/B testing features
- Managing feature toggles

## Feature Flag Patterns

### Environment-Based
Store flags in environment variables.

**Best for:** Simple projects, 12-factor apps
**Pros:** Simple, no external dependencies
**Cons:** Requires redeploy to change

```typescript
// .env
FEATURE_NEW_UI=false

// Usage
const isNewUIEnabled = process.env.FEATURE_NEW_UI === 'true';
```

### Config File-Based
Store flags in JSON/YAML configuration.

**Best for:** Moderate complexity, version-controlled flags
**Pros:** Easy to track changes, type-safe
**Cons:** Requires redeploy

```json
// config/features.json
{
  "features": {
    "newUI": {
      "enabled": false,
      "description": "Enable new UI design",
      "rollout": 0
    }
  }
}
```

### Database-Backed
Store flags in database for runtime changes.

**Best for:** Dynamic flags, admin control
**Pros:** Change without deploy, audit trail
**Cons:** Database dependency

```typescript
// Database model
interface FeatureFlag {
  name: string;
  enabled: boolean;
  rollout: number; // 0-100
  description: string;
}
```

### Service-Based
Use third-party services (LaunchDarkly, Unleash, etc.).

**Best for:** Enterprise, complex targeting
**Pros:** Rich features, SDKs, analytics
**Cons:** Cost, external dependency

## Implementation Pattern

### Type-Safe Feature Flags
```typescript
// Define flag types
type FeatureFlags = {
  readonly newUI: boolean;
  readonly darkMode: boolean;
  readonly betaFeatures: boolean;
};

// Load flags
const loadFeatureFlags = (): FeatureFlags => ({
  newUI: parseEnvFlag(process.env.FEATURE_NEW_UI),
  darkMode: parseEnvFlag(process.env.FEATURE_DARK_MODE),
  betaFeatures: parseEnvFlag(process.env.FEATURE_BETA),
});

// Pure helper
const parseEnvFlag = (value: string | undefined): boolean =>
  value?.toLowerCase() === 'true';
```

### Feature Check Helper
```typescript
// Functional approach
const withFeature = <T>(
  flagName: keyof FeatureFlags,
  enabledResult: () => T,
  disabledResult: () => T
): T => {
  const flags = loadFeatureFlags();
  return flags[flagName] ? enabledResult() : disabledResult();
};

// Usage
const component = withFeature('newUI',
  () => <NewUI />,
  () => <OldUI />
);
```

### Rollout Implementation
```typescript
// Percentage-based rollout
const isEnabledForUser = (
  flagName: string,
  userId: string,
  rolloutPercentage: number
): boolean => {
  // Deterministic hash for consistent user experience
  const hash = simpleHash(flagName + userId);
  return (hash % 100) < rolloutPercentage;
};
```

## Best Practices

### Naming Conventions
- Use descriptive names: `enableNewCheckoutFlow` not `flag1`
- Consistent prefix: `FEATURE_` for env vars
- Kebab-case for configs: `new-checkout-flow`

### Flag Lifecycle
1. **Create**: Add flag, default disabled
2. **Develop**: Build feature behind flag
3. **Test**: Enable in staging/dev
4. **Rollout**: Gradual enable in production
5. **Cleanup**: Remove flag when 100% enabled

### Security Considerations
- Don't expose all flags to client
- Validate flag values server-side
- Audit flag changes
- Use feature flags for security features carefully

### Testing
```typescript
describe('Feature Flag: newUI', () => {
  it('should be disabled by default', () => {
    expect(isFeatureEnabled('newUI')).toBe(false);
  });

  it('should return true when enabled', () => {
    process.env.FEATURE_NEW_UI = 'true';
    expect(isFeatureEnabled('newUI')).toBe(true);
  });
});
```

## Adding a New Flag

### Quick Add Checklist
1. Define flag in configuration
2. Add type definition
3. Implement feature check
4. Add tests
5. Document the flag

### Documentation Template
```markdown
## Feature Flag: new-checkout-flow

**Description**: Enable the redesigned checkout process
**Default**: disabled
**Added**: 2024-01-15
**Owner**: @team-checkout

**Usage**:
- Enable: Set `FEATURE_NEW_CHECKOUT=true`
- Test: Check /checkout page behavior

**Cleanup Target**: Q2 2024
```

## Invoke Full Workflow

For comprehensive feature flag management:

**Use the Task tool** to launch feature flag agents:

1. **System Detection**: Launch `feature-flags:flag-system-detector` to detect existing patterns
2. **Code Generation**: Launch `feature-flags:flag-code-generator` to add flags
3. **Validation**: Launch `feature-flags:flag-validator` to verify implementation

**Example prompt for agent:**
```
Add a feature flag called "new-payment-flow" to control access to
the redesigned payment processing. Should be disabled by default
with 10% initial rollout capability.
```

## Quick Reference

### Pattern Selection
| Criteria | Pattern |
|----------|---------|
| Simple project | Environment-based |
| Version control needed | Config file |
| Runtime changes | Database-backed |
| Complex targeting | Service-based |

### Common Mistakes
- Forgetting to clean up old flags
- Not testing both enabled/disabled states
- Exposing sensitive flags to client
- Using flags for permanent config

### Flag Cleanup Reminder
Feature flags should be temporary. Once a feature is fully rolled out:
1. Remove flag checks from code
2. Remove flag from configuration
3. Delete related tests
4. Update documentation
