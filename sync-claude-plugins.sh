#!/bin/bash
# Sync official Claude Code plugins from upstream repository
# This script pulls the latest plugins from the official Claude Code repo
# into the claude/plugins directory while preserving local changes

set -e

echo "🔄 Syncing Claude Code official plugins..."

# Remove existing plugins directory
if [ -d "claude/plugins" ]; then
    echo "📦 Removing old plugins..."
    rm -rf claude/plugins
fi

# Create temp directory
mkdir -p claude/temp

# Clone with sparse checkout to get only plugins directory
echo "📥 Fetching latest plugins from upstream..."
cd claude
git clone --depth 1 --filter=blob:none --sparse https://github.com/anthropics/claude-code.git temp
cd temp
git sparse-checkout set plugins

# Move plugins to parent directory
echo "📂 Moving plugins to claude/plugins..."
mv plugins ../
cd ..

# Clean up temp directory
echo "🧹 Cleaning up..."
rm -rf temp

cd ..

echo "✅ Sync complete! Official Claude Code plugins updated in claude/plugins/"
echo ""
echo "Next steps:"
echo "1. Review changes: git status"
echo "2. Test the updated plugins"
echo "3. Commit if satisfied: git add claude/ && git commit -m 'Update official Claude plugins'"
