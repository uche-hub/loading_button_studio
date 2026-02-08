# Button Loading FX 🎨

A Flutter package that provides beautiful, customizable loading animations for buttons. Say goodbye to boring circular progress indicators and elevate your UI with smooth, professional loading effects.

[![pub package](https://img.shields.io/pub/v/button_loading_fx.svg)](https://pub.dev/packages/button_loading_fx)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

- 🎭 **Multiple Animation Effects**: Choose from pulsing, liquid splash, and more
- 🎨 **Fully Customizable**: Colors, sizes, and animation speeds
- 🚀 **Easy to Use**: Drop-in replacement for CircularProgressIndicator
- 📦 **Lightweight**: Minimal dependencies, maximum performance
- 🎯 **Type-Safe**: Uses enums for animation selection

## 🎬 Animations

### Pulsing
A smooth pulsing animation with expanding and contracting circles.

### Liquid Splash
A water splash effect with animated droplets rising and falling.

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  button_loading_fx: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

Import the package:

```dart
import 'package:button_loading_fx/button_loading_fx.dart';
```

Use it in your button:

```dart
ElevatedButton(
  onPressed: _isLoading ? null : _handlePress,
  child: _isLoading
      ? const LoadingButtonStudio(
          animation: ButtonAnimationEffect.pulsing,
          effectColor: Colors.white,
        )
      : const Text('Submit'),
)
```

## 📖 Usage Examples

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:button_loading_fx/button_loading_fx.dart';

class MyButton extends StatefulWidget {
  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    setState(() => _isLoading = true);
    
    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handlePress,
      child: _isLoading
          ? const LoadingButtonStudio(
              animation: ButtonAnimationEffect.pulsing,
              effectColor: Colors.white,
            )
          : const Text('Submit'),
    );
  }
}
```

### Liquid Splash Animation

```dart
ElevatedButton(
  onPressed: _isLoading ? null : _handlePress,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  ),
  child: _isLoading
      ? const LoadingButtonStudio(
          animation: ButtonAnimationEffect.liquidSplash,
          effectColor: Colors.white,
          size: 24,
        )
      : const Text('Login'),
)
```

### Custom Colors

```dart
OutlinedButton(
  onPressed: _isLoading ? null : _handlePress,
  child: _isLoading
      ? const LoadingButtonStudio(
          animation: ButtonAnimationEffect.pulsing,
          effectColor: Colors.orange,
          size: 20,
        )
      : const Text('Save'),
)
```

### Different Button Types

#### Text Button
```dart
TextButton(
  onPressed: _isLoading ? null : _handlePress,
  child: _isLoading
      ? const LoadingButtonStudio(
          animation: ButtonAnimationEffect.liquidSplash,
          effectColor: Colors.blue,
        )
      : const Text('Cancel'),
)
```

#### Floating Action Button
```dart
FloatingActionButton(
  onPressed: _isLoading ? null : _handlePress,
  child: _isLoading
      ? const LoadingButtonStudio(
          animation: ButtonAnimationEffect.pulsing,
          effectColor: Colors.white,
          size: 28,
        )
      : const Icon(Icons.add),
)
```

### Custom Size and Duration

```dart
ElevatedButton(
  onPressed: _isLoading ? null : _handlePress,
  child: _isLoading
      ? const LoadingButtonStudio(
          animation: ButtonAnimationEffect.pulsing,
          effectColor: Colors.white,
          size: 30, // Larger loader
          duration: Duration(milliseconds: 800), // Faster animation
        )
      : const Text('Upload'),
)
```

## 🎨 API Reference

### LoadingButtonStudio

The main widget for displaying loading animations.

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `animation` | `ButtonAnimationEffect` | `pulsing` | The animation effect to display |
| `effectColor` | `Color` | `Colors.white` | Color of the animation |
| `strokeWidth` | `double` | `2.0` | Stroke width for animations that use strokes |
| `size` | `double` | `20.0` | Size of the loading indicator |
| `duration` | `Duration?` | `null` | Custom animation duration (uses defaults if null) |

### ButtonAnimationEffect

Enum of available animation effects.

```dart
enum ButtonAnimationEffect {
  pulsing,      // Smooth pulsing circles
  liquidSplash, // Water splash effect
}
```

## 🎯 Best Practices

1. **Match Button Style**: Choose animation colors that match your button's color scheme
2. **Consistent Sizing**: Keep loader size proportional to button size
3. **Disable on Loading**: Always disable the button when loading (`onPressed: _isLoading ? null : ...`)
4. **User Feedback**: Combine with haptic feedback or snackbars for better UX

## 🤝 Contributing

Contributions are welcome! If you'd like to add new animations or improve existing ones:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/NewAnimation`)
3. Commit your changes (`git commit -am 'Add new animation'`)
4. Push to the branch (`git push origin feature/NewAnimation`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the need for better loading indicators in Flutter
- Thanks to the Flutter community for feedback and support

## 📧 Contact

Have questions or suggestions? Feel free to open an issue on [GitHub](https://github.com/yourusername/button_loading_fx/issues).

---

Made with ❤️ for the Flutter community