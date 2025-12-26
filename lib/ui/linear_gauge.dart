import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The orientation of the linear gauge.
enum LinearGaugeOrientation {
  /// Horizontal orientation (left to right).
  horizontal,

  /// Vertical orientation (bottom to top).
  vertical,
}

/// The style of ruler/scale marks on the gauge.
enum RulerStyle {
  /// No ruler marks.
  none,

  /// Simple tick marks only.
  simple,

  /// Tick marks with labels.
  labeled,

  /// Major and minor tick marks.
  graduated,
}

/// The type of pointer to display on the gauge.
enum PointerType {
  /// No pointer.
  none,

  /// Triangle/arrow pointer.
  triangle,

  /// Diamond shaped pointer.
  diamond,

  /// Circle pointer.
  circle,

  /// Rectangle/bar pointer.
  rectangle,

  /// Inverted triangle pointer.
  invertedTriangle,

  /// Custom widget pointer.
  custom,
}

/// The position of the pointer relative to the gauge.
enum PointerPosition {
  /// Pointer above/left of the gauge.
  start,

  /// Pointer centered on the gauge.
  center,

  /// Pointer below/right of the gauge.
  end,
}

/// Configuration for a range in a linear gauge.
class LinearGaugeRange {
  /// The start value of the range (0.0 to 1.0).
  final double start;

  /// The end value of the range (0.0 to 1.0).
  final double end;

  /// The color of the range.
  final Color color;

  /// Optional label for the range.
  final String? label;

  /// The height/thickness of the range relative to gauge height.
  final double? thickness;

  /// Creates a linear gauge range.
  const LinearGaugeRange({
    required this.start,
    required this.end,
    required this.color,
    this.label,
    this.thickness,
  });
}

/// Configuration for ruler/scale of the gauge.
class RulerConfig {
  /// The style of the ruler.
  final RulerStyle style;

  /// Number of major divisions.
  final int majorDivisions;

  /// Number of minor divisions between major divisions.
  final int minorDivisionsPerMajor;

  /// Length of major tick marks.
  final double majorTickLength;

  /// Length of minor tick marks.
  final double minorTickLength;

  /// Thickness of tick marks.
  final double tickThickness;

  /// Color of tick marks.
  final Color? tickColor;

  /// Text style for ruler labels.
  final TextStyle? labelStyle;

  /// Custom label formatter.
  final String Function(double value)? labelFormatter;

  /// Position of labels relative to ticks.
  final PointerPosition labelPosition;

  /// Creates a ruler configuration.
  const RulerConfig({
    this.style = RulerStyle.simple,
    this.majorDivisions = 10,
    this.minorDivisionsPerMajor = 4,
    this.majorTickLength = 15.0,
    this.minorTickLength = 8.0,
    this.tickThickness = 1.5,
    this.tickColor,
    this.labelStyle,
    this.labelFormatter,
    this.labelPosition = PointerPosition.end,
  });
}

/// Configuration for the gauge pointer.
class PointerConfig {
  /// The type of pointer.
  final PointerType type;

  /// The size of the pointer.
  final Size size;

  /// The color of the pointer.
  final Color color;

  /// Border color of the pointer.
  final Color? borderColor;

  /// Border width of the pointer.
  final double borderWidth;

  /// Position of the pointer relative to the gauge.
  final PointerPosition position;

  /// Offset from the gauge.
  final double offset;

  /// Custom widget for the pointer (when type is custom).
  final Widget? customWidget;

  /// Whether to show shadow under the pointer.
  final bool showShadow;

  /// Creates a pointer configuration.
  const PointerConfig({
    this.type = PointerType.triangle,
    this.size = const Size(15, 20),
    this.color = Colors.red,
    this.borderColor,
    this.borderWidth = 0,
    this.position = PointerPosition.start,
    this.offset = 2.0,
    this.customWidget,
    this.showShadow = true,
  });
}

