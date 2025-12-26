import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The position/style of the radial gauge.
enum RadialGaugePosition {
  /// Full circle gauge (360 degrees).
  full,

  /// Half circle at top.
  halfTop,

  /// Half circle at bottom.
  halfBottom,

  /// Three-quarter gauge (typical speedometer style).
  threeQuarter,

  /// Custom angle configuration.
  custom,
}

/// The type of needle pointer for the radial gauge.
enum NeedlePointerType {
  /// No needle.
  none,

  /// Simple line needle.
  line,

  /// Triangle/arrow needle.
  triangle,

  /// Diamond tip needle.
  diamond,

  /// Tapered needle (thicker at base).
  tapered,

  /// Double-ended needle.
  doubleEnded,

  /// Modern flat needle.
  flat,
}

/// The type of shape pointer for the radial gauge.
enum ShapePointerType {
  /// No shape pointer.
  none,

  /// Circle marker.
  circle,

  /// Triangle marker.
  triangle,

  /// Diamond marker.
  diamond,

  /// Rectangle marker.
  rectangle,

  /// Inverted triangle marker.
  invertedTriangle,

  /// Custom widget marker.
  custom,
}

/// Configuration for the needle pointer.
class RadialNeedlePointer {
  /// The type of needle.
  final NeedlePointerType type;

  /// The length of the needle as a fraction of radius (0.0 to 1.0).
  final double length;

  /// The width of the needle at the base.
  final double width;

  /// The color of the needle.
  final Color color;

  /// Gradient for the needle (overrides color).
  final Gradient? gradient;

  /// The radius of the center knob.
  final double knobRadius;

  /// The color of the center knob.
  final Color knobColor;

  /// Whether the knob has a border.
  final bool knobHasBorder;

  /// The knob border color.
  final Color knobBorderColor;

  /// The knob border width.
  final double knobBorderWidth;

  /// Whether to show a tail (opposite side of needle).
  final bool showTail;

  /// The length of the tail as a fraction of radius.
  final double tailLength;

  /// Whether the needle casts a shadow.
  final bool hasShadow;

  /// Shadow color.
  final Color shadowColor;

  /// Shadow offset.
  final Offset shadowOffset;

  /// Creates a radial needle pointer configuration.
  const RadialNeedlePointer({
    this.type = NeedlePointerType.triangle,
    this.length = 0.7,
    this.width = 10.0,
    this.color = Colors.red,
    this.gradient,
    this.knobRadius = 12.0,
    this.knobColor = Colors.red,
    this.knobHasBorder = true,
    this.knobBorderColor = Colors.white,
    this.knobBorderWidth = 2.0,
    this.showTail = false,
    this.tailLength = 0.2,
    this.hasShadow = true,
    this.shadowColor = Colors.black26,
    this.shadowOffset = const Offset(2, 2),
  });
}

/// Configuration for the shape pointer.
class RadialShapePointer {
  /// The type of shape pointer.
  final ShapePointerType type;

  /// The size of the shape.
  final Size size;

  /// The color of the shape.
  final Color color;

  /// The border color of the shape.
  final Color? borderColor;

  /// The border width.
  final double borderWidth;

  /// The offset from the gauge arc (positive = outward).
  final double offset;

  /// Elevation/shadow for the shape.
  final double elevation;

  /// Custom widget for custom type.
  final Widget? child;

  /// Whether the shape rotates with the value angle.
  final bool rotateWithValue;

  /// Creates a radial shape pointer configuration.
  const RadialShapePointer({
    this.type = ShapePointerType.circle,
    this.size = const Size(16, 16),
    this.color = Colors.blue,
    this.borderColor,
    this.borderWidth = 0,
    this.offset = 0,
    this.elevation = 2,
    this.child,
    this.rotateWithValue = true,
  });
}

/// Configuration for the radial value bar.
class RadialValueBar {
  /// The color of the value bar.
  final Color color;

  /// Gradient for the value bar (overrides color).
  final Gradient? gradient;

  /// The thickness of the value bar.
  final double thickness;

