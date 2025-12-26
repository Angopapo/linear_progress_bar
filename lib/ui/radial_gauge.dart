import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The starting position for the radial gauge.
enum RadialGaugePosition {
  /// Start from the top (12 o'clock).
  top,

  /// Start from the right (3 o'clock).
  right,

  /// Start from the bottom (6 o'clock).
  bottom,

  /// Start from the left (9 o'clock).
  left,

  /// Custom angle (use startAngle parameter).
  custom,
}

/// The type of needle pointer for the radial gauge.
enum NeedlePointerType {
  /// No needle.
  none,

  /// Simple line needle.
  line,

  /// Triangle/tapered needle.
  triangle,

  /// Needle with a circle at the base.
  needleWithCircle,

  /// Diamond-shaped needle.
  diamond,

  /// Arrow-shaped needle.
  arrow,
}

/// The type of shape pointer for the radial gauge.
enum ShapePointerType {
  /// No shape pointer.
  none,

  /// Circle shape.
  circle,

  /// Triangle shape.
  triangle,

  /// Rectangle shape.
  rectangle,

  /// Diamond shape.
  diamond,

  /// Inverted triangle.
  invertedTriangle,

  /// Custom widget.
  custom,
}

/// Configuration for the needle pointer.
class NeedlePointer {
  /// The type of needle.
  final NeedlePointerType type;

  /// The color of the needle.
  final Color color;

  /// The length of the needle as a fraction of radius (0.0 to 1.0).
  final double lengthFactor;

  /// The width of the needle at the base.
  final double width;

  /// The color of the needle knob/circle.
  final Color? knobColor;

  /// The radius of the knob.
  final double knobRadius;

  /// Whether to show an inner knob.
  final bool showInnerKnob;

  /// The color of the inner knob.
  final Color? innerKnobColor;

  /// The radius factor of the inner knob (relative to knobRadius).
  final double innerKnobRadiusFactor;

  /// The gradient for the needle.
  final Gradient? gradient;

  /// Shadow configuration for the needle.
  final Shadow? shadow;

  /// Creates a needle pointer configuration.
  const NeedlePointer({
    this.type = NeedlePointerType.triangle,
    this.color = Colors.red,
    this.lengthFactor = 0.8,
    this.width = 8.0,
    this.knobColor,
    this.knobRadius = 10.0,
    this.showInnerKnob = true,
    this.innerKnobColor,
    this.innerKnobRadiusFactor = 0.5,
    this.gradient,
    this.shadow,
  });
}

/// Configuration for the shape pointer.
class ShapePointer {
  /// The type of shape.
  final ShapePointerType type;

  /// The color of the shape.
  final Color color;

  /// The size of the shape.
  final double size;

  /// The position factor along the radius (0.0 to 1.0).
  final double positionFactor;

  /// The elevation/shadow of the shape.
  final double elevation;

  /// Custom widget for the shape (when type is custom).
  final Widget? customWidget;

  /// The border width of the shape.
  final double borderWidth;

  /// The border color of the shape.
  final Color? borderColor;

  /// Creates a shape pointer configuration.
  const ShapePointer({
    this.type = ShapePointerType.circle,
    this.color = Colors.blue,
    this.size = 12.0,
    this.positionFactor = 0.8,
    this.elevation = 2.0,
    this.customWidget,
    this.borderWidth = 0.0,
    this.borderColor,
  });
}

/// Configuration for the radial value bar.
class RadialValueBar {
  /// The color of the value bar.
  final Color color;

  /// The gradient for the value bar (overrides color).
  final Gradient? gradient;

  /// The width of the value bar.
  final double width;

  /// The start position factor (0.0 to 1.0, relative to radius).
  final double startFactor;

  /// The end position factor (0.0 to 1.0, relative to radius).
  final double endFactor;

  /// The stroke cap style.
  final StrokeCap strokeCap;

  /// Creates a radial value bar configuration.
  const RadialValueBar({
    this.color = Colors.blue,
    this.gradient,
    this.width = 10.0,
    this.startFactor = 0.6,
    this.endFactor = 0.9,
    this.strokeCap = StrokeCap.round,
  });
}

/// Configuration for a range in the radial gauge.
class RadialGaugeRange {
  /// The start value of the range (0.0 to 1.0).
  final double start;

  /// The end value of the range (0.0 to 1.0).
  final double end;

  /// The color of the range.
  final Color color;

  /// The gradient for the range (overrides color).
  final Gradient? gradient;

