import 'package:flutter/material.dart';
import '../ui/linear_gauge.dart';

/// A decorator class for customizing the appearance of [LinearGauge].
///
/// This class provides preset configurations for common linear gauge styles
/// and allows for easy customization.
///
/// Example usage:
/// ```dart
/// final decorator = LinearGaugeDecorator.thermometer();
/// ```
class LinearGaugeDecorator {
  /// The color of the value bar.
  final Color? valueBarColor;

  /// The gradient for the value bar.
  final Gradient? valueBarGradient;

  /// The background color.
  final Color? backgroundColor;

  /// The configuration for the ruler.
  final RulerConfig? rulerConfig;

  /// The configuration for the pointer.
  final PointerConfig? pointerConfig;

  /// The ranges to display.
  final List<LinearGaugeRange>? ranges;

  /// The gauge thickness.
  final double? gaugeThickness;

  /// The border radius.
  final BorderRadius? borderRadius;

  /// Creates a linear gauge decorator.
  const LinearGaugeDecorator({
    this.valueBarColor,
    this.valueBarGradient,
    this.backgroundColor,
    this.rulerConfig,
    this.pointerConfig,
    this.ranges,
    this.gaugeThickness,
    this.borderRadius,
  });

  /// Creates a thermometer-style linear gauge decorator.
  factory LinearGaugeDecorator.thermometer({
    Color? lowColor,
    Color? mediumColor,
    Color? highColor,
  }) {
    return LinearGaugeDecorator(
      gaugeThickness: 25,
      borderRadius: BorderRadius.circular(12.5),
      valueBarGradient: LinearGradient(
        colors: [
          lowColor ?? Colors.blue,
          mediumColor ?? Colors.green,
          highColor ?? Colors.red,
        ],
      ),
      rulerConfig: const RulerConfig(
        style: RulerStyle.graduated,
        majorDivisions: 10,
        minorDivisionsPerMajor: 5,
        majorTickLength: 12,
        minorTickLength: 6,
      ),
      pointerConfig: const PointerConfig(
        type: PointerType.triangle,
        color: Colors.black87,
        size: Size(12, 15),
      ),
    );
  }

  /// Creates a progress bar style linear gauge decorator.
  factory LinearGaugeDecorator.progressBar({
    Color? progressColor,
    Color? backgroundColor,
    double thickness = 10,
  }) {
    return LinearGaugeDecorator(
      valueBarColor: progressColor ?? Colors.blue,
      backgroundColor: backgroundColor ?? Colors.grey.shade200,
      gaugeThickness: thickness,
      borderRadius: BorderRadius.circular(thickness / 2),
    );
  }

  /// Creates a battery indicator style linear gauge decorator.
  factory LinearGaugeDecorator.battery({
    Color? lowColor,
    Color? mediumColor,
    Color? highColor,
  }) {
    return LinearGaugeDecorator(
      gaugeThickness: 30,
      borderRadius: BorderRadius.circular(4),
      backgroundColor: Colors.grey.shade300,
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
          color: highColor ?? Colors.green,
        ),
      ],
    );
  }

  /// Creates a slider-style linear gauge decorator.
  factory LinearGaugeDecorator.slider({
    Color? trackColor,
    Color? activeColor,
  }) {
    return LinearGaugeDecorator(
      valueBarColor: activeColor ?? Colors.blue,
      backgroundColor: trackColor ?? Colors.grey.shade300,
      gaugeThickness: 8,
      borderRadius: BorderRadius.circular(4),
      pointerConfig: PointerConfig(
        type: PointerType.circle,
        color: activeColor ?? Colors.blue,
        size: const Size(20, 20),
        position: PointerPosition.center,
        showShadow: true,
        borderColor: Colors.white,
        borderWidth: 2,
      ),
    );
  }

  /// Creates a ruler/scale style linear gauge decorator.
  factory LinearGaugeDecorator.ruler({
    Color? scaleColor,
  }) {
    return LinearGaugeDecorator(
      gaugeThickness: 4,
      backgroundColor: scaleColor ?? Colors.grey.shade400,
      valueBarColor: Colors.transparent,
      rulerConfig: RulerConfig(
        style: RulerStyle.labeled,
        majorDivisions: 10,
        minorDivisionsPerMajor: 10,
        majorTickLength: 20,
        minorTickLength: 10,
        tickColor: scaleColor ?? Colors.grey.shade600,
      ),
    );
  }

  /// Creates a health/fitness style linear gauge decorator.
  factory LinearGaugeDecorator.health({
    String type = 'heart_rate', // 'heart_rate', 'steps', 'calories'
  }) {
    Color primaryColor;
    switch (type) {
      case 'heart_rate':
        primaryColor = Colors.red;
        break;
      case 'steps':
        primaryColor = Colors.green;
        break;
      case 'calories':
        primaryColor = Colors.orange;
        break;
      default:
        primaryColor = Colors.blue;
    }

    return LinearGaugeDecorator(
      gaugeThickness: 12,
      borderRadius: BorderRadius.circular(6),
      valueBarGradient: LinearGradient(
        colors: [
          primaryColor.withValues(alpha: 0.5),
          primaryColor,
        ],
      ),
      backgroundColor: primaryColor.withValues(alpha: 0.1),
    );
  }

  /// Creates a copy of this decorator with the given fields replaced.
  LinearGaugeDecorator copyWith({
    Color? valueBarColor,
    Gradient? valueBarGradient,
    Color? backgroundColor,
    RulerConfig? rulerConfig,
    PointerConfig? pointerConfig,
    List<LinearGaugeRange>? ranges,
    double? gaugeThickness,
    BorderRadius? borderRadius,
  }) {
    return LinearGaugeDecorator(
      valueBarColor: valueBarColor ?? this.valueBarColor,
      valueBarGradient: valueBarGradient ?? this.valueBarGradient,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      rulerConfig: rulerConfig ?? this.rulerConfig,
      pointerConfig: pointerConfig ?? this.pointerConfig,
      ranges: ranges ?? this.ranges,
      gaugeThickness: gaugeThickness ?? this.gaugeThickness,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
