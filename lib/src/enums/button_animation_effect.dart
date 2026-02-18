/// Enum representing different button loading animation effects
enum ButtonAnimationEffect {
  /// A smooth pulsing animation that scales in and out
  pulsing,

  /// A liquid splash animation with wave-like motion
  liquidSplash,

  /// A circular progress indicator showing percentage (0-100%)
  /// Use with progress parameter to show download/upload progress
  circularProgress,

  /// A rotating spinner with radiating lines
  spinner,

  /// Rotating dots in a circle with one highlighted dot
  dots,

  /// A horizontal linear progress bar
  /// Use with progress parameter for visual progress feedback
  linearProgress,
}