  /// The width of the range arc.
  final double? width;

  /// The position factor along the radius.
  final double positionFactor;

  /// Optional label for the range.
  final String? label;

  /// Creates a radial gauge range.
  const RadialGaugeRange({
    required this.start,
    required this.end,
    required this.color,
    this.gradient,
    this.width,
    this.positionFactor = 0.75,
    this.label,
  });
}

/// A customizable radial gauge widget.
///
/// This widget displays a radial/circular gauge with support for:
/// - Customizable starting position
/// - Multiple needle pointer styles
/// - Shape pointers
/// - Radial value bar
/// - Range coloring
/// - Animation support
/// - Touch interactivity
///
/// Example usage:
/// ```dart
/// RadialGauge(
///   value: 0.75,
///   size: 200,
///   position: RadialGaugePosition.bottom,
///   needlePointer: NeedlePointer(
///     type: NeedlePointerType.triangle,
///     color: Colors.red,
///   ),
///   valueBar: RadialValueBar(
///     color: Colors.blue,
///   ),
/// )
/// ```
class RadialGauge extends StatefulWidget {
  /// The current value (0.0 to 1.0).
  final double value;

  /// The size of the gauge.
  final double size;

  /// The starting position of the gauge.
  final RadialGaugePosition position;

  /// Custom start angle in degrees (used when position is custom).
  final double? customStartAngle;

  /// The sweep angle in degrees.
  final double sweepAngle;

  /// The background color of the gauge arc.
  final Color backgroundColor;

  /// The width of the background arc.
  final double backgroundWidth;

  /// The needle pointer configuration.
  final NeedlePointer? needlePointer;

  /// The shape pointer configuration.
  final ShapePointer? shapePointer;

  /// The value bar configuration.
  final RadialValueBar? valueBar;

  /// The ranges for the gauge.
  final List<RadialGaugeRange>? ranges;

  /// Whether to animate value changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Whether the gauge is interactive.
  final bool isInteractive;

  /// Callback when value changes through interaction.
  final ValueChanged<double>? onValueChanged;

  /// Callback when interaction starts.
  final VoidCallback? onInteractionStart;

  /// Callback when interaction ends.
  final VoidCallback? onInteractionEnd;

  /// Whether to show tick marks.
  final bool showTicks;

  /// Number of major tick marks.
  final int majorTickCount;

  /// Number of minor ticks between major ticks.
  final int minorTicksPerInterval;

  /// The length of major tick marks.
  final double majorTickLength;

  /// The length of minor tick marks.
  final double minorTickLength;

  /// The color of tick marks.
  final Color tickColor;

  /// Whether to show labels at major ticks.
  final bool showLabels;

  /// The text style for labels.
  final TextStyle? labelStyle;

  /// Custom label formatter.
  final String Function(double value)? labelFormatter;

  /// The minimum value for labels.
  final double minValue;

  /// The maximum value for labels.
  final double maxValue;

  /// Widget to display in the center.
  final Widget? center;

  /// Whether to show the value in the center.
  final bool showValue;

  /// The text style for the value display.
  final TextStyle? valueStyle;

  /// Custom value formatter.
  final String Function(double value)? valueFormatter;

  /// Title widget above the value.
  final Widget? title;

  /// Subtitle widget below the value.
  final Widget? subtitle;

  /// The stroke cap style for the background arc.
  final StrokeCap strokeCap;

  /// Callback when animation completes.
  final VoidCallback? onAnimationEnd;

