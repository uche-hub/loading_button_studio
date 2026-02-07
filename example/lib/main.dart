import 'package:button_loading_fx/button_loading_fx.dart';
import 'package:flutter/material.dart';

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
  bool _isPulsingLoading = false;
  bool _isLiquidLoading = false;
  bool _isCustomLoading = false;
  bool _isFabLoading = false;

  Future<void> _simulateAction(Function(bool) setLoading) async {
    setLoading(true);
    setState(() {});
    
    // Simulate network request
    await Future.delayed(const Duration(seconds: 3));
    
    setLoading(false);
    setState(() {});
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
              const SizedBox(height: 32),
              
              // Custom Color Example
              const Text(
                'Custom Color & Duration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: _isCustomLoading 
                    ? null 
                    : () => _simulateAction((v) => _isCustomLoading = v),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.orange, width: 2),
                ),
                child: _isCustomLoading
                    ? const SizedBox(
                        height: 24,
                        child: LoadingButtonStudio(
                          animation: ButtonAnimationEffect.pulsing,
                          effectColor: Colors.orange,
                          size: 24,
                          duration: Duration(milliseconds: 800),
                        ),
                      )
                    : const Text(
                        'Save with Custom Color',
                        style: TextStyle(color: Colors.orange),
                      ),
              ),
              const SizedBox(height: 32),
              
              // Text Button Example
              const Text(
                'Text Button',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _isPulsingLoading 
                    ? null 
                    : () => _simulateAction((v) => _isPulsingLoading = v),
                child: _isPulsingLoading
                    ? const LoadingButtonStudio(
                        animation: ButtonAnimationEffect.liquidSplash,
                        effectColor: Colors.deepPurple,
                        size: 20,
                      )
                    : const Text('Text Button with Loading'),
              ),
              const SizedBox(height: 32),
              
              // Comparison with Default
              const Text(
                'Comparison: Before & After',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Before (Default)',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: null,
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'After (Loading FX)',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: null,
                          child: LoadingButtonStudio(
                            animation: ButtonAnimationEffect.pulsing,
                            effectColor: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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