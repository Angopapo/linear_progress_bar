import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The position/start angle for the radial gauge.
enum RadialGaugePosition {
  /// Start from the top (12 o'clock).
  top,

  /// Start from the right (3 o'clock).
  right,

  /// Start from the bottom (6 o'clock).
  bottom,

  /// Start from the left (9 o'clock).
  left,

  /// Custom angle (use customStartAngle).
  custom,
}

/// Style of needle pointer for the radial gauge.
enum NeedleStyle {
  /// No needle.
  none,

  /// Simple line needle.
  simple,

  /// Tapered needle (wider at base).
  tapered,

  /// Needle with a triangle shape.
  triangle,

  /// Needle with diamond shape.
  diamond,

  /// Modern flat needle.
  flat,

  /// Compass-style needle.
  compass,
}

/// Style of shape pointer for the radial gauge.
enum ShapePointerStyle {
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

  /// Arrow shape.
  arrow,
}

/// Position of shape pointer on the gauge.
enum ShapePointerPosition {
  /// On the outer edge of the gauge.
  outer,

  /// On the inner edge of the gauge.
  inner,

  /// On the center of the gauge track.
  onTrack,
}

/// Configuration for the needle pointer.
class NeedleConfig {
  /// The style of the needle.
  final NeedleStyle style;

  /// The color of the needle.
  final Color color;

  /// The length of the needle as a ratio of the radius (0.0 to 1.0).
  final double lengthRatio;

  /// The width/thickness of the needle at its widest point.
  final double width;

  /// The color of the needle knob/center.
  final Color? knobColor;

  /// The radius of the needle knob.
  final double knobRadius;

  /// Whether to show the knob.
  final bool showKnob;

  /// The tail length ratio (for compass style).
  final double tailLengthRatio;

  /// Gradient for the needle.
  final Gradient? gradient;

  /// Whether the needle casts a shadow.
  final bool hasShadow;

  /// Creates a needle configuration.
  // ignore: sort_constructors_first
  const NeedleConfig({
    this.style = NeedleStyle.tapered,
    this.color = Colors.red,
    this.lengthRatio = 0.8,
    this.width = 8.0,
    this.knobColor,
    this.knobRadius = 10.0,
    this.showKnob = true,
    this.tailLengthRatio = 0.2,
    this.gradient,
    this.hasShadow = true,
  });
}

/// Configuration for the shape pointer.
class ShapePointerConfig {
  /// The style of the shape pointer.
  final ShapePointerStyle style;

  /// The color of the shape pointer.
  final Color color;

  /// The size of the shape pointer.
  final double size;

  /// The position of the shape pointer.
  final ShapePointerPosition position;

  /// Offset from the default position.
  final double offsetRatio;

  /// The border color of the shape.
  final Color? borderColor;

  /// The border width.
  final double borderWidth;

  /// Whether the shape casts a shadow.
  final bool hasShadow;

  /// Creates a shape pointer configuration.
  // ignore: sort_constructors_first
  const ShapePointerConfig({
    this.style = ShapePointerStyle.triangle,
    this.color = Colors.blue,
    this.size = 15.0,
    this.position = ShapePointerPosition.outer,
    this.offsetRatio = 0.0,
    this.borderColor,
    this.borderWidth = 0.0,
    this.hasShadow = true,
  });
}

/// Configuration for a range on the radial gauge.
class RadialGaugeRange {
  /// The start value of the range (0.0 to 1.0).
  final double start;

  /// The end value of the range (0.0 to 1.0).
  final double end;

  /// The color of the range.
  final Color color;

  /// Optional label for the range.
  final String? label;

  /// Width of the range (null uses default track width).
  final double? width;

  /// Offset from the track center (positive = outward).
  final double offsetRatio;

  /// Creates a radial gauge range.
  // ignore: sort_constructors_first
  const RadialGaugeRange({
    required this.start,
    required this.end,
    required this.color,
    this.label,
    this.width,
    this.offsetRatio = 0.0,
  });
}

/// Callback for value changes during interaction.
typedef OnRadialGaugeValueChanged = void Function(double value);

