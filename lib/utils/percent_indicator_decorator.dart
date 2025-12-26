import 'package:flutter/material.dart';
import '../ui/linear_percent_indicator.dart';
import '../ui/circular_percent_indicator.dart';

/// A decorator class for customizing the appearance of linear and circular
/// percent indicators.
///
/// This class provides preset configurations for common progress indicator styles
/// and allows for easy customization.
///
/// Example usage:
/// ```dart
/// final linearDecorator = PercentIndicatorDecorator.linearModern();
/// final circularDecorator = PercentIndicatorDecorator.circularRing();
/// ```
class PercentIndicatorDecorator {
  /// The color of the progress indicator.
  final Color? progressColor;

  /// The background color of the indicator.
  final Color? backgroundColor;

  /// Optional gradient for the progress.
  final Gradient? gradient;

  /// The line/stroke width.
  final double? lineWidth;

  /// Whether to animate changes.
  final bool? animation;

  /// The animation duration.
  final Duration? animationDuration;

  /// The animation curve.
  final Curve? animationCurve;

  /// The border radius for linear indicators.
  final BorderRadius? barRadius;

  /// The stroke cap style for circular indicators.
  final CircularStrokeCap? circularStrokeCap;

  /// Creates a percent indicator decorator.
  const PercentIndicatorDecorator({
    this.progressColor,
    this.backgroundColor,
    this.gradient,
    this.lineWidth,
    this.animation,
    this.animationDuration,
    this.animationCurve,
    this.barRadius,
    this.circularStrokeCap,
  });

  // ==================== LINEAR DECORATORS ====================

  /// Creates a modern linear progress indicator decorator.
  factory PercentIndicatorDecorator.linearModern({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.blue,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      lineWidth: 10,
      animation: true,
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeOutCubic,
      barRadius: BorderRadius.circular(5),
    );
  }

  /// Creates a flat linear progress indicator decorator.
  factory PercentIndicatorDecorator.linearFlat({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.teal,
      backgroundColor: backgroundColor ?? Colors.grey.shade300,
      lineWidth: 6,
      animation: true,
      barRadius: BorderRadius.zero,
    );
  }

  /// Creates a gradient linear progress indicator decorator.
  factory PercentIndicatorDecorator.linearGradient({
    List<Color>? colors,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      gradient: LinearGradient(
        colors: colors ?? [Colors.blue, Colors.purple],
      ),
      lineWidth: 12,
      animation: true,
      animationDuration: const Duration(milliseconds: 600),
      barRadius: BorderRadius.circular(6),
    );
  }

  /// Creates a thin linear progress indicator decorator.
  factory PercentIndicatorDecorator.linearThin({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.indigo,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      lineWidth: 3,
      animation: true,
      barRadius: BorderRadius.circular(1.5),
    );
  }

  /// Creates a thick linear progress indicator decorator.
  factory PercentIndicatorDecorator.linearThick({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.deepOrange,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      lineWidth: 20,
      animation: true,
      barRadius: BorderRadius.circular(10),
    );
  }

  /// Creates a download/upload style linear progress indicator decorator.
  factory PercentIndicatorDecorator.linearDownload({
    Color? progressColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.green,
      backgroundColor: Colors.green.withValues(alpha: 0.2),
      lineWidth: 8,
      animation: true,
      animationCurve: Curves.linear,
      barRadius: BorderRadius.circular(4),
    );
  }

  // ==================== CIRCULAR DECORATORS ====================

