import 'package:flutter/material.dart';
import 'enums/button_animation_effect.dart';
import 'animations/pulsing_loader.dart';
import 'animations/liquid_splash_loader.dart';

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
class LoadingButtonStudio extends StatelessWidget {
  /// The animation effect to use
  final ButtonAnimationEffect animation;
  
  /// Color of the animation effect
  final Color effectColor;
  
  /// Stroke width for animations that use strokes
  final double strokeWidth;
  
  /// Size of the loading indicator
  final double size;
  
  /// Duration of one animation cycle
  final Duration? duration;

  const LoadingButtonStudio({
    super.key,
    this.animation = ButtonAnimationEffect.pulsing,
    this.effectColor = Colors.white,
    this.strokeWidth = 2.0,
    this.size = 20.0,
    this.duration,
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
    }
  }
}