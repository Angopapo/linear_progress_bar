import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The position of the radial gauge (which part of the circle to show).
enum RadialGaugePosition {
  /// Full circle (360 degrees).
  full,

  /// Top half circle.
  topHalf,

  /// Bottom half circle.
  bottomHalf,

  /// Left half circle.
  leftHalf,

  /// Right half circle.
  rightHalf,

  /// Top-right quarter.
  topRightQuarter,

  /// Top-left quarter.
  topLeftQuarter,

  /// Bottom-right quarter.
  bottomRightQuarter,

  /// Bottom-left quarter.
  bottomLeftQuarter,

  /// Three quarters (270 degrees) - classic speedometer style.
  threeQuarters,

  /// Custom angle (use startAngle and sweepAngle).
  custom,
}

/// The type of needle pointer.
enum NeedleType {
  /// No needle.
  none,

  /// Simple line needle.
  simple,

  /// Tapered needle (wider at base).
  tapered,

  /// Diamond shaped needle.
  diamond,

  /// Arrow shaped needle.
  arrow,

  /// Needle with a circle at the end.
  circleEnd,
}

/// The type of shape pointer.
enum ShapePointerType {
  /// No shape pointer.
  none,

  /// Circle shape.
  circle,

  /// Triangle shape.
  triangle,

  /// Diamond shape.
  diamond,

  /// Rectangle shape.
  rectangle,

  /// Inverted triangle.
  invertedTriangle,
}

/// Configuration for the needle pointer.
class NeedleConfig {
  /// The type of needle.
  final NeedleType type;

  /// The color of the needle.
  final Color color;

  /// The length of the needle as a fraction of radius (0.0 to 1.0).
  final double length;

  /// The width at the base of the needle.
  final double baseWidth;

  /// The width at the tip of the needle.
  final double tipWidth;

  /// Whether to show the center knob.
  final bool showKnob;

  /// The radius of the center knob.
  final double knobRadius;

  /// The color of the center knob.
  final Color? knobColor;

  /// The inner color of the center knob.
  final Color? knobInnerColor;

  /// The tail length as a fraction of needle length.
  final double tailLength;

  /// Whether to show a shadow.
  final bool showShadow;

  /// Creates a needle configuration.
  const NeedleConfig({
    this.type = NeedleType.tapered,
    this.color = Colors.red,
    this.length = 0.7,
    this.baseWidth = 10.0,
    this.tipWidth = 2.0,
    this.showKnob = true,
    this.knobRadius = 12.0,
    this.knobColor,
    this.knobInnerColor,
    this.tailLength = 0.2,
    this.showShadow = true,
  });
}

/// Configuration for the shape pointer.
class ShapePointerConfig {
  /// The type of shape.
  final ShapePointerType type;

  /// The size of the shape.
  final Size size;

  /// The color of the shape.
  final Color color;

  /// The border color.
  final Color? borderColor;

  /// The border width.
  final double borderWidth;

  /// The offset from the arc (positive = outside, negative = inside).
  final double offset;

  /// Whether to show shadow.
  final bool showShadow;

  /// Creates a shape pointer configuration.
  const ShapePointerConfig({
    this.type = ShapePointerType.triangle,
    this.size = const Size(15, 20),
    this.color = Colors.red,
    this.borderColor,
    this.borderWidth = 0,
    this.offset = 0,
    this.showShadow = true,
  });
}

/// Configuration for range colors on the radial gauge.
class RadialRange {
  /// The start value (0.0 to 1.0).
  final double start;

  /// The end value (0.0 to 1.0).
  final double end;

  /// The color of this range.
  final Color color;

  /// Optional gradient for this range.
  final Gradient? gradient;

  /// The thickness of this range (null = use gauge thickness).
  final double? thickness;

  /// Optional label.
  final String? label;

  /// Creates a radial range.
  const RadialRange({
    required this.start,
    required this.end,
    required this.color,
    this.gradient,
    this.thickness,
    this.label,
  });
}

