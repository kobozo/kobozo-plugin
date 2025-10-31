---
description: List all feature flags in the system with their current state and details
---

# Feature Flags List

Lists all feature flags in your system, showing their current state, descriptions, and usage information.

## Usage

```
/feature-flags-list [options]
```

Examples:
- `/feature-flags-list` - List all flags with details
- `/feature-flags-list --enabled` - Show only enabled flags
- `/feature-flags-list --disabled` - Show only disabled flags
- `/feature-flags-list --format json` - Output as JSON
- `/feature-flags-list --usage` - Include usage locations in codebase

## What This Command Does

This command:
1. Detects your feature flag system
2. Retrieves all flags from the source (env, config, database, service)
3. Analyzes flag usage across the codebase
4. Presents flags in a clear, organized format
5. Identifies unused or stale flags

## Execution Flow

### Phase 1: System Detection

**Objective**: Identify the feature flag system

**Action**: Launch **flag-system-detector** agent to:
- Detect feature flag implementation type
- Locate flag definitions
- Find flag evaluation functions
- Identify flag usage patterns

**Output**: Detection report with system details

**Error Handling**:
- If no system found: Report "No feature flag system detected" and suggest `/feature-flags-init`
- If multiple systems: List flags from all systems with source indication

### Phase 2: Flag Retrieval

**Objective**: Get all flags and their current state

**Retrieval Strategy by System Type**:

#### Service Integration (LaunchDarkly/Unleash)

**Action**: Use SDK to list flags

```typescript
// LaunchDarkly
const flags = await ldClient.allFlags(user);

// Unleash
const features = unleashClient.getFeatureToggleDefinitions();
```

**Information Retrieved**:
- Flag names
- Current state (enabled/disabled)
- Descriptions
- Tags/categories
- Rollout percentages
- Targeting rules
- Last modified date

#### Environment-Based

**Action**: Parse .env files and code

```typescript
// Read .env.example for flag list
// Parse flag service for type definitions
// Extract flag names and defaults
```

**Information Retrieved**:
- Flag names (from FEATURE_* env vars)
- Current values (from .env if exists)
- Default values
- Comments/descriptions from .env

#### Config File-Based

**Action**: Read and parse config files

```typescript
// Read config/features.json or .yaml
const config = JSON.parse(fs.readFileSync('config/features.json'));
const flags = config.features;
```

**Information Retrieved**:
- Flag names
- Enabled state
- Descriptions
- Rollout percentages
- Metadata
- Timestamps (if available)

#### Database-Backed

**Action**: Query database for all flags

```typescript
// Query feature_flags table
const flags = await prisma.featureFlag.findMany({
  orderBy: { name: 'asc' }
});
```

**Information Retrieved**:
- All flag properties from database
- Creation/update timestamps
- Full metadata

#### Pub/Sub Based

**Action**: Query Redis or message broker

```typescript
// Get all feature:* keys from Redis
const keys = await redis.keys('feature:*');
const flags = await Promise.all(
  keys.map(key => redis.get(key))
);
```

**Information Retrieved**:
- Flag names
- Current state
- Cache metadata

### Phase 3: Usage Analysis

**Objective**: Find where flags are used in the codebase

**Action**: Use Grep to search for flag usage

**Search Patterns**:
```bash
# For each flag, search for usage
isFeatureEnabled('flag-name')
featureFlags.flag-name
FEATURE_FLAG_NAME
config.features.flagName
```

**Information Collected**:
- Files using each flag
- Line numbers
- Usage context (if statement, ternary, etc.)
- Number of usages per flag

**Identify Stale Flags**:
- Flags with zero usages (candidates for removal)
- Flags enabled everywhere (feature completed)
- Flags disabled everywhere (feature abandoned)

### Phase 4: Format Output

**Objective**: Present flags in requested format

**Default Format (Table)**:

```
┌──────────────────────┬──────────┬──────────┬─────────────────────────────┬──────────┐
│ Flag Name            │ State    │ Rollout  │ Description                 │ Usages   │
├──────────────────────┼──────────┼──────────┼─────────────────────────────┼──────────┤
│ new-ui               │ Enabled  │ 100%     │ Enable new UI redesign      │ 12       │
│ experimental-api     │ Disabled │ 0%       │ Experimental API endpoints  │ 5        │
│ beta-features        │ Enabled  │ 50%      │ Beta features rollout       │ 8        │
│ legacy-dashboard     │ Enabled  │ 100%     │ Use legacy dashboard        │ 0 ⚠️     │
└──────────────────────┴──────────┴──────────┴─────────────────────────────┴──────────┘

⚠️ Flags with zero usages may be stale and can be removed.
```

