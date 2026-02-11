# Button Loading FX 🎨

A Flutter package that provides beautiful, customizable loading animations for buttons. Transform boring loading states into delightful user experiences with smooth animations and progress indicators!

[![pub package](https://img.shields.io/pub/v/button_loading_fx.svg)](https://pub.dev/packages/button_loading_fx)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

- 🎭 **Multiple Loading Animations**: Pulsing, liquid splash, circular progress
- 📊 **Progress Tracking**: Real-time progress display with percentage
- 🎨 **Fully Customizable**: Colors, sizes, stroke widths
- 🚀 **Easy to Use**: Drop-in replacement for CircularProgressIndicator
- 📦 **Lightweight**: Zero dependencies, maximum performance
- 🎯 **Type-Safe**: Enum-based animation selection

## 🎬 Available Animations

### 1. Pulsing Animation
Smooth expanding and contracting circles - perfect for elegant loading states.

```dart
LoadingButtonStudio(
  animation: ButtonAnimationEffect.pulsing,
  effectColor: Colors.white,
)
```

### 2. Liquid Splash Animation
Water droplet effect with animated splashes - great for playful, dynamic interfaces.

```dart
LoadingButtonStudio(
  animation: ButtonAnimationEffect.liquidSplash,
  effectColor: Colors.white,
)
```

### 3. Circular Progress (NEW! 🎉)
Progress indicator with dual colors showing real-time percentage - ideal for downloads, uploads, or any task with measurable progress.

```dart
LoadingButtonStudio(
  animation: ButtonAnimationEffect.circularProgress,
  progress: 0.6, // 0.0 to 1.0 (60%)
  effectColor: Colors.blue,
  inactiveColor: Colors.grey.shade300,
)
```

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  button_loading_fx: ^0.0.2
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

### Basic Loading Animation

```dart
class MyButton extends StatefulWidget {
  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    setState(() => _isLoading = true);
    
    // Your async operation
    await Future.delayed(Duration(seconds: 2));
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handlePress,
      child: _isLoading
          ? LoadingButtonStudio(
              animation: ButtonAnimationEffect.pulsing,
              effectColor: Colors.white,
            )
          : Text('Submit'),
    );
  }
}
```

### Progress-Based Loading (Downloads, Uploads)

```dart
class DownloadButton extends StatefulWidget {
  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _isDownloading = false;
  double _progress = 0.0;

  Future<void> _startDownload() async {
    setState(() => _isDownloading = true);
    
    // Simulate download with progress updates
    for (double i = 0; i <= 1.0; i += 0.02) {
      await Future.delayed(Duration(milliseconds: 50));
      setState(() => _progress = i);
    }
    
    setState(() => _isDownloading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isDownloading ? null : _startDownload,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: _isDownloading
          ? LoadingButtonStudio(
              animation: ButtonAnimationEffect.circularProgress,
              progress: _progress,
              effectColor: Colors.white,
              inactiveColor: Colors.green.shade200,
              size: 28,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download),
                SizedBox(width: 8),
                Text('Download'),
              ],
            ),
    );
  }
}
```

## 📖 Detailed Examples

### Pulsing Animation in Login Button

```dart
ElevatedButton(
  onPressed: _isLoading ? null : _login,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  ),
  child: _isLoading
      ? LoadingButtonStudio(
          animation: ButtonAnimationEffect.pulsing,
          effectColor: Colors.white,
          size: 24,
        )
      : Text('Login', style: TextStyle(fontSize: 16)),
)
```

### Liquid Splash in Submit Button

```dart
ElevatedButton(
  onPressed: _isLoading ? null : _submit,
  child: _isLoading
      ? LoadingButtonStudio(
          animation: ButtonAnimationEffect.liquidSplash,
          effectColor: Colors.white,
          size: 24,
        )
      : Text('Submit Form'),
)
```

### Circular Progress in Upload Button

```dart
ElevatedButton(
  onPressed: _isUploading ? null : _upload,
  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
  child: _isUploading
      ? LoadingButtonStudio(
          animation: ButtonAnimationEffect.circularProgress,
          progress: _uploadProgress,
          effectColor: Colors.orange,
          inactiveColor: Colors.orange.shade100,
          size: 30,
          strokeWidth: 4,
          showPercentage: true, // Shows "60%"
        )
      : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_upload),
            SizedBox(width: 8),
            Text('Upload Photo'),
          ],
        ),
)
```

### Floating Action Button

```dart
FloatingActionButton(
  onPressed: _isLoading ? null : _handleAction,
  child: _isLoading
      ? LoadingButtonStudio(
          animation: ButtonAnimationEffect.liquidSplash,
          effectColor: Colors.white,
          size: 32,
        )
      : Icon(Icons.add),
)
```

### Text Button

```dart
TextButton(
  onPressed: _isLoading ? null : _cancel,
  child: _isLoading
      ? LoadingButtonStudio(
          animation: ButtonAnimationEffect.pulsing,
          effectColor: Colors.blue,
          size: 20,
        )
      : Text('Cancel'),
)
```

## 🎨 Customization

### LoadingButtonStudio API

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `animation` | `ButtonAnimationEffect` | `pulsing` | Animation type (pulsing, liquidSplash, circularProgress) |
| `effectColor` | `Color` | `Colors.white` | Primary/active color of animation |
| `inactiveColor` | `Color?` | `null` | Background color (circularProgress only) |
| `strokeWidth` | `double` | `2.0` | Width of strokes/rings |
| `size` | `double` | `20.0` | Size of the loading indicator |
| `duration` | `Duration?` | `null` | Animation duration (auto if null) |
| `progress` | `double?` | `null` | Progress value 0.0-1.0 (circularProgress only) |
| `showPercentage` | `bool` | `true` | Show percentage text (circularProgress only) |

### ButtonAnimationEffect Enum

```dart
enum ButtonAnimationEffect {
  pulsing,          // Smooth scaling circles
  liquidSplash,     // Water droplet animation
  circularProgress, // Progress ring with percentage
}
```

### Color Customization

```dart
// Match your brand
LoadingButtonStudio(
  animation: ButtonAnimationEffect.pulsing,
  effectColor: Theme.of(context).primaryColor,
)

// Custom progress colors
LoadingButtonStudio(
  animation: ButtonAnimationEffect.circularProgress,
  progress: _progress,
  effectColor: Colors.green,           // Active progress
  inactiveColor: Colors.green.shade100, // Background ring
)
```

### Size Recommendations

```dart
// Small buttons (TextButton)
size: 16-18

// Medium buttons (ElevatedButton)
size: 20-24

// Large buttons
size: 28-32

// FAB
size: 32-36
```

## 💡 Real-World Use Cases

### File Download with Progress

```dart
Future<void> _download() async {
  setState(() => _isDownloading = true);
  
  // Your actual download logic with progress callbacks
  await Dio().download(
    fileUrl,
    savePath,
    onReceiveProgress: (received, total) {
      setState(() {
        _progress = received / total;
      });
    },
  );
  
  setState(() => _isDownloading = false);
}

// Button
ElevatedButton(
  onPressed: _isDownloading ? null : _download,
  child: _isDownloading
      ? LoadingButtonStudio(
          animation: ButtonAnimationEffect.circularProgress,
          progress: _progress,
          effectColor: Colors.white,
          size: 28,
        )
      : Text('Download'),
)
```

### Form Submission

```dart
Future<void> _submitForm() async {
  setState(() => _isSubmitting = true);
  
  try {
    await api.submitForm(formData);
    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  } finally {
    setState(() => _isSubmitting = false);
  }
}

// Button
ElevatedButton(
  onPressed: _isSubmitting ? null : _submitForm,
  child: _isSubmitting
      ? LoadingButtonStudio(
          animation: ButtonAnimationEffect.pulsing,
          effectColor: Colors.white,
        )
      : Text('Submit'),
)
```

## 🎯 Best Practices

### 1. Always Disable Button While Loading

```dart
onPressed: _isLoading ? null : _handlePress,
```

### 2. Match Colors to Your Theme

```dart
LoadingButtonStudio(
  effectColor: Theme.of(context).primaryColor,
)
```

### 3. Provide User Feedback

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Action completed!')),
);
```

### 4. Handle Errors Gracefully

```dart
try {
  setState(() => _isLoading = true);
  await performAction();
} catch (e) {
  // Show error
} finally {
  setState(() => _isLoading = false);
}
```

### 5. Choose the Right Animation

- **Pulsing**: Professional apps (banking, business, forms)
- **Liquid Splash**: Fun apps (games, social media, creative tools)
- **Circular Progress**: Downloads, uploads, installations, data processing

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md).

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

## 📄 License

MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Support

- 🐛 [Report bugs](https://github.com/yourusername/button_loading_fx/issues)
- 💡 [Request features](https://github.com/yourusername/button_loading_fx/issues)
- ⭐ [Star on GitHub](https://github.com/yourusername/button_loading_fx)

---

Made with ❤️ for the Flutter community