/// A customizable radial gauge widget.
///
/// This widget displays a radial/circular gauge with extensive customization
/// options including position, needle pointers, shape pointers, value bars,
/// ranges, and interactivity.
///
/// Example usage:
/// ```dart
/// RadialGauge(
///   value: 0.65,
///   position: RadialGaugePosition.threeQuarters,
///   needleConfig: NeedleConfig(type: NeedleType.tapered),
///   showValueBar: true,
///   animation: true,
/// )
/// ```
class RadialGauge extends StatefulWidget {
  /// The current value between 0.0 and 1.0.
  final double value;

  /// The size of the gauge.
  final double size;

  /// The position/shape of the gauge.
  final RadialGaugePosition position;

  /// Custom start angle in degrees (for custom position).
  final double? customStartAngle;

  /// Custom sweep angle in degrees (for custom position).
  final double? customSweepAngle;

  /// The thickness of the gauge track.
  final double trackThickness;

  /// The background color of the track.
  final Color backgroundColor;

  /// Whether to show the value bar.
  final bool showValueBar;

  /// The color of the value bar.
  final Color valueBarColor;

  /// The gradient for the value bar.
  final Gradient? valueBarGradient;

  /// The thickness of the value bar.
  final double? valueBarThickness;

  /// Configuration for the needle pointer.
  final NeedleConfig? needleConfig;

  /// Configuration for the shape pointer.
  final ShapePointerConfig? shapePointerConfig;

  /// Ranges to display on the gauge.
  final List<RadialRange>? ranges;

  /// Whether to animate value changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Callback when animation completes.
  final VoidCallback? onAnimationEnd;

  /// Whether the gauge is interactive.
  final bool interactive;

  /// Callback when the value changes (through interaction).
  final ValueChanged<double>? onValueChanged;

  /// Widget to display in the center.
  final Widget? center;

  /// Whether to show the value as text.
  final bool showValue;

  /// Text style for the value.
  final TextStyle? valueTextStyle;

  /// Custom formatter for the value.
  final String Function(double value)? valueFormatter;

  /// The stroke cap style.
  final StrokeCap strokeCap;

  /// Whether to show scale/ruler marks.
  final bool showScale;

  /// Number of major scale divisions.
  final int scaleDivisions;

  /// Length of scale marks.
  final double scaleMarkLength;

  /// Color of scale marks.
  final Color? scaleColor;

  /// Whether to show scale labels.
  final bool showScaleLabels;

  /// Text style for scale labels.
  final TextStyle? scaleLabelStyle;

  /// Custom label formatter for scale.
  final String Function(double value)? scaleLabelFormatter;

  /// The minimum value for display purposes.
  final double minValue;

  /// The maximum value for display purposes.
  final double maxValue;

  /// Widget to display as title above the gauge.
  final Widget? title;

  /// Widget to display as subtitle below the gauge.
  final Widget? subtitle;

