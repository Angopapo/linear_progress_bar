import 'package:flutter/material.dart';
import '../ui/dots_indicator.dart';
import '../utils/dots_decorator.dart';

/// Callback signature for progress changes.
typedef OnProgressChanged = void Function(int currentStep, int maxSteps);

/// Callback signature for progress completion.
typedef OnProgressComplete = void Function();

/// The type of progress bar to display.
enum ProgressType {
  /// A linear/horizontal progress bar.
  linear,

  /// A dots/step indicator progress bar.
  dots,
}

/// A customizable linear progress bar widget that supports both linear and dots
/// progress indicators.
///
/// This widget provides a flexible way to display progress in your Flutter app.
/// You can choose between a traditional linear progress bar or a dots-based
/// step indicator.
///
/// Example usage:
/// ```dart
/// LinearProgressBar(
///   maxSteps: 6,
///   progressType: ProgressType.linear,
///   currentStep: 3,
///   progressColor: Colors.blue,
///   backgroundColor: Colors.grey,
///   borderRadius: BorderRadius.circular(10),
/// )
/// ```
class LinearProgressBar extends StatelessWidget {
  /// The maximum number of steps/segments in the progress bar.
  ///
  /// Must be greater than 0. Defaults to 1.
  final int maxSteps;

  /// The current step/progress value.
  ///
  /// Must be between 0 and [maxSteps]. Defaults to 0.
  final int currentStep;

  /// The color of the progress indicator.
  ///
  /// Defaults to [Colors.red].
  final Color progressColor;

  /// The background color of the progress bar.
  ///
  /// Defaults to [Colors.white].
  final Color backgroundColor;

  /// The semantic label for accessibility.
  final String? semanticsLabel;

  /// The semantic value for accessibility.
  final String? semanticsValue;

  /// The minimum height of the linear progress bar.
  ///
  /// Defaults to 10.0.
  final double minHeight;

  /// The type of progress bar to display.
  ///
  /// Use [ProgressType.linear] for a traditional progress bar or
  /// [ProgressType.dots] for a dots indicator. Defaults to [ProgressType.linear].
  final ProgressType progressType;

  /// The animation color for the linear progress bar.
  ///
  /// If provided, this will be used instead of [progressColor].
  final Animation<Color?>? valueColor;

  /// The border radius for the linear progress bar.
  ///
  /// Defaults to [BorderRadius.zero].
  final BorderRadiusGeometry borderRadius;

  /// The axis direction for dots indicator.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis dotsAxis;

  /// The spacing around each dot.
  ///
  /// Defaults to [EdgeInsets.zero].
  final EdgeInsets dotsSpacing;

  /// The size of the active dot.
  ///
  /// Defaults to 8.0.
  final double dotsActiveSize;

  /// The size of inactive dots.
  ///
  /// Defaults to 8.0.
  final double dotsInactiveSize;

  /// The shape of active dot.
  ///
  /// Defaults to [CircleBorder].
  final ShapeBorder? dotsActiveShape;

  /// The shape of inactive dots.
  ///
  /// Defaults to [CircleBorder].
  final ShapeBorder? dotsShape;

  /// Whether to reverse the dots order.
  ///
  /// Defaults to false.
  final bool dotsReversed;

  /// Callback when a dot is tapped.
  final OnTap? onDotTap;

  /// Callback when progress changes.
  final OnProgressChanged? onProgressChanged;

  /// Callback when progress is complete.
  final OnProgressComplete? onProgressComplete;

  /// The gradient for the progress bar.
  ///
  /// If provided, this will be used instead of [progressColor].
  /// Note: This only works with linear progress type.
  final Gradient? progressGradient;

  /// Whether to animate the progress changes.
  ///
  /// Defaults to false.
  final bool animateProgress;

  /// The duration of the progress animation.
  ///
  /// Defaults to 300 milliseconds.
  final Duration animationDuration;

  /// The curve for the progress animation.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve animationCurve;

  /// Legacy static constants for backward compatibility.
  @Deprecated('Use ProgressType.linear instead')
  static final int progressTypeLinear = 1;

  @Deprecated('Use ProgressType.dots instead')
  static final int progressTypeDots = 2;

