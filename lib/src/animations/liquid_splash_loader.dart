import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A liquid splash loading animation with wave-like water droplet effect
class LiquidSplashLoader extends StatefulWidget {
  /// Color of the liquid splash
  final Color effectColor;
  
  /// Stroke width (not used but kept for API consistency)
  final double strokeWidth;
  
  /// Duration of one splash cycle
  final Duration duration;
  
  /// Size of the loader
  final double size;

  const LiquidSplashLoader({
    super.key,
    this.effectColor = Colors.white,
    this.strokeWidth = 2.0,
    this.duration = const Duration(milliseconds: 1500),
    this.size = 20.0,
  });

  @override
  State<LiquidSplashLoader> createState() => _LiquidSplashLoaderState();
}

class _LiquidSplashLoaderState extends State<LiquidSplashLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _LiquidSplashPainter(
              animation: _controller,
              color: widget.effectColor,
            ),
          );
        },
      ),
    );
  }
}

class _LiquidSplashPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  _LiquidSplashPainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final progress = animation.value;

    // Draw three droplets at different phases
    for (int i = 0; i < 3; i++) {
      final phaseOffset = i / 3.0;
      final phaseProgress = (progress + phaseOffset) % 1.0;
      
      _drawDroplet(
        canvas,
        center,
        radius,
        phaseProgress,
        i * 120.0, // Rotate each droplet by 120 degrees
      );
    }
  }

  void _drawDroplet(
    Canvas canvas,
    Offset center,
    double radius,
    double progress,
    double rotationDegrees,
  ) {
    // Calculate droplet position and size based on progress
    final angle = rotationDegrees * math.pi / 180;
    
    // Droplet rises and falls
    final yOffset = math.sin(progress * math.pi) * radius * 0.6;
    final xOffset = math.cos(angle) * radius * 0.3;
    final yRotation = math.sin(angle) * radius * 0.3;
    
    final dropletCenter = Offset(
      center.dx + xOffset,
      center.dy - yOffset + yRotation,
    );

    // Size pulsates
    final sizeFactor = 0.3 + (math.sin(progress * math.pi) * 0.2);
    final dropletRadius = radius * sizeFactor;

    // Opacity fades in and out
    final opacity = math.sin(progress * math.pi);

    final paint = Paint()
      ..color = color.withOpacity(opacity * 0.8)
      ..style = PaintingStyle.fill;

    // Draw water droplet shape
    final path = Path();
    
    // Top point of droplet
    path.moveTo(dropletCenter.dx, dropletCenter.dy - dropletRadius);
    
    // Right curve
    path.quadraticBezierTo(
      dropletCenter.dx + dropletRadius * 0.7,
      dropletCenter.dy - dropletRadius * 0.3,
      dropletCenter.dx + dropletRadius * 0.5,
      dropletCenter.dy + dropletRadius * 0.3,
    );
    
    // Bottom right
    path.quadraticBezierTo(
      dropletCenter.dx + dropletRadius * 0.3,
      dropletCenter.dy + dropletRadius * 0.7,
      dropletCenter.dx,
      dropletCenter.dy + dropletRadius * 0.8,
    );
    
    // Bottom left
    path.quadraticBezierTo(
      dropletCenter.dx - dropletRadius * 0.3,
      dropletCenter.dy + dropletRadius * 0.7,
      dropletCenter.dx - dropletRadius * 0.5,
      dropletCenter.dy + dropletRadius * 0.3,
    );
    
    // Left curve
    path.quadraticBezierTo(
      dropletCenter.dx - dropletRadius * 0.7,
      dropletCenter.dy - dropletRadius * 0.3,
      dropletCenter.dx,
      dropletCenter.dy - dropletRadius,
    );
    
    path.close();
    canvas.drawPath(path, paint);

    // Add highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.4)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(
        dropletCenter.dx - dropletRadius * 0.2,
        dropletCenter.dy - dropletRadius * 0.3,
      ),
      dropletRadius * 0.15,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(_LiquidSplashPainter oldDelegate) => false;
}