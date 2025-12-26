import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The style of the line cap for the circular progress indicator.
enum CircularStrokeCap {
  /// Rounded cap at the ends of the arc.
  round,

  /// Square cap at the ends of the arc.
  square,

  /// No cap at the ends of the arc.
  butt,
}

/// The starting position for the circular progress.
enum CircularStartAngle {
  /// Start from the top (12 o'clock position).
  top,

  /// Start from the right (3 o'clock position).
  right,

  /// Start from the bottom (6 o'clock position).
  bottom,

  /// Start from the left (9 o'clock position).
  left,

  /// Custom angle (use customStartAngle parameter).
  custom,
}

/// The position of the child widget relative to the circular indicator.
enum CircularChildPosition {
  /// Child widget at the top.
  top,

  /// Child widget at the bottom.
  bottom,

  /// Child widget in the center (default).
  center,
}

/// Configuration for circular progress segments.
class CircularSegment {
  /// The percentage value of this segment (0.0 to 1.0).
  final double value;

  /// The color of this segment.
  final Color color;

  /// Optional gradient for this segment.
  final Gradient? gradient;

  /// Creates a circular segment.
  const CircularSegment({
    required this.value,
    required this.color,
    this.gradient,
  });
}

/// A beautiful and customizable circular percent indicator widget.
///
/// This widget displays progress in a circular format with extensive
/// customization options including gradients, animations, and center content.
///
/// Example usage:
/// ```dart
/// CircularPercentIndicator(
///   percent: 0.75,
///   radius: 60,
///   lineWidth: 10,
///   progressColor: Colors.blue,
///   backgroundColor: Colors.grey.shade300,
///   center: Text('75%'),
///   animation: true,
/// )
/// ```
class CircularPercentIndicator extends StatefulWidget {
  /// The progress value between 0.0 and 1.0.
  final double percent;

  /// The radius of the circle (from center to the middle of the stroke).
  final double radius;

  /// The width of the progress line.
  final double lineWidth;

  /// The width of the background circle line.
  /// If null, uses [lineWidth].
  final double? backgroundWidth;

  /// The color of the progress indicator.
  final Color progressColor;

  /// The background color of the circle.
  final Color backgroundColor;

  /// Optional gradient for the progress indicator.
  /// If provided, overrides [progressColor].
  final Gradient? linearGradient;

  /// Optional gradient for the background circle.
  final Gradient? backgroundGradient;

  /// Whether to fill the background completely.
  final bool fillColor;

  /// The fill color when [fillColor] is true.
  final Color? circleColor;

  /// The style of the line cap.
  final CircularStrokeCap circularStrokeCap;

  /// The starting angle for the progress.
  final CircularStartAngle startAngle;

  /// Custom start angle in degrees (when startAngle is custom).
  final double? customStartAngle;

  /// Whether to reverse the progress direction.
  final bool reverse;

  /// Whether to animate progress changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Widget to display in the center of the circle.
  final Widget? center;

  /// Widget to display as a header above the circle.
  final Widget? header;

  /// Widget to display as a footer below the circle.
  final Widget? footer;

  /// Whether to add rotation animation.
  final bool rotateLinearGradient;

  /// Callback when animation completes.
  final VoidCallback? onAnimationEnd;

  /// Whether to restart animation from 0 when percent changes.
  final bool restartAnimation;

  /// Custom arc type for different visual styles.
  final ArcType? arcType;

  /// The background arc color when using arc type.
  final Color? arcBackgroundColor;

  /// Whether to animate from last percent or from 0.
  final bool animateFromLastPercent;

  /// Child widget position (top, bottom, or center).
  final CircularChildPosition childPosition;

  /// Custom child widget (alternative to center).
  final Widget? child;

  /// Spacing between child and the circular indicator.
  final double childSpacing;

  /// Segments for multi-segment circular indicator.
  final List<CircularSegment>? segments;

  /// Whether the indicator is interactive.
  final bool interactive;

  /// Callback when the value changes (through interaction).
  final ValueChanged<double>? onValueChanged;

  /// Whether to add automatic keep alive for animation state.
  final bool addAutomaticKeepAlive;

  /// Creates a circular percent indicator widget.
  const CircularPercentIndicator({
    super.key,
    this.percent = 0.0,
    this.radius = 50.0,
    this.lineWidth = 5.0,
    this.backgroundWidth,
    this.progressColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.linearGradient,
    this.backgroundGradient,
    this.fillColor = false,
    this.circleColor,
    this.circularStrokeCap = CircularStrokeCap.round,
    this.startAngle = CircularStartAngle.top,
    this.customStartAngle,
    this.reverse = false,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.center,
    this.header,
    this.footer,
    this.rotateLinearGradient = false,
    this.onAnimationEnd,
    this.restartAnimation = false,
    this.arcType,
    this.arcBackgroundColor,
    this.animateFromLastPercent = false,
    this.childPosition = CircularChildPosition.center,
    this.child,
    this.childSpacing = 8.0,
    this.segments,
    this.interactive = false,
    this.onValueChanged,
    this.addAutomaticKeepAlive = true,
  }) : assert(percent >= 0.0 && percent <= 1.0, 'Percent must be between 0.0 and 1.0');

