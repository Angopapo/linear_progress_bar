import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The orientation of the linear gauge.
enum LinearGaugeOrientation {
  /// Horizontal orientation (left to right).
  horizontal,

  /// Vertical orientation (bottom to top).
  vertical,
}

/// The style of the ruler/scale markings.
enum RulerStyle {
  /// No ruler markings.
  none,

  /// Simple tick marks only.
  ticks,

  /// Tick marks with labels.
  ticksWithLabels,

  /// Only major tick marks.
  majorTicks,

  /// Graduated scale with varying tick sizes.
  graduated,
}

/// The pointer type for the linear gauge.
enum LinearPointerType {
  /// No pointer.
  none,

  /// Triangle/arrow pointer.
  triangle,

  /// Circle pointer.
  circle,

  /// Diamond/rhombus pointer.
  diamond,

  /// Rectangle/bar pointer.
  rectangle,

  /// Inverted triangle pointer.
  invertedTriangle,

  /// Custom widget pointer.
  custom,
}

/// The position of the pointer relative to the gauge track.
enum PointerPosition {
  /// Pointer at the top (horizontal) or left (vertical).
  start,

  /// Pointer at the bottom (horizontal) or right (vertical).
  end,

  /// Pointer at both sides.
  both,

  /// Pointer centered on the track.
  center,
}

/// Configuration for a range segment in the linear gauge.
class LinearGaugeRange {
  /// The start value of the range (0.0 to 1.0).
  final double start;

  /// The end value of the range (0.0 to 1.0).
  final double end;

  /// The color of the range.
  final Color color;

  /// Optional label for the range.
  final String? label;

  /// The width/height of this range segment (null = use default).
  final double? size;

  /// Creates a linear gauge range.
  const LinearGaugeRange({
    required this.start,
    required this.end,
    required this.color,
    this.label,
    this.size,
  });
}

/// Configuration for the linear gauge pointer.
class LinearGaugePointer {
  /// The type of pointer.
  final LinearPointerType type;

  /// The size of the pointer.
  final Size size;

  /// The color of the pointer.
  final Color color;

  /// The border color of the pointer.
  final Color? borderColor;

  /// The border width of the pointer.
  final double borderWidth;

  /// The position of the pointer.
  final PointerPosition position;

  /// The offset from the track.
  final double offset;

  /// Custom widget for custom pointer type.
  final Widget? child;

  /// Whether the pointer casts a shadow.
  final bool hasShadow;

  /// Shadow color.
  final Color shadowColor;

  /// Creates a linear gauge pointer configuration.
  const LinearGaugePointer({
    this.type = LinearPointerType.triangle,
    this.size = const Size(20, 15),
    this.color = Colors.blue,
    this.borderColor,
    this.borderWidth = 0,
    this.position = PointerPosition.start,
    this.offset = 0,
    this.child,
    this.hasShadow = false,
    this.shadowColor = Colors.black26,
  });
}

/// Configuration for the value bar in the linear gauge.
class LinearValueBar {
  /// The color of the value bar.
  final Color color;

  /// Optional gradient for the value bar.
  final Gradient? gradient;

  /// The thickness of the value bar (null = fill track).
  final double? thickness;

  /// The offset from the track edge.
  final double offset;

  /// The border radius of the value bar.
  final BorderRadius? borderRadius;

  /// Whether to animate the value bar.
  final bool animate;

  /// Creates a linear value bar configuration.
  const LinearValueBar({
    this.color = Colors.blue,
    this.gradient,
    this.thickness,
    this.offset = 0,
    this.borderRadius,
    this.animate = true,
  });
}

/// Callback for gauge value changes during interaction.
typedef OnLinearGaugeValueChanged = void Function(double value);

/// A comprehensive linear gauge indicator widget.
///
/// This widget displays a linear gauge with extensive customization options
/// including orientation, ruler style, pointers, value bars, ranges,
/// animations, and interactivity.
///
/// Example usage:
/// ```dart
/// LinearGaugeIndicator(
///   value: 0.75,
///   orientation: LinearGaugeOrientation.horizontal,
///   rulerStyle: RulerStyle.ticksWithLabels,
///   pointer: LinearGaugePointer(
///     type: LinearPointerType.triangle,
///     color: Colors.red,
///   ),
///   valueBar: LinearValueBar(
///     gradient: LinearGradient(colors: [Colors.green, Colors.red]),
///   ),
///   ranges: [
///     LinearGaugeRange(start: 0, end: 0.3, color: Colors.green),
///     LinearGaugeRange(start: 0.3, end: 0.7, color: Colors.orange),
///     LinearGaugeRange(start: 0.7, end: 1.0, color: Colors.red),
///   ],
///   animation: true,
///   interactive: true,
///   onValueChanged: (value) => print('Value: $value'),
/// )
/// ```
class LinearGaugeIndicator extends StatefulWidget {
  /// The current value between 0.0 and 1.0.
  final double value;

