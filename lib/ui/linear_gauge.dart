import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// The orientation of the linear gauge.
enum LinearGaugeOrientation {
  /// Horizontal orientation (left to right).
  horizontal,

  /// Vertical orientation (bottom to top).
  vertical,
}

/// The style of the ruler/scale marks on the linear gauge.
enum RulerStyle {
  /// No ruler marks.
  none,

  /// Simple tick marks.
  ticks,

  /// Tick marks with labels.
  ticksWithLabels,

  /// Gradient style ruler.
  gradient,
}

/// The type of pointer for the linear gauge.
enum LinearPointerType {
  /// No pointer.
  none,

  /// Triangle/arrow pointer.
  triangle,

  /// Circle pointer.
  circle,

  /// Rectangle/bar pointer.
  rectangle,

  /// Diamond shape pointer.
  diamond,

  /// Inverted triangle pointer.
  invertedTriangle,
}

/// The position of the pointer relative to the gauge track.
enum PointerPosition {
  /// Pointer above the track (horizontal) or left of track (vertical).
  start,

  /// Pointer centered on the track.
  center,

  /// Pointer below the track (horizontal) or right of track (vertical).
  end,
}

/// Configuration for a range in the linear gauge.
class LinearGaugeRange {
  /// The start value of the range (0.0 to 1.0).
  final double start;

  /// The end value of the range (0.0 to 1.0).
  final double end;

  /// The color of the range.
  final Color color;

  /// Optional label for the range.
  final String? label;

  /// Creates a linear gauge range.
  const LinearGaugeRange({
    required this.start,
    required this.end,
    required this.color,
    this.label,
  });
}

/// Configuration for a custom pointer widget.
class LinearGaugePointer {
  /// The type of pointer.
  final LinearPointerType type;

  /// The color of the pointer.
  final Color color;

  /// The size of the pointer.
  final double size;

  /// The position of the pointer.
  final PointerPosition position;

  /// Custom widget to use as pointer (overrides type).
  final Widget? customWidget;

  /// Whether the pointer is draggable.
  final bool isDraggable;

  /// Creates a linear gauge pointer configuration.
  const LinearGaugePointer({
    this.type = LinearPointerType.triangle,
    this.color = Colors.blue,
    this.size = 16.0,
    this.position = PointerPosition.start,
    this.customWidget,
    this.isDraggable = false,
  });
}

/// A customizable linear gauge widget with extensive styling options.
///
/// This widget displays a linear gauge with support for:
/// - Horizontal or vertical orientation
/// - Customizable ruler/scale marks
/// - Multiple pointer styles
/// - Value bar visualization
/// - Range coloring
/// - Animation support
/// - Touch interactivity
///
/// Example usage:
/// ```dart
/// LinearGauge(
///   value: 0.65,
///   orientation: LinearGaugeOrientation.horizontal,
///   rulerStyle: RulerStyle.ticksWithLabels,
///   pointer: LinearGaugePointer(
///     type: LinearPointerType.triangle,
///     color: Colors.red,
///   ),
///   showValueBar: true,
///   valueBarColor: Colors.blue,
/// )
/// ```
class LinearGauge extends StatefulWidget {
  /// The current value of the gauge (0.0 to 1.0).
  final double value;

  /// The minimum value for the gauge scale.
  final double minValue;

  /// The maximum value for the gauge scale.
  final double maxValue;

  /// The orientation of the gauge.
  final LinearGaugeOrientation orientation;

  /// The length of the gauge (width for horizontal, height for vertical).
  final double? length;

  /// The thickness of the gauge track.
  final double thickness;

  /// The style of ruler/scale marks.
  final RulerStyle rulerStyle;

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

  /// The text style for ruler labels.
  final TextStyle? labelStyle;

  /// Custom label formatter function.
  final String Function(double value)? labelFormatter;

  /// The pointer configuration.
  final LinearGaugePointer? pointer;

  /// Whether to show the value bar.
  final bool showValueBar;

  /// The color of the value bar.
  final Color valueBarColor;