/// A customizable linear gauge widget.
///
/// This widget displays a linear gauge with extensive customization options
/// including orientation, ruler styles, pointers, value bars, and ranges.
///
/// Example usage:
/// ```dart
/// LinearGauge(
///   value: 0.65,
///   orientation: LinearGaugeOrientation.horizontal,
///   showValueBar: true,
///   valueBarColor: Colors.blue,
///   rulerConfig: RulerConfig(style: RulerStyle.graduated),
///   pointerConfig: PointerConfig(type: PointerType.triangle),
///   animation: true,
/// )
/// ```
class LinearGauge extends StatefulWidget {
  /// The current value between 0.0 and 1.0.
  final double value;

  /// The minimum value for display purposes.
  final double minValue;

  /// The maximum value for display purposes.
  final double maxValue;

  /// The orientation of the gauge.
  final LinearGaugeOrientation orientation;

  /// The length/width of the gauge.
  final double? gaugeLength;

  /// The thickness/height of the gauge track.
  final double gaugeThickness;

  /// The background color of the gauge track.
  final Color backgroundColor;

  /// The border radius of the gauge track.
  final BorderRadius? borderRadius;

  /// Whether to show the value bar.
  final bool showValueBar;

  /// The color of the value bar.
  final Color valueBarColor;

  /// The gradient for the value bar.
  final Gradient? valueBarGradient;

  /// The thickness of the value bar relative to gauge thickness.
  final double? valueBarThickness;

  /// Ranges to display on the gauge.
  final List<LinearGaugeRange>? ranges;

  /// Whether ranges should be shown behind or on the track.
  final bool rangesOnTrack;

  /// Configuration for the ruler/scale.
  final RulerConfig? rulerConfig;

  /// Configuration for the pointer.
  final PointerConfig? pointerConfig;

  /// Whether to animate value changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Callback when animation completes.
  final VoidCallback? onAnimationEnd;

  /// Callback when the gauge is tapped.
  final ValueChanged<double>? onValueChanged;

  /// Whether the gauge is interactive (can be tapped/dragged).
  final bool interactive;

  /// Widget to display at the start of the gauge.
  final Widget? startChild;

  /// Widget to display at the end of the gauge.
  final Widget? endChild;

  /// Whether to show the current value as text.
  final bool showValue;

  /// Text style for the value display.
  final TextStyle? valueTextStyle;

  /// Custom formatter for the value display.
  final String Function(double value)? valueFormatter;

  /// Position of the value text.
  final PointerPosition valuePosition;

  /// The stroke cap style for the value bar.
  final StrokeCap strokeCap;