  /// Creates a linear progress bar widget.
  ///
  /// The [maxSteps] must be greater than 0.
  /// The [currentStep] must be between 0 and [maxSteps].
  const LinearProgressBar({
    super.key,
    this.progressColor = Colors.red,
    this.backgroundColor = Colors.white,
    this.maxSteps = 1,
    this.currentStep = 0,
    this.minHeight = 10,
    this.semanticsLabel,
    this.semanticsValue,
    this.valueColor,
    this.progressType = ProgressType.linear,
    this.dotsAxis = Axis.horizontal,
    this.dotsSpacing = EdgeInsets.zero,
    this.dotsActiveSize = 8,
    this.dotsInactiveSize = 8,
    this.dotsActiveShape,
    this.dotsShape,
    this.dotsReversed = false,
    this.onDotTap,
    this.onProgressChanged,
    this.onProgressComplete,
    this.progressGradient,
    this.animateProgress = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.borderRadius = BorderRadius.zero,
  })  : assert(maxSteps > 0, 'maxSteps must be greater than 0'),
        assert(currentStep >= 0, 'currentStep must be non-negative'),
        assert(currentStep <= maxSteps, 'currentStep must not exceed maxSteps');

  /// Calculates the progress value as a fraction between 0.0 and 1.0.
  double get progressValue {
    if (maxSteps <= 0) return 0.0;
    return (currentStep / maxSteps).clamp(0.0, 1.0);
  }

  /// Returns true if the progress is complete.
  bool get isComplete => currentStep >= maxSteps;

  /// Returns the progress as a percentage (0-100).
  double get progressPercentage => progressValue * 100;

  @override
  Widget build(BuildContext context) {
    final DotsDecorator decorator = DotsDecorator(
      activeColor: progressColor,
      color: backgroundColor,
      spacing: dotsSpacing,
      activeSize: Size.square(dotsActiveSize),
      size: Size.square(dotsInactiveSize),
      activeShape: dotsActiveShape ?? const CircleBorder(),
      shape: dotsShape ?? const CircleBorder(),
    );

    return _buildProgressIndicator(decorator);
  }

  Widget _buildProgressIndicator(DotsDecorator decorator) {
    switch (progressType) {
      case ProgressType.dots:
        return DotsIndicator(
          dotsCount: maxSteps,
          // Ensure position is within valid range (0 to dotsCount - 1)
          position: currentStep.clamp(0, maxSteps - 1).toDouble(),
          axis: dotsAxis,
          decorator: decorator,
          reversed: dotsReversed,
          onTap: onDotTap,
        );
      case ProgressType.linear:
        return _buildLinearProgress();
    }
  }

  Widget _buildLinearProgress() {
    if (progressGradient != null) {
      return _buildGradientProgress();
    }

    if (animateProgress) {
      return TweenAnimationBuilder<double>(
        duration: animationDuration,
        curve: animationCurve,
        tween: Tween<double>(begin: 0, end: progressValue),
        builder: (context, value, child) {
          return LinearProgressIndicator(
            value: value,
            backgroundColor: backgroundColor,
            color: progressColor,
            semanticsLabel: semanticsLabel,
            semanticsValue: semanticsValue,
            minHeight: minHeight,
            valueColor: valueColor,
            borderRadius: borderRadius,
          );
        },
      );
    }

    return LinearProgressIndicator(
      value: progressValue,
      backgroundColor: backgroundColor,
      color: progressColor,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      minHeight: minHeight,
      valueColor: valueColor,
      borderRadius: borderRadius,
    );
  }

  Widget _buildGradientProgress() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: minHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius as BorderRadius?,
          ),
          child: ClipRRect(
            borderRadius: borderRadius as BorderRadius? ?? BorderRadius.zero,
            child: Stack(
              children: [
                if (animateProgress)
                  TweenAnimationBuilder<double>(
                    duration: animationDuration,
                    curve: animationCurve,
                    tween: Tween<double>(begin: 0, end: progressValue),
                    builder: (context, value, child) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: value,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: progressGradient,
                          ),
                        ),
                      );
                    },
                  )
                else
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: progressGradient,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