**Detailed Format**:

```
## Feature Flags Summary

Total Flags: 4
Enabled: 3 (75%)
Disabled: 1 (25%)
Stale (unused): 1

---

### new-ui
**Status**: ✅ Enabled (100% rollout)
**Description**: Enable the new UI redesign
**Usages**: 12 locations
  - src/components/Dashboard.tsx:45
  - src/components/Header.tsx:23
  - src/pages/Home.tsx:67
  - ... (9 more)
**Last Modified**: 2025-01-15
**Tags**: frontend, ui

---

### experimental-api
**Status**: ❌ Disabled
**Description**: Experimental API endpoints
**Usages**: 5 locations
  - src/api/routes.ts:89
  - src/api/experimental.ts:12
  - ... (3 more)
**Last Modified**: 2025-01-10
**Tags**: backend, api

---

### beta-features
**Status**: ⚙️ Enabled (50% rollout)
**Description**: Beta features rollout
**Usages**: 8 locations
  - src/features/BetaFeature.tsx:15
  - ... (7 more)
**Last Modified**: 2025-01-20
**Tags**: beta

---

### legacy-dashboard
**Status**: ⚠️ Enabled but UNUSED
**Description**: Use legacy dashboard
**Usages**: 0 locations
**Last Modified**: 2024-11-05
**Recommendation**: This flag appears to be stale. Consider removing it.

---

## Recommendations

### Flags Ready for Cleanup:
1. **new-ui** - Enabled at 100%, consider removing flag and keeping new code
2. **legacy-dashboard** - No usages found, safe to remove

### Flags to Review:
1. **experimental-api** - Disabled for 3+ months, decide to enable or remove
2. **beta-features** - At 50% rollout for 2+ weeks, consider increasing or stabilizing
```

**JSON Format** (with --format json):

```json
{
  "summary": {
    "total": 4,
    "enabled": 3,
    "disabled": 1,
    "stale": 1
  },
  "flags": [
    {
      "name": "new-ui",
      "enabled": true,
      "rollout": 100,
      "description": "Enable the new UI redesign",
      "usages": 12,
      "locations": [
        {
          "file": "src/components/Dashboard.tsx",
          "line": 45
        }
      ],
      "lastModified": "2025-01-15T10:30:00Z",
      "tags": ["frontend", "ui"]
    }
  ],
  "recommendations": {
    "cleanup": ["new-ui", "legacy-dashboard"],
    "review": ["experimental-api", "beta-features"]
  }
}
```

**Filtered Output** (with --enabled or --disabled):

Only show flags matching the filter.

### Phase 5: Analysis & Recommendations

**Objective**: Provide insights on flag health

**Analysis**:

1. **Stale Flags**:
   - Flags with zero usages
   - Flags unchanged for 90+ days
   - Flags enabled at 100% for 30+ days (feature stable)

2. **Risky Flags**:
   - Flags with many usages (high impact if toggled)
   - Flags without tests
   - Flags with description missing

3. **Optimization Opportunities**:
   - Flags that can be removed (feature complete)
   - Flags that should be migrated to config (no need for toggle)
   - Duplicate or overlapping flags

**Recommendations Output**:

```
## Flag Health Analysis

### 🟢 Healthy Flags (2)
Flags that are properly configured and actively used.

### 🟡 Flags Needing Attention (1)
- **experimental-api**: Disabled for 3+ months, decide next steps

### 🔴 Stale Flags (1)
- **legacy-dashboard**: No usages found, safe to remove

### 💡 Optimization Suggestions
1. Remove `new-ui` flag - feature is stable at 100% rollout
2. Add tests for `beta-features` - no tests detected
3. Consider consolidating `feature-a` and `feature-b` - they overlap
```

### Phase 6: Interactive Actions

**Objective**: Offer quick actions for flag management

