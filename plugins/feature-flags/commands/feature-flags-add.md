---
description: Add a new feature flag to existing system - auto-detects patterns and integrates seamlessly
---

# Feature Flags Add

Adds a new feature flag to your existing feature flag system, automatically detecting the implementation pattern and integrating seamlessly.

## Usage

```
/feature-flags-add <flag-name> [options]
```

Examples:
- `/feature-flags-add new-ui` - Add flag with auto-detected pattern
- `/feature-flags-add experimental-api --description "Enable experimental API endpoints"`
- `/feature-flags-add beta-features --enabled --rollout 50`

## What This Command Does

This command:
1. Detects your existing feature flag system
2. Determines the correct pattern to follow
3. Adds the flag following project conventions
4. Generates tests for the new flag
5. Updates documentation
6. Validates the implementation

## Execution Flow

### Phase 1: System Detection

**Objective**: Understand the existing feature flag system

**Action**: Launch **flag-system-detector** agent to:
- Detect existing feature flag implementation
- Identify system type (service, env, config, database, pub/sub, custom)
- Extract naming conventions
- Find integration points
- Locate test patterns

**Output**: Detection report with implementation details

**Error Handling**:
- If no system found: Suggest running `/feature-flags-init` first
- If multiple conflicting systems: Ask user which to use
- If system unclear: Ask clarifying questions

### Phase 2: Flag Configuration

**Objective**: Gather flag details from user or defaults

**Information Needed**:
- Flag name (required, from command args)
- Description (optional, from args or prompt)
- Initial state (enabled/disabled, default: disabled)
- Rollout percentage (if supported, default: 0)
- Target users/groups (if supported, optional)

**Validation**:
- Flag name follows project conventions
- Flag name doesn't already exist
- Flag name is valid (no special characters unless convention allows)

**Actions**:
1. Parse command arguments for flag details
2. If description missing: Ask user or use default
3. If system supports advanced features (targeting, rollout): Ask if needed
4. Validate flag name against conventions
5. Check for duplicate flag names

### Phase 3: Code Generation

**Objective**: Generate code to add the flag

**Action**: Launch **flag-code-generator** agent with:
- Detection report from Phase 1
- Flag configuration from Phase 2
- Instruction to integrate with existing system

**Generation Strategy by System Type**:

#### Service Integration (LaunchDarkly/Unleash)

**Action**: Generate flag registration code

```typescript
// Add to service configuration or admin script
// LaunchDarkly: Use dashboard or API
// Unleash: Create feature toggle via API or UI

// Generate API script: scripts/add-flag.ts
import { createFlag } from './flagService';

await createFlag({
  name: 'new-ui',
  description: 'Enable the new UI redesign',
  enabled: false,
  tags: ['frontend', 'ui'],
});
```

**Files Modified/Created**:
- `scripts/add-flag.ts` - Helper script for adding flags
- Update types if using type-safe flag names
- Update documentation

#### Environment-Based

**Action**: Add to .env files and update service

```bash
# Add to .env.example
FEATURE_NEW_UI=false

# Add to .env (if exists and not in .gitignore)
FEATURE_NEW_UI=false
```

```typescript
// Update src/services/featureFlags.ts
type FeatureFlags = {
  readonly existingFlag: boolean;
  // Add new flag
  readonly newUI: boolean;
};

export const loadFeatureFlags = (): FeatureFlags => ({
  existingFlag: parseEnvFlag(process.env.FEATURE_EXISTING_FLAG),
  // Add new flag
  newUI: parseEnvFlag(process.env.FEATURE_NEW_UI),
});
```

**Files Modified**:
- `.env.example`
- `.env` (if exists and safe to modify)
- Type definitions
- Flag loading function

#### Config File-Based

**Action**: Add to config file

```json
// config/features.json
{
  "features": {
    "existingFeature": { "enabled": true, "description": "..." },
    "newUI": {
      "enabled": false,
      "description": "Enable the new UI redesign",
      "rollout": 0
    }
  }
}
```

**Files Modified**:
- `config/features.json` or `config/features.yaml`
- Type definitions (if strict typing)

