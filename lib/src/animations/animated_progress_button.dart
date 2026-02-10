import 'package:flutter/material.dart';
import '../widgets/circular_progress_loader.dart';

/// A button that smoothly transitions into a circular progress indicator
///
/// Perfect for download buttons, upload buttons, or any action with progress feedback
class AnimatedProgressButton extends StatefulWidget {
  /// The button's child when not in progress state
  final Widget child;

  /// Current progress value (0.0 to 1.0)
  /// Set to null to show button, set to 0.0-1.0 to show progress
  final double? progress;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Button background color
  final Color? backgroundColor;

  /// Progress indicator active color
  final Color progressActiveColor;

  /// Progress indicator inactive/background color
  final Color progressInactiveColor;

  /// Stroke width of the progress ring
  final double progressStrokeWidth;

  /// Whether to show percentage text
  final bool showPercentage;

  /// Button height
  final double height;

  /// Button width when expanded
  final double width;

  /// Border radius
  final double borderRadius;

  /// Padding around button content
  final EdgeInsetsGeometry padding;

  /// Duration of button to progress transition
  final Duration transitionDuration;

  /// Text style for percentage display
  final TextStyle? percentageTextStyle;

  const AnimatedProgressButton({
    required this.child,
    super.key,
    this.progress,
    this.onPressed,
    this.backgroundColor,
    this.progressActiveColor = Colors.blue,
    this.progressInactiveColor = Colors.grey,
    this.progressStrokeWidth = 4.0,
    this.showPercentage = true,
    this.height = 50.0,
    this.width = 200.0,
    this.borderRadius = 25.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.transitionDuration = const Duration(milliseconds: 400),
    this.percentageTextStyle,
  });

  @override
  State<AnimatedProgressButton> createState() => _AnimatedProgressButtonState();
}

class _AnimatedProgressButtonState extends State<AnimatedProgressButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<double> _borderRadiusAnimation;

  bool _isProgress = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    );

    _updateAnimations();

    _isProgress = widget.progress != null;
    if (_isProgress) {
      _animationController.forward();
    }
  }

  void _updateAnimations() {
    final circleSize = widget.height;

    _widthAnimation = Tween<double>(begin: widget.width, end: circleSize)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _borderRadiusAnimation =
        Tween<double>(begin: widget.borderRadius, end: circleSize / 2).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void didUpdateWidget(AnimatedProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    final shouldShowProgress = widget.progress != null;

    if (shouldShowProgress != _isProgress) {
      _isProgress = shouldShowProgress;

      if (_isProgress) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor =
        widget.backgroundColor ?? Theme.of(context).primaryColor;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.progress == null ? widget.onPressed : null,
          child: Container(
            width: _widthAnimation.value,
            height: widget.height,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: _animationController.value < 0.5
                ? Center(
                    child: Opacity(
                      opacity: 1 - (_animationController.value * 2),
                      child: widget.child,
                    ),
                  )
                : Center(
                    child: Opacity(
                      opacity: (_animationController.value - 0.5) * 2,
                      child: CircularProgressLoader(
                        progress: widget.progress ?? 0.0,
                        activeColor: widget.progressActiveColor,
                        inactiveColor: widget.progressInactiveColor,
                        strokeWidth: widget.progressStrokeWidth,
                        size: widget.height * 0.7,
                        showPercentage: widget.showPercentage,
                        percentageTextStyle: widget.percentageTextStyle,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