  /// Creates a radial gauge widget.
  const RadialGauge({
    super.key,
    this.value = 0.0,
    this.size = 200.0,
    this.position = RadialGaugePosition.bottom,
    this.customStartAngle,
    this.sweepAngle = 270.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.backgroundWidth = 15.0,
    this.needlePointer,
    this.shapePointer,
    this.valueBar,
    this.ranges,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.isInteractive = false,
    this.onValueChanged,
    this.onInteractionStart,
    this.onInteractionEnd,
    this.showTicks = false,
    this.majorTickCount = 5,
    this.minorTicksPerInterval = 4,
    this.majorTickLength = 10.0,
    this.minorTickLength = 5.0,
    this.tickColor = Colors.grey,
    this.showLabels = false,
    this.labelStyle,
    this.labelFormatter,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.center,
    this.showValue = true,
    this.valueStyle,
    this.valueFormatter,
    this.title,
    this.subtitle,
    this.strokeCap = StrokeCap.round,
    this.onAnimationEnd,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  @override
  State<RadialGauge> createState() => _RadialGaugeState();
}

class _RadialGaugeState extends State<RadialGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isDragging = false;

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
    if (oldWidget.value != widget.value && !_isDragging) {
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

  double _getStartAngle() {
    if (widget.position == RadialGaugePosition.custom && widget.customStartAngle != null) {
      return widget.customStartAngle! * math.pi / 180;
    }

    switch (widget.position) {
      case RadialGaugePosition.top:
        return -math.pi / 2 - widget.sweepAngle * math.pi / 360;
      case RadialGaugePosition.right:
        return -widget.sweepAngle * math.pi / 360;
      case RadialGaugePosition.bottom:
        return math.pi / 2 - widget.sweepAngle * math.pi / 360;
      case RadialGaugePosition.left:
        return math.pi - widget.sweepAngle * math.pi / 360;
      case RadialGaugePosition.custom:
        return 135 * math.pi / 180; // Default fallback
    }
  }

  double _getValueFromPosition(Offset position, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dx = position.dx - center.dx;
    final dy = position.dy - center.dy;
    var angle = math.atan2(dy, dx);

    final startAngle = _getStartAngle();
    final sweepAngle = widget.sweepAngle * math.pi / 180;

    // Normalize angle relative to start
    var normalizedAngle = angle - startAngle;
    while (normalizedAngle < 0) normalizedAngle += 2 * math.pi;
    while (normalizedAngle > 2 * math.pi) normalizedAngle -= 2 * math.pi;

    // Calculate value
    var value = normalizedAngle / sweepAngle;
    return value.clamp(0.0, 1.0);
  }

  void _handleInteraction(Offset position, Size size) {
    if (!widget.isInteractive) return;
    final value = _getValueFromPosition(position, size);
    widget.onValueChanged?.call(value);
  }

  String _formatValue(double value) {
    final actualValue = widget.minValue + value * (widget.maxValue - widget.minValue);
    if (widget.valueFormatter != null) {
      return widget.valueFormatter!(actualValue);
    }
    return '${actualValue.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: widget.isInteractive
          ? (details) {
              _isDragging = true;
              widget.onInteractionStart?.call();
              _handleInteraction(details.localPosition, Size(widget.size, widget.size));
            }
          : null,
      onPanUpdate: widget.isInteractive
          ? (details) {
              _handleInteraction(details.localPosition, Size(widget.size, widget.size));
            }
          : null,
      onPanEnd: widget.isInteractive
          ? (details) {
              _isDragging = false;
              widget.onInteractionEnd?.call();
            }
          : null,
      onTapDown: widget.isInteractive
          ? (details) {
              _handleInteraction(details.localPosition, Size(widget.size, widget.size));
            }
          : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final displayValue = _isDragging ? widget.value : _animation.value;

          return SizedBox(
            width: widget.size,
            height: widget.size * (widget.sweepAngle <= 180 ? 0.65 : 1.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _RadialGaugePainter(
                    value: displayValue,
                    startAngle: _getStartAngle(),
                    sweepAngle: widget.sweepAngle * math.pi / 180,
                    backgroundColor: widget.backgroundColor,
                    backgroundWidth: widget.backgroundWidth,
                    needlePointer: widget.needlePointer,
                    shapePointer: widget.shapePointer,
                    valueBar: widget.valueBar,
                    ranges: widget.ranges,
                    showTicks: widget.showTicks,
                    majorTickCount: widget.majorTickCount,
                    minorTicksPerInterval: widget.minorTicksPerInterval,
                    majorTickLength: widget.majorTickLength,
                    minorTickLength: widget.minorTickLength,
                    tickColor: widget.tickColor,
                    showLabels: widget.showLabels,
                    labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 10, color: Colors.grey),
                    labelFormatter: (v) {
                      final actual = widget.minValue + v * (widget.maxValue - widget.minValue);
                      if (widget.labelFormatter != null) {
                        return widget.labelFormatter!(actual);
                      }
                      return actual.toStringAsFixed(0);
                    },
                    strokeCap: widget.strokeCap,
                  ),
                ),
                if (widget.center != null)
                  widget.center!
                else if (widget.showValue)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.title != null) widget.title!,
                      Text(
                        _formatValue(displayValue),
                        style: widget.valueStyle ??
                            TextStyle(
                              fontSize: widget.size * 0.15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      ),
                      if (widget.subtitle != null) widget.subtitle!,
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RadialGaugePainter extends CustomPainter {
  final double value;
  final double startAngle;
  final double sweepAngle;
  final Color backgroundColor;
  final double backgroundWidth;
  final NeedlePointer? needlePointer;
  final ShapePointer? shapePointer;
  final RadialValueBar? valueBar;
  final List<RadialGaugeRange>? ranges;
  final bool showTicks;
  final int majorTickCount;
  final int minorTicksPerInterval;
  final double majorTickLength;
  final double minorTickLength;
  final Color tickColor;
  final bool showLabels;
  final TextStyle labelStyle;
  final String Function(double) labelFormatter;
  final StrokeCap strokeCap;

  _RadialGaugePainter({
    required this.value,
    required this.startAngle,
    required this.sweepAngle,
    required this.backgroundColor,
    required this.backgroundWidth,
    this.needlePointer,
    this.shapePointer,
    this.valueBar,
    this.ranges,
    required this.showTicks,
    required this.majorTickCount,
    required this.minorTicksPerInterval,
    required this.majorTickLength,
    required this.minorTickLength,
    required this.tickColor,
    required this.showLabels,
    required this.labelStyle,
    required this.labelFormatter,
    required this.strokeCap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - backgroundWidth) / 2;

    // Draw background arc
    _drawBackgroundArc(canvas, center, radius);

    // Draw ranges
    if (ranges != null) {
      _drawRanges(canvas, center, radius);
    }

    // Draw value bar
    if (valueBar != null && value > 0) {
      _drawValueBar(canvas, center, radius);
    }

    // Draw ticks
    if (showTicks) {
      _drawTicks(canvas, center, radius);
    }

    // Draw shape pointer
    if (shapePointer != null && shapePointer!.type != ShapePointerType.none) {
      _drawShapePointer(canvas, center, radius);
    }

    // Draw needle pointer
    if (needlePointer != null && needlePointer!.type != NeedlePointerType.none) {
      _drawNeedlePointer(canvas, center, radius);
    }
  }

  void _drawBackgroundArc(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = backgroundWidth
      ..strokeCap = strokeCap;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  void _drawRanges(Canvas canvas, Offset center, double radius) {
    for (final range in ranges!) {
      final rangeRadius = radius * range.positionFactor;
      final rangeWidth = range.width ?? backgroundWidth * 0.8;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = rangeWidth
        ..strokeCap = StrokeCap.butt;

      if (range.gradient != null) {
        final rect = Rect.fromCircle(center: center, radius: rangeRadius);
        paint.shader = range.gradient!.createShader(rect);
      } else {
        paint.color = range.color.withValues(alpha: 0.5);
      }

      final rangeStartAngle = startAngle + sweepAngle * range.start;
      final rangeSweepAngle = sweepAngle * (range.end - range.start);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: rangeRadius),
        rangeStartAngle,
        rangeSweepAngle,
        false,
        paint,
      );
    }
  }

  void _drawValueBar(Canvas canvas, Offset center, double radius) {
    final bar = valueBar!;
    final innerRadius = radius * bar.startFactor;
    final outerRadius = radius * bar.endFactor;
    final barRadius = (innerRadius + outerRadius) / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = bar.width
      ..strokeCap = bar.strokeCap;

    if (bar.gradient != null) {
      final rect = Rect.fromCircle(center: center, radius: barRadius);
      paint.shader = bar.gradient!.createShader(rect);
    } else {
      paint.color = bar.color;
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: barRadius),
      startAngle,
      sweepAngle * value,
      false,
      paint,
    );
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final totalTicks = majorTickCount + (majorTickCount - 1) * minorTicksPerInterval;
    final tickRadius = radius - backgroundWidth / 2 - 4;

    for (int i = 0; i <= totalTicks; i++) {
      final isMajor = i % (minorTicksPerInterval + 1) == 0;
      final tickLength = isMajor ? majorTickLength : minorTickLength;
      final normalizedPosition = i / totalTicks;
      final angle = startAngle + sweepAngle * normalizedPosition;

      final outerPoint = Offset(
        center.dx + tickRadius * math.cos(angle),
        center.dy + tickRadius * math.sin(angle),
      );
      final innerPoint = Offset(
        center.dx + (tickRadius - tickLength) * math.cos(angle),
        center.dy + (tickRadius - tickLength) * math.sin(angle),
      );

      canvas.drawLine(innerPoint, outerPoint, tickPaint);

      // Draw labels for major ticks
      if (isMajor && showLabels) {
        final label = labelFormatter(normalizedPosition);
        final textPainter = TextPainter(
          text: TextSpan(text: label, style: labelStyle),
          textDirection: TextDirection.ltr,
        )..layout();

        final labelRadius = tickRadius - tickLength - 8;
        final labelX = center.dx + labelRadius * math.cos(angle) - textPainter.width / 2;
        final labelY = center.dy + labelRadius * math.sin(angle) - textPainter.height / 2;

        textPainter.paint(canvas, Offset(labelX, labelY));
      }
    }
  }

  void _drawShapePointer(Canvas canvas, Offset center, double radius) {
    final pointer = shapePointer!;
    final pointerRadius = radius * pointer.positionFactor;
    final angle = startAngle + sweepAngle * value;

    final pointerCenter = Offset(
      center.dx + pointerRadius * math.cos(angle),
      center.dy + pointerRadius * math.sin(angle),
    );

    final paint = Paint()
      ..color = pointer.color
      ..style = PaintingStyle.fill;

    // Draw shadow
    if (pointer.elevation > 0) {
      final shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.2)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, pointer.elevation);
      canvas.drawCircle(
        pointerCenter.translate(pointer.elevation / 2, pointer.elevation / 2),
        pointer.size / 2,
        shadowPaint,
      );
    }

    switch (pointer.type) {
      case ShapePointerType.none:
      case ShapePointerType.custom:
        break;
      case ShapePointerType.circle:
        canvas.drawCircle(pointerCenter, pointer.size / 2, paint);
        if (pointer.borderWidth > 0 && pointer.borderColor != null) {
          final borderPaint = Paint()
            ..color = pointer.borderColor!
            ..style = PaintingStyle.stroke
            ..strokeWidth = pointer.borderWidth;
          canvas.drawCircle(pointerCenter, pointer.size / 2, borderPaint);
        }
        break;
      case ShapePointerType.triangle:
        _drawShapeTriangle(canvas, pointerCenter, pointer.size, paint, angle, false);
        break;
      case ShapePointerType.invertedTriangle:
        _drawShapeTriangle(canvas, pointerCenter, pointer.size, paint, angle, true);
        break;
      case ShapePointerType.rectangle:
        canvas.save();
        canvas.translate(pointerCenter.dx, pointerCenter.dy);
        canvas.rotate(angle);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: pointer.size, height: pointer.size * 0.6),
            Radius.circular(2),
          ),
          paint,
        );
        canvas.restore();
        break;
      case ShapePointerType.diamond:
        _drawShapeDiamond(canvas, pointerCenter, pointer.size, paint, angle);
        break;
    }
  }

  void _drawShapeTriangle(Canvas canvas, Offset center, double size, Paint paint, double angle, bool inverted) {
    final path = Path();
    final halfSize = size / 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle + (inverted ? math.pi : 0));

    path.moveTo(halfSize, 0);
    path.lineTo(-halfSize, -halfSize);
    path.lineTo(-halfSize, halfSize);
    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawShapeDiamond(Canvas canvas, Offset center, double size, Paint paint, double angle) {
    final path = Path();
    final halfSize = size / 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);

    path.moveTo(halfSize, 0);
    path.lineTo(0, -halfSize);
    path.lineTo(-halfSize, 0);
    path.lineTo(0, halfSize);
    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawNeedlePointer(Canvas canvas, Offset center, double radius) {
    final needle = needlePointer!;
    final needleLength = radius * needle.lengthFactor;
    final angle = startAngle + sweepAngle * value;

    // Draw shadow if specified
    if (needle.shadow != null) {
      final shadowPaint = Paint()
        ..color = needle.shadow!.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, needle.shadow!.blurRadius);
      _drawNeedleShape(canvas, center, needleLength, angle, needle, shadowPaint);
    }

    // Draw needle
    final needlePaint = Paint()
      ..color = needle.color
      ..style = PaintingStyle.fill;

    if (needle.gradient != null) {
      final rect = Rect.fromCenter(center: center, width: needleLength * 2, height: needleLength * 2);
      needlePaint.shader = needle.gradient!.createShader(rect);
    }

    _drawNeedleShape(canvas, center, needleLength, angle, needle, needlePaint);

    // Draw knob
    final knobPaint = Paint()
      ..color = needle.knobColor ?? needle.color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, needle.knobRadius, knobPaint);

    // Draw inner knob
    if (needle.showInnerKnob) {
      final innerKnobPaint = Paint()
        ..color = needle.innerKnobColor ?? Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, needle.knobRadius * needle.innerKnobRadiusFactor, innerKnobPaint);
    }
  }

  void _drawNeedleShape(Canvas canvas, Offset center, double length, double angle, NeedlePointer needle, Paint paint) {
    final needleEnd = Offset(
      center.dx + length * math.cos(angle),
      center.dy + length * math.sin(angle),
    );

    switch (needle.type) {
      case NeedlePointerType.none:
        break;
      case NeedlePointerType.line:
        final linePaint = Paint()
          ..color = paint.color
          ..strokeWidth = needle.width
          ..strokeCap = StrokeCap.round;
        if (paint.shader != null) linePaint.shader = paint.shader;
        canvas.drawLine(center, needleEnd, linePaint);
        break;
      case NeedlePointerType.triangle:
        _drawTriangleNeedle(canvas, center, needleEnd, needle.width, angle, paint);
        break;
      case NeedlePointerType.needleWithCircle:
        _drawTriangleNeedle(canvas, center, needleEnd, needle.width, angle, paint);
        break;
      case NeedlePointerType.diamond:
        _drawDiamondNeedle(canvas, center, length, needle.width, angle, paint);
        break;
      case NeedlePointerType.arrow:
        _drawArrowNeedle(canvas, center, needleEnd, needle.width, angle, paint);
        break;
    }
  }

  void _drawTriangleNeedle(Canvas canvas, Offset center, Offset end, double width, double angle, Paint paint) {
    final path = Path();
    final perpAngle = angle + math.pi / 2;
    final halfWidth = width / 2;

    final baseLeft = Offset(
      center.dx + halfWidth * math.cos(perpAngle),
      center.dy + halfWidth * math.sin(perpAngle),
    );
    final baseRight = Offset(
      center.dx - halfWidth * math.cos(perpAngle),
      center.dy - halfWidth * math.sin(perpAngle),
    );

    path.moveTo(end.dx, end.dy);
    path.lineTo(baseLeft.dx, baseLeft.dy);
    path.lineTo(baseRight.dx, baseRight.dy);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawDiamondNeedle(Canvas canvas, Offset center, double length, double width, double angle, Paint paint) {
    final path = Path();
    final perpAngle = angle + math.pi / 2;
    final halfWidth = width / 2;

    final tip = Offset(
      center.dx + length * math.cos(angle),
      center.dy + length * math.sin(angle),
    );
    final tail = Offset(
      center.dx - length * 0.2 * math.cos(angle),
      center.dy - length * 0.2 * math.sin(angle),
    );
    final left = Offset(
      center.dx + halfWidth * math.cos(perpAngle),
      center.dy + halfWidth * math.sin(perpAngle),
    );
    final right = Offset(
      center.dx - halfWidth * math.cos(perpAngle),
      center.dy - halfWidth * math.sin(perpAngle),
    );

    path.moveTo(tip.dx, tip.dy);
    path.lineTo(left.dx, left.dy);
    path.lineTo(tail.dx, tail.dy);
    path.lineTo(right.dx, right.dy);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawArrowNeedle(Canvas canvas, Offset center, Offset end, double width, double angle, Paint paint) {
    // Draw shaft
    final shaftPaint = Paint()
      ..color = paint.color
      ..strokeWidth = width * 0.4
      ..strokeCap = StrokeCap.round;
    if (paint.shader != null) shaftPaint.shader = paint.shader;
    canvas.drawLine(center, end, shaftPaint);

    // Draw arrowhead
    final arrowSize = width * 1.5;
    final perpAngle = angle + math.pi / 2;

    final arrowLeft = Offset(
      end.dx - arrowSize * math.cos(angle - 0.4) + arrowSize * 0.5 * math.cos(perpAngle),
      end.dy - arrowSize * math.sin(angle - 0.4) + arrowSize * 0.5 * math.sin(perpAngle),
    );
    final arrowRight = Offset(
      end.dx - arrowSize * math.cos(angle + 0.4) - arrowSize * 0.5 * math.cos(perpAngle),
      end.dy - arrowSize * math.sin(angle + 0.4) - arrowSize * 0.5 * math.sin(perpAngle),
    );

    final path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(arrowLeft.dx, arrowLeft.dy)
      ..lineTo(arrowRight.dx, arrowRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RadialGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.backgroundWidth != backgroundWidth ||
        oldDelegate.needlePointer != needlePointer ||
        oldDelegate.shapePointer != shapePointer ||
        oldDelegate.valueBar != valueBar;
  }
}