  /// The gradient for the value bar (overrides valueBarColor).
  final Gradient? valueBarGradient;

  /// The background color of the gauge track.
  final Color backgroundColor;

  /// The ranges for coloring different sections.
  final List<LinearGaugeRange>? ranges;

  /// Whether to animate value changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Whether the gauge is interactive (can be tapped/dragged).
  final bool isInteractive;

  /// Callback when value changes through interaction.
  final ValueChanged<double>? onValueChanged;

  /// Callback when interaction starts.
  final VoidCallback? onInteractionStart;

  /// Callback when interaction ends.
  final VoidCallback? onInteractionEnd;

  /// The border radius of the gauge track.
  final BorderRadius? borderRadius;

  /// Whether to show the current value as text.
  final bool showValue;

  /// The position for displaying the value text.
  final PointerPosition valuePosition;

  /// The text style for the value display.
  final TextStyle? valueStyle;

  /// Custom value formatter for display.
  final String Function(double value)? valueFormatter;

  /// Whether to use range colors for the value bar.
  final bool useRangeColorsForValueBar;

  /// The stroke cap style for the value bar.
  final StrokeCap strokeCap;

  /// Creates a linear gauge widget.
  const LinearGauge({
    super.key,
    this.value = 0.0,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.orientation = LinearGaugeOrientation.horizontal,
    this.length,
    this.thickness = 12.0,
    this.rulerStyle = RulerStyle.none,
    this.majorTickCount = 5,
    this.minorTicksPerInterval = 4,
    this.majorTickLength = 15.0,
    this.minorTickLength = 8.0,
    this.tickColor = Colors.grey,
    this.labelStyle,
    this.labelFormatter,
    this.pointer,
    this.showValueBar = true,
    this.valueBarColor = Colors.blue,
    this.valueBarGradient,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.ranges,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.isInteractive = false,
    this.onValueChanged,
    this.onInteractionStart,
    this.onInteractionEnd,
    this.borderRadius,
    this.showValue = false,
    this.valuePosition = PointerPosition.end,
    this.valueStyle,
    this.valueFormatter,
    this.useRangeColorsForValueBar = false,
    this.strokeCap = StrokeCap.round,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  @override
  State<LinearGauge> createState() => _LinearGaugeState();
}

class _LinearGaugeState extends State<LinearGauge>
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
    } else {
      _animation = AlwaysStoppedAnimation(widget.value);
    }
  }

  @override
  void didUpdateWidget(LinearGauge oldWidget) {
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
    _animationController.dispose();
    super.dispose();
  }

  double _getNormalizedValue(Offset localPosition, Size size) {
    double normalized;
    if (widget.orientation == LinearGaugeOrientation.horizontal) {
      normalized = (localPosition.dx / size.width).clamp(0.0, 1.0);
    } else {
      normalized = (1.0 - localPosition.dy / size.height).clamp(0.0, 1.0);
    }
    return normalized;
  }

  void _handleInteraction(Offset localPosition, Size size) {
    if (!widget.isInteractive) return;
    final normalizedValue = _getNormalizedValue(localPosition, size);
    widget.onValueChanged?.call(normalizedValue);
  }

  String _formatValue(double value) {
    final actualValue = widget.minValue + value * (widget.maxValue - widget.minValue);
    if (widget.valueFormatter != null) {
      return widget.valueFormatter!(actualValue);
    }
    return actualValue.toStringAsFixed(1);
  }

  String _formatLabel(double normalizedValue) {
    final actualValue = widget.minValue + normalizedValue * (widget.maxValue - widget.minValue);
    if (widget.labelFormatter != null) {
      return widget.labelFormatter!(actualValue);
    }
    return actualValue.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.orientation == LinearGaugeOrientation.horizontal;

    return LayoutBuilder(
      builder: (context, constraints) {
        final length = widget.length ??
            (isHorizontal ? constraints.maxWidth : constraints.maxHeight);

        final mainAxisSize = length;
        final crossAxisSize = _calculateCrossAxisSize();

        return GestureDetector(
          onPanStart: widget.isInteractive
              ? (details) {
                  _isDragging = true;
                  widget.onInteractionStart?.call();
                  _handleInteraction(
                    details.localPosition,
                    isHorizontal
                        ? Size(mainAxisSize, crossAxisSize)
                        : Size(crossAxisSize, mainAxisSize),
                  );
                }
              : null,
          onPanUpdate: widget.isInteractive
              ? (details) {
                  _handleInteraction(
                    details.localPosition,
                    isHorizontal
                        ? Size(mainAxisSize, crossAxisSize)
                        : Size(crossAxisSize, mainAxisSize),
                  );
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
                  _handleInteraction(
                    details.localPosition,
                    isHorizontal
                        ? Size(mainAxisSize, crossAxisSize)
                        : Size(crossAxisSize, mainAxisSize),
                  );
                }
              : null,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: isHorizontal
                    ? Size(mainAxisSize, crossAxisSize)
                    : Size(crossAxisSize, mainAxisSize),
                painter: _LinearGaugePainter(
                  value: _isDragging ? widget.value : _animation.value,
                  orientation: widget.orientation,
                  thickness: widget.thickness,
                  rulerStyle: widget.rulerStyle,
                  majorTickCount: widget.majorTickCount,
                  minorTicksPerInterval: widget.minorTicksPerInterval,
                  majorTickLength: widget.majorTickLength,
                  minorTickLength: widget.minorTickLength,
                  tickColor: widget.tickColor,
                  labelStyle: widget.labelStyle ?? const TextStyle(fontSize: 10, color: Colors.grey),
                  labelFormatter: _formatLabel,
                  pointer: widget.pointer,
                  showValueBar: widget.showValueBar,
                  valueBarColor: widget.valueBarColor,
                  valueBarGradient: widget.valueBarGradient,
                  backgroundColor: widget.backgroundColor,
                  ranges: widget.ranges,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.thickness / 2),
                  showValue: widget.showValue,
                  valuePosition: widget.valuePosition,
                  valueStyle: widget.valueStyle ?? const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  valueFormatter: _formatValue,
                  useRangeColorsForValueBar: widget.useRangeColorsForValueBar,
                  strokeCap: widget.strokeCap,
                ),
              );
            },
          ),
        );
      },
    );
  }

  double _calculateCrossAxisSize() {
    double size = widget.thickness;

    // Add space for ruler
    if (widget.rulerStyle != RulerStyle.none) {
      size += widget.majorTickLength + 8;
      if (widget.rulerStyle == RulerStyle.ticksWithLabels) {
        size += 16; // Space for labels
      }
    }

    // Add space for pointer
    if (widget.pointer != null && widget.pointer!.type != LinearPointerType.none) {
      size += widget.pointer!.size + 4;
    }

    // Add space for value display
    if (widget.showValue) {
      size += 20;
    }

    return math.max(size, 40);
  }
}