  /// The minimum value for display purposes.
  final double minValue;

  /// The maximum value for display purposes.
  final double maxValue;

  /// The orientation of the gauge.
  final LinearGaugeOrientation orientation;

  /// The length of the gauge (width for horizontal, height for vertical).
  final double? length;

  /// The thickness of the gauge track.
  final double thickness;

  /// The background color of the gauge track.
  final Color backgroundColor;

  /// The border color of the track.
  final Color? borderColor;

  /// The border width of the track.
  final double borderWidth;

  /// The border radius of the track.
  final BorderRadius? borderRadius;

  /// The ruler/scale style.
  final RulerStyle rulerStyle;

  /// The number of major divisions on the ruler.
  final int majorDivisions;

  /// The number of minor divisions between major divisions.
  final int minorDivisionsPerMajor;

  /// The length of major tick marks.
  final double majorTickLength;

  /// The length of minor tick marks.
  final double minorTickLength;

  /// The color of tick marks.
  final Color tickColor;

  /// The text style for ruler labels.
  final TextStyle? labelStyle;

  /// Custom label formatter.
  final String Function(double value)? labelFormatter;

  /// The offset of labels from tick marks.
  final double labelOffset;

  /// The pointer configuration.
  final LinearGaugePointer? pointer;

  /// The value bar configuration.
  final LinearValueBar? valueBar;

  /// The range segments to display.
  final List<LinearGaugeRange>? ranges;

  /// Whether ranges are drawn inside the track or outside.
  final bool rangesInsideTrack;

  /// Whether to animate value changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Whether the gauge is interactive (draggable).
  final bool interactive;

  /// Callback when value changes during interaction.
  final OnLinearGaugeValueChanged? onValueChanged;

  /// Callback when interaction starts.
  final VoidCallback? onInteractionStart;

  /// Callback when interaction ends.
  final VoidCallback? onInteractionEnd;

  /// Widget to display at the start of the gauge.
  final Widget? startChild;

  /// Widget to display at the end of the gauge.
  final Widget? endChild;

  /// Whether to show the current value as text.
  final bool showValue;

  /// The position of the value label.
  final Alignment valuePosition;

  /// The text style for the value label.
  final TextStyle? valueTextStyle;

  /// Custom value formatter for display.
  final String Function(double value)? valueFormatter;

  /// Whether to reverse the gauge direction.
  final bool reversed;

