import 'package:flutter/material.dart';
import '../ui/gauge_indicator.dart';

/// A decorator class for customizing the appearance of [GaugeIndicator].
///
/// This class provides preset configurations for common gauge styles
/// and allows for easy customization.
///
/// Example usage:
/// ```dart
/// final decorator = GaugeDecorator.speedometer(
///   maxValue: 200,
///   unit: 'km/h',
/// );
/// ```
class GaugeDecorator {
  /// The color of the value indicator.
  final Color? valueColor;

  /// The background color of the gauge arc.
  final Color? backgroundColor;

  /// Optional gradient for the value arc.
  final Gradient? gradient;

  /// The starting angle in degrees.
  final double? startAngle;

  /// The sweep angle in degrees.
  final double? sweepAngle;

  /// The style of the gauge.
  final GaugeStyle? gaugeStyle;

  /// Ranges for coloring different value ranges.
  final List<GaugeRange>? ranges;

  /// Number of tick marks.
  final int? tickCount;

  /// The text style for the value label.
  final TextStyle? valueTextStyle;

  /// Whether to show a needle.
  final bool? showNeedle;

  /// The color of the needle.
  final Color? needleColor;

  /// Creates a gauge decorator.
  // ignore: sort_constructors_first
  const GaugeDecorator({
    this.valueColor,
    this.backgroundColor,
    this.gradient,
    this.startAngle,
    this.sweepAngle,
    this.gaugeStyle,
    this.ranges,
    this.tickCount,
    this.valueTextStyle,
    this.showNeedle,
    this.needleColor,
  });

  /// Creates a speedometer-style gauge decorator.
  // ignore: sort_constructors_first
  factory GaugeDecorator.speedometer({
    double maxValue = 100, // ignore: avoid_unused_constructor_parameters
    String unit = '', // ignore: avoid_unused_constructor_parameters
    Color? lowColor,
    Color? mediumColor,
    Color? highColor,
  }) {
    return GaugeDecorator(
      startAngle: 135,
      sweepAngle: 270,
      gaugeStyle: GaugeStyle.ticked,
      showNeedle: true,
      needleColor: Colors.red,
      tickCount: 10,
      ranges: [
        GaugeRange(
          start: 0.0,
          end: 0.33,
          color: lowColor ?? Colors.green,
          label: 'Low',
        ),
        GaugeRange(
          start: 0.33,
          end: 0.66,
          color: mediumColor ?? Colors.orange,
          label: 'Medium',
        ),
        GaugeRange(
          start: 0.66,
          end: 1.0,
          color: highColor ?? Colors.red,
          label: 'High',
        ),
      ],
    );
  }