/// A powerful and customizable radial gauge widget.
///
/// This widget displays a radial/circular gauge with extensive customization
/// options including position, needle pointer, shape pointer, value bar,
/// ranges, and interactivity.
///
/// Example usage:
/// ```dart
/// RadialGauge(
///   value: 0.75,
///   size: 250,
///   startAngle: 135,
///   sweepAngle: 270,
///   needle: NeedleConfig(
///     style: NeedleStyle.tapered,
///     color: Colors.red,
///   ),
///   shapePointer: ShapePointerConfig(
///     style: ShapePointerStyle.triangle,
///     position: ShapePointerPosition.outer,
///   ),
///   showValueBar: true,
///   ranges: [
///     RadialGaugeRange(start: 0.0, end: 0.3, color: Colors.green),
///     RadialGaugeRange(start: 0.3, end: 0.7, color: Colors.yellow),
///     RadialGaugeRange(start: 0.7, end: 1.0, color: Colors.red),
///   ],
///   interactive: true,
///   onValueChanged: (value) => print('Value: $value'),
/// )
/// ```
class RadialGauge extends StatefulWidget {
  /// The current value between 0.0 and 1.0.
  final double value;

  /// The size of the gauge (width and height).
  final double size;

  /// The position/start angle of the gauge.
  final RadialGaugePosition position;

  /// Custom start angle in degrees (used when position is custom).
  final double customStartAngle;

  /// The sweep angle in degrees.
  final double sweepAngle;

  /// The width of the gauge track.
  final double trackWidth;

  /// The background color of the gauge track.
  final Color backgroundColor;

  /// The color of the value bar.
  final Color valueColor;

  /// Optional gradient for the value bar.
  final Gradient? valueGradient;

  /// Whether to show the value bar.
  final bool showValueBar;

  /// The needle configuration.
  final NeedleConfig? needle;

  /// The shape pointer configuration.
  final ShapePointerConfig? shapePointer;

  /// The ranges for the gauge.
  final List<RadialGaugeRange>? ranges;

  /// Whether to show ranges behind the value bar.
  final bool showRangesBehind;

  /// Whether to animate value changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Whether the gauge is interactive (draggable/tappable).
  final bool interactive;

  /// Callback when value changes during interaction.
  final OnRadialGaugeValueChanged? onValueChanged;

  /// Callback when interaction starts.
  final VoidCallback? onInteractionStart;

  /// Callback when interaction ends.
  final VoidCallback? onInteractionEnd;

  /// Widget to display in the center.
  final Widget? center;

  /// Whether to show the value as text in the center.
  final bool showValue;

  /// Custom value formatter.
  final String Function(double value)? valueFormatter;

  /// Text style for the value.
  final TextStyle? valueTextStyle;

  /// The minimum value (for display and formatting).
  final double minValue;

  /// The maximum value (for display and formatting).
  final double maxValue;

  /// The stroke cap style.
  final StrokeCap strokeCap;

  /// Whether to show tick marks.
  final bool showTicks;

  /// Number of major ticks.
  final int majorTickCount;

  /// Number of minor ticks between major ticks.
  final int minorTicksPerMajor;

  /// Length of major ticks.
  final double majorTickLength;

  /// Length of minor ticks.
  final double minorTickLength;

  /// Color of tick marks.
  final Color tickColor;

  /// Whether to show tick labels.
  final bool showTickLabels;

  /// Text style for tick labels.
  final TextStyle? tickLabelStyle;

  /// Custom tick label formatter.
  final String Function(double value)? tickLabelFormatter;