  /// Creates a linear gauge indicator widget.
  const LinearGaugeIndicator({
    super.key,
    this.value = 0.0,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.orientation = LinearGaugeOrientation.horizontal,
    this.length,
    this.thickness = 20.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius,
    this.rulerStyle = RulerStyle.none,
    this.majorDivisions = 10,
    this.minorDivisionsPerMajor = 5,
    this.majorTickLength = 15.0,
    this.minorTickLength = 8.0,
    this.tickColor = Colors.black54,
    this.labelStyle,
    this.labelFormatter,
    this.labelOffset = 8.0,
    this.pointer,
    this.valueBar,
    this.ranges,
    this.rangesInsideTrack = true,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.interactive = false,
    this.onValueChanged,
    this.onInteractionStart,
    this.onInteractionEnd,
    this.startChild,
    this.endChild,
    this.showValue = false,
    this.valuePosition = Alignment.center,
    this.valueTextStyle,
    this.valueFormatter,
    this.reversed = false,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  @override
  State<LinearGaugeIndicator> createState() => _LinearGaugeIndicatorState();
}

class _LinearGaugeIndicatorState extends State<LinearGaugeIndicator>
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
  void didUpdateWidget(LinearGaugeIndicator oldWidget) {
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

  void _handlePanStart(DragStartDetails details) {
    if (!widget.interactive) return;
    _isDragging = true;
    widget.onInteractionStart?.call();
  }

  void _handlePanUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    if (!widget.interactive) return;
    
    final isHorizontal = widget.orientation == LinearGaugeOrientation.horizontal;
    final maxExtent = isHorizontal ? constraints.maxWidth : constraints.maxHeight;
    final delta = isHorizontal ? details.delta.dx : -details.delta.dy;
    
    setState(() {
      _interactiveValue = (_interactiveValue + delta / maxExtent)
          .clamp(0.0, 1.0);
      if (widget.reversed) {
        _interactiveValue = 1.0 - _interactiveValue;
      }
    });
    
    widget.onValueChanged?.call(_interactiveValue);
  }

  void _handlePanEnd(DragEndDetails details) {
    if (!widget.interactive) return;
    _isDragging = false;
    widget.onInteractionEnd?.call();
  }

  void _handleTapUp(TapUpDetails details, BoxConstraints constraints) {
    if (!widget.interactive) return;
    
    final isHorizontal = widget.orientation == LinearGaugeOrientation.horizontal;
    final maxExtent = isHorizontal ? constraints.maxWidth : constraints.maxHeight;
    final position = isHorizontal
        ? details.localPosition.dx
        : constraints.maxHeight - details.localPosition.dy;
    
    setState(() {
      _interactiveValue = (position / maxExtent).clamp(0.0, 1.0);
      if (widget.reversed) {
        _interactiveValue = 1.0 - _interactiveValue;
      }
    });
    
    widget.onValueChanged?.call(_interactiveValue);
  }

  String _formatValue(double value) {
    if (widget.valueFormatter != null) {
      return widget.valueFormatter!(value);
    }
    final displayValue = widget.minValue + value * (widget.maxValue - widget.minValue);
    return displayValue.toStringAsFixed(1);
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
    final isHorizontal = widget.orientation == LinearGaugeOrientation.horizontal;

    Widget gauge = LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanStart: _handlePanStart,
          onPanUpdate: (details) => _handlePanUpdate(details, constraints),
          onPanEnd: _handlePanEnd,
          onTapUp: (details) => _handleTapUp(details, constraints),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(
                  isHorizontal ? (widget.length ?? constraints.maxWidth) : widget.thickness,
                  isHorizontal ? widget.thickness : (widget.length ?? constraints.maxHeight),
                ),
                painter: _LinearGaugePainter(
                  value: _currentValue,
                  orientation: widget.orientation,
                  thickness: widget.thickness,
                  backgroundColor: widget.backgroundColor,
                  borderColor: widget.borderColor,
                  borderWidth: widget.borderWidth,
                  borderRadius: widget.borderRadius,
                  rulerStyle: widget.rulerStyle,
                  majorDivisions: widget.majorDivisions,
                  minorDivisionsPerMajor: widget.minorDivisionsPerMajor,
                  majorTickLength: widget.majorTickLength,
                  minorTickLength: widget.minorTickLength,
                  tickColor: widget.tickColor,
                  labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 10, color: Colors.black54),
                  labelFormatter: _formatLabel,
                  labelOffset: widget.labelOffset,
                  pointer: widget.pointer,
                  valueBar: widget.valueBar,
                  ranges: widget.ranges,
                  rangesInsideTrack: widget.rangesInsideTrack,
                  reversed: widget.reversed,
                ),
              );
            },
          ),
        );
      },
    );

    // Add start/end children
    if (widget.startChild != null || widget.endChild != null) {
      final children = <Widget>[
        if (widget.startChild != null) widget.startChild!,
        Expanded(child: gauge),
        if (widget.endChild != null) widget.endChild!,
      ];

      gauge = isHorizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children.reversed.toList(),
            );
    }

    // Add value label
    if (widget.showValue) {
      gauge = Stack(
        alignment: widget.valuePosition,
        children: [
          gauge,
          AnimatedBuilder(
            animation: _animation,
            builder: (context, _) => Text(
              _formatValue(_currentValue),
              style: widget.valueTextStyle ??
                  TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: widget.valueBar?.color ?? Colors.blue,
                  ),
            ),
          ),
        ],
      );
    }

    return gauge;
  }
}

class _LinearGaugePainter extends CustomPainter {
  final double value;
  final LinearGaugeOrientation orientation;
  final double thickness;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final RulerStyle rulerStyle;
  final int majorDivisions;
  final int minorDivisionsPerMajor;
  final double majorTickLength;
  final double minorTickLength;
  final Color tickColor;
  final TextStyle labelStyle;
  final String Function(double) labelFormatter;
  final double labelOffset;
  final LinearGaugePointer? pointer;
  final LinearValueBar? valueBar;
  final List<LinearGaugeRange>? ranges;
  final bool rangesInsideTrack;
  final bool reversed;

