import 'package:flutter/material.dart';
import '../ui/linear_gauge.dart';

/// A decorator class for customizing the appearance of [LinearGauge].
///
/// This class provides preset configurations for common linear gauge styles
/// and allows for easy customization.
///
/// Example usage:
/// ```dart
/// final decorator = LinearGaugeDecorator.thermometer(
///   minTemp: -20,
///   maxTemp: 50,
/// );
/// ```
class LinearGaugeDecorator {
  /// The orientation of the gauge.
  final LinearGaugeOrientation? orientation;

  /// The style of ruler/scale marks.
  final RulerStyle? rulerStyle;

  /// The pointer configuration.
  final LinearGaugePointer? pointer;

  /// Whether to show the value bar.
  final bool? showValueBar;

  /// The color of the value bar.
  final Color? valueBarColor;

  /// The gradient for the value bar.
  final Gradient? valueBarGradient;

  /// The background color.
  final Color? backgroundColor;

  /// The ranges for coloring different sections.
  final List<LinearGaugeRange>? ranges;

  /// Whether the gauge is interactive.
  final bool? isInteractive;

  /// The thickness of the gauge track.
  final double? thickness;

  /// Creates a linear gauge decorator.
  const LinearGaugeDecorator({
    this.orientation,
    this.rulerStyle,
    this.pointer,
    this.showValueBar,
    this.valueBarColor,
    this.valueBarGradient,
    this.backgroundColor,
    this.ranges,
    this.isInteractive,
    this.thickness,
  });

  /// Creates a thermometer-style linear gauge decorator.
  factory LinearGaugeDecorator.thermometer({
    double minTemp = 0,
    double maxTemp = 100,
    Color? coldColor,
    Color? warmColor,
    Color? hotColor,
  }) {
    return LinearGaugeDecorator(
      orientation: LinearGaugeOrientation.vertical,
      rulerStyle: RulerStyle.ticksWithLabels,
      thickness: 16,
      showValueBar: true,
      pointer: const LinearGaugePointer(
        type: LinearPointerType.triangle,
        color: Colors.red,
        position: PointerPosition.end,
      ),
      ranges: [
        LinearGaugeRange(
          start: 0.0,
          end: 0.33,
          color: coldColor ?? Colors.blue,
          label: 'Cold',
        ),
        LinearGaugeRange(
          start: 0.33,
          end: 0.66,
          color: warmColor ?? Colors.orange,
          label: 'Warm',
        ),
        LinearGaugeRange(
          start: 0.66,
          end: 1.0,
          color: hotColor ?? Colors.red,
          label: 'Hot',
        ),
      ],
      valueBarGradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          coldColor ?? Colors.blue,
          warmColor ?? Colors.orange,
          hotColor ?? Colors.red,
        ],
      ),
    );
  }

  /// Creates a progress bar style linear gauge decorator.
  factory LinearGaugeDecorator.progressBar({
    Color? progressColor,
    Color? backgroundColor,
    bool showPointer = false,
  }) {
    return LinearGaugeDecorator(
      orientation: LinearGaugeOrientation.horizontal,
      rulerStyle: RulerStyle.none,
      thickness: 12,
      showValueBar: true,
      valueBarColor: progressColor ?? Colors.blue,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      pointer: showPointer
          ? LinearGaugePointer(
              type: LinearPointerType.circle,
              color: progressColor ?? Colors.blue,
              position: PointerPosition.center,
            )
          : null,
    );
  }

  /// Creates a slider-style linear gauge decorator.
  factory LinearGaugeDecorator.slider({
    Color? trackColor,
    Color? activeColor,
    Color? thumbColor,
  }) {
    return LinearGaugeDecorator(
      orientation: LinearGaugeOrientation.horizontal,
      rulerStyle: RulerStyle.none,
      thickness: 6,
      showValueBar: true,
      valueBarColor: activeColor ?? Colors.blue,
      backgroundColor: trackColor ?? Colors.grey.shade300,
      isInteractive: true,
      pointer: LinearGaugePointer(
        type: LinearPointerType.circle,
        color: thumbColor ?? Colors.white,
        size: 20,
        position: PointerPosition.center,
        isDraggable: true,
      ),
    );
  }

  /// Creates a ruler-style linear gauge decorator.
  factory LinearGaugeDecorator.ruler({
    Color? tickColor,
    bool showLabels = true,
  }) {
    return LinearGaugeDecorator(
      orientation: LinearGaugeOrientation.horizontal,
      rulerStyle: showLabels ? RulerStyle.ticksWithLabels : RulerStyle.ticks,
      thickness: 4,
      showValueBar: false,
      backgroundColor: tickColor ?? Colors.grey.shade400,
      pointer: LinearGaugePointer(
        type: LinearPointerType.invertedTriangle,
        color: Colors.red,
        position: PointerPosition.start,
      ),
    );
  }

  /// Creates a battery indicator style linear gauge decorator.
  factory LinearGaugeDecorator.battery({
    Color? lowColor,
    Color? mediumColor,
    Color? fullColor,
  }) {
    return LinearGaugeDecorator(
      orientation: LinearGaugeOrientation.horizontal,
      rulerStyle: RulerStyle.none,
      thickness: 20,
      showValueBar: true,
      ranges: [
        LinearGaugeRange(
          start: 0.0,
          end: 0.2,
          color: lowColor ?? Colors.red,
        ),
        LinearGaugeRange(
          start: 0.2,
          end: 0.5,
          color: mediumColor ?? Colors.orange,
        ),
        LinearGaugeRange(
          start: 0.5,
          end: 1.0,
          color: fullColor ?? Colors.green,
        ),
      ],
    );
  }

  /// Creates a gradient style linear gauge decorator.
  factory LinearGaugeDecorator.gradient({
    List<Color>? colors,
    LinearGaugeOrientation orientation = LinearGaugeOrientation.horizontal,
  }) {
    final gradientColors = colors ?? [Colors.green, Colors.yellow, Colors.orange, Colors.red];
    return LinearGaugeDecorator(
      orientation: orientation,
      rulerStyle: RulerStyle.ticks,
      thickness: 14,
      showValueBar: true,
      valueBarGradient: LinearGradient(
        begin: orientation == LinearGaugeOrientation.horizontal
            ? Alignment.centerLeft
            : Alignment.bottomCenter,
        end: orientation == LinearGaugeOrientation.horizontal
            ? Alignment.centerRight
            : Alignment.topCenter,
        colors: gradientColors,
      ),
    );
  }

  /// Creates a copy of this decorator with the given fields replaced.
  LinearGaugeDecorator copyWith({
    LinearGaugeOrientation? orientation,
    RulerStyle? rulerStyle,
    LinearGaugePointer? pointer,
    bool? showValueBar,
    Color? valueBarColor,
    Gradient? valueBarGradient,
    Color? backgroundColor,
    List<LinearGaugeRange>? ranges,
    bool? isInteractive,
    double? thickness,
  }) {
    return LinearGaugeDecorator(
      orientation: orientation ?? this.orientation,
      rulerStyle: rulerStyle ?? this.rulerStyle,
      pointer: pointer ?? this.pointer,
      showValueBar: showValueBar ?? this.showValueBar,
      valueBarColor: valueBarColor ?? this.valueBarColor,
      valueBarGradient: valueBarGradient ?? this.valueBarGradient,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      ranges: ranges ?? this.ranges,
      isInteractive: isInteractive ?? this.isInteractive,
      thickness: thickness ?? this.thickness,
    );
  }
}