  /// Creates a radial gauge widget.
  // ignore: sort_constructors_first
  const RadialGauge({
    super.key,
    this.value = 0.0,
    this.size = 200.0,
    this.position = RadialGaugePosition.bottom,
    this.customStartAngle = 135.0,
    this.sweepAngle = 270.0,
    this.trackWidth = 20.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.valueColor = Colors.blue,
    this.valueGradient,
    this.showValueBar = true,
    this.needle,
    this.shapePointer,
    this.ranges,
    this.showRangesBehind = true,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.interactive = false,
    this.onValueChanged,
    this.onInteractionStart,
    this.onInteractionEnd,
    this.center,
    this.showValue = false,
    this.valueFormatter,
    this.valueTextStyle,
    this.minValue = 0,
    this.maxValue = 100,
    this.strokeCap = StrokeCap.round,
    this.showTicks = false,
    this.majorTickCount = 11,
    this.minorTicksPerMajor = 4,
    this.majorTickLength = 10.0,
    this.minorTickLength = 5.0,
    this.tickColor = Colors.black54,
    this.showTickLabels = false,
    this.tickLabelStyle,
    this.tickLabelFormatter,
  }) : assert(
            value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  @override
  State<RadialGauge> createState() => _RadialGaugeState();
}

class _RadialGaugeState extends State<RadialGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _currentValue = 0.0;
  bool _isDragging = false;

