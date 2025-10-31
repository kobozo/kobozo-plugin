---
description: Initialize feature flag system in your codebase - detects patterns and generates implementation
---

# Feature Flags Init

Orchestrates the complete workflow for initializing a feature flag system in your codebase.

## Usage

```
/feature-flags-init [optional: system-type]
```

Examples:
- `/feature-flags-init` - Auto-detect best approach
- `/feature-flags-init launchdarkly` - Force LaunchDarkly integration
- `/feature-flags-init environment` - Force environment-based
- `/feature-flags-init config` - Force config file-based
- `/feature-flags-init database` - Force database-backed
- `/feature-flags-init unleash` - Force Unleash integration

## What This Command Does

This command analyzes your codebase to understand your architecture, then generates a complete feature flag system optimized for your project. It either:
1. **Creates a new system** (if no flags detected)
2. **Documents existing system** (if flags already present)

## Execution Flow

### Phase 1: System Detection

**Objective**: Understand the current state and determine best approach

**Action**: Launch **flag-system-detector** agent to:
- Detect any existing feature flag implementations
- Analyze technology stack (frontend, backend, database)
- Identify architecture patterns (monolith, microservices, serverless)
- Determine project scale and complexity
- Recommend optimal feature flag approach

**Output**: Comprehensive detection report with recommendations

### Phase 2: User Confirmation

**Objective**: Get user approval on approach

**If system-type provided**: Skip to Phase 3 with forced type

**If no existing system found**:
1. Present detection report summary
2. Show recommended approach with reasoning
3. Present alternatives:
   - **Service-based** (LaunchDarkly, Unleash): Best for teams, advanced features
   - **Environment-based**: Simple, good for small projects
   - **Config-based**: Flexible, no external dependencies
   - **Database-backed**: Dynamic, UI-manageable
   - **Hybrid**: Combines multiple approaches
4. Ask user to choose approach

**If existing system found**:
1. Present what was detected
2. Ask user:
   - Document existing system only?
   - Enhance existing system?
   - Migrate to different system?

### Phase 3: Implementation Generation

**Objective**: Generate feature flag implementation code

**Action**: Invoke `/feature-dev` with detailed specification

**For new system**, generate specification:
```markdown
You are implementing a feature flag system using [chosen approach].

## Requirements

### System Type: [LaunchDarkly | Unleash | Environment | Config | Database | Hybrid]

### Core Functionality

1. **Flag Evaluation**:
   - Pure function to check if flag is enabled
   - Support for boolean flags
   - [If applicable] Support for multi-variant flags
   - [If applicable] Support for user targeting
   - [If applicable] Support for rollout percentages

2. **Configuration**:
   - [Specific config requirements based on system type]
   - Environment variables for sensitive data
   - Type-safe configuration

3. **Caching** (if applicable):
   - In-memory cache for flag values
   - Configurable TTL
   - Cache invalidation strategy

4. **Error Handling**:
   - Graceful degradation (return defaults on error)
   - Comprehensive error logging
   - Retry logic for transient failures

### Architecture Constraints

**Project Stack**:
- Frontend: [Detected framework]
- Backend: [Detected framework]
- Database: [Detected database]
- Language: [TypeScript | JavaScript | Python | etc.]

**Conventions to Follow**:
- Naming: [Detected convention]
- File structure: [Detected pattern]
- Testing framework: [Detected framework]

### Implementation Details

[Specific details based on chosen system type]

**For Service Integration (LaunchDarkly/Unleash)**:
- Install SDK: `npm install [package]`
- Initialize client in `[recommended location]`
- API key from environment: `process.env.[KEY_NAME]`
- Client-side SDK: [yes/no based on frontend]
- Server-side SDK: [yes/no based on backend]

**For Environment-Based**:
- Create `.env.example` with flag definitions
- Create service in `[recommended location]`
- Parse environment variables (handle true/false/1/0/yes/no/on/off)
- Type-safe flag interface

**For Config-Based**:
- Create config file: `config/features.[json|yaml]`
- Define schema with enabled/description/rollout fields
- Implement config loader
- Hot-reload support (optional)

**For Database-Backed**:
- Create database schema/model
- Implement caching layer
- Create CRUD operations
- Add database indexes
- Generate migration files

### Testing Requirements

1. **Unit Tests**:
   - Test flag evaluation logic
   - Test all flag states (enabled/disabled/rollout)
   - Test error cases
   - Test pure functions with property-based tests

2. **Integration Tests**:
   - Test database operations (if applicable)
   - Test cache behavior
   - Test service initialization

3. **E2E Tests** (if applicable):
   - Test user-facing flag behavior
   - Test A/B scenarios

### Functional Programming Requirements

- **Pure Functions**: All flag evaluation logic must be pure
- **Immutable Data**: Use readonly types, no mutations
- **Side Effect Isolation**: Isolate I/O, network calls, and side effects at boundaries
- **Composition**: Build complex operations from simple pure functions
- **Type Safety**: Strong TypeScript types throughout

### Documentation

- README with setup instructions
- Usage examples
- Available flags documentation
- How to add new flags
- Environment variable documentation

### Files to Create

[Specific file list based on system type and project structure]

---

Please implement this feature flag system following the functional programming principles and architecture constraints specified above.
```

