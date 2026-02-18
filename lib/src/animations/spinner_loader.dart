import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A rotating spinner with radiating lines
///
/// Lines fade in and out as they rotate, creating a loading effect
class SpinnerLoader extends StatefulWidget {
  /// Color of the spinner lines
  final Color effectColor;

  /// Number of lines in the spinner
  final int lineCount;

  /// Duration of one rotation
  final Duration duration;

  /// Size of the spinner
  final double size;

  /// Width of each line
  final double lineWidth;

  const SpinnerLoader({
    super.key,
    this.effectColor = Colors.white,
    this.lineCount = 8,
    this.duration = const Duration(milliseconds: 1000),
    this.size = 20.0,
    this.lineWidth = 2.0,
  });

  @override
  State<SpinnerLoader> createState() => _SpinnerLoaderState();
}

class _SpinnerLoaderState extends State<SpinnerLoader>
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
            painter: _SpinnerPainter(
              progress: _controller.value,
              color: widget.effectColor,
              lineCount: widget.lineCount,
              lineWidth: widget.lineWidth,
            ),
          );
        },
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int lineCount;
  final double lineWidth;

  _SpinnerPainter({
    required this.progress,
    required this.color,
    required this.lineCount,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final angleStep = (2 * math.pi) / lineCount;

    for (int i = 0; i < lineCount; i++) {
      final angle = i * angleStep + (progress * 2 * math.pi);

      // Calculate opacity based on position
      final opacityIndex = (i / lineCount);
      final opacity = 0.2 + (0.8 * opacityIndex);

      final paint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..strokeWidth = lineWidth
        ..strokeCap = StrokeCap.round;

      // Start point (closer to center)
      final startX = center.dx + (radius * 0.3) * math.cos(angle);
      final startY = center.dy + (radius * 0.3) * math.sin(angle);

      // End point (at edge)
      final endX = center.dx + (radius * 0.9) * math.cos(angle);
      final endY = center.dy + (radius * 0.9) * math.sin(angle);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(_SpinnerPainter oldDelegate) => true;
}