  /// Creates a modern circular ring indicator decorator.
  factory PercentIndicatorDecorator.circularRing({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.blue,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      lineWidth: 10,
      animation: true,
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeOutCubic,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  /// Creates a thin circular indicator decorator.
  factory PercentIndicatorDecorator.circularThin({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.cyan,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      lineWidth: 4,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  /// Creates a thick circular indicator decorator.
  factory PercentIndicatorDecorator.circularThick({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.orange,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      lineWidth: 20,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  /// Creates a gradient circular indicator decorator.
  factory PercentIndicatorDecorator.circularGradient({
    List<Color>? colors,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      gradient: SweepGradient(
        colors: colors ?? [Colors.blue, Colors.purple, Colors.pink],
      ),
      lineWidth: 12,
      animation: true,
      animationDuration: const Duration(milliseconds: 1000),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  /// Creates a fitness/health ring style circular indicator decorator.
  factory PercentIndicatorDecorator.circularFitness({
    Color? ringColor,
  }) {
    final color = ringColor ?? Colors.green;
    return PercentIndicatorDecorator(
      progressColor: color,
      backgroundColor: color.withValues(alpha: 0.2),
      lineWidth: 15,
      animation: true,
      animationDuration: const Duration(milliseconds: 1200),
      animationCurve: Curves.easeOutBack,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  /// Creates a loading spinner style circular indicator decorator.
  factory PercentIndicatorDecorator.circularSpinner({
    Color? progressColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.blue,
      backgroundColor: Colors.transparent,
      lineWidth: 4,
      animation: true,
      animationDuration: const Duration(milliseconds: 300),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  /// Creates a dashed circular indicator decorator.
  factory PercentIndicatorDecorator.circularDashed({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? Colors.purple,
      backgroundColor: backgroundColor ?? Colors.grey.shade300,
      lineWidth: 8,
      animation: true,
      circularStrokeCap: CircularStrokeCap.butt,
    );
  }

  /// Creates a copy of this decorator with the given fields replaced.
  PercentIndicatorDecorator copyWith({
    Color? progressColor,
    Color? backgroundColor,
    Gradient? gradient,
    double? lineWidth,
    bool? animation,
    Duration? animationDuration,
    Curve? animationCurve,
    BorderRadius? barRadius,
    CircularStrokeCap? circularStrokeCap,
  }) {
    return PercentIndicatorDecorator(
      progressColor: progressColor ?? this.progressColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradient: gradient ?? this.gradient,
      lineWidth: lineWidth ?? this.lineWidth,
      animation: animation ?? this.animation,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      barRadius: barRadius ?? this.barRadius,
      circularStrokeCap: circularStrokeCap ?? this.circularStrokeCap,
    );
  }
}

/// Predefined multi-segment configurations for progress indicators.
class SegmentPresets {
  /// Traffic light style segments (red, yellow, green).
  static List<LinearSegment> trafficLight({
    double redPortion = 0.33,
    double yellowPortion = 0.33,
  }) {
    return [
      LinearSegment(value: redPortion, color: Colors.red),
      LinearSegment(value: yellowPortion, color: Colors.yellow),
      LinearSegment(value: 1.0 - redPortion - yellowPortion, color: Colors.green),
    ];
  }

  /// Rainbow style segments.
  static List<LinearSegment> rainbow() {
    return const [
      LinearSegment(value: 0.14, color: Colors.red),
      LinearSegment(value: 0.14, color: Colors.orange),
      LinearSegment(value: 0.14, color: Colors.yellow),
      LinearSegment(value: 0.14, color: Colors.green),
      LinearSegment(value: 0.14, color: Colors.blue),
      LinearSegment(value: 0.14, color: Colors.indigo),
      LinearSegment(value: 0.16, color: Colors.purple),
    ];
  }

  /// Task completion style segments (done, in progress, remaining).
  static List<LinearSegment> taskCompletion({
    required double completed,
    required double inProgress,
    Color? completedColor,
    Color? inProgressColor,
    Color? remainingColor,
  }) {
    final remaining = 1.0 - completed - inProgress;
    return [
      LinearSegment(value: completed, color: completedColor ?? Colors.green),
      LinearSegment(value: inProgress, color: inProgressColor ?? Colors.orange),
      if (remaining > 0)
        LinearSegment(value: remaining, color: remainingColor ?? Colors.grey.shade300),
    ];
  }

  /// Storage usage style segments.
  static List<LinearSegment> storageUsage({
    required double used,
    required double system,
    Color? usedColor,
    Color? systemColor,
    Color? freeColor,
  }) {
    final free = 1.0 - used - system;
    return [
      LinearSegment(value: used, color: usedColor ?? Colors.blue),
      LinearSegment(value: system, color: systemColor ?? Colors.orange),
      if (free > 0)
        LinearSegment(value: free, color: freeColor ?? Colors.grey.shade200),
    ];
  }

  /// Circular segments for fitness rings.
  static List<CircularSegment> fitnessRings({
    required double move,
    required double exercise,
    required double stand,
  }) {
    return [
      CircularSegment(value: move, color: Colors.red),
      CircularSegment(value: exercise, color: Colors.green),
      CircularSegment(value: stand, color: Colors.cyan),
    ];
  }
}