  _LinearGaugePainter({
    required this.value,
    required this.orientation,
    required this.thickness,
    required this.backgroundColor,
    this.borderColor,
    required this.borderWidth,
    this.borderRadius,
    required this.rulerStyle,
    required this.majorDivisions,
    required this.minorDivisionsPerMajor,
    required this.majorTickLength,
    required this.minorTickLength,
    required this.tickColor,
    required this.labelStyle,
    required this.labelFormatter,
    required this.labelOffset,
    this.pointer,
    this.valueBar,
    this.ranges,
    required this.rangesInsideTrack,
    required this.reversed,
  });

  bool get isHorizontal => orientation == LinearGaugeOrientation.horizontal;

  @override
  void paint(Canvas canvas, Size size) {
    final actualValue = reversed ? 1.0 - value : value;
    
    // Calculate track rect
    final trackRect = _getTrackRect(size);
    final radius = borderRadius ?? BorderRadius.circular(thickness / 2);
    
    // Draw track background
    _drawTrackBackground(canvas, trackRect, radius);
    
    // Draw ranges if outside track
    if (ranges != null && !rangesInsideTrack) {
      _drawRanges(canvas, size, trackRect);
    }
    
    // Draw ranges inside track
    if (ranges != null && rangesInsideTrack) {
      _drawRangesInsideTrack(canvas, trackRect, radius);
    }
    
    // Draw value bar
    if (valueBar != null) {
      _drawValueBar(canvas, trackRect, radius, actualValue);
    }
    
    // Draw border
    if (borderColor != null && borderWidth > 0) {
      _drawTrackBorder(canvas, trackRect, radius);
    }
    
    // Draw ruler/ticks
    if (rulerStyle != RulerStyle.none) {
      _drawRuler(canvas, size, trackRect);
    }
    
    // Draw pointer
    if (pointer != null && pointer!.type != LinearPointerType.none) {
      _drawPointer(canvas, size, trackRect, actualValue);
    }
  }

  Rect _getTrackRect(Size size) {
    if (isHorizontal) {
      final top = rulerStyle == RulerStyle.none ? 0.0 : majorTickLength + labelOffset + 12;
      return Rect.fromLTWH(0, top, size.width, thickness);
    } else {
      final left = rulerStyle == RulerStyle.none ? 0.0 : majorTickLength + labelOffset + 20;
      return Rect.fromLTWH(left, 0, thickness, size.height);
    }
  }

