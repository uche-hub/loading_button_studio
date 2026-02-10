import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A circular progress indicator with customizable active and inactive colors
///
/// Perfect for download progress, upload progress, or any percentage-based loading
class CircularProgressLoader extends StatelessWidget {
  /// Color of the active progress arc
  final Color activeColor;

  /// Color of the inactive/background arc
  final Color inactiveColor;

  /// Stroke width of the progress ring
  final double strokeWidth;

  /// Size of the progress indicator
  final double size;

  /// Current progress value (0.0 to 1.0)
  final double progress;

  /// Whether to show percentage text in the center
  final bool showPercentage;

  /// Text style for the percentage display
  final TextStyle? percentageTextStyle;

  const CircularProgressLoader({
    super.key,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.strokeWidth = 8.0,
    this.size = 60.0,
    this.progress = 0.0,
    this.showPercentage = true,
    this.percentageTextStyle,
  }) : assert(
         progress >= 0.0 && progress <= 1.0,
         'Progress must be between 0.0 and 1.0',
       );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CircularProgressPainter(
          progress: progress,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          strokeWidth: strokeWidth,
        ),
        child: showPercentage
            ? Center(
                child: Text(
                  '${(progress * 100).toInt()}%',
                  style:
                      percentageTextStyle ??
                      TextStyle(
                        fontSize: size * 0.25,
                        fontWeight: FontWeight.bold,
                        color: activeColor,
                      ),
                ),
              )
            : null,
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw inactive background circle
    final inactivePaint = Paint()
      ..color = inactiveColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, inactivePaint);

    // Draw active progress arc
    if (progress > 0) {
      final activePaint = Paint()
        ..color = activeColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      const startAngle = -math.pi / 2; // Start from top
      final sweepAngle = 2 * math.pi * progress;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        activePaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