  /// The offset from the main arc (negative = inside, positive = outside).
  final double offset;

  /// The corner style of the value bar.
  final StrokeCap strokeCap;

  /// Creates a radial value bar configuration.
  const RadialValueBar({
    this.color = Colors.blue,
    this.gradient,
    this.thickness = 10.0,
    this.offset = 0,
    this.strokeCap = StrokeCap.round,
  });
}

/// Configuration for a range segment in the radial gauge.
class RadialGaugeRange {
  /// The start value of the range (0.0 to 1.0).
  final double start;

  /// The end value of the range (0.0 to 1.0).
  final double end;

  /// The color of the range.
  final Color color;

  /// The thickness of the range (null = use gauge thickness).
  final double? thickness;

  /// Optional label for the range.
  final String? label;

  /// The offset from the main arc.
  final double offset;

  /// Creates a radial gauge range.
  const RadialGaugeRange({
    required this.start,
    required this.end,
    required this.color,
    this.thickness,
    this.label,
    this.offset = 0,
  });
}

/// Callback for gauge value changes during interaction.
typedef OnRadialGaugeValueChanged = void Function(double value);

/// A comprehensive radial gauge indicator widget.
///
/// This widget displays a radial/circular gauge with extensive customization options
/// including various positions, needle pointers, shape pointers, value bars,
/// ranges, animations, and interactivity.
///
/// Example usage:
/// ```dart
/// RadialGaugeIndicator(
///   value: 0.75,
///   position: RadialGaugePosition.threeQuarter,
///   needlePointer: RadialNeedlePointer(
///     type: NeedlePointerType.tapered,
///     color: Colors.red,
///   ),
///   shapePointer: RadialShapePointer(
///     type: ShapePointerType.circle,
///     color: Colors.orange,
///   ),
///   valueBar: RadialValueBar(
///     gradient: SweepGradient(colors: [Colors.green, Colors.red]),
///   ),
///   ranges: [
///     RadialGaugeRange(start: 0, end: 0.3, color: Colors.green),
///     RadialGaugeRange(start: 0.3, end: 0.7, color: Colors.orange),
///     RadialGaugeRange(start: 0.7, end: 1.0, color: Colors.red),
///   ],
///   interactive: true,
///   onValueChanged: (value) => print('Value: $value'),
/// )
/// ```
class RadialGaugeIndicator extends StatefulWidget {
  /// The current value between 0.0 and 1.0.
  final double value;

  /// The minimum value for display purposes.
  final double minValue;

  /// The maximum value for display purposes.
  final double maxValue;

  /// The size of the gauge.
  final double size;

  /// The position/style of the gauge.
  final RadialGaugePosition position;

  /// Custom start angle in degrees (used with RadialGaugePosition.custom).
  final double? customStartAngle;

  /// Custom sweep angle in degrees (used with RadialGaugePosition.custom).
  final double? customSweepAngle;

  /// The thickness of the gauge arc.
  final double thickness;

  /// The background color of the gauge arc.
  final Color backgroundColor;

  /// Gradient for the background arc.
  final Gradient? backgroundGradient;

  /// The needle pointer configuration.
  final RadialNeedlePointer? needlePointer;

  /// The shape pointer configuration.
  final RadialShapePointer? shapePointer;

  /// The value bar configuration.
  final RadialValueBar? valueBar;

  /// The range segments to display.
  final List<RadialGaugeRange>? ranges;

  /// Whether to show major tick marks.
  final bool showTicks;

  /// The number of major ticks.
  final int majorTickCount;

  /// The length of major ticks.
  final double majorTickLength;

  /// The length of minor ticks.
  final double minorTickLength;

  /// The number of minor ticks between major ticks.
  final int minorTicksPerMajor;

  /// The color of tick marks.
  final Color tickColor;

  /// Whether to show tick labels.
  final bool showLabels;

  /// The text style for labels.
  final TextStyle? labelStyle;

  /// Custom label formatter.
  final String Function(double value)? labelFormatter;

  /// The offset of labels from the gauge.
  final double labelOffset;

