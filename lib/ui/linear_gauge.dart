import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// Orientation of the linear gauge.
enum LinearGaugeOrientation {
  /// Horizontal gauge (left to right).
  horizontal,

  /// Vertical gauge (bottom to top).
  vertical,
}

/// Style of the ruler/tick marks on the gauge.
enum RulerStyle {
  /// No ruler marks.
  none,

  /// Simple tick marks.
  simple,

  /// Tick marks with labels.
  labeled,

  /// Major and minor tick marks.
  graduated,

  /// Tick marks on both sides.
  bothSides,
}

/// Position of the ruler relative to the gauge.
enum RulerPosition {
  /// Ruler on top (horizontal) or left (vertical).
  start,

  /// Ruler on bottom (horizontal) or right (vertical).
  end,

  /// Ruler on both sides.
  both,
}

/// Style of the pointer on the gauge.
enum PointerStyle {
  /// No pointer.
  none,

  /// Triangle pointer.
  triangle,

  /// Diamond/rhombus pointer.
  diamond,

  /// Arrow pointer.
  arrow,

  /// Circle pointer.
  circle,

  /// Rectangle/bar pointer.
  rectangle,

  /// Inverted triangle pointer.
  invertedTriangle,
}

/// Position of the pointer relative to the value bar.
enum PointerPosition {
  /// Pointer on top (horizontal) or left (vertical).
  start,

  /// Pointer on bottom (horizontal) or right (vertical).
  end,

  /// Pointer centered on the value bar.
  center,
}

/// Configuration for a range on the linear gauge.
class LinearGaugeRange {
  /// The start value of the range (0.0 to 1.0).
  final double start;

  /// The end value of the range (0.0 to 1.0).
  final double end;

  /// The color of the range.
  final Color color;

  /// Optional label for the range.
  final String? label;

  /// The height/width of the range relative to the gauge.
  final double? sizeRatio;

  /// Creates a linear gauge range.
  const LinearGaugeRange({
    required this.start,
    required this.end,
    required this.color,
    this.label,
    this.sizeRatio,
  }) : assert(start >= 0.0 && start <= 1.0, 'start must be between 0.0 and 1.0'),
       assert(end >= 0.0 && end <= 1.0, 'end must be between 0.0 and 1.0'),
       assert(start <= end, 'start must be <= end');
}

/// Configuration for the pointer widget.
class PointerConfig {
  /// The style of the pointer.
  final PointerStyle style;

  /// The color of the pointer.
  final Color color;

  /// The size of the pointer.
  final double size;

  /// The position of the pointer.
  final PointerPosition position;

  /// Custom pointer widget (used when style is none but widget is provided).
  final Widget? customPointer;

  /// The border color of the pointer.
  final Color? borderColor;

  /// The border width of the pointer.
  final double borderWidth;

  /// Whether the pointer casts a shadow.
  final bool hasShadow;

  /// Creates a pointer configuration.
  const PointerConfig({
    this.style = PointerStyle.triangle,
    this.color = Colors.red,
    this.size = 20.0,
    this.position = PointerPosition.start,
    this.customPointer,
    this.borderColor,
    this.borderWidth = 0.0,
    this.hasShadow = true,
  });
}

/// Callback for value changes during interaction.
typedef OnLinearGaugeValueChanged = void Function(double value);

/// A powerful and customizable linear gauge widget.
///
/// This widget displays a linear gauge with extensive customization options
/// including orientation, ruler styles, pointers, value bars, ranges,
/// custom curves, animations, and interactivity.
///
/// Example usage:
/// ```dart
/// LinearGauge(
///   value: 0.65,
///   orientation: LinearGaugeOrientation.horizontal,
///   rulerStyle: RulerStyle.graduated,
///   pointer: PointerConfig(
///     style: PointerStyle.triangle,
///     color: Colors.red,
///   ),
///   showValueBar: true,
///   ranges: [
///     LinearGaugeRange(start: 0.0, end: 0.3, color: Colors.green),
///     LinearGaugeRange(start: 0.3, end: 0.7, color: Colors.yellow),
///     LinearGaugeRange(start: 0.7, end: 1.0, color: Colors.red),
///   ],
///   animation: true,
///   interactive: true,
///   onValueChanged: (value) => print('Value: $value'),
/// )
/// ```
class LinearGauge extends StatefulWidget {
  /// The current value between 0.0 and 1.0.
  final double value;

  /// The orientation of the gauge.
  final LinearGaugeOrientation orientation;

