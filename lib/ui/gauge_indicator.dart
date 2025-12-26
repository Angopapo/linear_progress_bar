import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The style of gauge indicator.
enum GaugeStyle {
  /// A simple arc gauge.
  simple,

  /// A gauge with tick marks.
  ticked,

  /// A gauge with segments.
  segmented,

  /// A modern gradient gauge.
  modern,
}

/// The position of the value label in a gauge.
enum GaugeLabelPosition {
  /// Label at the center of the gauge.
  center,

  /// Label below the gauge.
  bottom,

  /// No label displayed.
  none,
}

/// Configuration for gauge segments.
class GaugeSegment {
  /// The start value of the segment (0.0 to 1.0).
  final double start;

  /// The end value of the segment (0.0 to 1.0).
  final double end;

  /// The color of the segment.
  final Color color;

  /// Creates a gauge segment.
  const GaugeSegment({
    required this.start,
    required this.end,
    required this.color,
  });
}

/// Configuration for gauge range colors.
class GaugeRange {
  /// The start value of the range (0.0 to 1.0).
  final double start;

  /// The end value of the range (0.0 to 1.0).
  final double end;

  /// The color of the range.
  final Color color;

  /// Optional label for the range.
  final String? label;

  /// Creates a gauge range.
  const GaugeRange({
    required this.start,
    required this.end,
    required this.color,
    this.label,
  });
}

/// A beautiful and customizable gauge indicator widget.
///
/// This widget displays a gauge/speedometer-style progress indicator
/// with extensive customization options.
///
/// Example usage:
/// ```dart
/// GaugeIndicator(
///   value: 0.75,
///   size: 200,
///   strokeWidth: 20,
///   valueColor: Colors.blue,
///   backgroundColor: Colors.grey.shade300,
///   showValue: true,
/// )
/// ```
class GaugeIndicator extends StatefulWidget {
  /// The current value between 0.0 and 1.0.
  final double value;

  /// The size of the gauge (width and height).
  final double size;

  /// The width of the gauge arc stroke.
  final double strokeWidth;

  /// The color of the value indicator.
  final Color valueColor;

  /// The background color of the gauge arc.
  final Color backgroundColor;

  /// Optional gradient for the value arc.
  final Gradient? gradient;

  /// The starting angle in degrees (0 = right, 90 = bottom, 180 = left, 270 = top).
  final double startAngle;

  /// The sweep angle in degrees.
  final double sweepAngle;

  /// Whether to show the value as text.
  final bool showValue;

  /// The position of the value label.
  final GaugeLabelPosition labelPosition;

  /// Custom format function for the value label.
  final String Function(double value)? valueFormatter;

  /// The text style for the value label.
  final TextStyle? valueTextStyle;

  /// Optional widget to display in the center.
  final Widget? center;

  /// Whether to animate value changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// The style of the gauge.
  final GaugeStyle gaugeStyle;

  /// Number of tick marks (for ticked style).
  final int tickCount;

  /// The length of tick marks.
  final double tickLength;

  /// The color of tick marks.
  final Color? tickColor;

  /// Segments for segmented gauge style.
  final List<GaugeSegment>? segments;

  /// Ranges for coloring different value ranges.
  final List<GaugeRange>? ranges;

  /// Whether to show a needle pointer.
  final bool showNeedle;

  /// The color of the needle.
  final Color needleColor;

  /// The length of the needle (as a fraction of radius).
  final double needleLength;

  /// Whether to show the min and max labels.
  final bool showMinMax;

  /// The minimum value label.
  final String? minLabel;

  /// The maximum value label.
  final String? maxLabel;

  /// The text style for min/max labels.
  final TextStyle? minMaxTextStyle;

  /// Optional title widget above the gauge.
  final Widget? title;

  /// Optional subtitle widget below the gauge.
  final Widget? subtitle;

  /// The stroke cap style.
  final StrokeCap strokeCap;

  /// Callback when animation completes.
  final VoidCallback? onAnimationEnd;