  /// Whether to animate value changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Whether the gauge is interactive (draggable).
  final bool interactive;

  /// Callback when value changes during interaction.
  final OnRadialGaugeValueChanged? onValueChanged;

  /// Callback when interaction starts.
  final VoidCallback? onInteractionStart;

  /// Callback when interaction ends.
  final VoidCallback? onInteractionEnd;

  /// Widget to display in the center.
  final Widget? center;

  /// Widget to display at the top.
  final Widget? header;

  /// Widget to display at the bottom.
  final Widget? footer;

  /// Whether to show the current value as text.
  final bool showValue;

  /// The text style for the value.
  final TextStyle? valueTextStyle;

  /// Custom value formatter.
  final String Function(double value)? valueFormatter;

  /// Whether to reverse the gauge direction.
  final bool reversed;

  /// Creates a radial gauge indicator widget.
  const RadialGaugeIndicator({
    super.key,
    this.value = 0.0,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.size = 200.0,
    this.position = RadialGaugePosition.threeQuarter,
    this.customStartAngle,
    this.customSweepAngle,
    this.thickness = 15.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.backgroundGradient,
    this.needlePointer,
    this.shapePointer,
    this.valueBar,
    this.ranges,
    this.showTicks = false,
    this.majorTickCount = 10,
    this.majorTickLength = 12.0,
    this.minorTickLength = 6.0,
    this.minorTicksPerMajor = 5,
    this.tickColor = Colors.black54,
    this.showLabels = false,
    this.labelStyle,
    this.labelFormatter,
    this.labelOffset = 20.0,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.interactive = false,
    this.onValueChanged,
    this.onInteractionStart,
    this.onInteractionEnd,
    this.center,
    this.header,
    this.footer,
    this.showValue = false,
    this.valueTextStyle,
    this.valueFormatter,
    this.reversed = false,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  @override
  State<RadialGaugeIndicator> createState() => _RadialGaugeIndicatorState();
}

class _RadialGaugeIndicatorState extends State<RadialGaugeIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _interactiveValue = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _interactiveValue = widget.value;
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _setupAnimation(0.0, widget.value);
    if (widget.animation) {
      _animationController.forward();
    }
  }