  /// Creates a linear gauge widget.
  const LinearGauge({
    super.key,
    this.value = 0.0,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.orientation = LinearGaugeOrientation.horizontal,
    this.gaugeLength,
    this.gaugeThickness = 20.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.borderRadius,
    this.showValueBar = true,
    this.valueBarColor = Colors.blue,
    this.valueBarGradient,
    this.valueBarThickness,
    this.ranges,
    this.rangesOnTrack = true,
    this.rulerConfig,
    this.pointerConfig,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.onAnimationEnd,
    this.onValueChanged,
    this.interactive = false,
    this.startChild,
    this.endChild,
    this.showValue = false,
    this.valueTextStyle,
    this.valueFormatter,
    this.valuePosition = PointerPosition.center,
    this.strokeCap = StrokeCap.round,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  @override
  State<LinearGauge> createState() => _LinearGaugeState();
}

class _LinearGaugeState extends State<LinearGauge>
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
  void didUpdateWidget(LinearGauge oldWidget) {
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

  double _calculateValueFromPosition(Offset localPosition, Size size) {
    double value;
    if (widget.orientation == LinearGaugeOrientation.horizontal) {
      value = (localPosition.dx / size.width).clamp(0.0, 1.0);
    } else {
      value = (1.0 - localPosition.dy / size.height).clamp(0.0, 1.0);
    }
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
    return displayValue.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.orientation == LinearGaugeOrientation.horizontal;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final gaugeLength = widget.gaugeLength ??
                (isHorizontal ? constraints.maxWidth : constraints.maxHeight);

            final mainContent = _buildGaugeContent(gaugeLength, isHorizontal);

            if (widget.startChild != null || widget.endChild != null) {
              final children = <Widget>[
                if (widget.startChild != null) ...[
                  widget.startChild!,
                  SizedBox(width: isHorizontal ? 8 : 0, height: isHorizontal ? 0 : 8),
                ],
                Expanded(child: mainContent),
                if (widget.endChild != null) ...[
                  SizedBox(width: isHorizontal ? 8 : 0, height: isHorizontal ? 0 : 8),
                  widget.endChild!,
                ],
              ];

              return isHorizontal
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

            return mainContent;
          },
        );
      },
    );
  }

  Widget _buildGaugeContent(double gaugeLength, bool isHorizontal) {
    Widget gauge = CustomPaint(
      size: isHorizontal
          ? Size(gaugeLength, _calculateTotalHeight())
          : Size(_calculateTotalHeight(), gaugeLength),
      painter: _LinearGaugePainter(
        value: _animation.value,
        orientation: widget.orientation,
        gaugeThickness: widget.gaugeThickness,
        backgroundColor: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        showValueBar: widget.showValueBar,
        valueBarColor: widget.valueBarColor,
        valueBarGradient: widget.valueBarGradient,
        valueBarThickness: widget.valueBarThickness,
        ranges: widget.ranges,
        rangesOnTrack: widget.rangesOnTrack,
        rulerConfig: widget.rulerConfig,
        pointerConfig: widget.pointerConfig,
        strokeCap: widget.strokeCap,
      ),
    );

    if (widget.interactive) {
      gauge = GestureDetector(
        onTapDown: (details) => _handleInteraction(
          details.localPosition,
          isHorizontal
              ? Size(gaugeLength, _calculateTotalHeight())
              : Size(_calculateTotalHeight(), gaugeLength),
        ),
        onPanUpdate: (details) => _handleInteraction(
          details.localPosition,
          isHorizontal
              ? Size(gaugeLength, _calculateTotalHeight())
              : Size(_calculateTotalHeight(), gaugeLength),
        ),
        child: gauge,
      );
    }

    if (widget.showValue) {
      final valueText = Text(
        _formatValue(_animation.value),
        style: widget.valueTextStyle ??
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
      );

      if (isHorizontal) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.valuePosition == PointerPosition.start) ...[
              valueText,
              const SizedBox(height: 4),
            ],
            gauge,
            if (widget.valuePosition == PointerPosition.end) ...[
              const SizedBox(height: 4),
              valueText,
            ],
          ],
        );
      } else {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.valuePosition == PointerPosition.start) ...[
              valueText,
              const SizedBox(width: 4),
            ],
            gauge,
            if (widget.valuePosition == PointerPosition.end) ...[
              const SizedBox(width: 4),
              valueText,
            ],
          ],
        );
      }
    }

    return gauge;
  }

  double _calculateTotalHeight() {
    double height = widget.gaugeThickness;

    if (widget.rulerConfig != null) {
      final ruler = widget.rulerConfig!;
      if (ruler.style != RulerStyle.none) {
        height += ruler.majorTickLength + 5;
        if (ruler.style == RulerStyle.labeled || ruler.style == RulerStyle.graduated) {
          height += 20; // Space for labels
        }
      }
    }

    if (widget.pointerConfig != null) {
      final pointer = widget.pointerConfig!;
      if (pointer.type != PointerType.none) {
        height += pointer.size.height + pointer.offset;
      }
    }

    return height;
  }
}

class _LinearGaugePainter extends CustomPainter {
  final double value;
  final LinearGaugeOrientation orientation;
  final double gaugeThickness;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final bool showValueBar;
  final Color valueBarColor;
  final Gradient? valueBarGradient;
  final double? valueBarThickness;
  final List<LinearGaugeRange>? ranges;
  final bool rangesOnTrack;
  final RulerConfig? rulerConfig;
  final PointerConfig? pointerConfig;
  final StrokeCap strokeCap;

