---
description: This skill should be used when the user asks to "design onboarding", "create onboarding flow", "build user onboarding", "create product tour", "add tooltips", "design welcome flow", or needs help creating user onboarding experiences. Provides guidance on onboarding flows, product tours, and contextual help.
---

# Onboarding Design Skill

Create comprehensive onboarding experiences that guide new users through your application to their first value moment.

## When to Use

- Designing new user signup flows
- Creating product tours
- Adding contextual tooltips
- Improving user activation rates
- Building progressive profiling
- Introducing complex features

## Onboarding Flow Types

### Linear Flow
Sequential steps for all users.

**Best for:** Simple products, universal user journey
**Structure:** Signup → Profile → Preferences → Tour → Dashboard

```
Step 1 → Step 2 → Step 3 → Step 4 → Complete
```

### Branched Flow
Different paths based on user type or role.

**Best for:** Products with distinct user personas
**Structure:** Detect user type → Route to appropriate path

```
             ┌→ Developer Path → API Setup → Integration
Signup → Role Selection ─┼→ Manager Path → Team Setup → Invites
             └→ Individual Path → Quick Start → Dashboard
```

### Progressive Profiling
Gradual information collection over time.

**Best for:** Reducing signup friction, complex products
**Structure:** Minimal signup → Quick activation → Enrichment over sessions

```
Session 1: Email only → Dashboard
Session 2: Add name → Personalized experience
Session 3: Add preferences → Tailored content
Session N: Complete profile → Full features
```

## Onboarding Best Practices

### Step Design
- **4-6 steps optimal**: Too few lacks guidance, too many causes dropout
- **Clear progress indicator**: Show users where they are
- **Skip option**: Allow advanced users to bypass
- **Back navigation**: Let users correct mistakes
- **Save progress**: Don't lose data on refresh

### Content Guidelines
- **Benefit-focused**: Show value, not just features
- **Action-oriented**: Each step has clear action
- **Contextual**: Information when needed
- **Personalized**: Use user's name, role

### Activation Metrics
- **Time to first value**: How fast users get benefit
- **Activation rate**: % completing key actions
- **Drop-off points**: Where users abandon
- **Engagement score**: Overall onboarding health

## Product Tour Patterns

### Step-by-Step Tour
Guided walkthrough of key features.

**Implementation:**
```javascript
const tourSteps = [
  {
    target: '.dashboard-nav',
    content: 'Navigate between sections here',
    placement: 'bottom'
  },
  {
    target: '.create-button',
    content: 'Click here to create your first project',
    placement: 'left'
  }
];
```

### Spotlight Tour
Highlight specific elements with explanations.

**Best for:** Complex interfaces, feature discovery

### Tooltip Hints
Contextual help on hover or first visit.

**Best for:** Progressive disclosure, advanced features

## Tour Libraries

### Intro.js
- Lightweight, no dependencies
- Simple step-by-step tours
- Good browser support

### Shepherd.js
- Flexible positioning
- Progress indicators
- Conditional steps

### Driver.js
- Smooth animations
- Keyboard navigation
- Active element highlighting

### React Joyride
- React-native integration
- Controlled/uncontrolled modes
- Callback hooks for analytics

## Progress Tracking

### Storage Options
- **localStorage**: Simple, client-side only
- **Database**: Persistent, cross-device
- **State management**: Redux, Context API

### Tracking Schema
```typescript
interface OnboardingProgress {
  userId: string;
  currentStep: number;
  completedSteps: string[];
  startedAt: Date;
  completedAt: Date | null;
  skippedSteps: string[];
}
```

### Events to Track
- Step viewed
- Step completed
- Step skipped
- Tour abandoned
- Tour completed

## Gamification Elements

### Progress Bars
Visual indicator of completion percentage.

### Checklists
Visible list of tasks with checkmarks.

### Achievements
Celebrate milestone completions.

### Points/Rewards
Optional: Points for completing tasks.

## Flow Design Checklist

- [ ] Clear user goal defined
- [ ] Steps mapped to activation milestones
- [ ] Progress indicator designed
- [ ] Skip/back navigation included
- [ ] Mobile-responsive layout
- [ ] Completion celebration planned
- [ ] Analytics tracking configured
- [ ] A/B testing considerations

## Invoke Full Workflow

For comprehensive onboarding design with implementation:

**Use the Task tool** to launch onboarding agents:

1. **Flow Design**: Launch `onboarding-assistant:onboarding-flow-designer` agent to design the complete flow
2. **Product Tour**: Launch `onboarding-assistant:tour-builder` agent to create interactive tours
3. **Contextual Help**: Launch `onboarding-assistant:tooltip-generator` agent for tooltips and hints

**Example prompt for agent:**
```
Design a new user onboarding flow for our SaaS dashboard.
Users are developers who need to set up API keys and make their first API call.
Include progress tracking and a product tour.
```

## Quick Reference

### Flow Type Selection
| Criteria | Flow Type |
|----------|-----------|
| Universal journey | Linear |
| Multiple personas | Branched |
| High friction signup | Progressive |
| Complex product | Branched + Progressive |

### Optimal Step Count
- Signup: 2-3 steps
- Product tour: 5-7 highlights
- Feature introduction: 3-5 steps

### Key Metrics
- Completion rate target: >70%
- Time to complete: <5 minutes
- Drop-off: <30% per step