  void _drawTrackBackground(Canvas canvas, Rect rect, BorderRadius radius) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final rrect = radius.toRRect(rect);
    canvas.drawRRect(rrect, paint);
  }

  void _drawTrackBorder(Canvas canvas, Rect rect, BorderRadius radius) {
    final paint = Paint()
      ..color = borderColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final rrect = radius.toRRect(rect);
    canvas.drawRRect(rrect, paint);
  }

  void _drawRangesInsideTrack(Canvas canvas, Rect trackRect, BorderRadius radius) {
    canvas.save();
    canvas.clipRRect(radius.toRRect(trackRect));
    
    for (final range in ranges!) {
      final paint = Paint()
        ..color = range.color
        ..style = PaintingStyle.fill;

      if (isHorizontal) {
        final startX = trackRect.left + trackRect.width * range.start;
        final endX = trackRect.left + trackRect.width * range.end;
        final rangeRect = Rect.fromLTRB(startX, trackRect.top, endX, trackRect.bottom);
        canvas.drawRect(rangeRect, paint);
      } else {
        final startY = trackRect.bottom - trackRect.height * range.start;
        final endY = trackRect.bottom - trackRect.height * range.end;
        final rangeRect = Rect.fromLTRB(trackRect.left, endY, trackRect.right, startY);
        canvas.drawRect(rangeRect, paint);
      }
    }
    
    canvas.restore();
  }

  void _drawRanges(Canvas canvas, Size size, Rect trackRect) {
    for (final range in ranges!) {
      final paint = Paint()
        ..color = range.color
        ..style = PaintingStyle.fill;

      final rangeThickness = range.size ?? thickness * 0.3;
      
      if (isHorizontal) {
        final startX = trackRect.left + trackRect.width * range.start;
        final endX = trackRect.left + trackRect.width * range.end;
        final rangeRect = Rect.fromLTRB(
          startX,
          trackRect.bottom + 4,
          endX,
          trackRect.bottom + 4 + rangeThickness,
        );
        canvas.drawRect(rangeRect, paint);
      } else {
        final startY = trackRect.bottom - trackRect.height * range.start;
        final endY = trackRect.bottom - trackRect.height * range.end;
        final rangeRect = Rect.fromLTRB(
          trackRect.right + 4,
          endY,
          trackRect.right + 4 + rangeThickness,
          startY,
        );
        canvas.drawRect(rangeRect, paint);
      }
    }
  }

  void _drawValueBar(Canvas canvas, Rect trackRect, BorderRadius radius, double actualValue) {
    if (actualValue <= 0) return;

    final bar = valueBar!;
    final barThickness = bar.thickness ?? thickness;
    final barOffset = bar.offset;

    late Rect valueRect;
    if (isHorizontal) {
      final width = trackRect.width * actualValue;
      final top = trackRect.top + (thickness - barThickness) / 2 + barOffset;
      valueRect = Rect.fromLTWH(trackRect.left, top, width, barThickness);
    } else {
      final height = trackRect.height * actualValue;
      final left = trackRect.left + (thickness - barThickness) / 2 + barOffset;
      valueRect = Rect.fromLTWH(
        left,
        trackRect.bottom - height,
        barThickness,
        height,
      );
    }

    final paint = Paint()..style = PaintingStyle.fill;
    
    if (bar.gradient != null) {
      paint.shader = bar.gradient!.createShader(valueRect);
    } else {
      paint.color = bar.color;
    }

    final barRadius = bar.borderRadius ?? radius;
    canvas.save();
    canvas.clipRRect(radius.toRRect(trackRect));
    canvas.drawRRect(barRadius.toRRect(valueRect), paint);
    canvas.restore();
  }

  void _drawRuler(Canvas canvas, Size size, Rect trackRect) {
    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final totalDivisions = majorDivisions * minorDivisionsPerMajor;
    
    for (int i = 0; i <= totalDivisions; i++) {
      final isMajor = i % minorDivisionsPerMajor == 0;
      
      if (rulerStyle == RulerStyle.majorTicks && !isMajor) continue;
      
      final tickLength = isMajor ? majorTickLength : minorTickLength;
      final normalizedPos = i / totalDivisions;
      
      Offset start, end;
      
      if (isHorizontal) {
        final x = trackRect.left + trackRect.width * normalizedPos;
        start = Offset(x, trackRect.top - 4);
        end = Offset(x, trackRect.top - 4 - tickLength);
      } else {
        final y = trackRect.bottom - trackRect.height * normalizedPos;
        start = Offset(trackRect.left - 4, y);
        end = Offset(trackRect.left - 4 - tickLength, y);
      }
      
      canvas.drawLine(start, end, tickPaint);
      
      // Draw labels for major ticks
      if (isMajor && (rulerStyle == RulerStyle.ticksWithLabels || rulerStyle == RulerStyle.graduated)) {
        final label = labelFormatter(normalizedPos);
        final textPainter = TextPainter(
          text: TextSpan(text: label, style: labelStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        
        Offset labelPos;
        if (isHorizontal) {
          labelPos = Offset(
            end.dx - textPainter.width / 2,
            end.dy - labelOffset - textPainter.height,
          );
        } else {
          labelPos = Offset(
            end.dx - labelOffset - textPainter.width,
            end.dy - textPainter.height / 2,
          );
        }
        
        textPainter.paint(canvas, labelPos);
      }
    }
  }

  void _drawPointer(Canvas canvas, Size size, Rect trackRect, double actualValue) {
    final p = pointer!;
    
    double position;
    if (isHorizontal) {
      position = trackRect.left + trackRect.width * actualValue;
    } else {
      position = trackRect.bottom - trackRect.height * actualValue;
    }

    final paint = Paint()
      ..color = p.color
      ..style = PaintingStyle.fill;

    if (p.hasShadow) {
      final shadowPaint = Paint()
        ..color = p.shadowColor
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      _drawPointerShape(canvas, trackRect, position, p, shadowPaint, offset: 2);
    }

    _drawPointerShape(canvas, trackRect, position, p, paint);

    if (p.borderColor != null && p.borderWidth > 0) {
      final borderPaint = Paint()
        ..color = p.borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = p.borderWidth;
      _drawPointerShape(canvas, trackRect, position, p, borderPaint);
    }
  }

  void _drawPointerShape(
    Canvas canvas,
    Rect trackRect,
    double position,
    LinearGaugePointer p,
    Paint paint, {
    double offset = 0,
  }) {
    late Offset center;
    
    if (isHorizontal) {
      final y = p.position == PointerPosition.start || p.position == PointerPosition.both
          ? trackRect.top - p.offset - p.size.height / 2
          : p.position == PointerPosition.end
              ? trackRect.bottom + p.offset + p.size.height / 2
              : trackRect.center.dy;
      center = Offset(position, y + offset);
    } else {
      final x = p.position == PointerPosition.start || p.position == PointerPosition.both
          ? trackRect.left - p.offset - p.size.width / 2
          : p.position == PointerPosition.end
              ? trackRect.right + p.offset + p.size.width / 2
              : trackRect.center.dx;
      center = Offset(x + offset, position);
    }

    switch (p.type) {
      case LinearPointerType.triangle:
        _drawTrianglePointer(canvas, center, p, paint, false);
        break;
      case LinearPointerType.invertedTriangle:
        _drawTrianglePointer(canvas, center, p, paint, true);
        break;
      case LinearPointerType.circle:
        final radius = math.min(p.size.width, p.size.height) / 2;
        canvas.drawCircle(center, radius, paint);
        break;
      case LinearPointerType.diamond:
        _drawDiamondPointer(canvas, center, p, paint);
        break;
      case LinearPointerType.rectangle:
        final rect = Rect.fromCenter(
          center: center,
          width: p.size.width,
          height: p.size.height,
        );
        canvas.drawRect(rect, paint);
        break;
      default:
        break;
    }

    // Draw second pointer if position is both
    if (p.position == PointerPosition.both) {
      late Offset secondCenter;
      if (isHorizontal) {
        secondCenter = Offset(position, trackRect.bottom + p.offset + p.size.height / 2 + offset);
      } else {
        secondCenter = Offset(trackRect.right + p.offset + p.size.width / 2 + offset, position);
      }
      
      switch (p.type) {
        case LinearPointerType.triangle:
          _drawTrianglePointer(canvas, secondCenter, p, paint, true);
          break;
        case LinearPointerType.invertedTriangle:
          _drawTrianglePointer(canvas, secondCenter, p, paint, false);
          break;
        case LinearPointerType.circle:
          final radius = math.min(p.size.width, p.size.height) / 2;
          canvas.drawCircle(secondCenter, radius, paint);
          break;
        case LinearPointerType.diamond:
          _drawDiamondPointer(canvas, secondCenter, p, paint);
          break;
        case LinearPointerType.rectangle:
          final rect = Rect.fromCenter(
            center: secondCenter,
            width: p.size.width,
            height: p.size.height,
          );
          canvas.drawRect(rect, paint);
          break;
        default:
          break;
      }
    }
  }

  void _drawTrianglePointer(
    Canvas canvas,
    Offset center,
    LinearGaugePointer p,
    Paint paint,
    bool inverted,
  ) {
    final path = Path();
    final halfWidth = p.size.width / 2;
    final height = p.size.height;
    
    if (isHorizontal) {
      if (inverted) {
        path.moveTo(center.dx, center.dy - height / 2);
        path.lineTo(center.dx - halfWidth, center.dy + height / 2);
        path.lineTo(center.dx + halfWidth, center.dy + height / 2);
      } else {
        path.moveTo(center.dx, center.dy + height / 2);
        path.lineTo(center.dx - halfWidth, center.dy - height / 2);
        path.lineTo(center.dx + halfWidth, center.dy - height / 2);
      }
    } else {
      if (inverted) {
        path.moveTo(center.dx - height / 2, center.dy);
        path.lineTo(center.dx + height / 2, center.dy - halfWidth);
        path.lineTo(center.dx + height / 2, center.dy + halfWidth);
      } else {
        path.moveTo(center.dx + height / 2, center.dy);
        path.lineTo(center.dx - height / 2, center.dy - halfWidth);
        path.lineTo(center.dx - height / 2, center.dy + halfWidth);
      }
    }
    
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawDiamondPointer(
    Canvas canvas,
    Offset center,
    LinearGaugePointer p,
    Paint paint,
  ) {
    final path = Path();
    final halfWidth = p.size.width / 2;
    final halfHeight = p.size.height / 2;
    
    path.moveTo(center.dx, center.dy - halfHeight);
    path.lineTo(center.dx + halfWidth, center.dy);
    path.lineTo(center.dx, center.dy + halfHeight);
    path.lineTo(center.dx - halfWidth, center.dy);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_LinearGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.orientation != orientation ||
        oldDelegate.thickness != thickness ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.rulerStyle != rulerStyle;
  }
}