  /// Creates a radial gauge widget.
  const RadialGauge({
    super.key,
    this.value = 0.0,
    this.size = 200.0,
    this.position = RadialGaugePosition.threeQuarters,
    this.customStartAngle,
    this.customSweepAngle,
    this.trackThickness = 15.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.showValueBar = true,
    this.valueBarColor = Colors.blue,
    this.valueBarGradient,
    this.valueBarThickness,
    this.needleConfig,
    this.shapePointerConfig,
    this.ranges,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.onAnimationEnd,
    this.interactive = false,
    this.onValueChanged,
    this.center,
    this.showValue = false,
    this.valueTextStyle,
    this.valueFormatter,
    this.strokeCap = StrokeCap.round,
    this.showScale = false,
    this.scaleDivisions = 10,
    this.scaleMarkLength = 10.0,
    this.scaleColor,
    this.showScaleLabels = false,
    this.scaleLabelStyle,
    this.scaleLabelFormatter,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.title,
    this.subtitle,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  @override
  State<RadialGauge> createState() => _RadialGaugeState();
}

class _RadialGaugeState extends State<RadialGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    if (widget.animation) {
      _animation = Tween<double>(
        begin: 0.0,
        end: widget.value,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ));
      _animationController.forward();
      _animationController.addStatusListener(_onAnimationStatus);
    } else {
      _animation = AlwaysStoppedAnimation(widget.value);
    }
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onAnimationEnd?.call();
    }
  }

  @override
  void didUpdateWidget(RadialGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.animation) {
        _animation = Tween<double>(
          begin: oldWidget.value,
          end: widget.value,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: widget.animationCurve,
        ));
        _animationController
          ..reset()
          ..forward();
      } else {
        _animation = AlwaysStoppedAnimation(widget.value);
      }
    }
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_onAnimationStatus);
    _animationController.dispose();
    super.dispose();
  }

  (double, double) _getAngles() {
    switch (widget.position) {
      case RadialGaugePosition.full:
        return (-90.0, 360.0);
      case RadialGaugePosition.topHalf:
        return (180.0, 180.0);
      case RadialGaugePosition.bottomHalf:
        return (0.0, 180.0);
      case RadialGaugePosition.leftHalf:
        return (90.0, 180.0);
      case RadialGaugePosition.rightHalf:
        return (-90.0, 180.0);
      case RadialGaugePosition.topRightQuarter:
        return (-90.0, 90.0);
      case RadialGaugePosition.topLeftQuarter:
        return (180.0, 90.0);
      case RadialGaugePosition.bottomRightQuarter:
        return (0.0, 90.0);
      case RadialGaugePosition.bottomLeftQuarter:
        return (90.0, 90.0);
      case RadialGaugePosition.threeQuarters:
        return (135.0, 270.0);
      case RadialGaugePosition.custom:
        return (widget.customStartAngle ?? 135.0, widget.customSweepAngle ?? 270.0);
    }
  }

  double _calculateValueFromPosition(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final (startAngle, sweepAngle) = _getAngles();

    // Calculate the angle from the touch point
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    var angle = math.atan2(dy, dx) * 180 / math.pi;

    // Normalize angle
    angle = (angle - startAngle) % 360;
    if (angle < 0) angle += 360;

    // Calculate value
    final value = (angle / sweepAngle).clamp(0.0, 1.0);
    return value;
  }

  void _handleInteraction(Offset localPosition, Size size) {
    if (!widget.interactive) return;
    final value = _calculateValueFromPosition(localPosition, size);
    widget.onValueChanged?.call(value);
  }

  String _formatValue(double value) {
    if (widget.valueFormatter != null) {
      return widget.valueFormatter!(value);
    }
    final displayValue = widget.minValue + (widget.maxValue - widget.minValue) * value;
    return '${displayValue.toInt()}';
  }

  @override
  Widget build(BuildContext context) {
    final (startAngle, sweepAngle) = _getAngles();
    final heightFactor = sweepAngle <= 180 ? 0.6 : 1.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          widget.title!,
          const SizedBox(height: 8),
        ],
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            Widget gauge = SizedBox(
              width: widget.size,
              height: widget.size * heightFactor,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(widget.size, widget.size),
                    painter: _RadialGaugePainter(
                      value: _animation.value,
                      startAngle: startAngle,
                      sweepAngle: sweepAngle,
                      trackThickness: widget.trackThickness,
                      backgroundColor: widget.backgroundColor,
                      showValueBar: widget.showValueBar,
                      valueBarColor: widget.valueBarColor,
                      valueBarGradient: widget.valueBarGradient,
                      valueBarThickness: widget.valueBarThickness,
                      needleConfig: widget.needleConfig,
                      shapePointerConfig: widget.shapePointerConfig,
                      ranges: widget.ranges,
                      strokeCap: widget.strokeCap,
                      showScale: widget.showScale,
                      scaleDivisions: widget.scaleDivisions,
                      scaleMarkLength: widget.scaleMarkLength,
                      scaleColor: widget.scaleColor,
                    ),
                  ),
                  if (widget.center != null)
                    widget.center!
                  else if (widget.showValue)
                    Text(
                      _formatValue(_animation.value),
                      style: widget.valueTextStyle ??
                          TextStyle(
                            fontSize: widget.size * 0.15,
                            fontWeight: FontWeight.bold,
                            color: widget.valueBarColor,
                          ),
                    ),
                ],
              ),
            );

            if (widget.interactive) {
              gauge = GestureDetector(
                onTapDown: (details) => _handleInteraction(
                  details.localPosition,
                  Size(widget.size, widget.size),
                ),
                onPanUpdate: (details) => _handleInteraction(
                  details.localPosition,
                  Size(widget.size, widget.size),
                ),
                child: gauge,
              );
            }

            return gauge;
          },
        ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 4),
          widget.subtitle!,
        ],
      ],
    );
  }
}

