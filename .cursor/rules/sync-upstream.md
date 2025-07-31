---
description: Comprehensive guide for syncing upstream repositories and managing tags
globs: ["**/*.sh", "**/*.md", "**/*.yaml", "**/*.yml"]
alwaysApply: false
---

# Upstream Repository Sync & Tag Management Guide

## Overview
This cursor rule provides comprehensive guidance for syncing upstream repositories, managing tags, and maintaining forks of the NGINX Ingress Controller project.

## Repository Setup

### 1. Add Upstream Remote
```bash
# Add the official NGINX Ingress Controller repository as upstream
git remote add upstream https://github.com/nginx/kubernetes-ingress.git

# Verify remotes
git remote -v
```

### 2. Initial Sync
```bash
# Fetch all branches and tags from upstream
git fetch upstream --all --tags

# Show available tags
git tag --list | grep -E "v[0-9]+\.[0-9]+\.[0-9]+" | sort -V
```

## Tag Management Commands

### View Available Tags
```bash
# List all tags
git tag --list

# List only version tags (vX.Y.Z format)
git tag --list | grep -E "v[0-9]+\.[0-9]+\.[0-9]+"

# Show latest 10 tags
git tag --list | grep -E "v[0-9]+\.[0-9]+\.[0-9]+" | sort -V | tail -10

# Show current tag
git describe --tags --abbrev=0
```

### Checkout Specific Versions
```bash
# Checkout specific version
git checkout v5.0.0
git checkout v3.7.2

# Create branch from tag
git checkout -b feature/v5.0.0 v5.0.0
git checkout -b hotfix/v3.7.2 v3.7.2

# Switch back to main branch
git checkout main
```

### Compare Versions
```bash
# Compare two versions
git diff v3.7.2 v5.0.0

# Show commits between versions
git log v3.7.2..v5.0.0 --oneline

# Show file changes between versions
git diff v3.7.2 v5.0.0 --name-only
```

### Sync Tags to Fork
```bash
# Push all tags to your fork
git push origin --tags

# Push specific tag
git push origin v5.0.0

# Delete tag from fork (if needed)
git push origin --delete v5.0.0
```

## Automated Sync Script

### Using the Sync Script
```bash
# Make script executable
chmod +x sync-tags.sh

# Run sync script
./sync-tags.sh
```

### Script Contents
```bash
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
```

## Branch Management

### Create Feature Branches from Tags
```bash
# Create feature branch from stable version
git checkout -b feature/new-feature v5.0.0

# Create hotfix branch from specific version
git checkout -b hotfix/security-fix v3.7.2

# Create development branch from latest
git checkout -b develop v5.1.0
```

### Merge Tags into Current Branch
```bash
# Merge specific version into current branch
git merge v5.0.0

# Merge with commit message
git merge v3.7.2 -m "Merge v3.7.2 for stability improvements"
```

## Version Comparison Workflow

### 1. Compare Major Versions
```bash
# Compare v3.x vs v5.x
git diff v3.7.2 v5.0.0 --name-only

# Show major changes
git log v3.7.2..v5.0.0 --oneline --grep="BREAKING"
```

### 2. Compare Minor Versions
```bash
# Compare within same major version
git diff v5.0.0 v5.1.0

# Show new features
git log v5.0.0..v5.1.0 --oneline --grep="feat"
```

### 3. Compare Patch Versions
```bash
# Compare patch releases
git diff v3.7.1 v3.7.2

# Show bug fixes
git log v3.7.1..v3.7.2 --oneline --grep="fix"
```

## Repository Maintenance

### Regular Sync Schedule
```bash
# Weekly sync
./sync-tags.sh

# Monthly cleanup of old branches
git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
```

### Cleanup Commands
```bash
# Remove local tags that don't exist upstream
git tag -l | xargs git tag -d
git fetch upstream --tags

# Clean up merged branches
git branch --merged main | grep -v '^[ *]*main$' | xargs git branch -d

# Prune remote references
git remote prune origin
```

## Troubleshooting

### Common Issues

#### 1. Upstream Already Exists
```bash
# Remove existing upstream
git remote remove upstream

# Add upstream again
git remote add upstream https://github.com/nginx/kubernetes-ingress.git
```

#### 2. Tag Conflicts
```bash
# Force update local tag
git tag -d v5.0.0
git fetch upstream v5.0.0

# Or reset to upstream version
git reset --hard upstream/v5.0.0
```

#### 3. Branch Conflicts
```bash
# Abort merge if conflicts
git merge --abort

# Reset to clean state
git reset --hard HEAD
```

### Verification Commands
```bash
# Verify upstream remote
git remote -v

# Check tag status
git tag --list | wc -l

# Verify branch status
git branch -a

# Check sync status
git fetch upstream --dry-run
```

## Best Practices

### 1. Tag Management
- **Regular sync**: Run sync script weekly
- **Version tracking**: Keep track of which versions you're using
- **Cleanup**: Remove old tags periodically
- **Documentation**: Document which versions are stable

### 2. Branch Strategy
- **Feature branches**: Create from stable tags
- **Hotfix branches**: Use specific version tags
- **Release branches**: Tag important releases
- **Cleanup**: Remove merged branches regularly

### 3. Version Selection
- **Production**: Use stable, tested versions
- **Development**: Use latest versions for new features
- **Testing**: Use specific versions for compatibility testing
- **Rollback**: Keep previous stable versions available

### 4. Sync Strategy
- **Automated**: Use scripts for regular sync
- **Manual**: Review changes before syncing
- **Selective**: Sync only needed versions
- **Backup**: Keep local copies of important versions

## Integration with CI/CD

### GitHub Actions Example
```yaml
name: Sync Upstream Tags
on:
  schedule:
    - cron: '0 2 * * 1'  # Every Monday at 2 AM
  workflow_dispatch:

jobs:
  sync-tags:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      
      - name: Add upstream remote
        run: |
          git remote add upstream https://github.com/nginx/kubernetes-ingress.git
      
      - name: Fetch upstream tags
        run: git fetch upstream --tags
      
      - name: Push tags to fork
        run: git push origin --tags
```

### Local Automation
```bash
# Add to crontab for automatic sync
# 0 2 * * 1 cd /path/to/repo && ./sync-tags.sh >> sync.log 2>&1
```

## Reference Commands

### Quick Reference
```bash
# Setup
git remote add upstream https://github.com/nginx/kubernetes-ingress.git
git fetch upstream --tags

# Sync
./sync-tags.sh
git push origin --tags

# Checkout
git checkout v5.0.0
git checkout -b feature/v5.0.0 v5.0.0

# Compare
git diff v3.7.2 v5.0.0
git log v3.7.2..v5.0.0 --oneline

# Cleanup
git tag -l | xargs git tag -d
git fetch upstream --tags
```

This cursor rule provides comprehensive guidance for managing upstream repository synchronization and tag management for the NGINX Ingress Controller project.