  /// Creates a minimal flat gauge decorator.
  // ignore: sort_constructors_first
  factory GaugeDecorator.minimal({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return GaugeDecorator(
      startAngle: 180,
      sweepAngle: 180,
      gaugeStyle: GaugeStyle.simple,
      showNeedle: false,
      valueColor: progressColor ?? Colors.blue,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
    );
  }

  /// Creates a gradient gauge decorator.
  // ignore: sort_constructors_first
  factory GaugeDecorator.gradient({
    List<Color>? colors,
    double startAngle = 135,
    double sweepAngle = 270,
  }) {
    return GaugeDecorator(
      startAngle: startAngle,
      sweepAngle: sweepAngle,
      gaugeStyle: GaugeStyle.modern,
      showNeedle: false,
      gradient: SweepGradient(
        startAngle: startAngle * 3.14159 / 180,
        endAngle: (startAngle + sweepAngle) * 3.14159 / 180,
        colors:
            colors ?? [Colors.green, Colors.yellow, Colors.orange, Colors.red],
      ),
    );
  }

  /// Creates a health/fitness style gauge decorator.
  // ignore: sort_constructors_first
  factory GaugeDecorator.health({
    Color? goodColor,
    Color? warningColor,
    Color? dangerColor,
  }) {
    return GaugeDecorator(
      startAngle: 135,
      sweepAngle: 270,
      gaugeStyle: GaugeStyle.modern,
      showNeedle: false,
      tickCount: 5,
      ranges: [
        GaugeRange(
          start: 0.0,
          end: 0.5,
          color: dangerColor ?? Colors.red,
          label: 'Low',
        ),
        GaugeRange(
          start: 0.5,
          end: 0.75,
          color: warningColor ?? Colors.orange,
          label: 'Medium',
        ),
        GaugeRange(
          start: 0.75,
          end: 1.0,
          color: goodColor ?? Colors.green,
          label: 'Good',
        ),
      ],
    );
  }

  /// Creates a temperature gauge decorator.
  // ignore: sort_constructors_first
  factory GaugeDecorator.temperature({
    double minTemp = 0, // ignore: avoid_unused_constructor_parameters
    double maxTemp = 100, // ignore: avoid_unused_constructor_parameters
  }) {
    return const GaugeDecorator(
      startAngle: 180,
      sweepAngle: 180,
      gaugeStyle: GaugeStyle.ticked,
      showNeedle: true,
      needleColor: Colors.black87,
      tickCount: 10,
      gradient: LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
          Colors.green,
          Colors.yellow,
          Colors.orange,
          Colors.red
        ],
      ),
    );
  }

  /// Creates a copy of this decorator with the given fields replaced.
  GaugeDecorator copyWith({
    Color? valueColor,
    Color? backgroundColor,
    Gradient? gradient,
    double? startAngle,
    double? sweepAngle,
    GaugeStyle? gaugeStyle,
    List<GaugeRange>? ranges,
    int? tickCount,
    TextStyle? valueTextStyle,
    bool? showNeedle,
    Color? needleColor,
  }) {
    return GaugeDecorator(
      valueColor: valueColor ?? this.valueColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradient: gradient ?? this.gradient,
      startAngle: startAngle ?? this.startAngle,
      sweepAngle: sweepAngle ?? this.sweepAngle,
      gaugeStyle: gaugeStyle ?? this.gaugeStyle,
      ranges: ranges ?? this.ranges,
      tickCount: tickCount ?? this.tickCount,
      valueTextStyle: valueTextStyle ?? this.valueTextStyle,
      showNeedle: showNeedle ?? this.showNeedle,
      needleColor: needleColor ?? this.needleColor,
    );
  }
}

/// A decorator class for customizing circular percent indicators.
///
/// This class provides preset configurations for common circular indicator styles.
class CircularDecorator {
  /// The color of the progress indicator.
  final Color? progressColor;

  /// The background color of the circle.
  final Color? backgroundColor;

  /// Optional gradient for the progress.
  final Gradient? gradient;

  /// The width of the progress line.
  final double? lineWidth;

  /// Whether to animate progress changes.
  final bool? animation;

  /// The duration of the animation.
  final Duration? animationDuration;

  /// Creates a circular decorator.
  // ignore: sort_constructors_first
  const CircularDecorator({
    this.progressColor,
    this.backgroundColor,
    this.gradient,
    this.lineWidth,
    this.animation,
    this.animationDuration,
  });

  /// Creates a modern gradient circular decorator.
  // ignore: sort_constructors_first
  factory CircularDecorator.gradient({
    List<Color>? colors,
    double lineWidth = 10,
  }) {
    return CircularDecorator(
      lineWidth: lineWidth,
      animation: true,
      gradient: LinearGradient(
        colors: colors ?? [Colors.blue, Colors.purple],
      ),
    );
  }

  /// Creates a minimal flat circular decorator.
  // ignore: sort_constructors_first
  factory CircularDecorator.minimal({
    Color progressColor = Colors.blue,
    Color backgroundColor = const Color(0xFFE0E0E0),
    double lineWidth = 8,
  }) {
    return CircularDecorator(
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      lineWidth: lineWidth,
      animation: true,
    );
  }

  /// Creates a thick circular decorator.
  // ignore: sort_constructors_first
  factory CircularDecorator.thick({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return CircularDecorator(
      progressColor: progressColor ?? Colors.teal,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      lineWidth: 20,
      animation: true,
    );
  }

  /// Creates a thin circular decorator.
  // ignore: sort_constructors_first
  factory CircularDecorator.thin({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return CircularDecorator(
      progressColor: progressColor ?? Colors.indigo,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      lineWidth: 4,
      animation: true,
    );
  }

  /// Creates a copy of this decorator with the given fields replaced.
  CircularDecorator copyWith({
    Color? progressColor,
    Color? backgroundColor,
    Gradient? gradient,
    double? lineWidth,
    bool? animation,
    Duration? animationDuration,
  }) {
    return CircularDecorator(
      progressColor: progressColor ?? this.progressColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradient: gradient ?? this.gradient,
      lineWidth: lineWidth ?? this.lineWidth,
      animation: animation ?? this.animation,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
}
