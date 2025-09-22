# GitHub Actions Setup Guide

This repository includes automated workflows for publishing to npm and managing versions.

## 🔧 Setup Required

### 1. NPM Token Setup

1. **Login to npm**: https://www.npmjs.com/
2. **Go to Access Tokens**: https://www.npmjs.com/settings/tokens
3. **Create New Token**:
   - Type: `Automation`
   - Scope: `Publish`
   - Copy the token

4. **Add to GitHub Secrets**:
   - Go to your GitHub repo → Settings → Secrets and variables → Actions
   - Click "New repository secret"
   - Name: `NPM_TOKEN`
   - Value: [paste your npm token]

### 2. GitHub Token (Automatic)

The `GITHUB_TOKEN` is automatically provided by GitHub Actions.

## 🚀 Automated Workflows

### 1. **CI/CD Pipeline** (`.github/workflows/ci.yml`)
**Triggers**: Every push and PR
- ✅ Tests across Node.js 16, 18, 20
- ✅ Security audit
- ✅ Build verification
- ✅ Package size check

### 2. **Auto Publish** (`.github/workflows/publish.yml`)
**Triggers**: Push to `main` with version changes
- ✅ Builds package
- ✅ Checks if version already exists
- ✅ Publishes to npm (if new version)
- ✅ Creates GitHub release

### 3. **Auto Version Bump** (`.github/workflows/version-bump.yml`)
**Triggers**: Push to `main` with code changes
- ✅ Detects change type from commit message
- ✅ Bumps version automatically
- ✅ Creates git tag
- ✅ Commits version bump

## 📝 Commit Message Convention

Use conventional commits for automatic version bumping:

```bash
# Patch version (1.0.1 → 1.0.2)
git commit -m "fix: resolve date parsing issue"
git commit -m "docs: update README"

# Minor version (1.0.1 → 1.1.0)  
git commit -m "feat: add time picker support"
git commit -m "feature: new calendar themes"

# Major version (1.0.1 → 2.0.0)
git commit -m "feat!: redesign API structure"
git commit -m "feat: remove deprecated methods

BREAKING CHANGE: removed old setDate method"
```

## 🎯 Manual Commands

If you prefer manual control:

```bash
# Version bump
npm run version:patch  # 1.0.1 → 1.0.2
npm run version:minor  # 1.0.1 → 1.1.0  
npm run version:major  # 1.0.1 → 2.0.0

# Build and publish
npm run release

# Test package before publish
npm run pack:test
```

## 🔄 Workflow Process

1. **Code Changes** → Push to `main`
2. **CI Pipeline** → Tests & builds
3. **Auto Version** → Bumps version based on commits
4. **Auto Publish** → Publishes to npm if version is new
5. **GitHub Release** → Creates release with changelog

## 🛑 Skip Automation

To skip version bumping, include `[skip-version]` in commit message:

```bash
git commit -m "docs: update README [skip-version]"
```

## 📊 Monitoring

- **npm**: https://www.npmjs.com/package/@kebalicious/vue3-daterange-picker
- **GitHub Actions**: Check the "Actions" tab in your repository
- **Releases**: Check the "Releases" section for auto-generated releases

## 🔒 Security

- ✅ NPM token is encrypted in GitHub Secrets
- ✅ Security audit runs on every push
- ✅ Vulnerability checks block high-risk publishes
- ✅ No sensitive data in public workflows