  /// The length of the gauge (width for horizontal, height for vertical).
  final double? length;

  /// The thickness of the gauge track.
  final double thickness;

  /// The background color of the gauge track.
  final Color backgroundColor;

  /// The color of the value bar.
  final Color valueColor;

  /// Optional gradient for the value bar.
  final Gradient? valueGradient;

  /// The style of the ruler/tick marks.
  final RulerStyle rulerStyle;

  /// The position of the ruler.
  final RulerPosition rulerPosition;

  /// Number of major tick marks.
  final int majorTickCount;

  /// Number of minor ticks between major ticks.
  final int minorTicksPerMajor;

  /// The length of major tick marks.
  final double majorTickLength;

  /// The length of minor tick marks.
  final double minorTickLength;

  /// The color of tick marks.
  final Color tickColor;

  /// The width of tick marks.
  final double tickWidth;

  /// Text style for tick labels.
  final TextStyle? labelStyle;

  /// Custom label formatter function.
  final String Function(double value)? labelFormatter;

  /// The pointer configuration.
  final PointerConfig? pointer;

  /// Whether to show the value bar.
  final bool showValueBar;

  /// The border radius of the gauge track and value bar.
  final BorderRadius? borderRadius;

  /// The ranges for the gauge.
  final List<LinearGaugeRange>? ranges;

  /// Whether to show ranges behind the value bar.
  final bool showRangesBehind;

  /// Optional custom curve path for the gauge.
  final Path Function(Size size)? customCurve;

  /// Whether to animate value changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Whether the gauge is interactive (draggable/tappable).
  final bool interactive;

  /// Callback when value changes during interaction.
  final OnLinearGaugeValueChanged? onValueChanged;

  /// Callback when interaction starts.
  final VoidCallback? onInteractionStart;

  /// Callback when interaction ends.
  final VoidCallback? onInteractionEnd;

  /// The minimum value (for label display).
  final double minValue;

  /// The maximum value (for label display).
  final double maxValue;

  /// Whether to show min/max labels.
  final bool showMinMaxLabels;

  /// Whether to show the current value label.
  final bool showValueLabel;

  /// Text style for the value label.
  final TextStyle? valueTextStyle;

  /// Position of the value label.
  final PointerPosition valueLabelPosition;

  /// Custom widget to display as pointer.
  final Widget? customPointerWidget;

  /// Padding around the gauge.
  final EdgeInsets padding;