  void _setupAnimation(double begin, double end) {
    _animation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: _animationController, curve: widget.animationCurve),
    );
  }

  @override
  void didUpdateWidget(RadialGaugeIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && !_isDragging) {
      _interactiveValue = widget.value;
      if (widget.animation) {
        _setupAnimation(oldWidget.value, widget.value);
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
    _animationController.dispose();
    super.dispose();
  }

  double get _currentValue {
    if (_isDragging) return _interactiveValue;
    if (widget.animation) return _animation.value;
    return widget.value;
  }

  (double, double) get _angles {
    switch (widget.position) {
      case RadialGaugePosition.full:
        return (-90.0, 360.0);
      case RadialGaugePosition.halfTop:
        return (180.0, 180.0);
      case RadialGaugePosition.halfBottom:
        return (0.0, 180.0);
      case RadialGaugePosition.threeQuarter:
        return (135.0, 270.0);
      case RadialGaugePosition.custom:
        return (widget.customStartAngle ?? 135.0, widget.customSweepAngle ?? 270.0);
    }
  }

  void _handlePanStart(DragStartDetails details) {
    if (!widget.interactive) return;
    _isDragging = true;
    widget.onInteractionStart?.call();
  }

  void _handlePanUpdate(DragUpdateDetails details, Offset center) {
    if (!widget.interactive) return;
    
    final position = details.localPosition;
    final angle = math.atan2(position.dy - center.dy, position.dx - center.dx);
    final (startAngle, sweepAngle) = _angles;
    final startRad = startAngle * math.pi / 180;
    final sweepRad = sweepAngle * math.pi / 180;
    
    var normalizedAngle = angle - startRad;
    if (normalizedAngle < 0) normalizedAngle += 2 * math.pi;
    if (normalizedAngle > 2 * math.pi) normalizedAngle -= 2 * math.pi;
    
    var newValue = normalizedAngle / sweepRad;
    newValue = newValue.clamp(0.0, 1.0);
    
    if (widget.reversed) {
      newValue = 1.0 - newValue;
    }
    
    setState(() {
      _interactiveValue = newValue;
    });
    
    widget.onValueChanged?.call(_interactiveValue);
  }

  void _handlePanEnd(DragEndDetails details) {
    if (!widget.interactive) return;
    _isDragging = false;
    widget.onInteractionEnd?.call();
  }

  String _formatValue(double value) {
    if (widget.valueFormatter != null) {
      return widget.valueFormatter!(value);
    }
    final displayValue = widget.minValue + value * (widget.maxValue - widget.minValue);
    return displayValue.toStringAsFixed(0);
  }

  String _formatLabel(double normalizedValue) {
    if (widget.labelFormatter != null) {
      return widget.labelFormatter!(normalizedValue);
    }
    final displayValue = widget.minValue + normalizedValue * (widget.maxValue - widget.minValue);
    return displayValue.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final (startAngle, sweepAngle) = _angles;
    
    // Calculate height factor for partial gauges
    double heightFactor = 1.0;
    if (sweepAngle <= 180) {
      heightFactor = 0.6;
    } else if (sweepAngle <= 270) {
      heightFactor = 0.85;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.header != null) ...[
          widget.header!,
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onPanStart: _handlePanStart,
          onPanUpdate: (details) => _handlePanUpdate(details, center),
          onPanEnd: _handlePanEnd,
          child: SizedBox(
            width: widget.size,
            height: widget.size * heightFactor,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: Size(widget.size, widget.size),
                      painter: _RadialGaugePainter(
                        value: _currentValue,
                        startAngle: startAngle,
                        sweepAngle: sweepAngle,
                        thickness: widget.thickness,
                        backgroundColor: widget.backgroundColor,
                        backgroundGradient: widget.backgroundGradient,
                        needlePointer: widget.needlePointer,
                        shapePointer: widget.shapePointer,
                        valueBar: widget.valueBar,
                        ranges: widget.ranges,
                        showTicks: widget.showTicks,
                        majorTickCount: widget.majorTickCount,
                        majorTickLength: widget.majorTickLength,
                        minorTickLength: widget.minorTickLength,
                        minorTicksPerMajor: widget.minorTicksPerMajor,
                        tickColor: widget.tickColor,
                        showLabels: widget.showLabels,
                        labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 10, color: Colors.black54),
                        labelFormatter: _formatLabel,
                        labelOffset: widget.labelOffset,
                        reversed: widget.reversed,
                      ),
                    ),
                    if (widget.center != null)
                      widget.center!
                    else if (widget.showValue)
                      Text(
                        _formatValue(_currentValue),
                        style: widget.valueTextStyle ??
                            TextStyle(
                              fontSize: widget.size * 0.12,
                              fontWeight: FontWeight.bold,
                              color: widget.valueBar?.color ?? Colors.blue,
                            ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
        if (widget.footer != null) ...[
          const SizedBox(height: 8),
          widget.footer!,
        ],
      ],
    );
  }
}

class _RadialGaugePainter extends CustomPainter {
  final double value;
  final double startAngle;
  final double sweepAngle;
  final double thickness;
  final Color backgroundColor;
  final Gradient? backgroundGradient;
  final RadialNeedlePointer? needlePointer;
  final RadialShapePointer? shapePointer;
  final RadialValueBar? valueBar;
  final List<RadialGaugeRange>? ranges;
  final bool showTicks;
  final int majorTickCount;
  final double majorTickLength;
  final double minorTickLength;
  final int minorTicksPerMajor;
  final Color tickColor;
  final bool showLabels;
  final TextStyle labelStyle;
  final String Function(double) labelFormatter;
  final double labelOffset;
  final bool reversed;