class _LinearGaugePainter extends CustomPainter {
  final double value;
  final LinearGaugeOrientation orientation;
  final double thickness;
  final RulerStyle rulerStyle;
  final int majorTickCount;
  final int minorTicksPerInterval;
  final double majorTickLength;
  final double minorTickLength;
  final Color tickColor;
  final TextStyle labelStyle;
  final String Function(double) labelFormatter;
  final LinearGaugePointer? pointer;
  final bool showValueBar;
  final Color valueBarColor;
  final Gradient? valueBarGradient;
  final Color backgroundColor;
  final List<LinearGaugeRange>? ranges;
  final BorderRadius borderRadius;
  final bool showValue;
  final PointerPosition valuePosition;
  final TextStyle valueStyle;
  final String Function(double) valueFormatter;
  final bool useRangeColorsForValueBar;
  final StrokeCap strokeCap;

  _LinearGaugePainter({
    required this.value,
    required this.orientation,
    required this.thickness,
    required this.rulerStyle,
    required this.majorTickCount,
    required this.minorTicksPerInterval,
    required this.majorTickLength,
    required this.minorTickLength,
    required this.tickColor,
    required this.labelStyle,
    required this.labelFormatter,
    this.pointer,
    required this.showValueBar,
    required this.valueBarColor,
    this.valueBarGradient,
    required this.backgroundColor,
    this.ranges,
    required this.borderRadius,
    required this.showValue,
    required this.valuePosition,
    required this.valueStyle,
    required this.valueFormatter,
    required this.useRangeColorsForValueBar,
    required this.strokeCap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isHorizontal = orientation == LinearGaugeOrientation.horizontal;
    final trackLength = isHorizontal ? size.width : size.height;

    // Calculate track position
    double trackOffset = 0;
    if (pointer != null && pointer!.position == PointerPosition.start) {
      trackOffset = pointer!.size + 4;
    }
    if (rulerStyle != RulerStyle.none) {
      trackOffset += majorTickLength + 8;
      if (rulerStyle == RulerStyle.ticksWithLabels) {
        trackOffset += 16;
      }
    }

    // Draw track background
    _drawTrackBackground(canvas, size, trackOffset, trackLength, isHorizontal);

    // Draw ranges
    if (ranges != null) {
      _drawRanges(canvas, size, trackOffset, trackLength, isHorizontal);
    }

    // Draw value bar
    if (showValueBar && value > 0) {
      _drawValueBar(canvas, size, trackOffset, trackLength, isHorizontal);
    }

    // Draw ruler
    if (rulerStyle != RulerStyle.none) {
      _drawRuler(canvas, size, trackOffset, trackLength, isHorizontal);
    }

    // Draw pointer
    if (pointer != null && pointer!.type != LinearPointerType.none) {
      _drawPointer(canvas, size, trackOffset, trackLength, isHorizontal);
    }

    // Draw value text
    if (showValue) {
      _drawValueText(canvas, size, trackOffset, trackLength, isHorizontal);
    }
  }

  void _drawTrackBackground(Canvas canvas, Size size, double trackOffset, double trackLength, bool isHorizontal) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    RRect trackRect;
    if (isHorizontal) {
      trackRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(0, trackOffset, trackLength, thickness),
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      );
    } else {
      trackRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(trackOffset, 0, thickness, trackLength),
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      );
    }

    canvas.drawRRect(trackRect, paint);
  }

  void _drawRanges(Canvas canvas, Size size, double trackOffset, double trackLength, bool isHorizontal) {
    for (final range in ranges!) {
      final paint = Paint()
        ..color = range.color.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;

      final startPos = range.start * trackLength;
      final endPos = range.end * trackLength;
      final rangeLength = endPos - startPos;

      RRect rangeRect;
      if (isHorizontal) {
        rangeRect = RRect.fromRectAndCorners(
          Rect.fromLTWH(startPos, trackOffset, rangeLength, thickness),
          topLeft: range.start == 0 ? borderRadius.topLeft : Radius.zero,
          topRight: range.end == 1 ? borderRadius.topRight : Radius.zero,
          bottomLeft: range.start == 0 ? borderRadius.bottomLeft : Radius.zero,
          bottomRight: range.end == 1 ? borderRadius.bottomRight : Radius.zero,
        );
      } else {
        final invertedStart = trackLength - endPos;
        rangeRect = RRect.fromRectAndCorners(
          Rect.fromLTWH(trackOffset, invertedStart, thickness, rangeLength),
          topLeft: range.end == 1 ? borderRadius.topLeft : Radius.zero,
          topRight: range.end == 1 ? borderRadius.topRight : Radius.zero,
          bottomLeft: range.start == 0 ? borderRadius.bottomLeft : Radius.zero,
          bottomRight: range.start == 0 ? borderRadius.bottomRight : Radius.zero,
        );
      }

      canvas.drawRRect(rangeRect, paint);
    }
  }

  void _drawValueBar(Canvas canvas, Size size, double trackOffset, double trackLength, bool isHorizontal) {
    Color barColor = valueBarColor;

    // Determine color from ranges if enabled
    if (useRangeColorsForValueBar && ranges != null) {
      for (final range in ranges!) {
        if (value >= range.start && value <= range.end) {
          barColor = range.color;
          break;
        }
      }
    }

    final paint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;

    if (valueBarGradient != null) {
      final rect = isHorizontal
          ? Rect.fromLTWH(0, trackOffset, trackLength * value, thickness)
          : Rect.fromLTWH(trackOffset, trackLength * (1 - value), thickness, trackLength * value);
      paint.shader = valueBarGradient!.createShader(rect);
    }

    final valueLength = trackLength * value;

    RRect valueRect;
    if (isHorizontal) {
      valueRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(0, trackOffset, valueLength, thickness),
        topLeft: borderRadius.topLeft,
        topRight: value >= 1 ? borderRadius.topRight : Radius.circular(thickness / 2),
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: value >= 1 ? borderRadius.bottomRight : Radius.circular(thickness / 2),
      );
    } else {
      valueRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(trackOffset, trackLength - valueLength, thickness, valueLength),
        topLeft: value >= 1 ? borderRadius.topLeft : Radius.circular(thickness / 2),
        topRight: value >= 1 ? borderRadius.topRight : Radius.circular(thickness / 2),
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      );
    }

    canvas.drawRRect(valueRect, paint);
  }

  void _drawRuler(Canvas canvas, Size size, double trackOffset, double trackLength, bool isHorizontal) {
    final tickPaint = Paint()
      ..color = tickColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final totalTicks = majorTickCount + (majorTickCount - 1) * minorTicksPerInterval;

    for (int i = 0; i <= totalTicks; i++) {
      final isMajor = i % (minorTicksPerInterval + 1) == 0;
      final tickLength = isMajor ? majorTickLength : minorTickLength;
      final position = i / totalTicks;

      if (isHorizontal) {
        final x = position * trackLength;
        final y1 = trackOffset - 4;
        final y2 = y1 - tickLength;
        canvas.drawLine(Offset(x, y1), Offset(x, y2), tickPaint);

        // Draw labels for major ticks
        if (isMajor && rulerStyle == RulerStyle.ticksWithLabels) {
          final label = labelFormatter(position);
          final textPainter = TextPainter(
            text: TextSpan(text: label, style: labelStyle),
            textDirection: TextDirection.ltr,
          )..layout();
          textPainter.paint(
            canvas,
            Offset(x - textPainter.width / 2, y2 - textPainter.height - 2),
          );
        }
      } else {
        final y = trackLength - position * trackLength;
        final x1 = trackOffset - 4;
        final x2 = x1 - tickLength;
        canvas.drawLine(Offset(x1, y), Offset(x2, y), tickPaint);

        // Draw labels for major ticks
        if (isMajor && rulerStyle == RulerStyle.ticksWithLabels) {
          final label = labelFormatter(position);
          final textPainter = TextPainter(
            text: TextSpan(text: label, style: labelStyle),
            textDirection: TextDirection.ltr,
          )..layout();
          textPainter.paint(
            canvas,
            Offset(x2 - textPainter.width - 4, y - textPainter.height / 2),
          );
        }
      }
    }
  }

  void _drawPointer(Canvas canvas, Size size, double trackOffset, double trackLength, bool isHorizontal) {
    final pointerSize = pointer!.size;
    final pointerColor = pointer!.color;

    double pointerX, pointerY;

    if (isHorizontal) {
      pointerX = value * trackLength;
      switch (pointer!.position) {
        case PointerPosition.start:
          pointerY = trackOffset - pointerSize / 2 - 2;
          break;
        case PointerPosition.center:
          pointerY = trackOffset + thickness / 2;
          break;
        case PointerPosition.end:
          pointerY = trackOffset + thickness + pointerSize / 2 + 2;
          break;
      }
    } else {
      pointerY = trackLength - value * trackLength;
      switch (pointer!.position) {
        case PointerPosition.start:
          pointerX = trackOffset - pointerSize / 2 - 2;
          break;
        case PointerPosition.center:
          pointerX = trackOffset + thickness / 2;
          break;
        case PointerPosition.end:
          pointerX = trackOffset + thickness + pointerSize / 2 + 2;
          break;
      }
    }

    final paint = Paint()
      ..color = pointerColor
      ..style = PaintingStyle.fill;

    switch (pointer!.type) {
      case LinearPointerType.none:
        break;
      case LinearPointerType.triangle:
        _drawTrianglePointer(canvas, pointerX, pointerY, pointerSize, paint, isHorizontal, false);
        break;
      case LinearPointerType.invertedTriangle:
        _drawTrianglePointer(canvas, pointerX, pointerY, pointerSize, paint, isHorizontal, true);
        break;
      case LinearPointerType.circle:
        canvas.drawCircle(Offset(pointerX, pointerY), pointerSize / 2, paint);
        break;
      case LinearPointerType.rectangle:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(pointerX, pointerY), width: pointerSize, height: pointerSize * 0.6),
            Radius.circular(2),
          ),
          paint,
        );
        break;
      case LinearPointerType.diamond:
        _drawDiamondPointer(canvas, pointerX, pointerY, pointerSize, paint);
        break;
    }
  }

  void _drawTrianglePointer(Canvas canvas, double x, double y, double size, Paint paint, bool isHorizontal, bool inverted) {
    final path = Path();
    final halfSize = size / 2;

    if (isHorizontal) {
      if (inverted) {
        path.moveTo(x, y + halfSize);
        path.lineTo(x - halfSize, y - halfSize);
        path.lineTo(x + halfSize, y - halfSize);
      } else {
        path.moveTo(x, y - halfSize);
        path.lineTo(x - halfSize, y + halfSize);
        path.lineTo(x + halfSize, y + halfSize);
      }
    } else {
      if (inverted) {
        path.moveTo(x - halfSize, y);
        path.lineTo(x + halfSize, y - halfSize);
        path.lineTo(x + halfSize, y + halfSize);
      } else {
        path.moveTo(x + halfSize, y);
        path.lineTo(x - halfSize, y - halfSize);
        path.lineTo(x - halfSize, y + halfSize);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawDiamondPointer(Canvas canvas, double x, double y, double size, Paint paint) {
    final path = Path();
    final halfSize = size / 2;

    path.moveTo(x, y - halfSize);
    path.lineTo(x + halfSize, y);
    path.lineTo(x, y + halfSize);
    path.lineTo(x - halfSize, y);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _drawValueText(Canvas canvas, Size size, double trackOffset, double trackLength, bool isHorizontal) {
    final valueText = valueFormatter(value);
    final textPainter = TextPainter(
      text: TextSpan(text: valueText, style: valueStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    double x, y;

    if (isHorizontal) {
      x = value * trackLength - textPainter.width / 2;
      x = x.clamp(0, trackLength - textPainter.width);
      switch (valuePosition) {
        case PointerPosition.start:
          y = trackOffset - textPainter.height - majorTickLength - 20;
          break;
        case PointerPosition.center:
          y = trackOffset + (thickness - textPainter.height) / 2;
          break;
        case PointerPosition.end:
          y = trackOffset + thickness + 4;
          break;
      }
    } else {
      y = trackLength - value * trackLength - textPainter.height / 2;
      y = y.clamp(0, trackLength - textPainter.height);
      switch (valuePosition) {
        case PointerPosition.start:
          x = trackOffset - textPainter.width - majorTickLength - 20;
          break;
        case PointerPosition.center:
          x = trackOffset + (thickness - textPainter.width) / 2;
          break;
        case PointerPosition.end:
          x = trackOffset + thickness + 4;
          break;
      }
    }

    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(_LinearGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.orientation != orientation ||
        oldDelegate.thickness != thickness ||
        oldDelegate.rulerStyle != rulerStyle ||
        oldDelegate.showValueBar != showValueBar ||
        oldDelegate.valueBarColor != valueBarColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
