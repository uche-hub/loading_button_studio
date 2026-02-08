# CI/CD Pipeline Documentation

## Overview
This repository uses a strict CI/CD pipeline to ensure code quality and security. All pull requests must pass multiple validation stages before merging.

## Branch Strategy

### Protected Branches
- **`main`**: Stable production-ready code
- **`publish`**: Publishing branch - only accepts merges from `main` or `uche-dev`
- **`uche-dev`**: Maintainer development branch
- **`develop`**: Integration branch for features

### Branch Protection Rules (Configure on GitHub)

#### For `main` branch:
1. ✅ Require pull request before merging
2. ✅ Require approvals: 1
3. ✅ Dismiss stale pull request approvals when new commits are pushed
4. ✅ Require status checks to pass before merging:
   - Code Quality & Linting
   - Unit & Widget Tests
   - Build Validation
   - Documentation Validation
   - Security & Dependency Audit
5. ✅ Require conversation resolution before merging
6. ✅ Require signed commits (recommended)
7. ✅ Include administrators (for strict mode)
8. ✅ Restrict who can push to matching branches (only maintainers)

#### For `publish` branch:
1. ✅ All the above rules from `main`
2. ✅ Require linear history
3. ✅ Only allow merge from `main` or `uche-dev` branches
4. ✅ Require deployment to succeed before merge
5. ✅ Lock branch (no direct pushes allowed)

## CI Workflows

### 1. PR Validation (`ci-pr-validation.yml`)
**Triggers**: On pull requests to `main`, `develop`, `uche-dev`

**Jobs**:

#### Job 1: Code Quality & Linting
- ✅ Checkout code
- ✅ Setup Flutter environment
- ✅ Verify `pubspec.yaml` validity
- ✅ Check code formatting (`dart format`)
- ✅ Run strict analysis (fail on errors, warnings, AND infos)
- ✅ Detect deprecated API usage
- ✅ Check for print statements
- ✅ Check for TODO/FIXME/HACK comments
- ✅ Check for debugPrint in production code

#### Job 2: Testing
- ✅ Run all unit and widget tests
- ✅ Generate test coverage report
- ✅ Enforce minimum 70% test coverage
- ✅ Fail if any test fails

#### Job 3: Build Validation
- ✅ Build example app for Android
- ✅ Build example app for iOS
- ✅ Build example app for Web
- ✅ Verify all builds complete successfully

#### Job 4: Documentation Validation
- ✅ Check for required files (README, CHANGELOG, LICENSE)
- ✅ Validate README content and format
- ✅ Validate CHANGELOG format
- ✅ Check API documentation coverage
- ✅ Verify no empty links

#### Job 5: Security & Dependency Audit
- ✅ Check for outdated dependencies
- ✅ Verify `pubspec.lock` exists
- ✅ Scan for hardcoded secrets
- ✅ Check dependency security

#### Job 6: PR Validation Summary
- ✅ Aggregate all job results
- ✅ Fail if any job failed
- ✅ Report success status

**All checks must pass** before the PR can be reviewed or merged.

### 2. Branch Protection (`branch-protection.yml`)
**Triggers**: On push or PR to `publish` branch

**Purpose**: Enforce strict rules for the publishing branch

**Checks**:
- ❌ Block direct pushes to `publish` branch
- ✅ Validate PR source branch (only `main` or `uche-dev`)
- ✅ Check PR author permissions
- ✅ Verify maintainer approval

### 3. Publishing (`cd-publish.yml`)
**Triggers**: On push to `publish` branch or version tags

**Jobs**:

#### Job 1: Validate Branch & Permissions
- ✅ Verify merge comes from `main` or `uche-dev`
- ✅ Verify commit author
- ✅ Check permissions

#### Job 2: Final Pre-Publish Validation
- ✅ Run format check
- ✅ Run strict analysis
- ✅ Run all tests
- ✅ Validate package for publishing
- ✅ Verify version bump
- ✅ Verify CHANGELOG updated

#### Job 3: Publish to pub.dev
- ✅ Setup pub.dev credentials
- ✅ Publish package
- ✅ Create GitHub release
- ✅ Tag version

#### Job 4: Post-Publish Verification
- ✅ Wait for pub.dev processing
- ✅ Verify package is live on pub.dev

## Required Secrets

Configure these in GitHub Settings → Secrets and variables → Actions:

1. **`PUB_DEV_CREDENTIALS`**
   - Your pub.dev credentials JSON
   - Get from: `~/.pub-cache/credentials.json` after running `flutter pub login`

2. **`GITHUB_TOKEN`**
   - Automatically provided by GitHub Actions
   - Used for creating releases

## Setup Instructions

### 1. Enable Branch Protection
Go to: Repository Settings → Branches → Add rule

