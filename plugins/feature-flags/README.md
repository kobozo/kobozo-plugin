# Feature Flags Plugin

Intelligent feature flag detection and implementation plugin for Claude Code. This plugin analyzes existing feature flag patterns in your codebase and generates production-ready implementations following functional programming principles.

## Overview

The Feature Flags plugin provides comprehensive support for feature flag management across multiple paradigms:

- **Service Integration**: LaunchDarkly, Unleash, ConfigCat, Split.io, Flagsmith
- **Environment-Based**: `.env` files with type-safe parsing
- **Config File-Based**: JSON, YAML configuration files
- **Database-Backed**: Dynamic flags with caching
- **Pub/Sub Distribution**: Redis, RabbitMQ, Kafka, AWS SNS/SQS
- **Custom Implementations**: Detects and follows project-specific patterns

## Features

### 🔍 Intelligent Detection
- Automatically detects existing feature flag systems
- Analyzes project architecture and conventions
- Recommends optimal implementation approach
- Identifies stale and unused flags

### 🎯 Seamless Integration
- Follows project naming conventions
- Matches existing code patterns
- Integrates with `/feature-dev` for implementation
- Generates comprehensive tests

### 🧪 Functional Programming First
- Pure functions for flag evaluation
- Immutable data structures
- Side effects isolated at boundaries
- Type-safe implementations

### 📊 Complete Visibility
- List all flags with current state
- Show flag usage across codebase
- Identify optimization opportunities
- Export in multiple formats

## Commands

### `/feature-flags-init [system-type]`

Initialize a feature flag system in your codebase.

```bash
# Auto-detect best approach
/feature-flags-init

# Force specific system
/feature-flags-init launchdarkly
/feature-flags-init environment
/feature-flags-init config
/feature-flags-init database
/feature-flags-init unleash
```

**What it does:**
1. Detects existing feature flag implementations or recommends approach
2. Generates complete implementation via `/feature-dev` integration
3. Creates tests following functional programming principles
4. Validates implementation for security and correctness
5. Provides setup instructions and documentation

**Output:**
- Feature flag service/configuration
- Type-safe flag evaluation functions
- Comprehensive test suite
- Documentation and usage guide
- Environment variable templates

### `/feature-flags-add <flag-name> [options]`

Add a new feature flag to existing system.

```bash
# Basic flag
/feature-flags-add new-ui

# With description
/feature-flags-add experimental-api --description "Enable experimental API endpoints"

# With initial state and rollout
/feature-flags-add beta-features --enabled --rollout 50
```

**What it does:**
1. Detects existing feature flag system
2. Validates flag name against conventions
3. Adds flag following project patterns
4. Generates tests for the new flag
5. Updates documentation
6. Validates the implementation

**Output:**
- Flag added to appropriate location (env, config, database, service)
- Type definitions updated
- Tests generated
- Documentation updated
- Usage examples provided

### `/feature-flags-list [options]`

List all feature flags with their current state and usage.

```bash
# List all flags
/feature-flags-list

# Show only enabled flags
/feature-flags-list --enabled

# Show only disabled flags
/feature-flags-list --disabled

# Include usage locations
/feature-flags-list --usage

# Export as JSON
/feature-flags-list --format json
```

**What it does:**
1. Detects feature flag system
2. Retrieves all flags and their state
3. Analyzes flag usage across codebase
4. Identifies stale or unused flags
5. Provides health analysis and recommendations

**Output:**
- Complete flag inventory
- Usage statistics
- Stale flag warnings
- Optimization recommendations
- Export options (markdown, JSON, CSV)

## Architecture

### Agents

#### `flag-system-detector`
**Purpose**: Analyzes codebase to detect feature flag patterns

**Capabilities**:
- Detects service integrations (LaunchDarkly, Unleash, etc.)
- Finds environment-based flags
- Identifies config file patterns
- Discovers database schemas
- Detects pub/sub distribution
- Extracts project conventions

**Output**: Comprehensive detection report with recommendations

#### `flag-code-generator`
**Purpose**: Generates feature flag implementation code

**Capabilities**:
- Generates service integration code
- Creates environment-based systems
- Builds config file systems
- Generates database schemas and services
- Creates pub/sub synchronization
- Generates comprehensive tests

