import 'package:flutter/material.dart';
import 'package:button_loading_fx/button_loading_fx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Loading FX Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  // Loading states for basic animations
  bool _isPulsingLoading = false;
  bool _isLiquidLoading = false;
  bool _isSpinnerLoading = false;
  bool _isDotsLoading = false;

  // Progress loader states
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  bool _isUploading = false;
  double _uploadProgress = 0.0;

  Future<void> _simulateAction(Function(bool) setLoading) async {
    setLoading(true);
    setState(() {});

    await Future.delayed(const Duration(seconds: 3));

    setLoading(false);
    setState(() {});
  }

  Future<void> _simulateDownload() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    for (double i = 0; i <= 1.0; i += 0.02) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (mounted) {
        setState(() => _downloadProgress = i);
      }
    }

    setState(() => _downloadProgress = 1.0);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _isDownloading = false);
    }
  }

  Future<void> _simulateUpload() async {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    for (double i = 0; i <= 1.0; i += 0.01) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (mounted) {
        setState(() => _uploadProgress = i);
      }
    }

    setState(() => _uploadProgress = 1.0);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Button Loading FX - All Loaders'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Button Loading FX',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                '6 Beautiful Loaders',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Progress-Based Loaders
              _buildSectionTitle('Progress Loaders', '📊'),
              const SizedBox(height: 16),

              // Circular Progress
              ElevatedButton(
                onPressed: _isDownloading ? null : _simulateDownload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isDownloading
                    ? SizedBox(
                        height: 28,
                        child: LoadingButtonStudio(
                          animation: ButtonAnimationEffect.circularProgress,
                          progress: _downloadProgress,
                          effectColor: Colors.white,
                          inactiveColor: Colors.green.shade200,
                          size: 28,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text('Circular Progress'),
              ),
              const SizedBox(height: 12),

              // Linear Progress
              ElevatedButton(
                onPressed: _isUploading ? null : _simulateUpload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isUploading
                    ? LoadingButtonStudio(
                        animation: ButtonAnimationEffect.linearProgress,
                        progress: _uploadProgress,
                        effectColor: Colors.white,
                        inactiveColor: Colors.blue.shade200,
                        size: 20,
                        strokeWidth: 2,
                      )
                    : const Text('Linear Progress'),
              ),

              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 24),

              // Animated Loaders
              _buildSectionTitle('Animated Loaders', '🎭'),
              const SizedBox(height: 16),

              // Pulsing
              ElevatedButton(
                onPressed: _isPulsingLoading
                    ? null
                    : () => _simulateAction((v) => _isPulsingLoading = v),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isPulsingLoading
                    ? const SizedBox(
                        height: 24,
                        child: LoadingButtonStudio(
                          animation: ButtonAnimationEffect.pulsing,
                          effectColor: Colors.white,
                          size: 24,
                        ),
                      )
                    : const Text('Pulsing'),
              ),
              const SizedBox(height: 12),

              // Liquid Splash
              ElevatedButton(
                onPressed: _isLiquidLoading
                    ? null
                    : () => _simulateAction((v) => _isLiquidLoading = v),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLiquidLoading
                    ? const SizedBox(
                        height: 24,
                        child: LoadingButtonStudio(
                          animation: ButtonAnimationEffect.liquidSplash,
                          effectColor: Colors.white,
                          size: 24,
                        ),
                      )
                    : const Text('Liquid Splash'),
              ),
              const SizedBox(height: 12),

              // Spinner
              ElevatedButton(
                onPressed: _isSpinnerLoading
                    ? null
                    : () => _simulateAction((v) => _isSpinnerLoading = v),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSpinnerLoading
                    ? const SizedBox(
                        height: 24,
                        child: LoadingButtonStudio(
                          animation: ButtonAnimationEffect.spinner,
                          effectColor: Colors.white,
                          size: 24,
                        ),
                      )
                    : const Text('Spinner'),
              ),
              const SizedBox(height: 12),

              // Dots
              ElevatedButton(
                onPressed: _isDotsLoading
                    ? null
                    : () => _simulateAction((v) => _isDotsLoading = v),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isDotsLoading
                    ? const SizedBox(
                        height: 24,
                        child: LoadingButtonStudio(
                          animation: ButtonAnimationEffect.dots,
                          effectColor: Colors.white,
                          size: 24,
                        ),
                      )
                    : const Text('Rotating Dots'),
              ),

              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),

              const Text(
                '💡 Tip: All loaders work with any button type!',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String emoji) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
