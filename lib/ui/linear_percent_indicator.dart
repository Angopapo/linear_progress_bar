import 'package:flutter/material.dart';

/// The position of the child widget relative to the linear indicator.
enum LinearChildPosition {
  /// Child positioned to the left of the indicator.
  left,

  /// Child positioned to the right of the indicator.
  right,

  /// Child positioned at the center (inside) the indicator.
  center,
}

/// Configuration for a segment in the multi-segment indicator.
class LinearSegment {
  /// The value/percentage of this segment (0.0 to 1.0).
  final double value;

  /// The color of this segment.
  final Color color;

  /// Optional label for this segment.
  final String? label;

  /// Creates a linear segment configuration.
  const LinearSegment({
    required this.value,
    required this.color,
    this.label,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');
}

/// A beautiful and customizable linear percent indicator widget.
///
/// This widget displays progress in a linear/horizontal format with extensive
/// customization options including gradients, animations, child positioning,
/// and multi-segment support.
///
/// Example usage:
/// ```dart
/// LinearPercentIndicator(
///   percent: 0.75,
///   width: 200,
///   lineHeight: 14,
///   progressColor: Colors.blue,
///   backgroundColor: Colors.grey.shade300,
///   barRadius: Radius.circular(7),
///   leading: Icon(Icons.star),
///   trailing: Text('75%'),
///   animation: true,
/// )
/// ```
class LinearPercentIndicator extends StatefulWidget {
  /// The progress value between 0.0 and 1.0.
  final double percent;

  /// The width of the indicator. If null, fills available width.
  final double? width;

  /// The height of the progress line.
  final double lineHeight;

  /// The color of the progress indicator.
  final Color progressColor;

  /// The background color of the indicator.
  final Color backgroundColor;

  /// Optional gradient for the progress (overrides progressColor).
  final LinearGradient? linearGradient;

  /// Optional gradient for the background.
  final LinearGradient? backgroundGradient;

  /// The radius for rounding the bar ends.
  final Radius? barRadius;

  /// Widget to display at the start (left) of the indicator.
  final Widget? leading;

  /// Widget to display at the end (right) of the indicator.
  final Widget? trailing;

  /// Widget to display in the center of the indicator.
  final Widget? center;

  /// The position of the center widget.
  final LinearChildPosition centerPosition;

  /// Padding around the indicator.
  final EdgeInsets padding;

  /// Whether to animate progress changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve curve;

  /// Whether to restart animation when percent changes.
  final bool restartAnimation;

  /// Callback when animation completes.
  final VoidCallback? onAnimationEnd;

  /// Whether to animate from the last percent value.
  final bool animateFromLastPercent;

  /// Whether to fill the background completely.
  final bool fillBackground;

  /// Whether to add a clip mask to the indicator.
  final bool clipLinearGradient;

  /// The alignment of the progress.
  final MainAxisAlignment alignment;

  /// The main axis size for the row.
  final MainAxisSize mainAxisSize;

  /// Whether the indicator is vertical instead of horizontal.
  final bool isRTL;

  /// Segments for multi-segment indicator mode.
  final List<LinearSegment>? segments;

  /// Whether to show segment labels.
  final bool showSegmentLabels;

  /// The text style for segment labels.
  final TextStyle? segmentLabelStyle;

  /// Widget builder for custom progress display.
  final Widget Function(BuildContext context, double percent)? widgetIndicator;

  /// Creates a linear percent indicator widget.
  const LinearPercentIndicator({
    super.key,
    this.percent = 0.0,
    this.width,
    this.lineHeight = 5.0,
    this.progressColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.linearGradient,
    this.backgroundGradient,
    this.barRadius,
    this.leading,
    this.trailing,
    this.center,
    this.centerPosition = LinearChildPosition.center,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.curve = Curves.linear,
    this.restartAnimation = false,
    this.onAnimationEnd,
    this.animateFromLastPercent = false,
    this.fillBackground = true,
    this.clipLinearGradient = false,
    this.alignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.isRTL = false,
    this.segments,
    this.showSegmentLabels = false,
    this.segmentLabelStyle,
    this.widgetIndicator,
  }) : assert(percent >= 0.0 && percent <= 1.0, 'Percent must be between 0.0 and 1.0');

  @override
  State<LinearPercentIndicator> createState() => _LinearPercentIndicatorState();
}

class _LinearPercentIndicatorState extends State<LinearPercentIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _previousPercent = 0.0;

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
        curve: widget.curve,
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
  void didUpdateWidget(LinearPercentIndicator oldWidget) {
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
            curve: widget.curve,
          ));
        } else {
          _animation = Tween<double>(
            begin: widget.animateFromLastPercent ? _previousPercent : oldWidget.percent,
            end: widget.percent,
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: widget.curve,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: widget.alignment,
        mainAxisSize: widget.mainAxisSize,
        textDirection: widget.isRTL ? TextDirection.rtl : TextDirection.ltr,
        children: [
          if (widget.leading != null) ...[
            widget.leading!,
            const SizedBox(width: 8),
          ],
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return _buildIndicator(_animation.value);
              },
            ),
          ),
          if (widget.trailing != null) ...[
            const SizedBox(width: 8),
            widget.trailing!,
          ],
        ],
      ),
    );
  }

  Widget _buildIndicator(double percent) {
    if (widget.segments != null && widget.segments!.isNotEmpty) {
      return _buildMultiSegmentIndicator();
    }

    return SizedBox(
      width: widget.width,
      height: widget.lineHeight,
      child: Stack(
        children: [
          // Background
          _buildBackground(),
          // Progress
          _buildProgress(percent),
          // Center widget
          if (widget.center != null) _buildCenterWidget(),
          // Widget indicator
          if (widget.widgetIndicator != null)
            Positioned(
              left: percent * (widget.width ?? double.infinity) - widget.lineHeight / 2,
              top: 0,
              bottom: 0,
              child: widget.widgetIndicator!(context, percent),
            ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundGradient == null ? widget.backgroundColor : null,
        gradient: widget.backgroundGradient,
        borderRadius: widget.barRadius != null
            ? BorderRadius.all(widget.barRadius!)
            : null,
      ),
    );
  }

  Widget _buildProgress(double percent) {
    return FractionallySizedBox(
      alignment: widget.isRTL ? Alignment.centerRight : Alignment.centerLeft,
      widthFactor: percent.clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.linearGradient == null ? widget.progressColor : null,
          gradient: widget.linearGradient,
          borderRadius: widget.barRadius != null
              ? BorderRadius.all(widget.barRadius!)
              : null,
        ),
      ),
    );
  }

  Widget _buildCenterWidget() {
    switch (widget.centerPosition) {
      case LinearChildPosition.left:
        return Positioned(
          left: 8,
          top: 0,
          bottom: 0,
          child: Center(child: widget.center),
        );
      case LinearChildPosition.right:
        return Positioned(
          right: 8,
          top: 0,
          bottom: 0,
          child: Center(child: widget.center),
        );
      case LinearChildPosition.center:
        return Positioned.fill(
          child: Center(child: widget.center),
        );
    }
  }

  Widget _buildMultiSegmentIndicator() {
    // Calculate total value
    final totalValue = widget.segments!.fold<double>(
      0.0,
      (sum, segment) => sum + segment.value,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.lineHeight,
          child: ClipRRect(
            borderRadius: widget.barRadius != null
                ? BorderRadius.all(widget.barRadius!)
                : BorderRadius.zero,
            child: Row(
              children: widget.segments!.map((segment) {
                final widthFactor = segment.value / (totalValue > 1 ? totalValue : 1.0);
                return Expanded(
                  flex: (widthFactor * 1000).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: segment.color,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        if (widget.showSegmentLabels && widget.segments!.any((s) => s.label != null))
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.segments!.map((segment) {
                final totalValue = widget.segments!.fold<double>(
                  0.0,
                  (sum, s) => sum + s.value,
                );
                final widthFactor = segment.value / (totalValue > 1 ? totalValue : 1.0);
                return SizedBox(
                  width: (widget.width ?? 100) * widthFactor,
                  child: Text(
                    segment.label ?? '',
                    style: widget.segmentLabelStyle ??
                        TextStyle(fontSize: 10, color: segment.color),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

/// A simple linear progress indicator with percentage display.
///
/// This is a convenience widget that combines [LinearPercentIndicator]
/// with a percentage text display.
class SimpleLinearProgress extends StatelessWidget {
  /// The progress value between 0.0 and 1.0.
  final double percent;

  /// The width of the indicator.
  final double? width;

  /// The height of the progress line.
  final double lineHeight;

  /// The color of the progress.
  final Color progressColor;

  /// The background color.
  final Color backgroundColor;

  /// Whether to animate progress changes.
  final bool animation;

  /// Whether to show the percentage text.
  final bool showPercentage;

  /// The text style for the percentage.
  final TextStyle? percentageStyle;

  /// Creates a simple linear progress widget.
  const SimpleLinearProgress({
    super.key,
    this.percent = 0.0,
    this.width,
    this.lineHeight = 10.0,
    this.progressColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.animation = true,
    this.showPercentage = true,
    this.percentageStyle,
  });

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      percent: percent,
      width: width,
      lineHeight: lineHeight,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      animation: animation,
      barRadius: Radius.circular(lineHeight / 2),
      trailing: showPercentage
          ? Text(
              '${(percent * 100).toInt()}%',
              style: percentageStyle ??
                  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: progressColor,
                  ),
            )
          : null,
    );
  }
}

/// A gradient linear progress indicator.
///
/// This is a convenience widget that provides a gradient progress bar.
class GradientLinearProgress extends StatelessWidget {
  /// The progress value between 0.0 and 1.0.
  final double percent;

  /// The width of the indicator.
  final double? width;

  /// The height of the progress line.
  final double lineHeight;

  /// The gradient colors.
  final List<Color> gradientColors;

  /// The background color.
  final Color backgroundColor;

  /// Whether to animate progress changes.
  final bool animation;

  /// The animation duration.
  final Duration animationDuration;

  /// Widget to display in the center.
  final Widget? center;

  /// Creates a gradient linear progress widget.
  const GradientLinearProgress({
    super.key,
    this.percent = 0.0,
    this.width,
    this.lineHeight = 12.0,
    this.gradientColors = const [Colors.blue, Colors.purple],
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.animation = true,
    this.animationDuration = const Duration(milliseconds: 500),
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      percent: percent,
      width: width,
      lineHeight: lineHeight,
      backgroundColor: backgroundColor,
      animation: animation,
      animationDuration: animationDuration,
      barRadius: Radius.circular(lineHeight / 2),
      linearGradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      center: center,
    );
  }
}

/// A multi-segment linear progress indicator.
///
/// This widget displays multiple colored segments in a single bar.
class MultiSegmentLinearIndicator extends StatelessWidget {
  /// The segments to display.
  final List<LinearSegment> segments;

  /// The width of the indicator.
  final double? width;

  /// The height of the indicator.
  final double height;

  /// The border radius.
  final Radius? barRadius;

  /// Whether to show labels.
  final bool showLabels;

  /// The text style for labels.
  final TextStyle? labelStyle;

  /// Spacing between bar and labels.
  final double labelSpacing;

  /// Creates a multi-segment linear indicator.
  const MultiSegmentLinearIndicator({
    super.key,
    required this.segments,
    this.width,
    this.height = 12.0,
    this.barRadius,
    this.showLabels = false,
    this.labelStyle,
    this.labelSpacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final totalValue = segments.fold<double>(
      0.0,
      (sum, segment) => sum + segment.value,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: ClipRRect(
            borderRadius: barRadius != null
                ? BorderRadius.all(barRadius!)
                : BorderRadius.circular(height / 2),
            child: Row(
              children: segments.asMap().entries.map((entry) {
                final index = entry.key;
                final segment = entry.value;
                final widthFactor = segment.value / (totalValue > 1 ? totalValue : 1.0);
                
                return Expanded(
                  flex: (widthFactor * 1000).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: segment.color,
                      border: index > 0
                          ? Border(
                              left: BorderSide(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        if (showLabels && segments.any((s) => s.label != null)) ...[
          SizedBox(height: labelSpacing),
          SizedBox(
            width: width,
            child: Row(
              children: segments.map((segment) {
                final widthFactor = segment.value / (totalValue > 1 ? totalValue : 1.0);
                return Expanded(
                  flex: (widthFactor * 1000).round(),
                  child: Text(
                    segment.label ?? '',
                    style: labelStyle ??
                        TextStyle(
                          fontSize: 10,
                          color: segment.color,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