  /// Creates a linear gauge widget.
  const LinearGauge({
    super.key,
    this.value = 0.0,
    this.orientation = LinearGaugeOrientation.horizontal,
    this.length,
    this.thickness = 20.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.valueColor = Colors.blue,
    this.valueGradient,
    this.rulerStyle = RulerStyle.none,
    this.rulerPosition = RulerPosition.start,
    this.majorTickCount = 11,
    this.minorTicksPerMajor = 4,
    this.majorTickLength = 15.0,
    this.minorTickLength = 8.0,
    this.tickColor = Colors.black54,
    this.tickWidth = 1.5,
    this.labelStyle,
    this.labelFormatter,
    this.pointer,
    this.showValueBar = true,
    this.borderRadius,
    this.ranges,
    this.showRangesBehind = true,
    this.customCurve,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.interactive = false,
    this.onValueChanged,
    this.onInteractionStart,
    this.onInteractionEnd,
    this.minValue = 0,
    this.maxValue = 100,
    this.showMinMaxLabels = false,
    this.showValueLabel = false,
    this.valueTextStyle,
    this.valueLabelPosition = PointerPosition.start,
    this.customPointerWidget,
    this.padding = EdgeInsets.zero,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  @override
  State<LinearGauge> createState() => _LinearGaugeState();
}

class _LinearGaugeState extends State<LinearGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _currentValue = 0.0;
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
    } else {
      _animation = AlwaysStoppedAnimation(widget.value);
    }
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(LinearGauge oldWidget) {
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
        _animationController
          ..reset()
          ..forward();
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

  void _handleInteraction(Offset localPosition, Size size) {
    if (!widget.interactive) return;

    double newValue;
    if (widget.orientation == LinearGaugeOrientation.horizontal) {
      newValue = (localPosition.dx / size.width).clamp(0.0, 1.0);
    } else {
      newValue = (1 - (localPosition.dy / size.height)).clamp(0.0, 1.0);
    }

    setState(() {
      _currentValue = newValue;
      _animation = AlwaysStoppedAnimation(newValue);
    });

    widget.onValueChanged?.call(newValue);
  }

  String _formatLabel(double normalizedValue) {
    if (widget.labelFormatter != null) {
      return widget.labelFormatter!(normalizedValue);
    }
    final actualValue = widget.minValue + (widget.maxValue - widget.minValue) * normalizedValue;
    return actualValue.toStringAsFixed(actualValue.truncateToDouble() == actualValue ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isHorizontal = widget.orientation == LinearGaugeOrientation.horizontal;
              final gaugeLength = widget.length ?? 
                  (isHorizontal ? constraints.maxWidth : constraints.maxHeight);
              
              // Calculate total size needed including ruler
              double totalThickness = widget.thickness;
              if (widget.rulerStyle != RulerStyle.none) {
                totalThickness += widget.majorTickLength + 10;
                if (widget.rulerPosition == RulerPosition.both || 
                    widget.rulerStyle == RulerStyle.bothSides) {
                  totalThickness += widget.majorTickLength + 10;
                }
              }
              if (widget.pointer != null) {
                totalThickness = math.max(totalThickness, widget.pointer!.size + 10);
              }

              final size = isHorizontal
                  ? Size(gaugeLength, totalThickness)
                  : Size(totalThickness, gaugeLength);

              Widget gauge = GestureDetector(
                onTapDown: widget.interactive
                    ? (details) {
                        widget.onInteractionStart?.call();
                        _isDragging = true;
                        _handleInteraction(details.localPosition, size);
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
                        _handleInteraction(details.localPosition, size);
                      }
                    : null,
                onPanUpdate: widget.interactive
                    ? (details) {
                        _handleInteraction(details.localPosition, size);
                      }
                    : null,
                onPanEnd: widget.interactive
                    ? (_) {
                        _isDragging = false;
                        widget.onInteractionEnd?.call();
                      }
                    : null,
                child: CustomPaint(
                  size: size,
                  painter: _LinearGaugePainter(
                    value: _isDragging ? _currentValue : _animation.value,
                    orientation: widget.orientation,
                    thickness: widget.thickness,
                    backgroundColor: widget.backgroundColor,
                    valueColor: widget.valueColor,
                    valueGradient: widget.valueGradient,
                    rulerStyle: widget.rulerStyle,
                    rulerPosition: widget.rulerPosition,
                    majorTickCount: widget.majorTickCount,
                    minorTicksPerMajor: widget.minorTicksPerMajor,
                    majorTickLength: widget.majorTickLength,
                    minorTickLength: widget.minorTickLength,
                    tickColor: widget.tickColor,
                    tickWidth: widget.tickWidth,
                    showValueBar: widget.showValueBar,
                    borderRadius: widget.borderRadius,
                    ranges: widget.ranges,
                    showRangesBehind: widget.showRangesBehind,
                    customCurve: widget.customCurve,
                    pointer: widget.pointer,
                    labelFormatter: _formatLabel,
                    labelStyle: widget.labelStyle,
                  ),
                ),
              );

              // Add value label if needed
              if (widget.showValueLabel) {
                final displayValue = _isDragging ? _currentValue : _animation.value;
                final actualValue = widget.minValue + 
                    (widget.maxValue - widget.minValue) * displayValue;
                final label = Text(
                  actualValue.toStringAsFixed(1),
                  style: widget.valueTextStyle ?? 
                      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                );

                if (isHorizontal) {
                  gauge = Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.valueLabelPosition == PointerPosition.start) label,
                      gauge,
                      if (widget.valueLabelPosition == PointerPosition.end) label,
                    ],
                  );
                } else {
                  gauge = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.valueLabelPosition == PointerPosition.start) label,
                      gauge,
                      if (widget.valueLabelPosition == PointerPosition.end) label,
                    ],
                  );
                }
              }

              return gauge;
            },
          );
        },
      ),
    );
  }
}

class _LinearGaugePainter extends CustomPainter {
  final double value;
  final LinearGaugeOrientation orientation;
  final double thickness;
  final Color backgroundColor;
  final Color valueColor;
  final Gradient? valueGradient;
  final RulerStyle rulerStyle;
  final RulerPosition rulerPosition;
  final int majorTickCount;
  final int minorTicksPerMajor;
  final double majorTickLength;
  final double minorTickLength;
  final Color tickColor;
  final double tickWidth;
  final bool showValueBar;
  final BorderRadius? borderRadius;
  final List<LinearGaugeRange>? ranges;
  final bool showRangesBehind;
  final Path Function(Size size)? customCurve;
  final PointerConfig? pointer;
  final String Function(double)? labelFormatter;
  final TextStyle? labelStyle;