**Principles**:
- Pure functions for business logic
- Immutable data structures
- Side effects isolated
- Type-safe implementations

#### `flag-validator`
**Purpose**: Validates feature flag implementations

**Capabilities**:
- Verifies implementation correctness
- Checks security (no exposed API keys)
- Validates performance (caching, efficiency)
- Ensures best practices
- Validates test coverage
- Reviews documentation

**Output**: Validation report with actionable recommendations

### Workflow

```
┌─────────────────────────────────────────────┐
│ /feature-flags-init                         │
└──────────────┬──────────────────────────────┘
               ↓
┌─────────────────────────────────────────────┐
│ Phase 1: flag-system-detector               │
│ - Detect existing patterns                  │
│ - Analyze architecture                      │
│ - Recommend approach                        │
└──────────────┬──────────────────────────────┘
               ↓ (Detection Report)
┌─────────────────────────────────────────────┐
│ Phase 2: User Confirmation                  │
│ - Present recommendations                   │
│ - Get approval on approach                  │
└──────────────┬──────────────────────────────┘
               ↓ (Approved Approach)
┌─────────────────────────────────────────────┐
│ Phase 3: /feature-dev Integration           │
│ - Generate detailed specification           │
│ - Invoke /feature-dev with spec             │
│ - Implement feature flag system             │
└──────────────┬──────────────────────────────┘
               ↓ (Implementation)
┌─────────────────────────────────────────────┐
│ Phase 4: flag-validator                     │
│ - Validate correctness                      │
│ - Check security                            │
│ - Verify performance                        │
└──────────────┬──────────────────────────────┘
               ↓ (Validation Report)
┌─────────────────────────────────────────────┐
│ Phase 5: Fix Issues & Documentation         │
│ - Address validation findings               │
│ - Generate setup guide                      │
│ - Run tests (optional)                      │
│ - Provide summary                           │
└─────────────────────────────────────────────┘
```

## Functional Programming Principles

The plugin generates code following strict functional programming principles:

### Pure Functions

All business logic is implemented as pure functions:

```typescript
// Pure flag evaluation
type FlagEvaluator = (flagName: string, context: Context) => boolean

// Pure configuration parsing
type ConfigParser = (raw: string) => FlagConfig

// Pure validation
type FlagValidator = (flag: Flag) => ValidationResult
```

### Immutable Data

All data structures are immutable:

```typescript
type FeatureFlags = {
  readonly newUI: boolean
  readonly experimentalAPI: boolean
}

type FlagConfig = {
  readonly name: string
  readonly enabled: boolean
  readonly rollout: number
}
```

### Side Effect Isolation

Side effects are isolated to boundaries:

```typescript
// Side effects isolated
const loadFlags = (): Promise<ReadonlyArray<Flag>> // I/O side effect
const evaluateFlag = (flag: Flag, context: Context): boolean // Pure
const saveFlag = (flag: Flag): Promise<void> // I/O side effect

// Pure core, effects at edges
const flagService = {
  async getFlag(name: string): Promise<boolean> {
    const flags = await loadFlags() // Side effect
    const flag = flags.find(f => f.name === name) // Pure
    return flag ? evaluateFlag(flag, context) : false // Pure
  }
}
```

### Function Composition

Complex operations built from simple pure functions:

```typescript
// Simple pure functions
const parseEnv = (value: string | undefined): boolean
const normalizeValue = (value: string): string
const validateFlag = (flag: Flag): boolean

// Composed pipeline
const loadFlagsFromEnv = pipe(
  readEnvVars,        // Side effect
  parseFlags,         // Pure
  validateFlags,      // Pure
  normalizeFlags      // Pure
)
```

## Supported Systems

### LaunchDarkly

**When to use**:
- Enterprise-grade feature management
- Advanced targeting and experimentation
- Team collaboration needs
- Budget available

**Generated code**:
- SDK initialization with timeout handling
- Type-safe flag evaluation
- User context management
- Offline mode support
- Comprehensive error handling

### Unleash

**When to use**:
- Open-source solution needed
- Self-hosting preferred
- Team features without SaaS costs
- Gradual rollout capabilities

**Generated code**:
- Client initialization with strategies
- Server-side evaluation
- Admin UI integration (optional)
- Metrics tracking
- Strategy configuration

### Environment-Based