  @override
  State<CircularPercentIndicator> createState() => _CircularPercentIndicatorState();
}

class _CircularPercentIndicatorState extends State<CircularPercentIndicator>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _previousPercent = 0.0;

  @override
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    if (widget.animation) {
      _animation = Tween<double>(
        begin: widget.animateFromLastPercent ? _previousPercent : 0.0,
        end: widget.percent,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ));
      _animationController.forward();
      _animationController.addStatusListener(_onAnimationStatus);
    } else {
      _animation = AlwaysStoppedAnimation(widget.percent);
    }
    _previousPercent = widget.percent;
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onAnimationEnd?.call();
    }
  }

  @override
  void didUpdateWidget(CircularPercentIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent) {
      if (widget.animation) {
        if (widget.restartAnimation) {
          _animationController.reset();
          _animation = Tween<double>(
            begin: 0.0,
            end: widget.percent,
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: widget.animationCurve,
          ));
        } else {
          _animation = Tween<double>(
            begin: widget.animateFromLastPercent ? _previousPercent : oldWidget.percent,
            end: widget.percent,
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: widget.animationCurve,
          ));
          _animationController.reset();
        }
        _animationController.forward();
      } else {
        _animation = AlwaysStoppedAnimation(widget.percent);
      }
      _previousPercent = widget.percent;
    }
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_onAnimationStatus);
    _animationController.dispose();
    super.dispose();
  }

  double _calculateValueFromPosition(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    
    // Calculate angle
    var angle = math.atan2(dy, dx);
    
    // Adjust for start angle
    double startAngleRad;
    switch (widget.startAngle) {
      case CircularStartAngle.top:
        startAngleRad = -math.pi / 2;
        break;
      case CircularStartAngle.right:
        startAngleRad = 0;
        break;
      case CircularStartAngle.bottom:
        startAngleRad = math.pi / 2;
        break;
      case CircularStartAngle.left:
        startAngleRad = math.pi;
        break;
      case CircularStartAngle.custom:
        startAngleRad = (widget.customStartAngle ?? -90) * math.pi / 180;
        break;
    }
    
    // Normalize angle relative to start
    angle = angle - startAngleRad;
    if (angle < 0) angle += 2 * math.pi;
    
    // Convert to value
    var value = angle / (2 * math.pi);
    if (widget.reverse) value = 1.0 - value;
    
    return value.clamp(0.0, 1.0);
  }

  void _handleInteraction(Offset localPosition, Size size) {
    if (!widget.interactive) return;
    final value = _calculateValueFromPosition(localPosition, size);
    widget.onValueChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = widget.radius * 2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.header != null) ...[
          widget.header!,
          const SizedBox(height: 8),
        ],
        // Top child position
        if ((widget.child != null && widget.childPosition == CircularChildPosition.top)) ...[
          widget.child!,
          SizedBox(height: widget.childSpacing),
        ],
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            Widget indicator = SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _CircularProgressPainter(
                  percent: _animation.value,
                  lineWidth: widget.lineWidth,
                  backgroundWidth: widget.backgroundWidth ?? widget.lineWidth,
                  progressColor: widget.progressColor,
                  backgroundColor: widget.backgroundColor,
                  linearGradient: widget.linearGradient,
                  backgroundGradient: widget.backgroundGradient,
                  circularStrokeCap: widget.circularStrokeCap,
                  startAngle: widget.startAngle,
                  customStartAngle: widget.customStartAngle,
                  reverse: widget.reverse,
                  fillColor: widget.fillColor,
                  circleColor: widget.circleColor,
                  rotateLinearGradient: widget.rotateLinearGradient,
                  arcType: widget.arcType,
                  arcBackgroundColor: widget.arcBackgroundColor,
                  segments: widget.segments,
                ),
                child: _buildCenterChild(),
              ),
            );

            if (widget.interactive) {
              indicator = GestureDetector(
                onTapDown: (details) => _handleInteraction(
                  details.localPosition,
                  Size(size, size),
                ),
                onPanUpdate: (details) => _handleInteraction(
                  details.localPosition,
                  Size(size, size),
                ),
                child: indicator,
              );
            }

            return indicator;
          },
        ),
        // Bottom child position
        if ((widget.child != null && widget.childPosition == CircularChildPosition.bottom)) ...[
          SizedBox(height: widget.childSpacing),
          widget.child!,
        ],
        if (widget.footer != null) ...[
          const SizedBox(height: 8),
          widget.footer!,
        ],
      ],
    );
  }

  Widget? _buildCenterChild() {
    // Center takes priority
    if (widget.center != null) {
      return Center(child: widget.center);
    }
    // Then check for center positioned child
    if (widget.child != null && widget.childPosition == CircularChildPosition.center) {
      return Center(child: widget.child);
    }
    return null;
  }
}

/// The type of arc to display.
enum ArcType {
  /// Half circle at the top.
  half,

  /// Full circle.
  full,
}

