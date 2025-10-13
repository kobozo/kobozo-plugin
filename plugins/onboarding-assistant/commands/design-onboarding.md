---
description: Design complete multi-step onboarding flows with progress tracking and conditional paths
---

# Design Onboarding

Create a comprehensive onboarding flow that guides new users through your application.

## Usage

```
/design-onboarding <flow-name> [--type=linear|branched|progressive]
```

**Examples:**
```
/design-onboarding new-user-setup
/design-onboarding developer-onboarding --type=branched
/design-onboarding progressive-profile --type=progressive
```

## Execution Flow

### Phase 1: User Journey Mapping
1. Launch **onboarding-flow-designer** agent
2. Analyze application structure and features
3. Identify key activation milestones
4. Map user journey from signup to first value

### Phase 2: Flow Design
1. Design step sequence (4-6 steps optimal)
2. Create conditional branches based on user type/role
3. Define progress indicators and completion criteria
4. Plan gamification elements (points, achievements)

### Phase 3: Implementation
1. Generate onboarding flow component
2. Create step components with validation
3. Implement progress tracking and persistence
4. Add completion detection and rewards

### Phase 4: Polish
1. Launch **tooltip-generator** agent
2. Add contextual help for each step
3. Implement skip/back navigation
4. Create completion celebration screen

## Flow Types

### Linear Flow
Sequential steps for all users:
- Signup → Profile Setup → Preferences → Tour → Dashboard

### Branched Flow
Different paths based on user type:
- Developer path: Setup API Keys → Integration Guide
- Manager path: Team Setup → Invite Members

### Progressive Profiling
Gradual information collection:
- Minimal signup → Quick activation → Profile enrichment over time

## When to Use

- For SaaS onboarding after signup
- To improve user activation rates
- When introducing complex workflows
- To collect user preferences and profile data

This command creates production-ready onboarding flows with progress tracking.