**When to use**:
- Small to medium projects
- Simple flag requirements
- No dynamic updates needed
- Minimal dependencies

**Generated code**:
- `.env` file management
- Type-safe flag parsing
- Multi-value support (true/false/1/0/yes/no/on/off)
- Hot-reload support (optional)
- Default value handling

### Config File-Based

**When to use**:
- Version-controlled flags desired
- Structured flag data needed
- No runtime updates required
- JSON/YAML preferred

**Generated code**:
- Config file with schema
- Type-safe parsing
- Rollout percentage logic
- Hot-reload support
- Validation on load

### Database-Backed

**When to use**:
- Runtime flag updates needed
- Admin UI for management
- Multiple environments
- Dynamic user targeting

**Generated code**:
- Database schema/migration
- Caching layer (in-memory)
- CRUD service layer
- Type-safe ORM models
- Admin API (optional)

### Pub/Sub Distribution

**When to use**:
- Microservices architecture
- Real-time flag updates
- Distributed systems
- High availability needs

**Generated code**:
- Redis/RabbitMQ/Kafka integration
- Message publisher/subscriber
- Cache synchronization
- Reconnection logic
- Graceful degradation

## Example: Environment-Based System

### Generated Files

**`.env.example`**:
```bash
# Feature Flags
FEATURE_NEW_UI=false
FEATURE_EXPERIMENTAL_API=false
FEATURE_BETA_FEATURES=false
```

**`src/services/featureFlags.ts`**:
```typescript
// Pure flag configuration
type FeatureFlags = {
  readonly newUI: boolean
  readonly experimentalAPI: boolean
  readonly betaFeatures: boolean
}

// Parse environment (side effect isolated)
const parseEnvFlag = (value: string | undefined): boolean => {
  if (!value) return false
  const normalized = value.toLowerCase()
  return normalized === 'true' || normalized === '1' || normalized === 'yes' || normalized === 'on'
}

// Pure flag loading
export const loadFeatureFlags = (): FeatureFlags => ({
  newUI: parseEnvFlag(process.env.FEATURE_NEW_UI),
  experimentalAPI: parseEnvFlag(process.env.FEATURE_EXPERIMENTAL_API),
  betaFeatures: parseEnvFlag(process.env.FEATURE_BETA_FEATURES),
})

// Singleton instance (side effect isolated)
let flags: FeatureFlags | null = null

export const getFeatureFlags = (): FeatureFlags => {
  if (!flags) {
    flags = loadFeatureFlags()
  }
  return flags
}

// Pure flag checking
export const isFeatureEnabled = (flagName: keyof FeatureFlags): boolean => {
  return getFeatureFlags()[flagName]
}

// Type-safe helper with pure branches
export const withFeature = <T>(
  flagName: keyof FeatureFlags,
  enabled: () => T,
  disabled: () => T
): T => {
  return isFeatureEnabled(flagName) ? enabled() : disabled()
}
```

**`src/services/__tests__/featureFlags.test.ts`**:
```typescript
import { describe, it, expect, beforeEach } from 'vitest'
import { isFeatureEnabled, loadFeatureFlags } from '../featureFlags'

describe('Feature Flags', () => {
  beforeEach(() => {
    process.env.FEATURE_NEW_UI = 'false'
    process.env.FEATURE_EXPERIMENTAL_API = 'false'
  })

  describe('parseEnvFlag', () => {
    it('should parse "true" as true', () => {
      process.env.FEATURE_NEW_UI = 'true'
      const flags = loadFeatureFlags()
      expect(flags.newUI).toBe(true)
    })

    it('should parse "1" as true', () => {
      process.env.FEATURE_NEW_UI = '1'
      const flags = loadFeatureFlags()
      expect(flags.newUI).toBe(true)
    })

    it('should be case insensitive', () => {
      process.env.FEATURE_NEW_UI = 'TRUE'
      const flags = loadFeatureFlags()
      expect(flags.newUI).toBe(true)
    })
  })

  describe('isFeatureEnabled', () => {
    it('should return false when flag is not set', () => {
      expect(isFeatureEnabled('newUI')).toBe(false)
    })

    it('should return true when flag is enabled', () => {
      process.env.FEATURE_NEW_UI = 'true'
      expect(isFeatureEnabled('newUI')).toBe(true)
    })
  })
})
```

