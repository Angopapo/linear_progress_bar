import 'package:flutter/material.dart';
import '../ui/radial_gauge.dart';

/// A decorator class for customizing the appearance of [RadialGauge].
///
/// This class provides preset configurations for common radial gauge styles
/// and allows for easy customization.
///
/// Example usage:
/// ```dart
/// final decorator = RadialGaugeDecorator.speedometer();
/// ```
class RadialGaugeDecorator {
  /// The color of the value bar.
  final Color? valueBarColor;

  /// The gradient for the value bar.
  final Gradient? valueBarGradient;

  /// The background color.
  final Color? backgroundColor;

  /// The gauge position.
  final RadialGaugePosition? position;

  /// The configuration for the needle.
  final NeedleConfig? needleConfig;

  /// The configuration for the shape pointer.
  final ShapePointerConfig? shapePointerConfig;

  /// The ranges to display.
  final List<RadialRange>? ranges;

  /// The track thickness.
  final double? trackThickness;

  /// Whether to show the scale.
  final bool? showScale;

  /// Number of scale divisions.
  final int? scaleDivisions;

  /// Creates a radial gauge decorator.
  const RadialGaugeDecorator({
    this.valueBarColor,
    this.valueBarGradient,
    this.backgroundColor,
    this.position,
    this.needleConfig,
    this.shapePointerConfig,
    this.ranges,
    this.trackThickness,
    this.showScale,
    this.scaleDivisions,
  });

  /// Creates a speedometer-style radial gauge decorator.
  factory RadialGaugeDecorator.speedometer({
    Color? lowColor,
    Color? mediumColor,
    Color? highColor,
    double maxSpeed = 200,
  }) {
    return RadialGaugeDecorator(
      position: RadialGaugePosition.threeQuarters,
      trackThickness: 20,
      showScale: true,
      scaleDivisions: 10,
      needleConfig: const NeedleConfig(
        type: NeedleType.tapered,
        color: Colors.red,
        length: 0.75,
        baseWidth: 12,
        tipWidth: 2,
        showKnob: true,
        knobRadius: 15,
        knobColor: Colors.red,
        knobInnerColor: Colors.white,
      ),
      ranges: [
        RadialRange(
          start: 0.0,
          end: 0.4,
          color: lowColor ?? Colors.green,
        ),
        RadialRange(
          start: 0.4,
          end: 0.7,
          color: mediumColor ?? Colors.yellow,
        ),
        RadialRange(
          start: 0.7,
          end: 1.0,
          color: highColor ?? Colors.red,
        ),
      ],
    );
  }

  /// Creates a tachometer-style radial gauge decorator.
  factory RadialGaugeDecorator.tachometer({
    Color? normalColor,
    Color? redlineColor,
    double redlineStart = 0.8,
  }) {
    return RadialGaugeDecorator(
      position: RadialGaugePosition.threeQuarters,
      trackThickness: 15,
      showScale: true,
      scaleDivisions: 8,
      needleConfig: const NeedleConfig(
        type: NeedleType.arrow,
        color: Colors.orange,
        length: 0.7,
        baseWidth: 8,
        showKnob: true,
        knobRadius: 12,
        knobColor: Colors.black87,
      ),
      ranges: [
        RadialRange(
          start: 0.0,
          end: redlineStart,
          color: normalColor ?? Colors.grey.shade400,
        ),
        RadialRange(
          start: redlineStart,
          end: 1.0,
          color: redlineColor ?? Colors.red,
        ),
      ],
    );
  }

  /// Creates a fuel gauge style radial gauge decorator.
  factory RadialGaugeDecorator.fuelGauge({
    Color? emptyColor,
    Color? fullColor,
  }) {
    return RadialGaugeDecorator(
      position: RadialGaugePosition.topHalf,
      trackThickness: 12,
      showScale: true,
      scaleDivisions: 4,
      needleConfig: const NeedleConfig(
        type: NeedleType.simple,
        color: Colors.black87,
        length: 0.6,
        baseWidth: 4,
        showKnob: true,
        knobRadius: 8,
      ),
      valueBarGradient: LinearGradient(
        colors: [
          emptyColor ?? Colors.red,
          Colors.yellow,
          fullColor ?? Colors.green,
        ],
      ),
    );
  }