/// A decorator class for customizing the appearance of [RadialGauge].
class RadialGaugeDecorator {
  /// The starting position of the gauge.
  final dynamic position;

  /// The sweep angle in degrees.
  final double? sweepAngle;

  /// The needle pointer configuration.
  final dynamic needlePointer;

  /// The shape pointer configuration.
  final dynamic shapePointer;

  /// The value bar configuration.
  final dynamic valueBar;

  /// The ranges for the gauge.
  final List<dynamic>? ranges;

  /// Whether to show tick marks.
  final bool? showTicks;

  /// Whether to show labels.
  final bool? showLabels;

  /// Creates a radial gauge decorator.
  const RadialGaugeDecorator({
    this.position,
    this.sweepAngle,
    this.needlePointer,
    this.shapePointer,
    this.valueBar,
    this.ranges,
    this.showTicks,
    this.showLabels,
  });
}

/// A decorator class for customizing linear percent indicators.
class LinearPercentDecorator {
  /// The color of the progress.
  final Color? progressColor;

  /// The background color.
  final Color? backgroundColor;

  /// The gradient for the progress.
  final LinearGradient? gradient;

  /// The height of the progress line.
  final double? lineHeight;

  /// The bar radius.
  final Radius? barRadius;

  /// Whether to animate progress changes.
  final bool? animation;

  /// The animation duration.
  final Duration? animationDuration;

  /// Creates a linear percent decorator.
  const LinearPercentDecorator({
    this.progressColor,
    this.backgroundColor,
    this.gradient,
    this.lineHeight,
    this.barRadius,
    this.animation,
    this.animationDuration,
  });

  /// Creates a modern gradient linear percent decorator.
  factory LinearPercentDecorator.gradient({
    List<Color>? colors,
    double lineHeight = 10,
  }) {
    return LinearPercentDecorator(
      lineHeight: lineHeight,
      animation: true,
      barRadius: Radius.circular(lineHeight / 2),
      gradient: LinearGradient(
        colors: colors ?? [Colors.blue, Colors.purple],
      ),
    );
  }

  /// Creates a minimal flat linear percent decorator.
  factory LinearPercentDecorator.minimal({
    Color progressColor = Colors.blue,
    Color backgroundColor = const Color(0xFFE0E0E0),
    double lineHeight = 6,
  }) {
    return LinearPercentDecorator(
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      lineHeight: lineHeight,
      animation: true,
      barRadius: Radius.circular(lineHeight / 2),
    );
  }

  /// Creates a thick linear percent decorator.
  factory LinearPercentDecorator.thick({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return LinearPercentDecorator(
      progressColor: progressColor ?? Colors.teal,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      lineHeight: 20,
      animation: true,
      barRadius: const Radius.circular(10),
    );
  }

  /// Creates a copy of this decorator with the given fields replaced.
  LinearPercentDecorator copyWith({
    Color? progressColor,
    Color? backgroundColor,
    LinearGradient? gradient,
    double? lineHeight,
    Radius? barRadius,
    bool? animation,
    Duration? animationDuration,
  }) {
    return LinearPercentDecorator(
      progressColor: progressColor ?? this.progressColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradient: gradient ?? this.gradient,
      lineHeight: lineHeight ?? this.lineHeight,
      barRadius: barRadius ?? this.barRadius,
      animation: animation ?? this.animation,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
}
