---
description: Create interactive product tour with step-by-step guidance through key features
---

# Create Tour

Generate an interactive product tour for your application.

## Usage

```
/create-tour <tour-name> [--library=react-joyride|intro.js|shepherd|driver]
```

**Examples:**
```
/create-tour dashboard-intro
/create-tour getting-started --library=shepherd
```

## Execution Flow

### Phase 1: UI Analysis
1. Launch **tour-builder** agent
2. Scan application components
3. Identify key features and UI elements
4. Determine optimal step sequence

### Phase 2: Tour Design
1. Create 5-7 step tour focusing on core features
2. Write engaging tooltip content
3. Design step sequence and placement
4. Add progress indicators

### Phase 3: Implementation
1. Generate tour configuration file
2. Create React component with tour logic
3. Add trigger logic (first login, feature discovery)
4. Implement completion tracking

### Phase 4: Tooltips
1. Launch **tooltip-generator** agent
2. Generate contextual tooltips for each step
3. Add keyboard shortcuts hints
4. Include benefit-focused copy

## When to Use

- After launching new features
- For first-time user activation
- When introducing complex workflows
- To increase feature discovery

This command creates ready-to-use tour implementations.