  _LinearGaugePainter({
    required this.value,
    required this.orientation,
    required this.gaugeThickness,
    required this.backgroundColor,
    this.borderRadius,
    required this.showValueBar,
    required this.valueBarColor,
    this.valueBarGradient,
    this.valueBarThickness,
    this.ranges,
    required this.rangesOnTrack,
    this.rulerConfig,
    this.pointerConfig,
    required this.strokeCap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isHorizontal = orientation == LinearGaugeOrientation.horizontal;

    // Calculate the track rect
    double trackY = 0;
    if (pointerConfig != null && 
        pointerConfig!.type != PointerType.none &&
        pointerConfig!.position == PointerPosition.start) {
      trackY = pointerConfig!.size.height + pointerConfig!.offset;
    }

    final trackRect = isHorizontal
        ? Rect.fromLTWH(0, trackY, size.width, gaugeThickness)
        : Rect.fromLTWH(trackY, 0, gaugeThickness, size.height);

    // Draw background track
    _drawTrack(canvas, trackRect, isHorizontal);

    // Draw ranges
    if (ranges != null && ranges!.isNotEmpty) {
      _drawRanges(canvas, trackRect, isHorizontal);
    }

    // Draw value bar
    if (showValueBar && value > 0) {
      _drawValueBar(canvas, trackRect, isHorizontal);
    }

    // Draw ruler
    if (rulerConfig != null && rulerConfig!.style != RulerStyle.none) {
      _drawRuler(canvas, trackRect, size, isHorizontal);
    }

    // Draw pointer
    if (pointerConfig != null && pointerConfig!.type != PointerType.none) {
      _drawPointer(canvas, trackRect, isHorizontal);
    }
  }

  void _drawTrack(Canvas canvas, Rect trackRect, bool isHorizontal) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final radius = borderRadius ?? BorderRadius.circular(gaugeThickness / 2);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        trackRect,
        topLeft: radius.topLeft,
        topRight: radius.topRight,
        bottomLeft: radius.bottomLeft,
        bottomRight: radius.bottomRight,
      ),
      paint,
    );
  }

  void _drawRanges(Canvas canvas, Rect trackRect, bool isHorizontal) {
    for (final range in ranges!) {
      final paint = Paint()
        ..color = range.color
        ..style = PaintingStyle.fill;

      final thickness = range.thickness ?? gaugeThickness;
      final thicknessOffset = (gaugeThickness - thickness) / 2;

      Rect rangeRect;
      if (isHorizontal) {
        final startX = trackRect.left + trackRect.width * range.start;
        final endX = trackRect.left + trackRect.width * range.end;
        rangeRect = Rect.fromLTWH(
          startX,
          trackRect.top + thicknessOffset,
          endX - startX,
          thickness,
        );
      } else {
        final startY = trackRect.bottom - trackRect.height * range.start;
        final endY = trackRect.bottom - trackRect.height * range.end;
        rangeRect = Rect.fromLTWH(
          trackRect.left + thicknessOffset,
          endY,
          thickness,
          startY - endY,
        );
      }

      final radius = borderRadius ?? BorderRadius.circular(thickness / 2);
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          rangeRect,
          topLeft: radius.topLeft,
          topRight: radius.topRight,
          bottomLeft: radius.bottomLeft,
          bottomRight: radius.bottomRight,
        ),
        paint,
      );
    }
  }

  void _drawValueBar(Canvas canvas, Rect trackRect, bool isHorizontal) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final barThickness = valueBarThickness ?? gaugeThickness;
    final thicknessOffset = (gaugeThickness - barThickness) / 2;

    Rect valueRect;
    if (isHorizontal) {
      valueRect = Rect.fromLTWH(
        trackRect.left,
        trackRect.top + thicknessOffset,
        trackRect.width * value,
        barThickness,
      );
    } else {
      valueRect = Rect.fromLTWH(
        trackRect.left + thicknessOffset,
        trackRect.bottom - trackRect.height * value,
        barThickness,
        trackRect.height * value,
      );
    }

    if (valueBarGradient != null) {
      paint.shader = valueBarGradient!.createShader(valueRect);
    } else {
      paint.color = valueBarColor;
    }

    final radius = borderRadius ?? BorderRadius.circular(barThickness / 2);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        valueRect,
        topLeft: radius.topLeft,
        topRight: radius.topRight,
        bottomLeft: radius.bottomLeft,
        bottomRight: radius.bottomRight,
      ),
      paint,
    );
  }

  void _drawRuler(Canvas canvas, Rect trackRect, Size size, bool isHorizontal) {
    final ruler = rulerConfig!;
    final tickPaint = Paint()
      ..color = ruler.tickColor ?? Colors.grey.shade700
      ..strokeWidth = ruler.tickThickness
      ..strokeCap = StrokeCap.round;

    final totalTicks = ruler.majorDivisions;
    final minorPerMajor = ruler.minorDivisionsPerMajor;

    for (int i = 0; i <= totalTicks; i++) {
      final isMajor = true;
      final tickLength = isMajor ? ruler.majorTickLength : ruler.minorTickLength;
      final progress = i / totalTicks;

      _drawTick(canvas, trackRect, progress, tickLength, tickPaint, isHorizontal);

      // Draw minor ticks
      if (i < totalTicks && ruler.style == RulerStyle.graduated) {
        for (int j = 1; j < minorPerMajor; j++) {
          final minorProgress = (i + j / minorPerMajor) / totalTicks;
          _drawTick(canvas, trackRect, minorProgress, ruler.minorTickLength, tickPaint, isHorizontal);
        }
      }
    }
  }

  void _drawTick(Canvas canvas, Rect trackRect, double progress, double tickLength,
      Paint paint, bool isHorizontal) {
    final ruler = rulerConfig!;

    if (isHorizontal) {
      final x = trackRect.left + trackRect.width * progress;
      double startY, endY;
      
      if (ruler.labelPosition == PointerPosition.start) {
        startY = trackRect.top - 2;
        endY = startY - tickLength;
      } else {
        startY = trackRect.bottom + 2;
        endY = startY + tickLength;
      }
      
      canvas.drawLine(Offset(x, startY), Offset(x, endY), paint);
    } else {
      final y = trackRect.bottom - trackRect.height * progress;
      double startX, endX;
      
      if (ruler.labelPosition == PointerPosition.start) {
        startX = trackRect.left - 2;
        endX = startX - tickLength;
      } else {
        startX = trackRect.right + 2;
        endX = startX + tickLength;
      }
      
      canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
    }
  }

  void _drawPointer(Canvas canvas, Rect trackRect, bool isHorizontal) {
    final pointer = pointerConfig!;
    final pointerPosition = isHorizontal
        ? trackRect.left + trackRect.width * value
        : trackRect.bottom - trackRect.height * value;

    Offset center;
    if (isHorizontal) {
      switch (pointer.position) {
        case PointerPosition.start:
          center = Offset(pointerPosition, trackRect.top - pointer.offset - pointer.size.height / 2);
          break;
        case PointerPosition.center:
          center = Offset(pointerPosition, trackRect.center.dy);
          break;
        case PointerPosition.end:
          center = Offset(pointerPosition, trackRect.bottom + pointer.offset + pointer.size.height / 2);
          break;
      }
    } else {
      switch (pointer.position) {
        case PointerPosition.start:
          center = Offset(trackRect.left - pointer.offset - pointer.size.width / 2, pointerPosition);
          break;
        case PointerPosition.center:
          center = Offset(trackRect.center.dx, pointerPosition);
          break;
        case PointerPosition.end:
          center = Offset(trackRect.right + pointer.offset + pointer.size.width / 2, pointerPosition);
          break;
      }
    }

    // Draw shadow
    if (pointer.showShadow) {
      final shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      _drawPointerShape(canvas, center, pointer, shadowPaint, isHorizontal);
    }

    // Draw pointer
    final paint = Paint()
      ..color = pointer.color
      ..style = PaintingStyle.fill;
    _drawPointerShape(canvas, center, pointer, paint, isHorizontal);

    // Draw border
    if (pointer.borderColor != null && pointer.borderWidth > 0) {
      final borderPaint = Paint()
        ..color = pointer.borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = pointer.borderWidth;
      _drawPointerShape(canvas, center, pointer, borderPaint, isHorizontal);
    }
  }

  void _drawPointerShape(Canvas canvas, Offset center, PointerConfig pointer,
      Paint paint, bool isHorizontal) {
    final halfWidth = pointer.size.width / 2;
    final halfHeight = pointer.size.height / 2;

    Path path;
    switch (pointer.type) {
      case PointerType.triangle:
        path = Path();
        if (isHorizontal) {
          if (pointer.position == PointerPosition.start) {
            path.moveTo(center.dx, center.dy + halfHeight);
            path.lineTo(center.dx - halfWidth, center.dy - halfHeight);
            path.lineTo(center.dx + halfWidth, center.dy - halfHeight);
          } else {
            path.moveTo(center.dx, center.dy - halfHeight);
            path.lineTo(center.dx - halfWidth, center.dy + halfHeight);
            path.lineTo(center.dx + halfWidth, center.dy + halfHeight);
          }
        } else {
          if (pointer.position == PointerPosition.start) {
            path.moveTo(center.dx + halfWidth, center.dy);
            path.lineTo(center.dx - halfWidth, center.dy - halfHeight);
            path.lineTo(center.dx - halfWidth, center.dy + halfHeight);
          } else {
            path.moveTo(center.dx - halfWidth, center.dy);
            path.lineTo(center.dx + halfWidth, center.dy - halfHeight);
            path.lineTo(center.dx + halfWidth, center.dy + halfHeight);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
        break;

      case PointerType.invertedTriangle:
        path = Path();
        if (isHorizontal) {
          if (pointer.position == PointerPosition.start) {
            path.moveTo(center.dx, center.dy - halfHeight);
            path.lineTo(center.dx - halfWidth, center.dy + halfHeight);
            path.lineTo(center.dx + halfWidth, center.dy + halfHeight);
          } else {
            path.moveTo(center.dx, center.dy + halfHeight);
            path.lineTo(center.dx - halfWidth, center.dy - halfHeight);
            path.lineTo(center.dx + halfWidth, center.dy - halfHeight);
          }
        } else {
          if (pointer.position == PointerPosition.start) {
            path.moveTo(center.dx - halfWidth, center.dy);
            path.lineTo(center.dx + halfWidth, center.dy - halfHeight);
            path.lineTo(center.dx + halfWidth, center.dy + halfHeight);
          } else {
            path.moveTo(center.dx + halfWidth, center.dy);
            path.lineTo(center.dx - halfWidth, center.dy - halfHeight);
            path.lineTo(center.dx - halfWidth, center.dy + halfHeight);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
        break;

      case PointerType.diamond:
        path = Path();
        path.moveTo(center.dx, center.dy - halfHeight);
        path.lineTo(center.dx + halfWidth, center.dy);
        path.lineTo(center.dx, center.dy + halfHeight);
        path.lineTo(center.dx - halfWidth, center.dy);
        path.close();
        canvas.drawPath(path, paint);
        break;

      case PointerType.circle:
        canvas.drawCircle(center, math.min(halfWidth, halfHeight), paint);
        break;

      case PointerType.rectangle:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: center,
              width: pointer.size.width,
              height: pointer.size.height,
            ),
            Radius.circular(math.min(halfWidth, halfHeight) / 4),
          ),
          paint,
        );
        break;

      case PointerType.none:
      case PointerType.custom:
        // Custom widgets are handled separately
        break;
    }
  }

  @override
  bool shouldRepaint(_LinearGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.gaugeThickness != gaugeThickness ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.valueBarColor != valueBarColor ||
        oldDelegate.showValueBar != showValueBar;
  }
}