**Action**: Execute `/feature-dev` command with this specification

### Phase 4: Validation

**Objective**: Verify implementation is correct and secure

**Action**: Launch **flag-validator** agent to:
- Validate implementation correctness
- Check security (no exposed API keys)
- Verify performance (caching, efficiency)
- Ensure best practices
- Validate test coverage
- Review documentation

**Output**: Validation report with any issues found

### Phase 5: Fix Issues (if any)

**Objective**: Address validation findings

**If critical issues found**:
1. Present validation report
2. Ask user if they want auto-fix or manual fix
3. **If auto-fix**: Generate fixes and apply them
4. **If manual**: Provide detailed fix instructions
5. Re-run validation

**If only warnings**:
1. Present summary
2. Ask user if they want to address now or later
3. **If now**: Generate fixes
4. **If later**: Document in TODO comments

### Phase 6: Documentation & Setup

**Objective**: Ensure user can use the system

**Actions**:
1. **Check dependencies**:
   - If service SDK needed: Offer to install (`npm install [package]`)
   - If database migrations needed: Show migration command

2. **Generate .env.example** (if needed):
   ```bash
   # Feature Flags Configuration
   [Required environment variables with examples]
   ```

3. **Create setup guide** in README or docs/

4. **Show next steps**:
   ```
   ✅ Feature flag system initialized!

   ## Next Steps:

   1. Configure environment variables:
      - Copy .env.example to .env
      - Fill in required values: [list]

   2. [If database]: Run migrations:
      - npm run db:migrate (or npx prisma migrate dev)

   3. [If service]: Set up service account:
      - Create account at [service URL]
      - Get API key
      - Add to .env

   4. Add your first flag:
      - /feature-flags-add my-first-flag

   5. Use in code:
      [Usage example]
   ```

### Phase 7: Test Execution

**Objective**: Verify everything works

**Actions**:
1. Ask user if they want to run tests now
2. **If yes**:
   - Run unit tests
   - Run integration tests (if env configured)
   - Show results
3. **If no**: Skip

### Phase 8: Summary & Handoff

**Objective**: Wrap up and provide clear documentation

**Actions**:
1. Summarize what was created:
   - List all generated files
   - Highlight key components
   - Show configuration required

2. Provide usage guide:
   ```typescript
   // Quick usage example
   import { isFeatureEnabled } from './services/featureFlags';

   const enabled = await isFeatureEnabled('my-feature');
   ```

3. Document available commands:
   - `/feature-flags-add flag-name` - Add new flag
   - `/feature-flags-list` - List all flags
   - `/feature-flags-remove flag-name` - Remove flag (future)