#### Database-Backed

**Action**: Generate database insertion

```typescript
// Generate migration or admin script
// Migration: prisma/migrations/add_new_ui_flag.sql
INSERT INTO feature_flags (name, enabled, description, rollout)
VALUES ('new-ui', false, 'Enable the new UI redesign', 0);

// Or via ORM: scripts/add-flag.ts
import { prisma } from './db';

await prisma.featureFlag.create({
  data: {
    name: 'new-ui',
    enabled: false,
    description: 'Enable the new UI redesign',
    rollout: 0,
  },
});
```

**Files Created**:
- Migration file or seed script
- Helper script for adding flags

#### Pub/Sub Based

**Action**: Publish flag creation message

```typescript
// Generate script: scripts/add-flag.ts
import { redis } from './config/redis';

// Set flag in Redis
await redis.set('feature:new-ui', 'false');

// Publish update
await redis.publish('feature-flags:update', JSON.stringify({
  action: 'create',
  name: 'new-ui',
  enabled: false,
  description: 'Enable the new UI redesign',
}));
```

**Files Created**:
- Helper script for flag management
- Update documentation

### Phase 4: Test Generation

**Objective**: Generate tests for the new flag

**Action**: Launch **flag-code-generator** agent to create tests

**Test Types Generated**:

1. **Unit Tests**:
   ```typescript
   // Add to existing test file or create new
   describe('Feature Flag: new-ui', () => {
     it('should be disabled by default', () => {
       expect(isFeatureEnabled('newUI')).toBe(false);
     });

     it('should return true when enabled', () => {
       // Setup based on system type
       expect(isFeatureEnabled('newUI')).toBe(true);
     });
   });
   ```

2. **Integration Tests** (if applicable):
   ```typescript
   // Test database operations, cache, etc.
   it('should retrieve new-ui flag from database', async () => {
     const flag = await getFlag('new-ui');
     expect(flag.enabled).toBe(false);
   });
   ```

3. **E2E Tests** (if applicable):
   ```typescript
   // Test user-facing behavior
   it('should show old UI when flag disabled', async () => {
     await page.goto('/');
     expect(await page.locator('.old-ui').isVisible()).toBe(true);
   });
   ```

**Files Modified/Created**:
- Add to existing test files or create new
- Follow project test conventions

### Phase 5: Documentation Update

**Objective**: Update documentation with new flag

**Actions**:

1. **Update README** or docs with flag list:
   ```markdown
   ## Available Feature Flags

   - `existing-flag`: Description of existing flag
   - `new-ui`: Enable the new UI redesign (Default: disabled)
   ```

2. **Update usage examples** if needed:
   ```typescript
   // Example using new flag
   import { isFeatureEnabled } from './services/featureFlags';

   if (await isFeatureEnabled('new-ui')) {
     return <NewUI />;
   } else {
     return <OldUI />;
   }
   ```

3. **Update environment documentation** if env-based:
   ```bash
   # Add to environment docs
   FEATURE_NEW_UI=false  # Enable the new UI redesign
   ```

**Files Modified**:
- `README.md` or `docs/feature-flags.md`
- `.env.example` comments (if env-based)
- Usage documentation

### Phase 6: Validation

**Objective**: Verify the flag was added correctly

**Action**: Launch **flag-validator** agent to:
- Verify flag was added to correct location
- Check naming conventions followed
- Ensure no duplicate flags
- Validate test coverage
- Check documentation updated

**Validation Checks**:
- ✅ Flag added to primary source (env/.config/database/service)
- ✅ Naming convention followed
- ✅ No syntax errors introduced
- ✅ Tests generated and passing
- ✅ Documentation updated
- ✅ Type definitions updated (if applicable)

**Output**: Validation report

### Phase 7: Test Execution

**Objective**: Verify tests pass

**Actions**:
1. Ask user if they want to run tests now
2. **If yes**:
   - Run unit tests for feature flags
   - Show results
   - If failures: Provide debugging guidance
3. **If no**: Remind to run tests before committing

### Phase 8: Usage Guidance

**Objective**: Show user how to use the new flag