  /// Creates a gauge indicator widget.
  const GaugeIndicator({
    super.key,
    this.value = 0.0,
    this.size = 200.0,
    this.strokeWidth = 15.0,
    this.valueColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.gradient,
    this.startAngle = 135.0,
    this.sweepAngle = 270.0,
    this.showValue = true,
    this.labelPosition = GaugeLabelPosition.center,
    this.valueFormatter,
    this.valueTextStyle,
    this.center,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.gaugeStyle = GaugeStyle.simple,
    this.tickCount = 10,
    this.tickLength = 8.0,
    this.tickColor,
    this.segments,
    this.ranges,
    this.showNeedle = false,
    this.needleColor = Colors.red,
    this.needleLength = 0.8,
    this.showMinMax = false,
    this.minLabel,
    this.maxLabel,
    this.minMaxTextStyle,
    this.title,
    this.subtitle,
    this.strokeCap = StrokeCap.round,
    this.onAnimationEnd,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');

  @override
  State<GaugeIndicator> createState() => _GaugeIndicatorState();
}

class _GaugeIndicatorState extends State<GaugeIndicator>
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
  void didUpdateWidget(GaugeIndicator oldWidget) {
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

  String _formatValue(double value) {
    if (widget.valueFormatter != null) {
      return widget.valueFormatter!(value);
    }
    return '${(value * 100).toInt()}%';
  }

  @override
  Widget build(BuildContext context) {
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
            return SizedBox(
              width: widget.size,
              height: widget.size * (widget.sweepAngle <= 180 ? 0.6 : 1.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(widget.size, widget.size),
                    painter: _GaugePainter(
                      value: _animation.value,
                      strokeWidth: widget.strokeWidth,
                      valueColor: widget.valueColor,
                      backgroundColor: widget.backgroundColor,
                      gradient: widget.gradient,
                      startAngle: widget.startAngle,
                      sweepAngle: widget.sweepAngle,
                      gaugeStyle: widget.gaugeStyle,
                      tickCount: widget.tickCount,
                      tickLength: widget.tickLength,
                      tickColor: widget.tickColor,
                      segments: widget.segments,
                      ranges: widget.ranges,
                      showNeedle: widget.showNeedle,
                      needleColor: widget.needleColor,
                      needleLength: widget.needleLength,
                      strokeCap: widget.strokeCap,
                    ),
                  ),
                  if (widget.center != null)
                    widget.center!
                  else if (widget.showValue && widget.labelPosition == GaugeLabelPosition.center)
                    Text(
                      _formatValue(_animation.value),
                      style: widget.valueTextStyle ??
                          TextStyle(
                            fontSize: widget.size * 0.15,
                            fontWeight: FontWeight.bold,
                            color: widget.valueColor,
                          ),
                    ),
                  if (widget.showMinMax)
                    Positioned(
                      bottom: widget.sweepAngle <= 180 ? 0 : widget.size * 0.15,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: widget.strokeWidth),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.minLabel ?? '0',
                              style: widget.minMaxTextStyle ??
                                  TextStyle(
                                    fontSize: widget.size * 0.06,
                                    color: Colors.grey,
                                  ),
                            ),
                            Text(
                              widget.maxLabel ?? '100',
                              style: widget.minMaxTextStyle ??
                                  TextStyle(
                                    fontSize: widget.size * 0.06,
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        if (widget.showValue && widget.labelPosition == GaugeLabelPosition.bottom) ...[
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, _) => Text(
              _formatValue(_animation.value),
              style: widget.valueTextStyle ??
                  TextStyle(
                    fontSize: widget.size * 0.12,
                    fontWeight: FontWeight.bold,
                    color: widget.valueColor,
                  ),
            ),
          ),
        ],
        if (widget.subtitle != null) ...[
          const SizedBox(height: 4),
          widget.subtitle!,
        ],
      ],
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final Color valueColor;
  final Color backgroundColor;
  final Gradient? gradient;
  final double startAngle;
  final double sweepAngle;
  final GaugeStyle gaugeStyle;
  final int tickCount;
  final double tickLength;
  final Color? tickColor;
  final List<GaugeSegment>? segments;
  final List<GaugeRange>? ranges;
  final bool showNeedle;
  final Color needleColor;
  final double needleLength;
  final StrokeCap strokeCap;

  _GaugePainter({
    required this.value,
    required this.strokeWidth,
    required this.valueColor,
    required this.backgroundColor,
    this.gradient,
    required this.startAngle,
    required this.sweepAngle,
    required this.gaugeStyle,
    required this.tickCount,
    required this.tickLength,
    this.tickColor,
    this.segments,
    this.ranges,
    required this.showNeedle,
    required this.needleColor,
    required this.needleLength,
    required this.strokeCap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final startRad = startAngle * math.pi / 180;
    final sweepRad = sweepAngle * math.pi / 180;

    // Draw background arc
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRad,
      sweepRad,
      false,
      backgroundPaint,
    );

    // Draw segments if in segmented mode
    if (gaugeStyle == GaugeStyle.segmented && segments != null) {
      for (final segment in segments!) {
        final segmentPaint = Paint()
          ..color = segment.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = strokeCap;

        final segmentStart = startRad + sweepRad * segment.start;
        final segmentSweep = sweepRad * (segment.end - segment.start);

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          segmentStart,
          segmentSweep,
          false,
          segmentPaint,
        );
      }
    }

    // Draw ranges if provided
    if (ranges != null) {
      for (final range in ranges!) {
        final rangePaint = Paint()
          ..color = range.color.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;

        final rangeStart = startRad + sweepRad * range.start;
        final rangeSweep = sweepRad * (range.end - range.start);

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          rangeStart,
          rangeSweep,
          false,
          rangePaint,
        );
      }
    }

    // Draw value arc (unless segmented with segments covering value)
    if (value > 0 && gaugeStyle != GaugeStyle.segmented) {
      final valuePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = strokeCap;

      if (gradient != null) {
        final rect = Rect.fromCircle(center: center, radius: radius);
        valuePaint.shader = gradient!.createShader(rect);
      } else if (ranges != null) {
        // Find the appropriate color based on value
        Color currentColor = valueColor;
        for (final range in ranges!) {
          if (value >= range.start && value <= range.end) {
            currentColor = range.color;
            break;
          }
        }
        valuePaint.color = currentColor;
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

    // Draw tick marks
    if (gaugeStyle == GaugeStyle.ticked || gaugeStyle == GaugeStyle.modern) {
      _drawTicks(canvas, center, radius, startRad, sweepRad);
    }

    // Draw needle if enabled
    if (showNeedle) {
      _drawNeedle(canvas, center, radius, startRad, sweepRad);
    }
  }

  void _drawTicks(Canvas canvas, Offset center, double radius, double startRad, double sweepRad) {
    final tickPaint = Paint()
      ..color = tickColor ?? Colors.grey.shade600
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i <= tickCount; i++) {
      final angle = startRad + (sweepRad * i / tickCount);
      final isMainTick = i % 2 == 0;
      final length = isMainTick ? tickLength : tickLength * 0.6;

      final outerPoint = Offset(
        center.dx + (radius - strokeWidth / 2 - 4) * math.cos(angle),
        center.dy + (radius - strokeWidth / 2 - 4) * math.sin(angle),
      );
      final innerPoint = Offset(
        center.dx + (radius - strokeWidth / 2 - 4 - length) * math.cos(angle),
        center.dy + (radius - strokeWidth / 2 - 4 - length) * math.sin(angle),
      );

      canvas.drawLine(innerPoint, outerPoint, tickPaint);
    }
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius, double startRad, double sweepRad) {
    final needleAngle = startRad + sweepRad * value;
    final needleRadius = radius * needleLength;

    // Draw needle
    final needlePaint = Paint()
      ..color = needleColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final needleEnd = Offset(
      center.dx + needleRadius * math.cos(needleAngle),
      center.dy + needleRadius * math.sin(needleAngle),
    );

    canvas.drawLine(center, needleEnd, needlePaint);

    // Draw center circle
    final centerPaint = Paint()
      ..color = needleColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, strokeWidth * 0.4, centerPaint);

    // Draw center inner circle (for depth effect)
    final innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, strokeWidth * 0.2, innerPaint);
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.valueColor != valueColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.gaugeStyle != gaugeStyle ||
        oldDelegate.showNeedle != showNeedle;
  }
}