  _RadialGaugePainter({
    required this.value,
    required this.startAngle,
    required this.sweepAngle,
    required this.thickness,
    required this.backgroundColor,
    this.backgroundGradient,
    this.needlePointer,
    this.shapePointer,
    this.valueBar,
    this.ranges,
    required this.showTicks,
    required this.majorTickCount,
    required this.majorTickLength,
    required this.minorTickLength,
    required this.minorTicksPerMajor,
    required this.tickColor,
    required this.showLabels,
    required this.labelStyle,
    required this.labelFormatter,
    required this.labelOffset,
    required this.reversed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - thickness) / 2;
    final startRad = startAngle * math.pi / 180;
    final sweepRad = sweepAngle * math.pi / 180;
    final actualValue = reversed ? 1.0 - value : value;

    // Draw background arc
    _drawBackgroundArc(canvas, center, radius, startRad, sweepRad);

    // Draw ranges
    if (ranges != null) {
      _drawRanges(canvas, center, radius, startRad, sweepRad);
    }

    // Draw value bar
    if (valueBar != null && actualValue > 0) {
      _drawValueBar(canvas, center, radius, startRad, sweepRad, actualValue);
    }

    // Draw ticks
    if (showTicks) {
      _drawTicks(canvas, center, radius, startRad, sweepRad);
    }

    // Draw labels
    if (showLabels) {
      _drawLabels(canvas, center, radius, startRad, sweepRad);
    }

    // Draw shape pointer
    if (shapePointer != null && shapePointer!.type != ShapePointerType.none) {
      _drawShapePointer(canvas, center, radius, startRad, sweepRad, actualValue);
    }

    // Draw needle pointer
    if (needlePointer != null && needlePointer!.type != NeedlePointerType.none) {
      _drawNeedlePointer(canvas, center, radius, startRad, sweepRad, actualValue);
    }
  }