class _CircularProgressPainter extends CustomPainter {
  final double percent;
  final double lineWidth;
  final double backgroundWidth;
  final Color progressColor;
  final Color backgroundColor;
  final Gradient? linearGradient;
  final Gradient? backgroundGradient;
  final CircularStrokeCap circularStrokeCap;
  final CircularStartAngle startAngle;
  final double? customStartAngle;
  final bool reverse;
  final bool fillColor;
  final Color? circleColor;
  final bool rotateLinearGradient;
  final ArcType? arcType;
  final Color? arcBackgroundColor;
  final List<CircularSegment>? segments;

  _CircularProgressPainter({
    required this.percent,
    required this.lineWidth,
    required this.backgroundWidth,
    required this.progressColor,
    required this.backgroundColor,
    this.linearGradient,
    this.backgroundGradient,
    required this.circularStrokeCap,
    required this.startAngle,
    this.customStartAngle,
    required this.reverse,
    required this.fillColor,
    this.circleColor,
    required this.rotateLinearGradient,
    this.arcType,
    this.arcBackgroundColor,
    this.segments,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - math.max(lineWidth, backgroundWidth)) / 2;

    // Calculate start angle
    double startAngleRadians;
    switch (startAngle) {
      case CircularStartAngle.top:
        startAngleRadians = -math.pi / 2;
        break;
      case CircularStartAngle.right:
        startAngleRadians = 0;
        break;
      case CircularStartAngle.bottom:
        startAngleRadians = math.pi / 2;
        break;
      case CircularStartAngle.left:
        startAngleRadians = math.pi;
        break;
      case CircularStartAngle.custom:
        startAngleRadians = (customStartAngle ?? -90) * math.pi / 180;
        break;
    }

    // Convert stroke cap
    StrokeCap strokeCap;
    switch (circularStrokeCap) {
      case CircularStrokeCap.round:
        strokeCap = StrokeCap.round;
        break;
      case CircularStrokeCap.square:
        strokeCap = StrokeCap.square;
        break;
      case CircularStrokeCap.butt:
        strokeCap = StrokeCap.butt;
        break;
    }

    // Determine sweep angle based on arc type
    double sweepAngle;
    if (arcType == ArcType.half) {
      sweepAngle = math.pi;
      startAngleRadians = -math.pi;
    } else {
      sweepAngle = 2 * math.pi;
    }

    // Draw fill if enabled
    if (fillColor && circleColor != null) {
      final fillPaint = Paint()
        ..color = circleColor!
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius, fillPaint);
    }

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = backgroundWidth
      ..strokeCap = strokeCap;

    if (backgroundGradient != null) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      backgroundPaint.shader = backgroundGradient!.createShader(rect);
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngleRadians,
      sweepAngle,
      false,
      backgroundPaint,
    );

    // Draw arc background for arc type
    if (arcType != null && arcBackgroundColor != null) {
      final arcBgPaint = Paint()
        ..color = arcBackgroundColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = backgroundWidth
        ..strokeCap = strokeCap;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngleRadians,
        sweepAngle,
        false,
        arcBgPaint,
      );
    }

    // Draw segments if provided
    if (segments != null && segments!.isNotEmpty) {
      _drawSegments(canvas, center, radius, startAngleRadians, sweepAngle, strokeCap);
    }
    // Draw progress arc
    else if (percent > 0) {
      final progressPaint = Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth
        ..strokeCap = strokeCap;

      if (linearGradient != null) {
        final rect = Rect.fromCircle(center: center, radius: radius);
        if (rotateLinearGradient) {
          progressPaint.shader = linearGradient!.createShader(rect, textDirection: TextDirection.ltr);
        } else {
          progressPaint.shader = linearGradient!.createShader(rect);
        }
      }

      final progressSweep = sweepAngle * percent * (reverse ? -1 : 1);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngleRadians,
        progressSweep,
        false,
        progressPaint,
      );
    }
  }

  void _drawSegments(Canvas canvas, Offset center, double radius, 
      double startAngleRadians, double sweepAngle, StrokeCap strokeCap) {
    double currentAngle = startAngleRadians;
    double remainingPercent = percent;

    for (final segment in segments!) {
      if (remainingPercent <= 0) break;

      final segmentSweep = math.min(segment.value, remainingPercent) * sweepAngle;
      
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth
        ..strokeCap = strokeCap;

      if (segment.gradient != null) {
        final rect = Rect.fromCircle(center: center, radius: radius);
        paint.shader = segment.gradient!.createShader(rect);
      } else {
        paint.color = segment.color;
      }

      final actualSweep = segmentSweep * (reverse ? -1 : 1);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        actualSweep,
        false,
        paint,
      );

      currentAngle += segmentSweep * (reverse ? -1 : 1);
      remainingPercent -= segment.value;
    }
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.percent != percent ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.backgroundWidth != backgroundWidth ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.linearGradient != linearGradient ||
        oldDelegate.circularStrokeCap != circularStrokeCap ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.customStartAngle != customStartAngle ||
        oldDelegate.reverse != reverse ||
        oldDelegate.segments != segments;
  }
}