class _RadialGaugePainter extends CustomPainter {
  final double value;
  final double startAngle;
  final double sweepAngle;
  final double trackThickness;
  final Color backgroundColor;
  final bool showValueBar;
  final Color valueBarColor;
  final Gradient? valueBarGradient;
  final double? valueBarThickness;
  final NeedleConfig? needleConfig;
  final ShapePointerConfig? shapePointerConfig;
  final List<RadialRange>? ranges;
  final StrokeCap strokeCap;
  final bool showScale;
  final int scaleDivisions;
  final double scaleMarkLength;
  final Color? scaleColor;

  _RadialGaugePainter({
    required this.value,
    required this.startAngle,
    required this.sweepAngle,
    required this.trackThickness,
    required this.backgroundColor,
    required this.showValueBar,
    required this.valueBarColor,
    this.valueBarGradient,
    this.valueBarThickness,
    this.needleConfig,
    this.shapePointerConfig,
    this.ranges,
    required this.strokeCap,
    required this.showScale,
    required this.scaleDivisions,
    required this.scaleMarkLength,
    this.scaleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - trackThickness) / 2;
    final startRad = startAngle * math.pi / 180;
    final sweepRad = sweepAngle * math.pi / 180;

    // Draw background track
    _drawTrack(canvas, center, radius, startRad, sweepRad);

    // Draw ranges
    if (ranges != null && ranges!.isNotEmpty) {
      _drawRanges(canvas, center, radius, startRad, sweepRad);
    }

    // Draw value bar
    if (showValueBar && value > 0) {
      _drawValueBar(canvas, center, radius, startRad, sweepRad);
    }

    // Draw scale
    if (showScale) {
      _drawScale(canvas, center, radius, startRad, sweepRad);
    }

    // Draw shape pointer
    if (shapePointerConfig != null && shapePointerConfig!.type != ShapePointerType.none) {
      _drawShapePointer(canvas, center, radius, startRad, sweepRad);
    }

    // Draw needle
    if (needleConfig != null && needleConfig!.type != NeedleType.none) {
      _drawNeedle(canvas, center, radius, startRad, sweepRad);
    }
  }