  /// Creates a temperature gauge style radial gauge decorator.
  factory RadialGaugeDecorator.temperature({
    Color? coldColor,
    Color? normalColor,
    Color? hotColor,
  }) {
    return RadialGaugeDecorator(
      position: RadialGaugePosition.topHalf,
      trackThickness: 15,
      showScale: true,
      scaleDivisions: 5,
      needleConfig: const NeedleConfig(
        type: NeedleType.tapered,
        color: Colors.black87,
        length: 0.65,
        baseWidth: 10,
        showKnob: true,
        knobRadius: 10,
      ),
      ranges: [
        RadialRange(
          start: 0.0,
          end: 0.3,
          color: coldColor ?? Colors.blue,
        ),
        RadialRange(
          start: 0.3,
          end: 0.7,
          color: normalColor ?? Colors.green,
        ),
        RadialRange(
          start: 0.7,
          end: 1.0,
          color: hotColor ?? Colors.red,
        ),
      ],
    );
  }

  /// Creates a modern minimal radial gauge decorator.
  factory RadialGaugeDecorator.minimal({
    Color? progressColor,
    Color? backgroundColor,
  }) {
    return RadialGaugeDecorator(
      position: RadialGaugePosition.threeQuarters,
      trackThickness: 8,
      valueBarColor: progressColor ?? Colors.blue,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      showScale: false,
      shapePointerConfig: ShapePointerConfig(
        type: ShapePointerType.circle,
        color: progressColor ?? Colors.blue,
        size: const Size(16, 16),
        offset: 0,
        borderColor: Colors.white,
        borderWidth: 2,
      ),
    );
  }

  /// Creates a gradient arc radial gauge decorator.
  factory RadialGaugeDecorator.gradientArc({
    List<Color>? colors,
  }) {
    return RadialGaugeDecorator(
      position: RadialGaugePosition.threeQuarters,
      trackThickness: 20,
      showScale: false,
      valueBarGradient: SweepGradient(
        colors: colors ?? [
          Colors.blue,
          Colors.purple,
          Colors.pink,
          Colors.red,
        ],
        startAngle: 0.75 * 3.14159,
        endAngle: 2.25 * 3.14159,
      ),
    );
  }

  /// Creates a compass style radial gauge decorator.
  factory RadialGaugeDecorator.compass() {
    return const RadialGaugeDecorator(
      position: RadialGaugePosition.full,
      trackThickness: 3,
      showScale: true,
      scaleDivisions: 8,
      needleConfig: NeedleConfig(
        type: NeedleType.diamond,
        color: Colors.red,
        length: 0.7,
        baseWidth: 15,
        showKnob: true,
        knobRadius: 10,
        knobColor: Colors.grey,
      ),
    );
  }

  /// Creates a health/fitness style radial gauge decorator.
  factory RadialGaugeDecorator.fitness({
    Color? ringColor,
  }) {
    return RadialGaugeDecorator(
      position: RadialGaugePosition.full,
      trackThickness: 15,
      showScale: false,
      valueBarColor: ringColor ?? Colors.green,
      backgroundColor: (ringColor ?? Colors.green).withValues(alpha: 0.2),
    );
  }

  /// Creates a copy of this decorator with the given fields replaced.
  RadialGaugeDecorator copyWith({
    Color? valueBarColor,
    Gradient? valueBarGradient,
    Color? backgroundColor,
    RadialGaugePosition? position,
    NeedleConfig? needleConfig,
    ShapePointerConfig? shapePointerConfig,
    List<RadialRange>? ranges,
    double? trackThickness,
    bool? showScale,
    int? scaleDivisions,
  }) {
    return RadialGaugeDecorator(
      valueBarColor: valueBarColor ?? this.valueBarColor,
      valueBarGradient: valueBarGradient ?? this.valueBarGradient,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      position: position ?? this.position,
      needleConfig: needleConfig ?? this.needleConfig,
      shapePointerConfig: shapePointerConfig ?? this.shapePointerConfig,
      ranges: ranges ?? this.ranges,
      trackThickness: trackThickness ?? this.trackThickness,
      showScale: showScale ?? this.showScale,
      scaleDivisions: scaleDivisions ?? this.scaleDivisions,
    );
  }
}