4. Highlight any manual steps required

## System Type Details

### LaunchDarkly Integration

**When to use**:
- Team needs feature management dashboard
- Advanced targeting and experimentation
- Enterprise-grade reliability
- Budget available ($$$)

**What gets generated**:
- LaunchDarkly SDK initialization
- Server-side client (Node.js/Python/Go/etc.)
- Client-side SDK (React/Vue/Angular if applicable)
- Type-safe flag evaluation functions
- User context handling
- Offline mode support

### Unleash Integration

**When to use**:
- Want open-source solution
- Need self-hosting option
- Team collaboration features
- No budget for SaaS

**What gets generated**:
- Unleash client initialization
- Server-side evaluation
- Admin UI integration (optional)
- Strategy configuration
- Metrics tracking

### Environment-Based

**When to use**:
- Small to medium projects
- Simple flag requirements
- No dynamic flag updates needed
- Minimal dependencies desired

**What gets generated**:
- .env file with flags
- Flag parsing service
- Type-safe flag interface
- Hot-reload support (optional)

### Config File-Based

**When to use**:
- Want version-controlled flags
- Need structured flag data (description, rollout, etc.)
- Don't need runtime updates
- Flexible configuration desired

**What gets generated**:
- config/features.json or .yaml
- Config loader with validation
- Schema types
- Hot-reload support (optional)
- Rollout percentage logic

### Database-Backed

**When to use**:
- Need runtime flag updates
- Want admin UI for flag management
- Multiple environments
- Dynamic user targeting

**What gets generated**:
- Database schema/migration
- CRUD service layer
- Caching layer
- Admin API endpoints (optional)
- Type-safe ORM models

### Hybrid Approach

**When to use**:
- Complex requirements
- Multiple environments with different needs
- Gradual migration strategy

**What gets generated**:
- Combination of above approaches
- Fallback chain (service → config → env → default)
- Unified API

## Functional Programming Approach

The generated code emphasizes functional programming:

```typescript
// Pure flag evaluation
type FlagEvaluator = (flagName: string, context: Context) => boolean

// Immutable configuration
type FlagConfig = {
  readonly name: string
  readonly enabled: boolean
  readonly rollout: number
}

// Side effects isolated
const loadFlags = (): Promise<ReadonlyArray<FlagConfig>> // Side effect
const evaluateFlag = (flag: FlagConfig, context: Context): boolean // Pure
```

## Troubleshooting

**No package manager detected**:
- Manually install dependencies listed
- Run initialization scripts

**Database connection failed**:
- Verify DATABASE_URL environment variable
- Check database is running
- Ensure migrations executed

**Service SDK initialization failed**:
- Verify API key is correct
- Check network connectivity
- Ensure service endpoint reachable

**Tests failing**:
- Check environment configuration
- Verify database migrations run
- Review test output for specific errors

## Implementation Instructions

Your task as the orchestrator is to:

1. **Use TodoWrite** to track each phase clearly
2. **Launch flag-system-detector** agent with project context
3. **Present recommendations** to user and get approval
4. **Invoke /feature-dev** with detailed specification
   - Use natural language to invoke the command
   - Format: "Execute /feature-dev command with the following specification: [detailed spec]"
5. **Launch flag-validator** agent after implementation
6. **Handle validation issues** with auto-fix or guidance
7. **Verify dependencies** and offer to install
8. **Generate documentation** and setup guide
9. **Optionally run tests** if user confirms
10. **Provide comprehensive summary** with next steps

## Success Criteria

The command is successful when:
- ✅ Feature flag system correctly implemented for project architecture
- ✅ Code follows functional programming principles
- ✅ Security validated (no exposed secrets)
- ✅ Tests generated and passing
- ✅ Documentation complete and clear
- ✅ User knows how to add their first flag

Your goal is to make feature flag initialization completely automated and effortless for the user.
