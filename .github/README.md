# GitHub Actions Setup

This repository uses GitHub Actions for automated CI/CD pipeline. Here's what you need to set up:

## Required Secrets

### NPM_TOKEN
1. Go to [npmjs.com](https://www.npmjs.com/)
2. Login to your account
3. Go to **Access Tokens** → **Generate New Token**
4. Select **Automation** token type
5. Copy the token
6. In your GitHub repo: **Settings** → **Secrets and variables** → **Actions**
7. Click **New repository secret**
8. Name: `NPM_TOKEN`
9. Value: Your npm token

## Workflows

### 1. CI/CD Pipeline (`ci.yml`)
- Runs on every push and pull request
- Tests on multiple Node.js versions (18, 20, 22)
- Runs linting, tests, and build
- Verifies package integrity

### 2. Publish to NPM (`publish.yml`)
- Triggers when version in package.json changes
- Automatically publishes to npm
- Creates GitHub release with changelog
- Creates git tag

### 3. Auto Version Bump (`version-bump.yml`)
- Automatically bumps version based on commit messages
- **Major**: `[major]` or `BREAKING CHANGE` in commit message
- **Minor**: `[minor]`, `feat`, or `feature` in commit message  
- **Patch**: All other commits

## Usage

### Manual Version Bump
```bash
# Update version in package.json
npm version patch   # 1.0.4 → 1.0.5
npm version minor   # 1.0.4 → 1.1.0  
npm version major   # 1.0.4 → 2.0.0

# Push to trigger publish
git push origin main
```

### Auto Version Bump via Commit Messages
```bash
# Patch version bump (default)
git commit -m "fix: resolve date picker styling issue"

# Minor version bump  
git commit -m "feat: add new calendar theme [minor]"

# Major version bump
git commit -m "BREAKING CHANGE: update Vue 3 compatibility"

# Skip version bump
git commit -m "docs: update README [skip version]"

# Skip all CI
git commit -m "chore: update config [skip ci]"
```

## Workflow Status
- ✅ **CI/CD Pipeline**: Tests and builds on every commit
- ✅ **Auto Publish**: Publishes to npm when version changes
- ✅ **Auto Versioning**: Bumps version based on commit messages
- ✅ **GitHub Releases**: Creates releases automatically

## Branch Protection
Recommended to set up branch protection rules:
1. Go to **Settings** → **Branches**
2. Add rule for `main` branch
3. Require status checks to pass before merging
4. Require CI/CD pipeline to pass