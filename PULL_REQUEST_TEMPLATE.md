---
name: Pull Request
about: Submit a pull request to contribute to button_loading_fx
title: '[TYPE] Brief description'
labels: ''
assignees: ''
---

## Description
<!-- Provide a clear and concise description of what this PR does -->

## Type of Change
<!-- Mark the relevant option with an "x" -->
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Code refactoring
- [ ] Performance improvement

## Related Issue
<!-- Link to the issue this PR addresses (if applicable) -->
Fixes #(issue number)

## Checklist
<!-- Mark completed items with an "x" -->

### Code Quality
- [ ] I have run `dart format .` and my code follows the project's style guidelines
- [ ] I have run `flutter analyze` with no errors, warnings, or infos
- [ ] I have checked for deprecated API usage and removed/replaced them
- [ ] I have removed all `print()`, `debugPrint()`, and `TODO` comments
- [ ] My code follows the DRY (Don't Repeat Yourself) principle
- [ ] I have added proper error handling where necessary

### Testing
- [ ] I have added tests that prove my fix is effective or my feature works
- [ ] All new and existing tests pass locally (`flutter test`)
- [ ] I have tested the changes on multiple platforms (iOS, Android, Web)
- [ ] My changes do not break the example app
- [ ] Test coverage is maintained or improved

### Documentation
- [ ] I have updated the README.md (if needed)
- [ ] I have updated the CHANGELOG.md with my changes
- [ ] I have added dartdoc comments (///) to all new public APIs
- [ ] I have updated example code (if new features were added)
- [ ] All public methods, classes, and enums are properly documented

### Dependencies
- [ ] I have not added new dependencies without discussion
- [ ] If I added dependencies, they are necessary and well-maintained
- [ ] I have run `flutter pub get` successfully
- [ ] The `pubspec.yaml` is properly formatted

### Security
- [ ] My code does not expose any sensitive information
- [ ] I have not included API keys, tokens, or credentials
- [ ] I have considered security implications of my changes

### Performance
- [ ] My changes do not negatively impact performance
- [ ] I have optimized animations for 60fps
- [ ] I have avoided memory leaks (properly disposed controllers)

## Screenshots/Videos (if applicable)
<!-- Add screenshots or videos demonstrating the changes -->

## Breaking Changes
<!-- If this PR introduces breaking changes, list them here with migration guide -->

## Additional Notes
<!-- Add any additional context or notes for reviewers -->

## Reviewer Guidelines
**For Maintainers Only:**
- [ ] Code follows project architecture and patterns
- [ ] Changes align with project goals and roadmap
- [ ] PR is from `main` or `uche-dev` branch (if targeting `publish`)
- [ ] All CI/CD checks have passed
- [ ] Documentation is complete and accurate
- [ ] No breaking changes without proper deprecation warnings