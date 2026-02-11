import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A rotating dots loader with one highlighted dot
///
/// Dots rotate in a circle with one dot highlighted
class DotsLoader extends StatefulWidget {
  /// Color of the dots
  final Color effectColor;

  /// Number of dots
  final int dotCount;

  /// Duration of one rotation
  final Duration duration;

  /// Size of the loader
  final double size;

  /// Size of each dot
  final double dotSize;

  const DotsLoader({
    super.key,
    this.effectColor = Colors.white,
    this.dotCount = 8,
    this.duration = const Duration(milliseconds: 1200),
    this.size = 20.0,
    this.dotSize = 3.0,
  });

  @override
  State<DotsLoader> createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<DotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
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
            painter: _DotsPainter(
              progress: _controller.value,
              color: widget.effectColor,
              dotCount: widget.dotCount,
              dotSize: widget.dotSize,
            ),
          );
        },
      ),
    );
  }
}

class _DotsPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int dotCount;
  final double dotSize;

  _DotsPainter({
    required this.progress,
    required this.color,
    required this.dotCount,
    required this.dotSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.5;
    final angleStep = (2 * math.pi) / dotCount;

    // Calculate which dot should be highlighted
    final highlightedDot = (progress * dotCount).floor() % dotCount;

    for (int i = 0; i < dotCount; i++) {
      final angle = i * angleStep - (math.pi / 2); // Start from top

      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      // Highlighted dot is fully opaque, others are faded
      final isHighlighted = i == highlightedDot;
      final opacity = isHighlighted ? 1.0 : 0.3;

      final paint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), dotSize, paint);
    }
  }

  @override
  bool shouldRepaint(_DotsPainter oldDelegate) => true;
}