  _LinearGaugePainter({
    required this.value,
    required this.orientation,
    required this.thickness,
    required this.backgroundColor,
    required this.valueColor,
    this.valueGradient,
    required this.rulerStyle,
    required this.rulerPosition,
    required this.majorTickCount,
    required this.minorTicksPerMajor,
    required this.majorTickLength,
    required this.minorTickLength,
    required this.tickColor,
    required this.tickWidth,
    required this.showValueBar,
    this.borderRadius,
    this.ranges,
    required this.showRangesBehind,
    this.customCurve,
    this.pointer,
    this.labelFormatter,
    this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isHorizontal = orientation == LinearGaugeOrientation.horizontal;
    final gaugeLength = isHorizontal ? size.width : size.height;
    
    // Calculate gauge track position
    double trackOffset = 0;
    if (rulerStyle != RulerStyle.none) {
      if (rulerPosition == RulerPosition.start || rulerPosition == RulerPosition.both) {
        trackOffset = majorTickLength + 5;
      }
    }

    final trackRect = isHorizontal
        ? Rect.fromLTWH(0, trackOffset, size.width, thickness)
        : Rect.fromLTWH(trackOffset, 0, thickness, size.height);

    // Draw track background
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final radius = borderRadius ?? BorderRadius.circular(thickness / 2);
    final bgRRect = RRect.fromRectAndCorners(
      trackRect,
      topLeft: radius.topLeft,
      topRight: radius.topRight,
      bottomLeft: radius.bottomLeft,
      bottomRight: radius.bottomRight,
    );
    canvas.drawRRect(bgRRect, bgPaint);

    // Draw ranges
    if (ranges != null && showRangesBehind) {
      for (final range in ranges!) {
        final rangePaint = Paint()
          ..color = range.color
          ..style = PaintingStyle.fill;

        final rangeStart = range.start * gaugeLength;
        final rangeEnd = range.end * gaugeLength;
        final rangeLength = rangeEnd - rangeStart;
        final rangeThickness = range.sizeRatio != null 
            ? thickness * range.sizeRatio! 
            : thickness;
        final rangeOffset = (thickness - rangeThickness) / 2;

        final rangeRect = isHorizontal
            ? Rect.fromLTWH(rangeStart, trackOffset + rangeOffset, rangeLength, rangeThickness)
            : Rect.fromLTWH(trackOffset + rangeOffset, size.height - rangeEnd, rangeThickness, rangeLength);

        canvas.save();
        canvas.clipRRect(bgRRect);
        canvas.drawRect(rangeRect, rangePaint);
        canvas.restore();
      }
    }

    // Draw value bar
    if (showValueBar && value > 0) {
      final valuePaint = Paint()..style = PaintingStyle.fill;

      if (valueGradient != null) {
        valuePaint.shader = valueGradient!.createShader(trackRect);
      } else {
        valuePaint.color = valueColor;
      }

      final valueLength = gaugeLength * value;
      final valueRect = isHorizontal
          ? Rect.fromLTWH(0, trackOffset, valueLength, thickness)
          : Rect.fromLTWH(trackOffset, size.height - valueLength, thickness, valueLength);

      canvas.save();
      canvas.clipRRect(bgRRect);
      canvas.drawRect(valueRect, valuePaint);
      canvas.restore();
    }

    // Draw ruler/ticks
    if (rulerStyle != RulerStyle.none) {
      _drawRuler(canvas, size, trackOffset, gaugeLength, isHorizontal);
    }

    // Draw pointer
    if (pointer != null && pointer!.style != PointerStyle.none) {
      _drawPointer(canvas, size, trackOffset, gaugeLength, isHorizontal);
    }
  }

  void _drawRuler(Canvas canvas, Size size, double trackOffset, double gaugeLength, bool isHorizontal) {
    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = tickWidth
      ..strokeCap = StrokeCap.round;

    final totalTicks = (majorTickCount - 1) * (minorTicksPerMajor + 1) + 1;
    final tickSpacing = gaugeLength / (totalTicks - 1);

    for (int i = 0; i < totalTicks; i++) {
      final isMajor = i % (minorTicksPerMajor + 1) == 0;
      final tickLength = isMajor ? majorTickLength : minorTickLength;
      final position = i * tickSpacing;

      if (rulerPosition == RulerPosition.start || rulerPosition == RulerPosition.both) {
        final start = isHorizontal
            ? Offset(position, trackOffset - 2)
            : Offset(trackOffset - 2, size.height - position);
        final end = isHorizontal
            ? Offset(position, trackOffset - 2 - tickLength)
            : Offset(trackOffset - 2 - tickLength, size.height - position);
        canvas.drawLine(start, end, tickPaint);
      }

      if (rulerPosition == RulerPosition.end || rulerPosition == RulerPosition.both) {
        final start = isHorizontal
            ? Offset(position, trackOffset + thickness + 2)
            : Offset(trackOffset + thickness + 2, size.height - position);
        final end = isHorizontal
            ? Offset(position, trackOffset + thickness + 2 + tickLength)
            : Offset(trackOffset + thickness + 2 + tickLength, size.height - position);
        canvas.drawLine(start, end, tickPaint);
      }

      // Draw labels for major ticks
      if (isMajor && (rulerStyle == RulerStyle.labeled || rulerStyle == RulerStyle.graduated)) {
        final labelValue = i / (totalTicks - 1);
        final labelText = labelFormatter?.call(labelValue) ?? '${(labelValue * 100).toInt()}';
        
        final textPainter = TextPainter(
          text: TextSpan(
            text: labelText,
            style: labelStyle ?? TextStyle(color: tickColor, fontSize: 10),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        Offset labelOffset;
        if (isHorizontal) {
          labelOffset = Offset(
            position - textPainter.width / 2,
            rulerPosition == RulerPosition.start
                ? trackOffset - tickLength - 5 - textPainter.height
                : trackOffset + thickness + tickLength + 5,
          );
        } else {
          labelOffset = Offset(
            rulerPosition == RulerPosition.start
                ? trackOffset - tickLength - 5 - textPainter.width
                : trackOffset + thickness + tickLength + 5,
            size.height - position - textPainter.height / 2,
          );
        }
        textPainter.paint(canvas, labelOffset);
      }
    }
  }

  void _drawPointer(Canvas canvas, Size size, double trackOffset, double gaugeLength, bool isHorizontal) {
    if (pointer == null) return;

    final pointerPaint = Paint()
      ..color = pointer!.color
      ..style = PaintingStyle.fill;

    if (pointer!.hasShadow) {
      canvas.save();
      canvas.translate(2, 2);
      final shadowPaint = Paint()
        ..color = Colors.black26
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      _drawPointerShape(canvas, size, trackOffset, gaugeLength, isHorizontal, shadowPaint);
      canvas.restore();
    }

    _drawPointerShape(canvas, size, trackOffset, gaugeLength, isHorizontal, pointerPaint);

    if (pointer!.borderColor != null && pointer!.borderWidth > 0) {
      final borderPaint = Paint()
        ..color = pointer!.borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = pointer!.borderWidth;
      _drawPointerShape(canvas, size, trackOffset, gaugeLength, isHorizontal, borderPaint);
    }
  }

  void _drawPointerShape(Canvas canvas, Size size, double trackOffset, double gaugeLength, 
      bool isHorizontal, Paint paint) {
    if (pointer == null) return;

    final pointerSize = pointer!.size;
    final position = gaugeLength * value;
    
    double centerX, centerY;
    if (isHorizontal) {
      centerX = position;
      centerY = pointer!.position == PointerPosition.start
          ? trackOffset - pointerSize / 2 - 2
          : pointer!.position == PointerPosition.end
              ? trackOffset + thickness + pointerSize / 2 + 2
              : trackOffset + thickness / 2;
    } else {
      centerX = pointer!.position == PointerPosition.start
          ? trackOffset - pointerSize / 2 - 2
          : pointer!.position == PointerPosition.end
              ? trackOffset + thickness + pointerSize / 2 + 2
              : trackOffset + thickness / 2;
      centerY = size.height - position;
    }

    final center = Offset(centerX, centerY);

    switch (pointer!.style) {
      case PointerStyle.triangle:
        final path = Path();
        if (isHorizontal) {
          if (pointer!.position == PointerPosition.start) {
            path.moveTo(center.dx, center.dy + pointerSize / 2);
            path.lineTo(center.dx - pointerSize / 2, center.dy - pointerSize / 2);
            path.lineTo(center.dx + pointerSize / 2, center.dy - pointerSize / 2);
          } else {
            path.moveTo(center.dx, center.dy - pointerSize / 2);
            path.lineTo(center.dx - pointerSize / 2, center.dy + pointerSize / 2);
            path.lineTo(center.dx + pointerSize / 2, center.dy + pointerSize / 2);
          }
        } else {
          if (pointer!.position == PointerPosition.start) {
            path.moveTo(center.dx + pointerSize / 2, center.dy);
            path.lineTo(center.dx - pointerSize / 2, center.dy - pointerSize / 2);
            path.lineTo(center.dx - pointerSize / 2, center.dy + pointerSize / 2);
          } else {
            path.moveTo(center.dx - pointerSize / 2, center.dy);
            path.lineTo(center.dx + pointerSize / 2, center.dy - pointerSize / 2);
            path.lineTo(center.dx + pointerSize / 2, center.dy + pointerSize / 2);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
        break;

      case PointerStyle.invertedTriangle:
        final path = Path();
        if (isHorizontal) {
          if (pointer!.position == PointerPosition.start) {
            path.moveTo(center.dx, center.dy - pointerSize / 2);
            path.lineTo(center.dx - pointerSize / 2, center.dy + pointerSize / 2);
            path.lineTo(center.dx + pointerSize / 2, center.dy + pointerSize / 2);
          } else {
            path.moveTo(center.dx, center.dy + pointerSize / 2);
            path.lineTo(center.dx - pointerSize / 2, center.dy - pointerSize / 2);
            path.lineTo(center.dx + pointerSize / 2, center.dy - pointerSize / 2);
          }
        } else {
          if (pointer!.position == PointerPosition.start) {
            path.moveTo(center.dx - pointerSize / 2, center.dy);
            path.lineTo(center.dx + pointerSize / 2, center.dy - pointerSize / 2);
            path.lineTo(center.dx + pointerSize / 2, center.dy + pointerSize / 2);
          } else {
            path.moveTo(center.dx + pointerSize / 2, center.dy);
            path.lineTo(center.dx - pointerSize / 2, center.dy - pointerSize / 2);
            path.lineTo(center.dx - pointerSize / 2, center.dy + pointerSize / 2);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
        break;

      case PointerStyle.diamond:
        final path = Path();
        path.moveTo(center.dx, center.dy - pointerSize / 2);
        path.lineTo(center.dx + pointerSize / 2, center.dy);
        path.lineTo(center.dx, center.dy + pointerSize / 2);
        path.lineTo(center.dx - pointerSize / 2, center.dy);
        path.close();
        canvas.drawPath(path, paint);
        break;

      case PointerStyle.circle:
        canvas.drawCircle(center, pointerSize / 2, paint);
        break;

      case PointerStyle.rectangle:
        final rect = Rect.fromCenter(
          center: center,
          width: pointerSize * 0.6,
          height: pointerSize,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(pointerSize * 0.1)),
          paint,
        );
        break;

      case PointerStyle.arrow:
        final path = Path();
        if (isHorizontal) {
          path.moveTo(center.dx, center.dy + pointerSize / 2);
          path.lineTo(center.dx - pointerSize / 3, center.dy);
          path.lineTo(center.dx - pointerSize / 6, center.dy);
          path.lineTo(center.dx - pointerSize / 6, center.dy - pointerSize / 2);
          path.lineTo(center.dx + pointerSize / 6, center.dy - pointerSize / 2);
          path.lineTo(center.dx + pointerSize / 6, center.dy);
          path.lineTo(center.dx + pointerSize / 3, center.dy);
        } else {
          path.moveTo(center.dx + pointerSize / 2, center.dy);
          path.lineTo(center.dx, center.dy - pointerSize / 3);
          path.lineTo(center.dx, center.dy - pointerSize / 6);
          path.lineTo(center.dx - pointerSize / 2, center.dy - pointerSize / 6);
          path.lineTo(center.dx - pointerSize / 2, center.dy + pointerSize / 6);
          path.lineTo(center.dx, center.dy + pointerSize / 6);
          path.lineTo(center.dx, center.dy + pointerSize / 3);
        }
        path.close();
        canvas.drawPath(path, paint);
        break;

      case PointerStyle.none:
        break;
    }
  }

  @override
  bool shouldRepaint(_LinearGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.orientation != orientation ||
        oldDelegate.thickness != thickness ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.valueColor != valueColor ||
        oldDelegate.rulerStyle != rulerStyle;
  }
}