  void _drawBackgroundArc(
    Canvas canvas,
    Offset center,
    double radius,
    double startRad,
    double sweepRad,
  ) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    if (backgroundGradient != null) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      paint.shader = backgroundGradient!.createShader(rect);
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRad,
      sweepRad,
      false,
      paint,
    );
  }

  void _drawRanges(
    Canvas canvas,
    Offset center,
    double radius,
    double startRad,
    double sweepRad,
  ) {
    for (final range in ranges!) {
      final rangeThickness = range.thickness ?? thickness;
      final rangeRadius = radius + range.offset;
      
      final paint = Paint()
        ..color = range.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = rangeThickness
        ..strokeCap = StrokeCap.butt;

      final rangeStart = startRad + sweepRad * range.start;
      final rangeSweep = sweepRad * (range.end - range.start);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: rangeRadius),
        rangeStart,
        rangeSweep,
        false,
        paint,
      );
    }
  }

  void _drawValueBar(
    Canvas canvas,
    Offset center,
    double radius,
    double startRad,
    double sweepRad,
    double actualValue,
  ) {
    final bar = valueBar!;
    final barRadius = radius + bar.offset;
    
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = bar.thickness
      ..strokeCap = bar.strokeCap;

    if (bar.gradient != null) {
      final rect = Rect.fromCircle(center: center, radius: barRadius);
      paint.shader = bar.gradient!.createShader(rect);
    } else {
      paint.color = bar.color;
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: barRadius),
      startRad,
      sweepRad * actualValue,
      false,
      paint,
    );
  }

  void _drawTicks(
    Canvas canvas,
    Offset center,
    double radius,
    double startRad,
    double sweepRad,
  ) {
    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final totalTicks = majorTickCount * minorTicksPerMajor;
    
    for (int i = 0; i <= totalTicks; i++) {
      final isMajor = i % minorTicksPerMajor == 0;
      final tickLength = isMajor ? majorTickLength : minorTickLength;
      final angle = startRad + sweepRad * i / totalTicks;
      
      final outerRadius = radius + thickness / 2 - 2;
      final innerRadius = outerRadius - tickLength;
      
      final outer = Offset(
        center.dx + outerRadius * math.cos(angle),
        center.dy + outerRadius * math.sin(angle),
      );
      final inner = Offset(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      );
      
      canvas.drawLine(inner, outer, tickPaint);
    }
  }

  void _drawLabels(
    Canvas canvas,
    Offset center,
    double radius,
    double startRad,
    double sweepRad,
  ) {
    for (int i = 0; i <= majorTickCount; i++) {
      final angle = startRad + sweepRad * i / majorTickCount;
      final normalizedValue = i / majorTickCount;
      final label = labelFormatter(normalizedValue);
      
      final textPainter = TextPainter(
        text: TextSpan(text: label, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      
      final labelRadius = radius - thickness / 2 - labelOffset;
      final labelPos = Offset(
        center.dx + labelRadius * math.cos(angle) - textPainter.width / 2,
        center.dy + labelRadius * math.sin(angle) - textPainter.height / 2,
      );
      
      textPainter.paint(canvas, labelPos);
    }
  }

  void _drawShapePointer(
    Canvas canvas,
    Offset center,
    double radius,
    double startRad,
    double sweepRad,
    double actualValue,
  ) {
    final pointer = shapePointer!;
    final angle = startRad + sweepRad * actualValue;
    final pointerRadius = radius + pointer.offset;
    
    final pointerCenter = Offset(
      center.dx + pointerRadius * math.cos(angle),
      center.dy + pointerRadius * math.sin(angle),
    );

    // Draw shadow
    if (pointer.elevation > 0) {
      final shadowPaint = Paint()
        ..color = Colors.black26
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, pointer.elevation);
      _drawShape(canvas, pointerCenter, pointer, shadowPaint, angle, offset: Offset(1, 1));
    }

    // Draw shape
    final paint = Paint()
      ..color = pointer.color
      ..style = PaintingStyle.fill;
    _drawShape(canvas, pointerCenter, pointer, paint, angle);

    // Draw border
    if (pointer.borderColor != null && pointer.borderWidth > 0) {
      final borderPaint = Paint()
        ..color = pointer.borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = pointer.borderWidth;
      _drawShape(canvas, pointerCenter, pointer, borderPaint, angle);
    }
  }

  void _drawShape(
    Canvas canvas,
    Offset center,
    RadialShapePointer pointer,
    Paint paint,
    double angle, {
    Offset offset = Offset.zero,
  }) {
    final adjustedCenter = center + offset;
    
    canvas.save();
    if (pointer.rotateWithValue) {
      canvas.translate(adjustedCenter.dx, adjustedCenter.dy);
      canvas.rotate(angle + math.pi / 2);
      canvas.translate(-adjustedCenter.dx, -adjustedCenter.dy);
    }

    switch (pointer.type) {
      case ShapePointerType.circle:
        final radius = math.min(pointer.size.width, pointer.size.height) / 2;
        canvas.drawCircle(adjustedCenter, radius, paint);
        break;
      case ShapePointerType.triangle:
        _drawTriangle(canvas, adjustedCenter, pointer.size, paint, false);
        break;
      case ShapePointerType.invertedTriangle:
        _drawTriangle(canvas, adjustedCenter, pointer.size, paint, true);
        break;
      case ShapePointerType.diamond:
        _drawDiamond(canvas, adjustedCenter, pointer.size, paint);
        break;
      case ShapePointerType.rectangle:
        final rect = Rect.fromCenter(
          center: adjustedCenter,
          width: pointer.size.width,
          height: pointer.size.height,
        );
        canvas.drawRect(rect, paint);
        break;
      default:
        break;
    }

    canvas.restore();
  }

  void _drawTriangle(Canvas canvas, Offset center, Size size, Paint paint, bool inverted) {
    final path = Path();
    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;
    
    if (inverted) {
      path.moveTo(center.dx, center.dy + halfHeight);
      path.lineTo(center.dx - halfWidth, center.dy - halfHeight);
      path.lineTo(center.dx + halfWidth, center.dy - halfHeight);
    } else {
      path.moveTo(center.dx, center.dy - halfHeight);
      path.lineTo(center.dx - halfWidth, center.dy + halfHeight);
      path.lineTo(center.dx + halfWidth, center.dy + halfHeight);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawDiamond(Canvas canvas, Offset center, Size size, Paint paint) {
    final path = Path();
    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;
    
    path.moveTo(center.dx, center.dy - halfHeight);
    path.lineTo(center.dx + halfWidth, center.dy);
    path.lineTo(center.dx, center.dy + halfHeight);
    path.lineTo(center.dx - halfWidth, center.dy);
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawNeedlePointer(
    Canvas canvas,
    Offset center,
    double radius,
    double startRad,
    double sweepRad,
    double actualValue,
  ) {
    final needle = needlePointer!;
    final angle = startRad + sweepRad * actualValue;
    final needleLength = radius * needle.length;

    // Draw shadow
    if (needle.hasShadow) {
      final shadowPaint = Paint()
        ..color = needle.shadowColor
        ..strokeWidth = needle.width
        ..strokeCap = StrokeCap.round;
      _drawNeedle(canvas, center, needleLength, angle, needle, shadowPaint, needle.shadowOffset);
    }

    // Draw tail if enabled
    if (needle.showTail) {
      final tailLength = radius * needle.tailLength;
      final tailAngle = angle + math.pi;
      final tailPaint = Paint()
        ..color = needle.color.withValues(alpha: 0.5)
        ..strokeWidth = needle.width * 0.6
        ..strokeCap = StrokeCap.round;
      
      final tailEnd = Offset(
        center.dx + tailLength * math.cos(tailAngle),
        center.dy + tailLength * math.sin(tailAngle),
      );
      canvas.drawLine(center, tailEnd, tailPaint);
    }

    // Draw needle
    final paint = Paint()
      ..color = needle.color
      ..strokeWidth = needle.width
      ..strokeCap = StrokeCap.round;
    
    if (needle.gradient != null) {
      final rect = Rect.fromCenter(center: center, width: needleLength * 2, height: needleLength * 2);
      paint.shader = needle.gradient!.createShader(rect);
    }

    _drawNeedle(canvas, center, needleLength, angle, needle, paint, Offset.zero);

    // Draw knob
    _drawKnob(canvas, center, needle);
  }

  void _drawNeedle(
    Canvas canvas,
    Offset center,
    double length,
    double angle,
    RadialNeedlePointer needle,
    Paint paint,
    Offset offset,
  ) {
    final adjustedCenter = center + offset;
    final end = Offset(
      adjustedCenter.dx + length * math.cos(angle),
      adjustedCenter.dy + length * math.sin(angle),
    );

    switch (needle.type) {
      case NeedlePointerType.line:
        canvas.drawLine(adjustedCenter, end, paint);
        break;
      case NeedlePointerType.triangle:
        _drawTriangleNeedle(canvas, adjustedCenter, end, needle.width, paint);
        break;
      case NeedlePointerType.tapered:
        _drawTaperedNeedle(canvas, adjustedCenter, end, needle.width, paint);
        break;
      case NeedlePointerType.diamond:
        _drawDiamondNeedle(canvas, adjustedCenter, end, needle.width, paint);
        break;
      case NeedlePointerType.flat:
        _drawFlatNeedle(canvas, adjustedCenter, end, needle.width, paint);
        break;
      case NeedlePointerType.doubleEnded:
        final oppositeEnd = Offset(
          adjustedCenter.dx - length * 0.3 * math.cos(angle),
          adjustedCenter.dy - length * 0.3 * math.sin(angle),
        );
        canvas.drawLine(oppositeEnd, end, paint);
        break;
      default:
        canvas.drawLine(adjustedCenter, end, paint);
    }
  }

  void _drawTriangleNeedle(Canvas canvas, Offset center, Offset tip, double width, Paint paint) {
    final angle = math.atan2(tip.dy - center.dy, tip.dx - center.dx);
    final perpAngle = angle + math.pi / 2;
    
    final path = Path();
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(
      center.dx + width / 2 * math.cos(perpAngle),
      center.dy + width / 2 * math.sin(perpAngle),
    );
    path.lineTo(
      center.dx - width / 2 * math.cos(perpAngle),
      center.dy - width / 2 * math.sin(perpAngle),
    );
    path.close();
    
    canvas.drawPath(path, paint..style = PaintingStyle.fill);
  }

  void _drawTaperedNeedle(Canvas canvas, Offset center, Offset tip, double width, Paint paint) {
    final angle = math.atan2(tip.dy - center.dy, tip.dx - center.dx);
    final perpAngle = angle + math.pi / 2;
    final length = (tip - center).distance;
    
    final midPoint = Offset(
      center.dx + length * 0.7 * math.cos(angle),
      center.dy + length * 0.7 * math.sin(angle),
    );
    
    final path = Path();
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(
      midPoint.dx + width * 0.3 * math.cos(perpAngle),
      midPoint.dy + width * 0.3 * math.sin(perpAngle),
    );
    path.lineTo(
      center.dx + width / 2 * math.cos(perpAngle),
      center.dy + width / 2 * math.sin(perpAngle),
    );
    path.lineTo(
      center.dx - width / 2 * math.cos(perpAngle),
      center.dy - width / 2 * math.sin(perpAngle),
    );
    path.lineTo(
      midPoint.dx - width * 0.3 * math.cos(perpAngle),
      midPoint.dy - width * 0.3 * math.sin(perpAngle),
    );
    path.close();
    
    canvas.drawPath(path, paint..style = PaintingStyle.fill);
  }

  void _drawDiamondNeedle(Canvas canvas, Offset center, Offset tip, double width, Paint paint) {
    final angle = math.atan2(tip.dy - center.dy, tip.dx - center.dx);
    final perpAngle = angle + math.pi / 2;
    final length = (tip - center).distance;
    
    final midPoint = Offset(
      center.dx + length * 0.4 * math.cos(angle),
      center.dy + length * 0.4 * math.sin(angle),
    );
    
    final path = Path();
    path.moveTo(tip.dx, tip.dy);
    path.lineTo(
      midPoint.dx + width / 2 * math.cos(perpAngle),
      midPoint.dy + width / 2 * math.sin(perpAngle),
    );
    path.lineTo(center.dx, center.dy);
    path.lineTo(
      midPoint.dx - width / 2 * math.cos(perpAngle),
      midPoint.dy - width / 2 * math.sin(perpAngle),
    );
    path.close();
    
    canvas.drawPath(path, paint..style = PaintingStyle.fill);
  }

  void _drawFlatNeedle(Canvas canvas, Offset center, Offset tip, double width, Paint paint) {
    final angle = math.atan2(tip.dy - center.dy, tip.dx - center.dx);
    final perpAngle = angle + math.pi / 2;
    
    final path = Path();
    path.moveTo(
      tip.dx + width * 0.15 * math.cos(perpAngle),
      tip.dy + width * 0.15 * math.sin(perpAngle),
    );
    path.lineTo(
      tip.dx - width * 0.15 * math.cos(perpAngle),
      tip.dy - width * 0.15 * math.sin(perpAngle),
    );
    path.lineTo(
      center.dx - width / 2 * math.cos(perpAngle),
      center.dy - width / 2 * math.sin(perpAngle),
    );
    path.lineTo(
      center.dx + width / 2 * math.cos(perpAngle),
      center.dy + width / 2 * math.sin(perpAngle),
    );
    path.close();
    
    canvas.drawPath(path, paint..style = PaintingStyle.fill);
  }

  void _drawKnob(Canvas canvas, Offset center, RadialNeedlePointer needle) {
    // Outer knob
    final knobPaint = Paint()
      ..color = needle.knobColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, needle.knobRadius, knobPaint);

    // Border
    if (needle.knobHasBorder) {
      final borderPaint = Paint()
        ..color = needle.knobBorderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = needle.knobBorderWidth;
      canvas.drawCircle(center, needle.knobRadius, borderPaint);
    }

    // Inner highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(center.dx - needle.knobRadius * 0.2, center.dy - needle.knobRadius * 0.2),
      needle.knobRadius * 0.3,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(_RadialGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.thickness != thickness ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