  void _drawTrack(Canvas canvas, Offset center, double radius, double startRad, double sweepRad) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackThickness
      ..strokeCap = strokeCap;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRad,
      sweepRad,
      false,
      paint,
    );
  }

  void _drawRanges(Canvas canvas, Offset center, double radius, double startRad, double sweepRad) {
    for (final range in ranges!) {
      final thickness = range.thickness ?? trackThickness;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness
        ..strokeCap = StrokeCap.butt;

      if (range.gradient != null) {
        final rect = Rect.fromCircle(center: center, radius: radius);
        paint.shader = range.gradient!.createShader(rect);
      } else {
        paint.color = range.color;
      }

      final rangeStart = startRad + sweepRad * range.start;
      final rangeSweep = sweepRad * (range.end - range.start);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        rangeStart,
        rangeSweep,
        false,
        paint,
      );
    }
  }

  void _drawValueBar(Canvas canvas, Offset center, double radius, double startRad, double sweepRad) {
    final thickness = valueBarThickness ?? trackThickness;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = strokeCap;

    if (valueBarGradient != null) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      paint.shader = valueBarGradient!.createShader(rect);
    } else {
      paint.color = valueBarColor;
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRad,
      sweepRad * value,
      false,
      paint,
    );
  }

  void _drawScale(Canvas canvas, Offset center, double radius, double startRad, double sweepRad) {
    final paint = Paint()
      ..color = scaleColor ?? Colors.grey.shade700
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final innerRadius = radius - trackThickness / 2 - 4;
    final outerRadius = innerRadius - scaleMarkLength;

    for (int i = 0; i <= scaleDivisions; i++) {
      final angle = startRad + (sweepRad * i / scaleDivisions);
      final isMajor = i % 2 == 0;
      final currentOuterRadius = isMajor ? outerRadius : innerRadius - scaleMarkLength * 0.6;

      final outer = Offset(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      );
      final inner = Offset(
        center.dx + currentOuterRadius * math.cos(angle),
        center.dy + currentOuterRadius * math.sin(angle),
      );

      canvas.drawLine(inner, outer, paint);
    }
  }

  void _drawShapePointer(Canvas canvas, Offset center, double radius, double startRad, double sweepRad) {
    final config = shapePointerConfig!;
    final angle = startRad + sweepRad * value;
    final pointerRadius = radius + config.offset;

    final pointerCenter = Offset(
      center.dx + pointerRadius * math.cos(angle),
      center.dy + pointerRadius * math.sin(angle),
    );

    // Draw shadow
    if (config.showShadow) {
      final shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      _drawShape(canvas, pointerCenter, config, shadowPaint, angle);
    }

    // Draw shape
    final paint = Paint()
      ..color = config.color
      ..style = PaintingStyle.fill;
    _drawShape(canvas, pointerCenter, config, paint, angle);

    // Draw border
    if (config.borderColor != null && config.borderWidth > 0) {
      final borderPaint = Paint()
        ..color = config.borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = config.borderWidth;
      _drawShape(canvas, pointerCenter, config, borderPaint, angle);
    }
  }

  void _drawShape(Canvas canvas, Offset center, ShapePointerConfig config, Paint paint, double angle) {
    final halfWidth = config.size.width / 2;
    final halfHeight = config.size.height / 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle + math.pi / 2);
    canvas.translate(-center.dx, -center.dy);

    Path path;
    switch (config.type) {
      case ShapePointerType.circle:
        canvas.drawCircle(center, math.min(halfWidth, halfHeight), paint);
        break;

      case ShapePointerType.triangle:
        path = Path();
        path.moveTo(center.dx, center.dy - halfHeight);
        path.lineTo(center.dx - halfWidth, center.dy + halfHeight);
        path.lineTo(center.dx + halfWidth, center.dy + halfHeight);
        path.close();
        canvas.drawPath(path, paint);
        break;

      case ShapePointerType.invertedTriangle:
        path = Path();
        path.moveTo(center.dx, center.dy + halfHeight);
        path.lineTo(center.dx - halfWidth, center.dy - halfHeight);
        path.lineTo(center.dx + halfWidth, center.dy - halfHeight);
        path.close();
        canvas.drawPath(path, paint);
        break;

      case ShapePointerType.diamond:
        path = Path();
        path.moveTo(center.dx, center.dy - halfHeight);
        path.lineTo(center.dx + halfWidth, center.dy);
        path.lineTo(center.dx, center.dy + halfHeight);
        path.lineTo(center.dx - halfWidth, center.dy);
        path.close();
        canvas.drawPath(path, paint);
        break;

      case ShapePointerType.rectangle:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: center, width: config.size.width, height: config.size.height),
            const Radius.circular(2),
          ),
          paint,
        );
        break;

      case ShapePointerType.none:
        break;
    }

    canvas.restore();
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius, double startRad, double sweepRad) {
    final config = needleConfig!;
    final angle = startRad + sweepRad * value;
    final needleLength = radius * config.length;
    final tailLength = needleLength * config.tailLength;

    // Draw shadow
    if (config.showShadow) {
      canvas.save();
      canvas.translate(2, 2);
      _drawNeedleShape(canvas, center, angle, needleLength, tailLength, config,
          Paint()
            ..color = Colors.black.withValues(alpha: 0.2)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3));
      canvas.restore();
    }

    // Draw needle
    _drawNeedleShape(canvas, center, angle, needleLength, tailLength, config,
        Paint()..color = config.color);

    // Draw knob
    if (config.showKnob) {
      // Outer knob
      final knobPaint = Paint()
        ..color = config.knobColor ?? config.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, config.knobRadius, knobPaint);

      // Inner knob
      final innerPaint = Paint()
        ..color = config.knobInnerColor ?? Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, config.knobRadius * 0.4, innerPaint);
    }
  }

  void _drawNeedleShape(Canvas canvas, Offset center, double angle, double length,
      double tailLength, NeedleConfig config, Paint paint) {
    final tipPoint = Offset(
      center.dx + length * math.cos(angle),
      center.dy + length * math.sin(angle),
    );
    final tailPoint = Offset(
      center.dx - tailLength * math.cos(angle),
      center.dy - tailLength * math.sin(angle),
    );

    switch (config.type) {
      case NeedleType.simple:
        paint.strokeWidth = config.tipWidth;
        paint.strokeCap = StrokeCap.round;
        canvas.drawLine(center, tipPoint, paint);
        break;

      case NeedleType.tapered:
        final perpAngle = angle + math.pi / 2;
        final baseOffset = Offset(
          math.cos(perpAngle) * config.baseWidth / 2,
          math.sin(perpAngle) * config.baseWidth / 2,
        );

        final path = Path();
        path.moveTo(tipPoint.dx, tipPoint.dy);
        path.lineTo(center.dx + baseOffset.dx, center.dy + baseOffset.dy);
        path.lineTo(tailPoint.dx, tailPoint.dy);
        path.lineTo(center.dx - baseOffset.dx, center.dy - baseOffset.dy);
        path.close();

        paint.style = PaintingStyle.fill;
        canvas.drawPath(path, paint);
        break;

      case NeedleType.diamond:
        final perpAngle = angle + math.pi / 2;
        final midOffset = Offset(
          math.cos(perpAngle) * config.baseWidth / 2,
          math.sin(perpAngle) * config.baseWidth / 2,
        );
        final midPoint = Offset(
          center.dx + (tipPoint.dx - center.dx) * 0.3,
          center.dy + (tipPoint.dy - center.dy) * 0.3,
        );

        final path = Path();
        path.moveTo(tipPoint.dx, tipPoint.dy);
        path.lineTo(midPoint.dx + midOffset.dx, midPoint.dy + midOffset.dy);
        path.lineTo(tailPoint.dx, tailPoint.dy);
        path.lineTo(midPoint.dx - midOffset.dx, midPoint.dy - midOffset.dy);
        path.close();

        paint.style = PaintingStyle.fill;
        canvas.drawPath(path, paint);
        break;

      case NeedleType.arrow:
        // Arrow body
        final perpAngle = angle + math.pi / 2;
        final bodyWidth = config.baseWidth * 0.4;
        final bodyOffset = Offset(
          math.cos(perpAngle) * bodyWidth / 2,
          math.sin(perpAngle) * bodyWidth / 2,
        );
        final arrowStartPoint = Offset(
          center.dx + (tipPoint.dx - center.dx) * 0.7,
          center.dy + (tipPoint.dy - center.dy) * 0.7,
        );

        final path = Path();
        // Arrow head
        path.moveTo(tipPoint.dx, tipPoint.dy);
        path.lineTo(
          arrowStartPoint.dx + math.cos(perpAngle) * config.baseWidth / 2,
          arrowStartPoint.dy + math.sin(perpAngle) * config.baseWidth / 2,
        );
        // Body
        path.lineTo(arrowStartPoint.dx + bodyOffset.dx, arrowStartPoint.dy + bodyOffset.dy);
        path.lineTo(tailPoint.dx + bodyOffset.dx, tailPoint.dy + bodyOffset.dy);
        path.lineTo(tailPoint.dx - bodyOffset.dx, tailPoint.dy - bodyOffset.dy);
        path.lineTo(arrowStartPoint.dx - bodyOffset.dx, arrowStartPoint.dy - bodyOffset.dy);
        path.lineTo(
          arrowStartPoint.dx - math.cos(perpAngle) * config.baseWidth / 2,
          arrowStartPoint.dy - math.sin(perpAngle) * config.baseWidth / 2,
        );
        path.close();

        paint.style = PaintingStyle.fill;
        canvas.drawPath(path, paint);
        break;

      case NeedleType.circleEnd:
        // Line
        paint.strokeWidth = config.baseWidth * 0.3;
        paint.strokeCap = StrokeCap.round;
        canvas.drawLine(center, tipPoint, paint);

        // Circle at tip
        paint.style = PaintingStyle.fill;
        canvas.drawCircle(tipPoint, config.baseWidth / 2, paint);
        break;

      case NeedleType.none:
        break;
    }
  }

  @override
  bool shouldRepaint(_RadialGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.trackThickness != trackThickness ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.valueBarColor != valueBarColor ||
        oldDelegate.showValueBar != showValueBar;
  }
}
