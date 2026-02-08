# Contributing to Button Loading FX

Thank you for your interest in contributing to Button Loading FX! This document provides guidelines and instructions for contributing.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Quality Standards](#quality-standards)
- [Pull Request Process](#pull-request-process)
- [Coding Guidelines](#coding-guidelines)
- [Testing Guidelines](#testing-guidelines)

## Code of Conduct

By participating in this project, you agree to:
- Be respectful and inclusive
- Welcome newcomers and help them learn
- Accept constructive criticism gracefully
- Focus on what's best for the community
- Show empathy towards other community members

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Git
- A GitHub account

### Fork and Clone
```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/YOUR_USERNAME/button_loading_fx.git
cd button_loading_fx

# Add upstream remote
git remote add upstream https://github.com/uche-dev/button_loading_fx.git
```

### Install Dependencies
```bash
flutter pub get
cd example
flutter pub get
```

### Verify Setup
```bash
# Run tests
flutter test

# Run analysis
flutter analyze

# Format code
dart format .

# Run example app
cd example
flutter run
```

## Development Workflow

### 1. Create a Branch
```bash
# Update your fork
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/your-feature-name
```

### 2. Make Changes
- Write clean, readable code
- Follow the coding guidelines below
- Add tests for new functionality
- Update documentation as needed

### 3. Test Your Changes
```bash
# Format code
dart format .

# Run analysis (must pass with zero issues)
flutter analyze

# Run tests
flutter test --coverage

# Test example app
cd example
flutter run
```

### 4. Commit Your Changes
```bash
git add .
git commit -m "type: brief description"
```

**Commit Message Format:**
```
type: subject

body (optional)

footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Example:**
```
feat: add bouncing dots animation

Implements a new bouncing dots loading animation with customizable
dot size, spacing, and bounce height.

Closes #42
```

### 5. Push and Create PR
```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub from your branch to `main`.

## Quality Standards

All contributions must meet these strict quality standards:

### ✅ Code Quality
- **Zero** errors from `flutter analyze`
- **Zero** warnings from `flutter analyze`
- **Zero** infos from `flutter analyze`
- **Zero** linting issues
- Properly formatted with `dart format`

### ✅ Testing
- All tests must pass
- Minimum 70% code coverage
- New features require new tests
- Bug fixes require regression tests

### ✅ Documentation
- All public APIs must have dartdoc comments (`///`)
- README updated if adding features
- CHANGELOG updated with your changes
- Example app updated if applicable

### ✅ Code Standards
- No `print()` statements
- No `debugPrint()` in production code
- No `TODO`, `FIXME`, or `HACK` comments
- No deprecated API usage
- Proper error handling
- No hardcoded values where const should be used

## Pull Request Process

### Before Submitting
1. ✅ Run all checks locally:
   ```bash
   dart format .
   flutter analyze
   flutter test --coverage
   ```

2. ✅ Update CHANGELOG.md
3. ✅ Update documentation
4. ✅ Test on multiple platforms (if possible)

### Submitting PR
1. Create PR from your branch to `main`
2. Fill out the PR template completely
3. Link related issues
4. Add screenshots/videos if UI changes
5. Wait for CI checks to complete

### PR Review Process
1. **Automated Checks**: CI will run all validations
2. **Code Review**: Maintainer will review code
3. **Feedback**: Address any requested changes
4. **Approval**: Get approval from code owner
5. **Merge**: Maintainer will merge when ready

### CI Requirements
Your PR must pass ALL of these checks:
- ✅ Code formatting
- ✅ Strict analysis (no errors/warnings/infos)
- ✅ All tests passing
- ✅ 70%+ code coverage
- ✅ Successful builds (Android, iOS, Web)
- ✅ Documentation validation
- ✅ Security checks

## Coding Guidelines

### File Organization
```
lib/
├── button_loading_fx.dart       # Main export
└── src/
    ├── loading_button_studio.dart
    ├── enums/
    │   └── *.dart
    └── animations/
        └── *.dart
```

### Naming Conventions
- **Classes**: `PascalCase` (e.g., `PulsingLoader`)
- **Files**: `snake_case.dart` (e.g., `pulsing_loader.dart`)
- **Variables**: `camelCase` (e.g., `effectColor`)
- **Constants**: `lowerCamelCase` (e.g., `defaultSize`)
- **Private**: `_leadingUnderscore` (e.g., `_controller`)

### Code Style
```dart
// ✅ Good
class PulsingLoader extends StatefulWidget {
  /// Color of the pulsing effect
  final Color effectColor;
  
  const PulsingLoader({
    super.key,
    this.effectColor = Colors.white,
  });
  
  @override
  State<PulsingLoader> createState() => _PulsingLoaderState();
}

// ❌ Bad - missing documentation, not const
class PulsingLoader extends StatefulWidget {
  final Color effectColor;
  
  PulsingLoader({
    Key? key,
    this.effectColor = Colors.white,
  }) : super(key: key);
}
```

### Documentation
```dart
/// A pulsing loading animation that scales in and out smoothly.
///
/// This widget creates a pulsing effect with an expanding outer circle
/// and a solid inner circle. The animation repeats infinitely.
///
/// Example:
/// ```dart
/// PulsingLoader(
///   effectColor: Colors.blue,
///   size: 24.0,
/// )
/// ```
class PulsingLoader extends StatefulWidget {
  /// Color of the pulsing circles.
  ///
  /// Defaults to [Colors.white].
  final Color effectColor;
}
```

## Testing Guidelines

### Test Structure
```dart
void main() {
  group('PulsingLoader', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PulsingLoader(),
        ),
      );
      
      expect(find.byType(PulsingLoader), findsOneWidget);
    });
    
    testWidgets('accepts custom color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PulsingLoader(effectColor: Colors.red),
        ),
      );
      
      final widget = tester.widget<PulsingLoader>(
        find.byType(PulsingLoader),
      );
      
      expect(widget.effectColor, Colors.red);
    });
  });
}
```

### Test Coverage
- Test all public APIs
- Test edge cases
- Test error conditions
- Test widget lifecycle
- Test animations (if applicable)

## Adding New Animations

### Steps
1. Create new file in `lib/src/animations/`
   ```dart
   // bouncing_dots_loader.dart
   import 'package:flutter/material.dart';
   
   class BouncingDotsLoader extends StatefulWidget {
     // Implementation
   }
   ```

2. Add to enum in `button_animation_effect.dart`
   ```dart
   enum ButtonAnimationEffect {
     pulsing,
     liquidSplash,
     bouncingDots, // New
   }
   ```

3. Add case in `loading_button_studio.dart`
   ```dart
   switch (animation) {
     // ... existing cases
     case ButtonAnimationEffect.bouncingDots:
       return BouncingDotsLoader(
         effectColor: effectColor,
         size: size,
       );
   }
   ```

4. Add tests
5. Update README
6. Update CHANGELOG
7. Add to example app

## Common Issues

### "CI failing on analysis"
```bash
flutter analyze
# Fix all issues shown
```

### "Tests failing locally"
```bash
# Run specific test
flutter test test/specific_test.dart

# Run with verbose output
flutter test --verbose
```

### "Format check failing"
```bash
dart format .
git add .
git commit --amend --no-edit
```

## Questions?

- 📖 Read the [CI/CD Documentation](CI_CD_DOCUMENTATION.md)
- 🐛 Open an issue for bugs
- 💡 Open a discussion for feature ideas
- 📧 Contact maintainer: @uche-dev

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Button Loading FX! 🎉