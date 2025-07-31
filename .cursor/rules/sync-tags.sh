#!/bin/bash

# Sync tags from upstream NGINX Ingress Controller repository
echo "🔄 Syncing tags from upstream repository..."

# Fetch latest tags from upstream
git fetch upstream --tags

# Show latest tags
echo "📋 Latest available tags:"
git tag --list | grep -E "v[0-9]+\.[0-9]+\.[0-9]+" | sort -V | tail -10

# Optional: Push tags to your fork
read -p "Do you want to push tags to your fork? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 Pushing tags to origin..."
    git push origin --tags
fi

echo "✅ Tag sync completed!" 