**Actions**:

1. **Show usage example** based on system type:
   ```typescript
   // Import the flag service
   import { isFeatureEnabled } from './services/featureFlags';

   // Check if flag is enabled
   const isNewUIEnabled = await isFeatureEnabled('new-ui');

   if (isNewUIEnabled) {
     // New feature code
   } else {
     // Existing code
   }

   // Or use helper
   return withFeature('newUI',
     () => <NewUI />,
     () => <OldUI />
   );
   ```

2. **Show how to enable the flag**:
   - **Environment**: Set `FEATURE_NEW_UI=true` in `.env`
   - **Config**: Edit `config/features.json`, set `enabled: true`
   - **Database**: Run update SQL or use admin script
   - **Service**: Enable via LaunchDarkly/Unleash dashboard

3. **Show how to test the flag**:
   ```bash
   # Run tests
   npm test

   # Test manually with flag enabled
   FEATURE_NEW_UI=true npm run dev
   ```

4. **Remind about cleanup**:
   ```
   ⚠️ Remember: Feature flags should be temporary!

   Once the feature is stable and rolled out:
   1. Remove the flag checks from code
   2. Remove the flag from configuration
   3. Clean up tests
   ```

### Phase 9: Summary

**Objective**: Provide clear summary of what was done

**Output**:
```
✅ Feature flag "new-ui" added successfully!

📁 Files Modified:
- [file list with paths]

📝 Files Created:
- [file list with paths]

🧪 Tests Generated:
- [test file paths]

📚 Documentation Updated:
- README.md - Added flag to list

🚀 Next Steps:

1. Use the flag in your code:
   [usage example]

2. Enable the flag:
   [how to enable based on system type]

3. Test your implementation:
   npm test

4. Deploy and monitor:
   [deployment guidance if applicable]

5. When stable, remove the flag:
   [cleanup guidance]
```

## Advanced Options

### Flag with Targeting

For systems that support user targeting (LaunchDarkly, Unleash, custom):

```
/feature-flags-add premium-features --target "user.subscription === 'premium'"
```

Generates targeting logic based on system capabilities.

### Flag with Rollout

For gradual rollouts:

```
/feature-flags-add new-algorithm --rollout 10
```

Generates rollout logic (10% of users see the feature).

### Flag with Variants

For A/B testing (if supported):

```
/feature-flags-add ui-variant --variants "control,variant-a,variant-b"
```

Generates multi-variant flag handling.

## Functional Programming Approach

Generated code maintains functional principles:

```typescript
// Pure flag definition
type NewFlag = {
  readonly newUI: boolean
}

// Immutable flag addition
type AllFlags = ExistingFlags & NewFlag

// Pure evaluation
const evaluateNewUI = (config: FlagConfig): boolean => {
  // Pure logic
}
```

## Error Handling

**Flag already exists**:
- Show existing flag details
- Ask if user wants to:
  - Update the flag
  - Use different name
  - Cancel

**Invalid flag name**:
- Show naming convention
- Suggest valid alternatives
- Ask user to choose

**System not initialized**:
- Detect that no feature flag system exists
- Suggest running `/feature-flags-init` first
- Offer to run init now

**Multiple systems detected**:
- Show all detected systems
- Ask user which to use
- Remember choice for future adds

## Implementation Instructions

Your task as the orchestrator is to:

1. **Use TodoWrite** to track each phase
2. **Launch flag-system-detector** to understand existing system
3. **Validate flag name** and check for duplicates
4. **Parse command options** or ask user for missing details
5. **Launch flag-code-generator** to add the flag
6. **Launch flag-code-generator** again for tests
7. **Update documentation** as needed
8. **Launch flag-validator** to verify correctness
9. **Optionally run tests** if user confirms
10. **Provide usage guidance** and summary

## Success Criteria

The command is successful when:
- ✅ Flag added to correct location following conventions
- ✅ No duplicate flags introduced
- ✅ Tests generated and passing
- ✅ Documentation updated
- ✅ Validation passed
- ✅ User knows how to use the flag

Your goal is to make adding feature flags completely seamless and require zero manual configuration.