For `main`:
```
Branch name pattern: main
☑ Require a pull request before merging
  ☑ Require approvals: 1
  ☑ Dismiss stale pull request approvals when new commits are pushed
☑ Require status checks to pass before merging
  ☑ Require branches to be up to date before merging
  Status checks:
    - Code Quality & Linting
    - Unit & Widget Tests
    - Build Validation
    - Documentation Validation
    - Security & Dependency Audit
☑ Require conversation resolution before merging
☑ Include administrators
☑ Restrict who can push to matching branches
  Add: uche-dev (your GitHub username)
```

For `publish`:
```
Branch name pattern: publish
☑ All rules from 'main' above, plus:
☑ Require linear history
☑ Do not allow bypassing the above settings
☑ Lock branch (prevent all changes)
```

### 2. Add Secrets
1. Go to Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add `PUB_DEV_CREDENTIALS`:
   ```bash
   # On your local machine
   flutter pub login
   cat ~/.pub-cache/credentials.json
   # Copy the output and paste as secret value
   ```

### 3. Configure CODEOWNERS
The `.github/CODEOWNERS` file is already configured. Make sure to:
1. Replace `@uche-dev` with your actual GitHub username
2. Enable "Require review from Code Owners" in branch protection

## Workflow for Contributors

### For External Contributors:
1. Fork the repository
2. Create feature branch from `main`
3. Make changes
4. Run locally:
   ```bash
   dart format .
   flutter analyze
   flutter test
   ```
5. Create PR to `main` branch
6. Wait for all CI checks to pass
7. Address review feedback
8. Maintainer will merge

### For Maintainers (`uche-dev`):
1. Create branch from `main` or use `uche-dev` branch
2. Make changes
3. Create PR to `main`
4. Ensure all CI checks pass
5. Get approval (if required)
6. Merge to `main`
7. When ready to publish:
   ```bash
   # Update version in pubspec.yaml
   # Update CHANGELOG.md
   git checkout main
   git pull
   git checkout publish
   git merge main
   git push
   ```

## Publishing Workflow

### Step 1: Prepare Release
```bash
# Update version in pubspec.yaml
version: 1.0.1

# Update CHANGELOG.md
## 1.0.1
* Fixed bug in liquid splash animation
* Improved performance
```

### Step 2: Merge to Main
```bash
git add pubspec.yaml CHANGELOG.md
git commit -m "chore: bump version to 1.0.1"
git push origin main
```

### Step 3: Trigger Publishing
```bash
git checkout publish
git merge main
git push origin publish
```

### Step 4: Verify
- GitHub Actions will run all validations
- If all checks pass, package will be published to pub.dev
- GitHub release will be created automatically
- Verify at https://pub.dev/packages/button_loading_fx

## Troubleshooting

### CI Fails on Formatting
```bash
dart format .
git add .
git commit -m "style: format code"
git push
```

### CI Fails on Analysis
```bash
flutter analyze
# Fix all errors, warnings, and infos
git add .
git commit -m "fix: resolve analysis issues"
git push
```

### Tests Fail
```bash
flutter test
# Fix failing tests
git add .
git commit -m "test: fix failing tests"
git push
```

### Coverage Below 70%
Add more tests:
```bash
flutter test --coverage
# Check coverage/lcov.info
# Add tests for uncovered code
```

### Publishing Fails
1. Check pub.dev credentials are valid
2. Verify version was bumped
3. Verify CHANGELOG was updated
4. Check package validation: `flutter pub publish --dry-run`

## Quality Gates Summary

| Stage | Check | Failure Impact |
|-------|-------|---------------|
| PR | Code Formatting | ❌ Blocks merge |
| PR | Analysis (errors/warnings/infos) | ❌ Blocks merge |
| PR | Deprecated APIs | ❌ Blocks merge |
| PR | Print statements | ❌ Blocks merge |
| PR | TODO comments | ❌ Blocks merge |
| PR | All tests pass | ❌ Blocks merge |
| PR | 70% coverage | ❌ Blocks merge |
| PR | Build success (all platforms) | ❌ Blocks merge |
| PR | Documentation | ❌ Blocks merge |
| PR | No secrets | ❌ Blocks merge |
| Publish | Branch = main/uche-dev | ❌ Blocks publish |
| Publish | All validations | ❌ Blocks publish |
| Publish | Version bump | ❌ Blocks publish |
| Publish | CHANGELOG update | ❌ Blocks publish |

## Best Practices

1. **Always run checks locally first**
   ```bash
   dart format .
   flutter analyze
   flutter test --coverage
   ```

2. **Keep commits small and focused**
3. **Write descriptive commit messages**
4. **Update documentation with code changes**
5. **Add tests for new features**
6. **Never skip CI checks**
7. **Respond to review feedback promptly**

## Support

For questions about the CI/CD pipeline:
- Create an issue with label `ci/cd`
- Contact maintainer: @uche-dev