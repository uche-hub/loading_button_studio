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
  // Original animations state
  bool _isPulsingLoading = false;
  bool _isLiquidLoading = false;
  bool _isFabLoading = false;

  // Progress button states
  double? _downloadProgress;
  double? _uploadProgress;
  double? _customProgress;

  Future<void> _simulateAction(Function(bool) setLoading) async {
    setLoading(true);
    setState(() {});

    await Future.delayed(const Duration(seconds: 3));

    setLoading(false);
    setState(() {});
  }

  Future<void> _simulateDownload() async {
    setState(() => _downloadProgress = 0.0);

    // Simulate smooth download progress
    for (double i = 0; i <= 1.0; i += 0.02) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (mounted) {
        setState(() => _downloadProgress = i);
      }
    }

    // Ensure we hit 100%
    setState(() => _downloadProgress = 1.0);

    // Reset after completion
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _downloadProgress = null);
    }
  }

  Future<void> _simulateUpload() async {
    setState(() => _uploadProgress = 0.0);

    // Simulate smooth upload progress
    for (double i = 0; i <= 1.0; i += 0.01) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (mounted) {
        setState(() => _uploadProgress = i);
      }
    }

    // Ensure we hit 100%
    setState(() => _uploadProgress = 1.0);

    // Reset after completion
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _uploadProgress = null);
    }
  }

  Future<void> _simulateCustomProgress() async {
    setState(() => _customProgress = 0.0);

    // Simulate smooth custom progress
    for (double i = 0; i <= 1.0; i += 0.015) {
      await Future.delayed(const Duration(milliseconds: 40));
      if (mounted) {
        setState(() => _customProgress = i);
      }
    }

    // Ensure we hit 100%
    setState(() => _customProgress = 1.0);

    // Reset after completion
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _customProgress = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Button Loading FX Demo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Button Loading FX Examples',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Animated Progress Buttons Section
              const Text(
                'Animated Progress Buttons',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
              const SizedBox(height: 16),

              // Download Button with Progress
              Center(
                child: AnimatedProgressButton(
                  progress: _downloadProgress,
                  onPressed: _simulateDownload,
                  backgroundColor: Colors.green,
                  progressActiveColor: Colors.white,
                  progressInactiveColor: Colors.green.shade200,
                  height: 56,
                  width: 220,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Download File',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Upload Button with Progress
              Center(
                child: AnimatedProgressButton(
                  progress: _uploadProgress,
                  onPressed: _simulateUpload,
                  backgroundColor: Colors.blue,
                  progressActiveColor: Colors.blue,
                  progressInactiveColor: Colors.grey.shade300,
                  progressStrokeWidth: 5,
                  height: 56,
                  width: 220,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_upload, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Upload Photo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Custom Colored Progress Button
              Center(
                child: AnimatedProgressButton(
                  progress: _customProgress,
                  onPressed: _simulateCustomProgress,
                  backgroundColor: Colors.orange,
                  progressActiveColor: Colors.orange,
                  progressInactiveColor: Colors.orange.shade100,
                  progressStrokeWidth: 6,
                  showPercentage: true,
                  height: 60,
                  width: 240,
                  borderRadius: 30,
                  percentageTextStyle: const TextStyle(
                    color: Colors.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sync, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Process Data',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 20),

              // Original Animations Section
              const Text(
                'Original Loading Animations',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
              const SizedBox(height: 16),

              // Pulsing Animation Example
              const Text(
                'Pulsing Animation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
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
                    : const Text('Submit with Pulsing'),
              ),
              const SizedBox(height: 32),

              // Liquid Splash Animation Example
              const Text(
                'Liquid Splash Animation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
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
                    : const Text('Login with Liquid Splash'),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isFabLoading
            ? null
            : () => _simulateAction((v) => _isFabLoading = v),
        tooltip: 'FAB with Loading',
        child: _isFabLoading
            ? const LoadingButtonStudio(
                animation: ButtonAnimationEffect.liquidSplash,
                effectColor: Colors.white,
                size: 28,
              )
            : const Icon(Icons.add),
      ),
    );
  }
}
