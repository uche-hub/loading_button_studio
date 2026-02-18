import 'package:flutter/material.dart';

/// A horizontal linear progress bar
///
/// Shows progress with active and inactive colors
class LinearProgressLoader extends StatelessWidget {
  /// Color of the active progress
  final Color activeColor;

  /// Color of the inactive/background
  final Color inactiveColor;

  /// Height of the progress bar
  final double height;

  /// Width of the progress bar
  final double width;

  /// Current progress value (0.0 to 1.0)
  final double progress;

  /// Border radius of the bar
  final double borderRadius;

  const LinearProgressLoader({
    super.key,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.height = 4.0,
    this.width = 100.0,
    this.progress = 0.0,
    this.borderRadius = 2.0,
  }) : assert(
         progress >= 0.0 && progress <= 1.0,
         'Progress must be between 0.0 and 1.0',
       );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          // Background bar
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: inactiveColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          // Active progress bar
          Container(
            width: width * progress,
            height: height,
            decoration: BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ],
      ),
    );
  }
}