## Best Practices

### 1. Feature Flags are Temporary

Feature flags should have a lifecycle:
1. **Add**: When developing new feature
2. **Enable**: Gradual rollout to users
3. **Remove**: Once feature is stable (within 30-90 days)

**Don't**:
- Keep flags indefinitely
- Create permanent configuration switches
- Use flags for business logic

**Do**:
- Set removal date when adding flag
- Review flags monthly
- Remove flags after successful rollout

### 2. Name Flags Clearly

Use descriptive, action-oriented names:

**Good**:
- `enable-new-checkout-flow`
- `use-optimized-algorithm`
- `show-beta-features`

**Bad**:
- `flag1`, `test`, `temp`
- `new-feature` (too vague)
- `experiment-123` (unclear intent)

### 3. Document Every Flag

Always include:
- Description of what the flag controls
- Expected behavior when enabled/disabled
- Owner/team responsible
- Target removal date

### 4. Test Both States

Write tests for:
- Feature enabled
- Feature disabled
- Toggle behavior
- Edge cases in both states

### 5. Monitor Flag Usage

Regularly:
- Review flag health with `/feature-flags-list`
- Remove stale flags
- Update flag documentation
- Check for performance impact

## Troubleshooting

### No Feature Flag System Detected

**Symptom**: Running `/feature-flags-add` or `/feature-flags-list` shows "No system detected"

**Solution**: Run `/feature-flags-init` to initialize a feature flag system first

### API Key Not Found

**Symptom**: Service integration (LaunchDarkly/Unleash) fails with "API key required"

**Solution**:
1. Check `.env` file exists and contains the key
2. Verify key name matches expected format
3. Ensure `.env` is loaded (check your framework docs)

### Flag Not Found in List

**Symptom**: Recently added flag doesn't appear in `/feature-flags-list`

**Solutions**:
- **Environment**: Check flag added to `.env.example` and service
- **Config**: Verify JSON/YAML syntax is valid
- **Database**: Run migrations and check database connection
- **Cache**: Clear cache or restart application

### Tests Failing

**Symptom**: Feature flag tests fail after generation

**Solutions**:
1. Check environment variables are set in test environment
2. Verify database is seeded for integration tests
3. Review test output for specific assertion failures
4. Ensure mocking is correct for service integrations

### Stale Flags Warning

**Symptom**: `/feature-flags-list` shows many stale flags

**Solution**: Review and remove unused flags:
1. Identify flags with 0 usages
2. Check git history for last modification
3. Verify with team if flag still needed
4. Use `/feature-flags-remove` to clean up (coming soon)

## Migration Guide

### From Manual Flags to Plugin-Managed

1. **Run detection**:
   ```
   /feature-flags-list
   ```

2. **Document existing flags**: The list command will inventory your current flags

3. **Standardize naming**: Update flags to follow consistent convention

4. **Add tests**: Generate tests for existing flags

5. **Set up monitoring**: Use list command regularly to track flag health

### From Simple to Service-Based

1. **Document current flags**:
   ```
   /feature-flags-list --format json > flags-backup.json
   ```

2. **Initialize new system**:
   ```
   /feature-flags-init launchdarkly
   ```

3. **Migrate flags**: Add each flag to new system

4. **Parallel run**: Keep both systems temporarily

5. **Validate**: Ensure both systems return same values

6. **Switch over**: Update code to use new system

7. **Clean up**: Remove old system

## Contributing

This plugin follows functional programming principles strictly:

- All business logic must be pure functions
- Side effects isolated to boundaries
- Immutable data structures only
- Strong type safety required
- Comprehensive tests for all pure functions

## Version History

### 1.0.0 (Current)
- Initial release
- Three commands: init, add, list
- Three agents: detector, generator, validator
- Support for LaunchDarkly, Unleash, environment, config, database, pub/sub
- Functional programming first approach
- Integration with `/feature-dev`

### Roadmap
- `/feature-flags-remove` command for safe flag removal
- `/feature-flags-migrate` for system migrations
- Dashboard generation for flag management
- A/B testing support
- Gradual rollout automation
- Flag impact analysis
- Integration with CI/CD pipelines

## License

Part of the Kobozo Plugins collection by Yannick De Backer.
