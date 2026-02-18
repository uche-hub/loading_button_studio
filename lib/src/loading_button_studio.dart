import 'package:button_loading_fx/button_loading_fx.dart';
import 'package:button_loading_fx/src/animations/linear_progress_bar.dart';
import 'package:flutter/material.dart';
import 'animations/pulsing_loader.dart';
import 'animations/liquid_splash_loader.dart';
import 'animations/spinner_loader.dart';
import 'animations/dots_loader.dart';

/// A customizable loading indicator widget for buttons with multiple animation effects
///
/// Use this widget inside your button's child when showing a loading state.
///
/// Example:
/// ```dart
/// ElevatedButton(
///   onPressed: _isLoading ? null : _handlePress,
///   child: _isLoading
///       ? const LoadingButtonStudio(
///           animation: ButtonAnimationEffect.pulsing,
///           effectColor: Colors.white,
///         )
///       : const Text('Submit'),
/// )
/// ```
///
/// For progress-based loading (downloads, uploads):
/// ```dart
/// ElevatedButton(
///   onPressed: _isLoading ? null : _handlePress,
///   child: _isLoading
///       ? LoadingButtonStudio(
///           animation: ButtonAnimationEffect.circularProgress,
///           progress: _downloadProgress, // 0.0 to 1.0
///           effectColor: Colors.white,
///           inactiveColor: Colors.grey.shade300,
///         )
///       : const Text('Download'),
/// )
/// ```
class LoadingButtonStudio extends StatelessWidget {
  /// The animation effect to use
  final ButtonAnimationEffect animation;

  /// Color of the animation effect (active color for progress indicators)
  final Color effectColor;

  /// Inactive/background color (only used for progress indicators)
  final Color? inactiveColor;

  /// Stroke width for animations that use strokes
  final double strokeWidth;

  /// Size of the loading indicator
  final double size;

  /// Duration of one animation cycle
  final Duration? duration;

  /// Progress value for progress-based animations (0.0 to 1.0)
  /// Used for: circularProgress, linearProgress
  final double? progress;

  /// Whether to show percentage text (only for circularProgress)
  final bool showPercentage;

  const LoadingButtonStudio({
    super.key,
    this.animation = ButtonAnimationEffect.pulsing,
    this.effectColor = Colors.white,
    this.inactiveColor,
    this.strokeWidth = 2.0,
    this.size = 20.0,
    this.duration,
    this.progress,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    switch (animation) {
      case ButtonAnimationEffect.pulsing:
        return PulsingLoader(
          effectColor: effectColor,
          strokeWidth: strokeWidth,
          size: size,
          duration: duration ?? const Duration(milliseconds: 1200),
        );

      case ButtonAnimationEffect.liquidSplash:
        return LiquidSplashLoader(
          effectColor: effectColor,
          strokeWidth: strokeWidth,
          size: size,
          duration: duration ?? const Duration(milliseconds: 1500),
        );

      case ButtonAnimationEffect.circularProgress:
        return CircularProgressLoader(
          progress: progress ?? 0.0,
          activeColor: effectColor,
          inactiveColor: inactiveColor ?? Colors.grey.withValues(alpha: 0.3),
          strokeWidth: strokeWidth,
          size: size,
          showPercentage: showPercentage,
        );

      case ButtonAnimationEffect.spinner:
        return SpinnerLoader(
          effectColor: effectColor,
          size: size,
          lineWidth: strokeWidth,
          duration: duration ?? const Duration(milliseconds: 1000),
        );

      case ButtonAnimationEffect.dots:
        return DotsLoader(
          effectColor: effectColor,
          size: size,
          duration: duration ?? const Duration(milliseconds: 1200),
        );

      case ButtonAnimationEffect.linearProgress:
        return LinearProgressLoader(
          progress: progress ?? 0.0,
          activeColor: effectColor,
          inactiveColor: inactiveColor ?? Colors.grey.withValues(alpha: 0.3),
          height: strokeWidth * 2,
          width: size * 5, // Linear bar is wider
        );
    }
  }
}
