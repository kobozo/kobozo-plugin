# Onboarding Assistant Plugin

Create interactive user onboarding experiences - guided tours, product walkthroughs, tooltips, and step-by-step flows.

**Version:** 1.0.0
**Author:** Yannick De Backer (yannick@kobozo.eu)

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Commands](#commands)
  - [create-tour](#create-tour)
  - [design-onboarding](#design-onboarding)
- [Agents](#agents)
  - [tour-builder](#tour-builder)
  - [onboarding-flow-designer](#onboarding-flow-designer)
  - [tooltip-generator](#tooltip-generator)
- [Supported Tour Libraries](#supported-tour-libraries)
  - [React Joyride](#react-joyride)
  - [Intro.js](#introjs)
  - [Shepherd.js](#shepherdjs)
  - [Driver.js](#driverjs)
- [Workflow Examples](#workflow-examples)
- [Best Practices](#best-practices)
- [Use Cases](#use-cases)

---

## Overview

The Onboarding Assistant plugin helps you create engaging, effective user onboarding experiences that improve activation rates and feature adoption. It provides specialized agents and commands to build:

- **Interactive Product Tours**: Step-by-step guided walkthroughs of your application
- **Onboarding Flows**: Multi-step user activation sequences with progress tracking
- **Contextual Tooltips**: Inline help text and guidance for UI elements
- **Progressive Disclosure**: Gradual feature introduction based on user journey

The plugin supports popular tour libraries and generates production-ready React components with best practices built in.

---

## Key Features

- **Multi-library Support**: Works with React Joyride, Intro.js, Shepherd.js, and Driver.js
- **Intelligent UI Analysis**: Automatically scans your application to identify key features
- **Flow Design**: Creates linear, branched, or progressive onboarding experiences
- **Progress Tracking**: Implements completion detection and persistence
- **Gamification**: Adds points, achievements, and progress indicators
- **Contextual Help**: Generates benefit-focused tooltip copy
- **Production-Ready Code**: Generates complete, tested implementations
- **Customizable**: Easily adapt generated code to your design system

---

## Installation

This plugin is designed for use with Claude Code. To install:

1. Clone or download this plugin to your Claude Code plugins directory
2. The plugin will be automatically available in Claude Code
3. Use the commands below to generate onboarding experiences

**No additional dependencies required** - the plugin generates code that you can integrate with your preferred tour library.

---

## Commands

### create-tour

Create an interactive product tour with step-by-step guidance through key features.

#### Usage

```bash
/create-tour <tour-name> [--library=react-joyride|intro.js|shepherd|driver]
```

#### Examples

```bash
# Create a dashboard tour with default library (React Joyride)
/create-tour dashboard-intro

# Create a getting started tour with Shepherd.js
/create-tour getting-started --library=shepherd

# Create a feature discovery tour with Driver.js
/create-tour feature-discovery --library=driver
```

#### Execution Flow

**Phase 1: UI Analysis**
1. Launches the **tour-builder** agent
2. Scans application components for key features
3. Identifies important UI elements and their purpose
4. Determines optimal step sequence and flow

**Phase 2: Tour Design**
1. Creates 5-7 step tour focusing on core features
2. Writes engaging, benefit-focused tooltip content
3. Designs step sequence and element placement
4. Adds progress indicators and navigation controls

**Phase 3: Implementation**
1. Generates tour configuration file with all steps
2. Creates React component with tour logic
3. Adds trigger logic (first login, feature discovery, etc.)
4. Implements completion tracking and persistence

**Phase 4: Tooltips**
1. Launches the **tooltip-generator** agent
2. Generates contextual tooltips for each step
3. Adds keyboard shortcut hints where applicable
4. Includes benefit-focused, action-oriented copy

#### Output Files

- `src/tours/{tour-name}Tour.js` - Tour configuration
- `src/components/{TourName}Tour.jsx` - React component
- Implementation guide with integration instructions

#### When to Use

- After launching new features that need introduction
- For first-time user activation and orientation
- When introducing complex workflows or interfaces
- To increase feature discovery and adoption rates
- After UI redesigns to guide existing users

---

### design-onboarding

Design complete multi-step onboarding flows with progress tracking and conditional paths.

#### Usage

```bash
/design-onboarding <flow-name> [--type=linear|branched|progressive]
```

#### Examples

```bash
# Create a linear onboarding flow
/design-onboarding new-user-setup

# Create a branched flow for different user types
/design-onboarding developer-onboarding --type=branched

# Create progressive profiling flow
/design-onboarding progressive-profile --type=progressive
```

#### Execution Flow

**Phase 1: User Journey Mapping**
1. Launches the **onboarding-flow-designer** agent
2. Analyzes application structure and key features
3. Identifies activation milestones and success metrics
4. Maps complete user journey from signup to first value

**Phase 2: Flow Design**
1. Designs optimal step sequence (4-6 steps recommended)
2. Creates conditional branches based on user type or role
3. Defines progress indicators and completion criteria
4. Plans gamification elements (points, achievements, badges)

**Phase 3: Implementation**
1. Generates onboarding flow component with routing
2. Creates individual step components with validation
3. Implements progress tracking and state persistence
4. Adds completion detection and reward mechanics

**Phase 4: Polish**
1. Launches the **tooltip-generator** agent
2. Adds contextual help for each onboarding step
3. Implements skip/back navigation options
4. Creates completion celebration screen

#### Flow Types

**Linear Flow**
```
Signup → Profile Setup → Preferences → Tour → Dashboard
```
Sequential steps that all users complete in the same order. Best for simple applications with straightforward setup.

**Branched Flow**
```
Signup → Choose Role
    ├─ Developer → Setup API Keys → Integration Guide
    └─ Manager → Team Setup → Invite Members → Dashboard
```
Different paths based on user type, role, or preferences. Ideal for applications serving multiple personas.

**Progressive Profiling**
```
Signup (email only) → Quick Activation → Profile Enrichment → Advanced Features
```
Gradual information collection over time. Minimizes initial friction while gathering data progressively.

#### Output Files

- `src/components/OnboardingFlow.jsx` - Main flow component
- `src/components/onboarding/` - Individual step components
- `src/config/onboardingSteps.js` - Flow configuration
- Integration guide and styling templates

#### When to Use

- For SaaS applications after user signup
- To improve user activation and retention rates
- When introducing complex workflows or setup processes
- To collect user preferences and profile data
- When you need role-based or conditional onboarding

---

## Agents

### tour-builder

Creates interactive product tours and guided walkthroughs using popular tour libraries.

#### Capabilities

- **UI Analysis**: Scans components to identify key features
- **Tour Design**: Creates logical step sequences (5-7 steps optimal)
- **Configuration Generation**: Produces library-specific config files
- **Content Creation**: Writes engaging tooltip copy
- **Implementation**: Generates complete React components

#### Tools Available

- Bash, Read, Glob, Grep, TodoWrite, Write

#### Tour Design Principles

1. **Keep it Short**: 5-7 steps maximum, focus on core features only
2. **Progressive Disclosure**: Start with basics, build complexity gradually
3. **Contextual Timing**: Show tours at the right moment in user journey
4. **Clear Value**: Explain benefits, not just features

#### Example Output

The agent generates complete tour implementations with:
- Step-by-step configuration
- React component with hooks
- Completion tracking via localStorage
- Customizable styling
- Skip and navigation controls

---

### onboarding-flow-designer

Designs multi-step onboarding flows with progress tracking, user profiling, and conditional paths.

#### Capabilities

- **Journey Mapping**: Maps complete user activation journey
- **Flow Design**: Creates linear, branched, or progressive flows
- **Progress Tracking**: Implements completion metrics and persistence
- **Conditional Logic**: Builds role-based or preference-based paths
- **Gamification**: Adds points, achievements, and progress indicators

#### Tools Available

- Bash, Read, Glob, Grep, TodoWrite, Write

#### Onboarding Patterns

**Linear Flow Pattern**
```javascript
const STEPS = [
  { id: 'welcome', title: 'Welcome' },
  { id: 'profile', title: 'Profile Setup' },
  { id: 'preferences', title: 'Preferences' },
  { id: 'complete', title: 'All Done!' }
];
```

**Checklist Pattern**
```javascript
const TASKS = [
  { id: 'profile', title: 'Complete your profile', points: 10 },
  { id: 'invite', title: 'Invite team members', points: 20 },
  { id: 'project', title: 'Create first project', points: 30 }
];
```

**Branched Flow Pattern**
```javascript
const PATHS = {
  developer: ['welcome', 'api-setup', 'integration'],
  manager: ['welcome', 'team-setup', 'invite-members']
};
```

---

### tooltip-generator

Generates contextual tooltips and help text for UI elements to guide users through features.

#### Capabilities

- **UI Scanning**: Identifies complex features needing explanation
- **Copy Writing**: Creates clear, concise tooltip text
- **Configuration**: Generates tooltip library configs
- **Implementation**: Provides integration code
- **Progressive Disclosure**: Implements contextual help patterns

#### Tools Available

- Bash, Read, Glob, Grep, TodoWrite, Write

#### Tooltip Writing Guidelines

**Be Concise**
- Good: "Search across all projects"
- Bad: "Click this button to search for items across all of your projects in the system"

**Explain Benefits**
- Good: "Export to PDF for easy sharing"
- Bad: "Export button"

**Use Action Verbs**
- Good: "Click to add a new member"
- Bad: "New member"

**Provide Context**
- Good: "Search across projects (⌘K)"
- Bad: "Search"

---

## Supported Tour Libraries

### React Joyride

**Best for:** React applications, simple setup, flexible styling

```javascript
import Joyride from 'react-joyride';

const steps = [
  {
    target: '.dashboard-header',
    content: 'Welcome to your dashboard!',
    placement: 'bottom',
    disableBeacon: true
  },
  {
    target: '#create-button',
    content: 'Click here to create your first project',
    placement: 'left'
  }
];

<Joyride
  steps={steps}
  continuous
  showProgress
  showSkipButton
/>
```

**Features:**
- Built for React
- Highly customizable
- Progress indicators
- Skip/back navigation
- Event callbacks

---

### Intro.js

**Best for:** Vanilla JavaScript, framework-agnostic, quick integration

```javascript
import introJs from 'intro.js';

introJs().setOptions({
  steps: [
    {
      element: document.querySelector('.dashboard'),
      intro: 'This is your main dashboard',
      position: 'bottom'
    },
    {
      element: document.querySelector('#sidebar'),
      intro: 'Navigate using this sidebar',
      position: 'right'
    }
  ],
  showProgress: true,
  showBullets: false
}).start();
```

**Features:**
- Framework agnostic
- Simple API
- Keyboard navigation
- Multi-page tours
- RTL support

---

### Shepherd.js

**Best for:** Complex tours, custom styling, advanced features

```javascript
import Shepherd from 'shepherd.js';

const tour = new Shepherd.Tour({
  useModalOverlay: true,
  defaultStepOptions: {
    classes: 'shadow-md bg-purple-dark',
    scrollTo: true
  }
});

tour.addStep({
  id: 'welcome',
  text: 'Welcome to the app!',
  attachTo: {
    element: '.header',
    on: 'bottom'
  },
  buttons: [
    {
      text: 'Next',
      action: tour.next
    }
  ]
});

tour.start();
```

**Features:**
- Powerful API
- Modal overlays
- Custom buttons
- Extensive theming
- Accessibility support

---

### Driver.js

**Best for:** Lightweight, modern, minimal dependencies

```javascript
import { driver } from 'driver.js';

const driverObj = driver({
  showProgress: true,
  steps: [
    {
      element: '#search',
      popover: {
        title: 'Search',
        description: 'Find anything you need quickly'
      }
    },
    {
      element: '#profile',
      popover: {
        title: 'Profile',
        description: 'Manage your account settings'
      }
    }
  ]
});

driverObj.drive();
```

**Features:**
- Lightweight (~5KB)
- Modern API
- Keyboard navigation
- Smooth animations
- TypeScript support

---

## Workflow Examples

### Example 1: Create Dashboard Tour

```bash
# Generate a tour for your dashboard
/create-tour dashboard-walkthrough --library=react-joyride
```

**What happens:**
1. Tour-builder agent analyzes your dashboard components
2. Identifies key features (navigation, actions, stats, etc.)
3. Creates 6-step tour with engaging copy
4. Generates React component with completion tracking
5. Provides integration instructions

**Result:**
- `src/tours/dashboardWalkthroughTour.js` with step configuration
- `src/components/DashboardWalkthroughTour.jsx` with React implementation
- Automatic tour launch on first dashboard visit
- LocalStorage persistence to avoid showing repeatedly

---

### Example 2: Design New User Onboarding

```bash
# Create comprehensive onboarding flow
/design-onboarding new-user-setup --type=linear
```

**What happens:**
1. Onboarding-flow-designer maps your activation journey
2. Creates 5-step flow: Welcome → Profile → Preferences → Tour → Dashboard
3. Implements progress bar and step indicators
4. Adds validation for each step
5. Tooltip-generator adds contextual help

**Result:**
- `src/components/OnboardingFlow.jsx` with routing logic
- Individual step components in `src/components/onboarding/`
- Progress tracking with localStorage
- Celebration screen on completion

---

### Example 3: Role-Based Onboarding

```bash
# Create branched flow for different user types
/design-onboarding role-based-setup --type=branched
```

**What happens:**
1. Agent analyzes your user roles (Developer, Manager, etc.)
2. Creates conditional paths based on role selection
3. Developer path: API Keys → Integration → Documentation
4. Manager path: Team Setup → Invite Members → Dashboard
5. Generates routing logic for path switching

**Result:**
- Role selection screen
- Separate step sequences per role
- Shared progress tracking
- Role-specific completion actions

---

### Example 4: Add Contextual Tooltips

After generating a tour, the tooltip-generator automatically creates additional contextual help:

```javascript
// Generated tooltip configuration
export const tooltips = {
  'search-button': {
    content: 'Search across all projects (⌘K)',
    placement: 'bottom'
  },
  'export-button': {
    content: 'Export data to CSV or PDF for sharing',
    placement: 'left'
  },
  'help-icon': {
    content: 'Access help documentation and support',
    placement: 'bottom'
  }
};
```

---

## Best Practices

### Tour Design

1. **Keep Tours Short**
   - 5-7 steps maximum for product tours
   - Focus on critical features only
   - Offer advanced tours separately

2. **Use Progressive Disclosure**
   - Start with basic navigation
   - Introduce complexity gradually
   - Provide "Learn More" options

3. **Optimize Timing**
   - First login: Basic navigation tour
   - After first action: Feature discovery
   - On feature access: Detailed explanation

4. **Write Benefit-Focused Copy**
   - Explain "why" not just "what"
   - Connect features to user goals
   - Use action-oriented language

### Onboarding Flow Design

1. **Minimize Initial Friction**
   - Collect only essential information upfront
   - Use progressive profiling for additional details
   - Allow users to skip optional steps

2. **Show Clear Progress**
   - Use progress bars and step indicators
   - Display percentage completion
   - Celebrate milestones

3. **Provide Escape Hatches**
   - Allow users to skip onboarding
   - Offer "Complete Later" options
   - Don't block access to core features

4. **Track Activation Metrics**
   - Monitor completion rates
   - Identify drop-off points
   - A/B test different flows

### Tooltip Guidelines

1. **Be Concise**
   - Keep tooltips under 10 words when possible
   - Use fragments, not full sentences
   - Avoid redundant information

2. **Provide Value**
   - Explain benefits, not obvious facts
   - Include keyboard shortcuts
   - Mention time-saving features

3. **Use Consistent Placement**
   - Follow consistent placement rules
   - Avoid covering critical UI elements
   - Ensure tooltips are readable

4. **Don't Overuse**
   - Tooltip truly complex features only
   - Avoid stating the obvious
   - Respect user expertise

---

## Use Cases

### SaaS Applications

- **First-time user activation**: Guide new users to their "aha moment"
- **Feature adoption**: Introduce new features to existing users
- **Role-based onboarding**: Different flows for admins vs. users
- **Progressive profiling**: Collect user data gradually over time

### E-commerce Platforms

- **Seller onboarding**: Guide through product listing and store setup
- **Buyer orientation**: Tour of shopping features and checkout
- **Admin tools**: Walkthrough of analytics and management features

### Developer Tools

- **API setup tours**: Guide through API key generation and first request
- **Integration guides**: Step-by-step integration walkthroughs
- **Feature discovery**: Introduce advanced features as users progress

### Internal Tools

- **Employee onboarding**: Orient new team members to internal systems
- **Process training**: Guide through complex workflows
- **Tool adoption**: Drive usage of new internal applications

---

## Tips for Success

1. **Test with Real Users**: Watch actual users go through your onboarding
2. **Iterate Based on Data**: Track metrics and optimize drop-off points
3. **Keep Content Fresh**: Update tours when features change
4. **Mobile Responsiveness**: Ensure tours work on all device sizes
5. **Accessibility**: Support keyboard navigation and screen readers
6. **Localization**: Translate tour content for international users
7. **Contextual Triggers**: Show tours at the right moment, not on every page load

---

## Troubleshooting

**Tour not showing:**
- Check localStorage for completion flags
- Verify element selectors exist in DOM
- Ensure library is properly imported

**Steps not highlighting correctly:**
- Confirm element selectors are accurate
- Check z-index conflicts with modals
- Wait for dynamic content to load

**Progress not persisting:**
- Verify localStorage is enabled
- Check for localStorage key conflicts
- Test in incognito mode for clean state

---

## Contributing

This plugin is part of the Kobozo Plugins collection. To contribute:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request with clear description

---

## License

Copyright (c) 2025 Yannick De Backer

---

## Support

For issues, questions, or feature requests:

- Email: yannick@kobozo.eu
- Open an issue in the repository

---

**Happy Onboarding!** Create experiences that delight users and drive activation.