  double get _startAngle {
    switch (widget.position) {
      case RadialGaugePosition.top:
        return -90 - widget.sweepAngle / 2;
      case RadialGaugePosition.right:
        return -widget.sweepAngle / 2;
      case RadialGaugePosition.bottom:
        return 90 - widget.sweepAngle / 2;
      case RadialGaugePosition.left:
        return 180 - widget.sweepAngle / 2;
      case RadialGaugePosition.custom:
        return widget.customStartAngle;
    }
  }

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
      // ignore: discarded_futures
      _animationController.forward();
    } else {
      _animation = AlwaysStoppedAnimation(widget.value);
    }
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(RadialGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && !_isDragging) {
      if (widget.animation) {
        _animation = Tween<double>(
          begin: _currentValue,
          end: widget.value,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: widget.animationCurve,
        ));
        // ignore: discarded_futures
        _animationController.reset();
        // ignore: discarded_futures
        _animationController.forward();
      } else {
        _animation = AlwaysStoppedAnimation(widget.value);
      }
      _currentValue = widget.value;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleInteraction(Offset localPosition) {
    if (!widget.interactive) return;

    final center = Offset(widget.size / 2, widget.size / 2);
    final touchVector = localPosition - center;
    var angle = math.atan2(touchVector.dy, touchVector.dx) * 180 / math.pi;

    // Normalize angle to start from startAngle
    angle = angle - _startAngle;
    if (angle < 0) angle += 360;
    if (angle > 360) angle -= 360;

    // Calculate value from angle
    final newValue = (angle / widget.sweepAngle).clamp(0.0, 1.0);

    setState(() {
      _currentValue = newValue;
      _animation = AlwaysStoppedAnimation(newValue);
    });

    widget.onValueChanged?.call(newValue);
  }

  String _formatValue(double normalizedValue) {
    if (widget.valueFormatter != null) {
      return widget.valueFormatter!(normalizedValue);
    }
    final actualValue =
        widget.minValue + (widget.maxValue - widget.minValue) * normalizedValue;
    return actualValue.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.interactive
          ? (details) {
              widget.onInteractionStart?.call();
              _isDragging = true;
              _handleInteraction(details.localPosition);
            }
          : null,
      onTapUp: widget.interactive
          ? (_) {
              _isDragging = false;
              widget.onInteractionEnd?.call();
            }
          : null,
      onPanStart: widget.interactive
          ? (details) {
              widget.onInteractionStart?.call();
              _isDragging = true;
              _handleInteraction(details.localPosition);
            }
          : null,
      onPanUpdate: widget.interactive
          ? (details) => _handleInteraction(details.localPosition)
          : null,
      onPanEnd: widget.interactive
          ? (_) {
              _isDragging = false;
              widget.onInteractionEnd?.call();
            }
          : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final displayValue = _isDragging ? _currentValue : _animation.value;

          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _RadialGaugePainter(
                    value: displayValue,
                    startAngle: _startAngle,
                    sweepAngle: widget.sweepAngle,
                    trackWidth: widget.trackWidth,
                    backgroundColor: widget.backgroundColor,
                    valueColor: widget.valueColor,
                    valueGradient: widget.valueGradient,
                    showValueBar: widget.showValueBar,
                    needle: widget.needle,
                    shapePointer: widget.shapePointer,
                    ranges: widget.ranges,
                    showRangesBehind: widget.showRangesBehind,
                    strokeCap: widget.strokeCap,
                    showTicks: widget.showTicks,
                    majorTickCount: widget.majorTickCount,
                    minorTicksPerMajor: widget.minorTicksPerMajor,
                    majorTickLength: widget.majorTickLength,
                    minorTickLength: widget.minorTickLength,
                    tickColor: widget.tickColor,
                    showTickLabels: widget.showTickLabels,
                    tickLabelStyle: widget.tickLabelStyle,
                    tickLabelFormatter: widget.tickLabelFormatter ??
                        (v) =>
                            '${(widget.minValue + (widget.maxValue - widget.minValue) * v).toInt()}',
                  ),
                ),
                if (widget.center != null)
                  widget.center!
                else if (widget.showValue)
                  Text(
                    _formatValue(displayValue),
                    style: widget.valueTextStyle ??
                        TextStyle(
                          fontSize: widget.size * 0.12,
                          fontWeight: FontWeight.bold,
                          color: widget.valueColor,
                        ),
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
  final double trackWidth;
  final Color backgroundColor;
  final Color valueColor;
  final Gradient? valueGradient;
  final bool showValueBar;
  final NeedleConfig? needle;
  final ShapePointerConfig? shapePointer;
  final List<RadialGaugeRange>? ranges;
  final bool showRangesBehind;
  final StrokeCap strokeCap;
  final bool showTicks;
  final int majorTickCount;
  final int minorTicksPerMajor;
  final double majorTickLength;
  final double minorTickLength;
  final Color tickColor;
  final bool showTickLabels;
  final TextStyle? tickLabelStyle;
  final String Function(double)? tickLabelFormatter;

  // ignore: sort_constructors_first
  _RadialGaugePainter({
    required this.value,
    required this.startAngle,
    required this.sweepAngle,
    required this.trackWidth,
    required this.backgroundColor,
    required this.valueColor,
    this.valueGradient,
    required this.showValueBar,
    this.needle,
    this.shapePointer,
    this.ranges,
    required this.showRangesBehind,
    required this.strokeCap,
    required this.showTicks,
    required this.majorTickCount,
    required this.minorTicksPerMajor,
    required this.majorTickLength,
    required this.minorTickLength,
    required this.tickColor,
    required this.showTickLabels,
    this.tickLabelStyle,
    this.tickLabelFormatter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - trackWidth) / 2;
    final startRad = startAngle * math.pi / 180;
    final sweepRad = sweepAngle * math.pi / 180;

    // Draw background track
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackWidth
      ..strokeCap = strokeCap;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRad,
      sweepRad,
      false,
      bgPaint,
    );

    // Draw ranges
    if (ranges != null && showRangesBehind) {
      for (final range in ranges!) {
        final rangeWidth = range.width ?? trackWidth;
        final rangeRadius = radius + (range.offsetRatio * trackWidth);

        final rangePaint = Paint()
          ..color = range.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = rangeWidth
          ..strokeCap = StrokeCap.butt;

        final rangeStartRad = startRad + sweepRad * range.start;
        final rangeSweepRad = sweepRad * (range.end - range.start);

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: rangeRadius),
          rangeStartRad,
          rangeSweepRad,
          false,
          rangePaint,
        );
      }
    }

    // Draw value bar
    if (showValueBar && value > 0) {
      final valuePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = trackWidth
        ..strokeCap = strokeCap;

      if (valueGradient != null) {
        final rect = Rect.fromCircle(center: center, radius: radius);
        valuePaint.shader = valueGradient!.createShader(rect);
      } else {
        valuePaint.color = valueColor;
      }

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRad,
        sweepRad * value,
        false,
        valuePaint,
      );
    }

    // Draw ticks
    if (showTicks) {
      _drawTicks(canvas, center, radius, startRad, sweepRad);
    }

    // Draw shape pointer
    if (shapePointer != null && shapePointer!.style != ShapePointerStyle.none) {
      _drawShapePointer(canvas, center, radius, startRad, sweepRad);
    }

    // Draw needle
    if (needle != null && needle!.style != NeedleStyle.none) {
      _drawNeedle(canvas, center, radius, startRad, sweepRad);
    }
  }

  void _drawTicks(Canvas canvas, Offset center, double radius, double startRad,
      double sweepRad) {
    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final totalTicks = (majorTickCount - 1) * (minorTicksPerMajor + 1) + 1;

    for (var i = 0; i < totalTicks; i++) {
      final isMajor = i % (minorTicksPerMajor + 1) == 0;
      final tickLength = isMajor ? majorTickLength : minorTickLength;
      final angle = startRad + (sweepRad * i / (totalTicks - 1));

      final outerRadius = radius + trackWidth / 2 + 2;
      final innerRadius = outerRadius + tickLength;

      final outerPoint = Offset(
        center.dx + outerRadius * math.cos(angle),
        center.dy + outerRadius * math.sin(angle),
      );
      final innerPoint = Offset(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      );

      canvas.drawLine(outerPoint, innerPoint, tickPaint);

      // Draw tick labels for major ticks
      if (isMajor && showTickLabels && tickLabelFormatter != null) {
        final labelValue = i / (totalTicks - 1);
        final labelText = tickLabelFormatter!(labelValue);

        final textPainter = TextPainter(
          text: TextSpan(
            text: labelText,
            style: tickLabelStyle ?? TextStyle(color: tickColor, fontSize: 10),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        final labelRadius = innerRadius + 10;
        final labelOffset = Offset(
          center.dx + labelRadius * math.cos(angle) - textPainter.width / 2,
          center.dy + labelRadius * math.sin(angle) - textPainter.height / 2,
        );
        textPainter.paint(canvas, labelOffset);
      }
    }
  }

  void _drawShapePointer(Canvas canvas, Offset center, double radius,
      double startRad, double sweepRad) {
    if (shapePointer == null) return;

    final angle = startRad + sweepRad * value;

    double pointerRadius;
    switch (shapePointer!.position) {
      case ShapePointerPosition.outer:
        pointerRadius = radius +
            trackWidth / 2 +
            shapePointer!.size / 2 +
            (shapePointer!.offsetRatio * trackWidth);
        break;
      case ShapePointerPosition.inner:
        pointerRadius = radius -
            trackWidth / 2 -
            shapePointer!.size / 2 +
            (shapePointer!.offsetRatio * trackWidth);
        break;
      case ShapePointerPosition.onTrack:
        pointerRadius = radius + (shapePointer!.offsetRatio * trackWidth);
        break;
    }

    final pointerCenter = Offset(
      center.dx + pointerRadius * math.cos(angle),
      center.dy + pointerRadius * math.sin(angle),
    );

    // Draw shadow
    if (shapePointer!.hasShadow) {
      canvas.save();
      canvas.translate(2, 2);
      final shadowPaint = Paint()
        ..color = Colors.black26
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      _drawShape(canvas, pointerCenter, angle, shadowPaint);
      canvas.restore();
    }

    // Draw shape
    final shapePaint = Paint()
      ..color = shapePointer!.color
      ..style = PaintingStyle.fill;
    _drawShape(canvas, pointerCenter, angle, shapePaint);

    // Draw border
    if (shapePointer!.borderColor != null && shapePointer!.borderWidth > 0) {
      final borderPaint = Paint()
        ..color = shapePointer!.borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = shapePointer!.borderWidth;
      _drawShape(canvas, pointerCenter, angle, borderPaint);
    }
  }

  void _drawShape(Canvas canvas, Offset center, double angle, Paint paint) {
    if (shapePointer == null) return;

    final size = shapePointer!.size;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle + math.pi / 2);
    canvas.translate(-center.dx, -center.dy);

    switch (shapePointer!.style) {
      case ShapePointerStyle.circle:
        canvas.drawCircle(center, size / 2, paint);
        break;

      case ShapePointerStyle.triangle:
        final path = Path();
        path.moveTo(center.dx, center.dy - size / 2);
        path.lineTo(center.dx - size / 2, center.dy + size / 2);
        path.lineTo(center.dx + size / 2, center.dy + size / 2);
        path.close();
        canvas.drawPath(path, paint);
        break;

      case ShapePointerStyle.invertedTriangle:
        final path = Path();
        path.moveTo(center.dx, center.dy + size / 2);
        path.lineTo(center.dx - size / 2, center.dy - size / 2);
        path.lineTo(center.dx + size / 2, center.dy - size / 2);
        path.close();
        canvas.drawPath(path, paint);
        break;

      case ShapePointerStyle.diamond:
        final path = Path();
        path.moveTo(center.dx, center.dy - size / 2);
        path.lineTo(center.dx + size / 2, center.dy);
        path.lineTo(center.dx, center.dy + size / 2);
        path.lineTo(center.dx - size / 2, center.dy);
        path.close();
        canvas.drawPath(path, paint);
        break;

      case ShapePointerStyle.rectangle:
        final rect = Rect.fromCenter(
          center: center,
          width: size * 0.6,
          height: size,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(size * 0.1)),
          paint,
        );
        break;

      case ShapePointerStyle.arrow:
        final path = Path();
        path.moveTo(center.dx, center.dy - size / 2);
        path.lineTo(center.dx - size / 3, center.dy);
        path.lineTo(center.dx - size / 6, center.dy);
        path.lineTo(center.dx - size / 6, center.dy + size / 2);
        path.lineTo(center.dx + size / 6, center.dy + size / 2);
        path.lineTo(center.dx + size / 6, center.dy);
        path.lineTo(center.dx + size / 3, center.dy);
        path.close();
        canvas.drawPath(path, paint);
        break;

      case ShapePointerStyle.none:
        break;
    }

    canvas.restore();
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius, double startRad,
      double sweepRad) {
    if (needle == null) return;

    final angle = startRad + sweepRad * value;
    final needleLength = radius * needle!.lengthRatio;

    // Draw shadow
    if (needle!.hasShadow) {
      canvas.save();
      canvas.translate(2, 2);
      final shadowPaint = Paint()
        ..color = Colors.black26
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      _drawNeedleShape(canvas, center, angle, needleLength, shadowPaint);
      canvas.restore();
    }

    // Draw needle
    final needlePaint = Paint()
      ..color = needle!.color
      ..style = PaintingStyle.fill;

    if (needle!.gradient != null) {
      final rect = Rect.fromCenter(
        center: center,
        width: needleLength * 2,
        height: needleLength * 2,
      );
      needlePaint.shader = needle!.gradient!.createShader(rect);
    }

    _drawNeedleShape(canvas, center, angle, needleLength, needlePaint);

    // Draw knob
    if (needle!.showKnob) {
      final knobPaint = Paint()
        ..color = needle!.knobColor ?? needle!.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, needle!.knobRadius, knobPaint);

      // Inner knob highlight
      final innerKnobPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.4)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(center.dx - needle!.knobRadius * 0.2,
            center.dy - needle!.knobRadius * 0.2),
        needle!.knobRadius * 0.4,
        innerKnobPaint,
      );
    }
  }

  void _drawNeedleShape(
      Canvas canvas, Offset center, double angle, double length, Paint paint) {
    if (needle == null) return;

    final endPoint = Offset(
      center.dx + length * math.cos(angle),
      center.dy + length * math.sin(angle),
    );

    switch (needle!.style) {
      case NeedleStyle.simple:
        final linePaint = Paint()
          ..color = paint.color
          ..strokeWidth = needle!.width / 2
          ..strokeCap = StrokeCap.round;
        if (paint.shader != null) linePaint.shader = paint.shader;
        canvas.drawLine(center, endPoint, linePaint);
        break;

      case NeedleStyle.tapered:
        final path = Path();
        final perpAngle = angle + math.pi / 2;
        final baseWidth = needle!.width / 2;

        path.moveTo(
          center.dx + baseWidth * math.cos(perpAngle),
          center.dy + baseWidth * math.sin(perpAngle),
        );
        path.lineTo(endPoint.dx, endPoint.dy);
        path.lineTo(
          center.dx - baseWidth * math.cos(perpAngle),
          center.dy - baseWidth * math.sin(perpAngle),
        );
        path.close();
        canvas.drawPath(path, paint);
        break;

      case NeedleStyle.triangle:
        final path = Path();
        final baseWidth = needle!.width;
        final perpAngle = angle + math.pi / 2;

        path.moveTo(
          center.dx + baseWidth * math.cos(perpAngle),
          center.dy + baseWidth * math.sin(perpAngle),
        );
        path.lineTo(endPoint.dx, endPoint.dy);
        path.lineTo(
          center.dx - baseWidth * math.cos(perpAngle),
          center.dy - baseWidth * math.sin(perpAngle),
        );
        path.close();
        canvas.drawPath(path, paint);
        break;

      case NeedleStyle.diamond:
        final path = Path();
        final baseWidth = needle!.width;
        final midPoint = Offset(
          center.dx + (length * 0.3) * math.cos(angle),
          center.dy + (length * 0.3) * math.sin(angle),
        );
        final perpAngle = angle + math.pi / 2;

        path.moveTo(center.dx, center.dy);
        path.lineTo(
          midPoint.dx + baseWidth * math.cos(perpAngle),
          midPoint.dy + baseWidth * math.sin(perpAngle),
        );
        path.lineTo(endPoint.dx, endPoint.dy);
        path.lineTo(
          midPoint.dx - baseWidth * math.cos(perpAngle),
          midPoint.dy - baseWidth * math.sin(perpAngle),
        );
        path.close();
        canvas.drawPath(path, paint);
        break;

      case NeedleStyle.flat:
        final path = Path();
        final baseWidth = needle!.width;
        final perpAngle = angle + math.pi / 2;

        path.moveTo(
          center.dx + baseWidth * 0.3 * math.cos(perpAngle),
          center.dy + baseWidth * 0.3 * math.sin(perpAngle),
        );
        path.lineTo(
          endPoint.dx + baseWidth * 0.15 * math.cos(perpAngle),
          endPoint.dy + baseWidth * 0.15 * math.sin(perpAngle),
        );
        path.lineTo(
          endPoint.dx - baseWidth * 0.15 * math.cos(perpAngle),
          endPoint.dy - baseWidth * 0.15 * math.sin(perpAngle),
        );
        path.lineTo(
          center.dx - baseWidth * 0.3 * math.cos(perpAngle),
          center.dy - baseWidth * 0.3 * math.sin(perpAngle),
        );
        path.close();
        canvas.drawPath(path, paint);
        break;

      case NeedleStyle.compass:
        final path = Path();
        final baseWidth = needle!.width;
        final perpAngle = angle + math.pi / 2;
        final tailLength = length * needle!.tailLengthRatio;

        final tailPoint = Offset(
          center.dx - tailLength * math.cos(angle),
          center.dy - tailLength * math.sin(angle),
        );

        // Front half (colored)
        path.moveTo(
          center.dx + baseWidth * 0.5 * math.cos(perpAngle),
          center.dy + baseWidth * 0.5 * math.sin(perpAngle),
        );
        path.lineTo(endPoint.dx, endPoint.dy);
        path.lineTo(
          center.dx - baseWidth * 0.5 * math.cos(perpAngle),
          center.dy - baseWidth * 0.5 * math.sin(perpAngle),
        );
        path.close();
        canvas.drawPath(path, paint);

        // Back half (lighter)
        final tailPath = Path();
        final tailPaint = Paint()
          ..color = paint.color.withValues(alpha: 0.5)
          ..style = PaintingStyle.fill;

        tailPath.moveTo(
          center.dx + baseWidth * 0.5 * math.cos(perpAngle),
          center.dy + baseWidth * 0.5 * math.sin(perpAngle),
        );
        tailPath.lineTo(tailPoint.dx, tailPoint.dy);
        tailPath.lineTo(
          center.dx - baseWidth * 0.5 * math.cos(perpAngle),
          center.dy - baseWidth * 0.5 * math.sin(perpAngle),
        );
        tailPath.close();
        canvas.drawPath(tailPath, tailPaint);
        break;

      case NeedleStyle.none:
        break;
    }
  }

  @override
  bool shouldRepaint(_RadialGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.trackWidth != trackWidth ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.valueColor != valueColor;
  }
}