**If stale flags found**:
```
Found 2 stale flags that can be cleaned up:
- legacy-dashboard (0 usages)
- old-feature (enabled 100% for 90+ days)

Would you like to:
1. Remove these flags now
2. Review each flag individually
3. Generate cleanup PR
4. Do nothing (keep for now)
```

**User can choose**:
- Automatic cleanup with `/feature-flags-remove`
- Review process with detailed analysis
- Generate PR with all cleanup changes
- Skip for now

### Phase 7: Export Options

**Objective**: Allow export for external use

**Export Formats**:
- **Markdown**: For documentation
- **JSON**: For programmatic use
- **CSV**: For spreadsheet analysis
- **HTML**: For dashboard/wiki

**Actions**:
1. Ask user if they want to export
2. Choose format
3. Choose destination (file, stdout, clipboard)
4. Generate and save

### Phase 8: Summary

**Objective**: Wrap up with clear action items

**Output**:
```
✅ Feature Flags Listed

📊 Summary:
- Total Flags: 4
- Enabled: 3 (75%)
- Disabled: 1 (25%)
- Stale: 1

⚠️ Action Items:
1. Review `legacy-dashboard` flag (unused)
2. Decide on `experimental-api` (disabled 3+ months)
3. Consider removing `new-ui` flag (feature stable)

📝 Documentation:
Flag list exported to: docs/feature-flags.md

🔧 Next Steps:
- Add new flag: /feature-flags-add <name>
- Remove stale flag: /feature-flags-remove <name>
- Initialize system: /feature-flags-init (if not found)
```

## Advanced Options

### Show Usage Locations

```
/feature-flags-list --usage
```

Shows detailed usage information for each flag:
```
### new-ui (12 usages)

**Frontend (8 usages)**:
- src/components/Dashboard.tsx:45
  ```typescript
  if (isFeatureEnabled('new-ui')) {
  ```
- src/components/Header.tsx:23
  ```typescript
  const Header = withFeature('newUI', NewHeader, OldHeader);
  ```

**Backend (4 usages)**:
- src/api/routes.ts:89
  ```typescript
  if (await isFeatureEnabled('new-ui')) {
  ```
```

### Filter by Tag/Category

```
/feature-flags-list --tag frontend
```

Shows only flags with specific tags (if system supports tagging).

### Show Only Changed Recently

```
/feature-flags-list --recent 7d
```

Shows flags modified in last 7 days.

## Functional Programming Approach

The listing logic is implemented as pure functions:

```typescript
// Pure flag listing
type FlagList = ReadonlyArray<FlagInfo>

const listFlags = (source: FlagSource): FlagList
const filterFlags = (flags: FlagList, predicate: Predicate): FlagList
const analyzeUsage = (flags: FlagList, codebase: Codebase): FlagList
const formatOutput = (flags: FlagList, format: Format): string

// Composition
const pipeline = pipe(
  listFlags,
  flags => filterFlags(flags, options.filter),
  flags => analyzeUsage(flags, codebase),
  flags => formatOutput(flags, options.format)
)
```

## Error Handling

**No feature flag system found**:
- Display friendly message
- Suggest running `/feature-flags-init`
- Offer to search for ad-hoc flags in codebase

**Service connection failed** (LaunchDarkly/Unleash):
- Use cached flags if available
- Show warning about stale data
- Provide connection troubleshooting

**Database connection failed**:
- Show cached flags if available
- Provide clear error message
- Suggest checking DATABASE_URL

**Config file parsing failed**:
- Show specific parsing error
- Suggest validation with JSON/YAML linter
- Show line number of error

## Implementation Instructions

Your task as the orchestrator is to:

1. **Use TodoWrite** to track phases
2. **Launch flag-system-detector** to identify system
3. **Retrieve flags** based on detected system type
4. **Analyze usage** across codebase with Grep
5. **Format output** according to user options
6. **Provide analysis** and recommendations
7. **Offer interactive actions** for flag management
8. **Export if requested** in chosen format
9. **Summarize** with action items

## Success Criteria

The command is successful when:
- ✅ All flags retrieved from system
- ✅ Usage information accurate
- ✅ Stale flags identified correctly
- ✅ Output formatted clearly
- ✅ Recommendations actionable
- ✅ User understands flag state

Your goal is to provide complete visibility into the feature flag landscape with actionable insights.
