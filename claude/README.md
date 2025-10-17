# Official Claude Code Plugins

This directory contains the official plugins from the [Claude Code repository](https://github.com/anthropics/claude-code), synchronized for reference and customization.

## Directory Structure

```
claude/
└── plugins/              # Official Claude Code plugins
    ├── agent-sdk-dev/    # Agent SDK development tools
    ├── commit-commands/  # Git commit helpers
    ├── feature-dev/      # Feature development workflow
    ├── pr-review-toolkit/# Pull request review tools
    └── security-guidance/# Security best practices
```

## Syncing Updates

To pull the latest updates from the official Claude Code repository:

```bash
./sync-claude-plugins.sh
```

This script will:
1. Remove the existing `claude/plugins` directory
2. Fetch the latest plugins from upstream using git sparse-checkout
3. Place them in `claude/plugins/`

After syncing:
```bash
# Review changes
git status
git diff claude/

# Commit if satisfied
git add claude/
git commit -m "Update official Claude plugins"
git push
```

## Making Local Modifications

You can make changes to these plugins for experimentation or customization:

1. **Edit files** in `claude/plugins/` as needed
2. **Commit your changes** to track modifications
3. **When syncing updates**, your local changes will be replaced
   - Review the diff carefully before committing
   - Re-apply your customizations if needed
   - Or keep your custom versions in the `plugins/` directory instead

## Workflow

### Reference Official Plugins
Use the `claude/plugins/` directory to:
- Study how official plugins are structured
- Learn patterns and best practices
- Get inspiration for new features
- Test official plugins

### Create Custom Plugins
Create your own plugins in the `plugins/` directory:
- Based on patterns from official plugins
- Customized for your specific needs
- Fully under your control

### Sync Strategy

**Option 1: Read-only reference**
- Sync regularly to stay updated
- Don't modify files in `claude/plugins/`
- Use as reference only

**Option 2: Modify and track**
- Make changes in `claude/plugins/`
- Commit your modifications
- When syncing, review diffs carefully
- Re-apply or merge your changes after sync

**Option 3 (Recommended): Copy and customize**
- Copy official plugins to `plugins/` directory
- Customize the copied versions
- Keep `claude/plugins/` as pristine reference
- Sync updates without conflicts

## Last Synced

Check git log to see when plugins were last updated:
```bash
git log --oneline claude/plugins/ | head -5
```

## Upstream Repository

- Repository: https://github.com/anthropics/claude-code
- Plugins path: `/plugins`
- License: Check upstream repository for license information
