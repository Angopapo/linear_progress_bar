import 'package:flutter/material.dart';

/// Position of the child widget in the linear percent indicator.
enum LinearChildPosition {
  /// Child on the left side.
  left,

  /// Child on the right side.
  right,

  /// Child in the center (overlay on the progress bar).
  center,
}

/// Configuration for a segment in multi-segment linear indicator.
class LinearSegment {
  /// The start value of the segment (0.0 to 1.0).
  final double start;

  /// The end value of the segment (0.0 to 1.0).
  final double end;

  /// The color of the segment.
  final Color color;

  /// Optional gradient for the segment.
  final Gradient? gradient;

  /// Optional label for the segment.
  final String? label;

  /// Creates a linear segment.
  // ignore: sort_constructors_first
  const LinearSegment({
    required this.start,
    required this.end,
    required this.color,
    this.gradient,
    this.label,
  })  : assert(
            start >= 0.0 && start <= 1.0, 'start must be between 0.0 and 1.0'),
        assert(end >= 0.0 && end <= 1.0, 'end must be between 0.0 and 1.0'),
        assert(start <= end, 'start must be <= end');
}

/// A powerful and customizable linear percent indicator widget.
///
/// This widget displays a linear progress indicator with extensive customization
/// options including multi-segment support, animation controls, child positioning,
/// and gradient support.
///
/// Example usage:
/// ```dart
/// LinearPercentIndicator(
///   percent: 0.75,
///   width: 200,
///   lineHeight: 20,
///   progressColor: Colors.blue,
///   backgroundColor: Colors.grey.shade300,
///   animation: true,
///   animationDuration: 1000,
///   leading: Icon(Icons.download),
///   trailing: Text('75%'),
///   center: Text('Downloading...'),
/// )
/// ```
class LinearPercentIndicator extends StatefulWidget {
  /// The progress value between 0.0 and 1.0.
  final double percent;

  /// The width of the progress bar. If null, uses available space.
  final double? width;

  /// The height of the progress bar line.
  final double lineHeight;

  /// The color of the progress indicator.
  final Color progressColor;

  /// The background color of the progress bar.
  final Color backgroundColor;

  /// Optional gradient for the progress bar.
  /// If provided, overrides [progressColor].
  final Gradient? linearGradient;

  /// Optional gradient for the background.
  final Gradient? backgroundGradient;

  /// Whether to animate progress changes.
  final bool animation;

  /// The duration of the animation in milliseconds.
  final int animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Whether to restart animation from 0 when percent changes.
  final bool restartAnimation;

  /// Whether to animate from last percent or from 0.
  final bool animateFromLastPercent;

  /// Widget to display on the left side.
  final Widget? leading;

  /// Widget to display on the right side.
  final Widget? trailing;

  /// Widget to display in the center (overlay).
  final Widget? center;

  /// Position of the child widget.
  final LinearChildPosition childPosition;

  /// The border radius of the progress bar.
  final BorderRadius? borderRadius;

  /// Padding around the leading widget.
  final EdgeInsets leadingPadding;

  /// Padding around the trailing widget.
  final EdgeInsets trailingPadding;

  /// Whether to fill the background.
  final bool fillBackground;

  /// Whether to clip the progress bar.
  final bool clipLinearGradient;

  /// Callback when animation completes.
  final VoidCallback? onAnimationEnd;

  /// Multi-segment configuration.
  final List<LinearSegment>? segments;

  /// Whether to show percentage text in center.
  final bool showPercentage;

  /// Text style for percentage text.
  final TextStyle? percentageTextStyle;

  /// Number of decimal places for percentage.
  final int percentageDecimals;

  /// Whether to add percent symbol.
  final bool addPercentSign;

  /// Alignment of the widget.
  final MainAxisAlignment alignment;

  /// Padding around the entire widget.
  final EdgeInsets padding;

  /// Mask filter for the progress bar (for glow effects).
  final MaskFilter? maskFilter;

  /// Whether the progress bar is reversed (right to left).
  final bool isRTL;

  /// Bar radius (deprecated, use borderRadius instead).
  final Radius? barRadius;

  /// Creates a linear percent indicator widget.
  // ignore: sort_constructors_first
  const LinearPercentIndicator({
    super.key,
    this.percent = 0.0,
    this.width,
    this.lineHeight = 10.0,
    this.progressColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.linearGradient,
    this.backgroundGradient,
    this.animation = false,
    this.animationDuration = 500,
    this.animationCurve = Curves.easeInOut,
    this.restartAnimation = false,
    this.animateFromLastPercent = false,
    this.leading,
    this.trailing,
    this.center,
    this.childPosition = LinearChildPosition.center,
    this.borderRadius,
    this.leadingPadding = const EdgeInsets.only(right: 8),
    this.trailingPadding = const EdgeInsets.only(left: 8),
    this.fillBackground = false,
    this.clipLinearGradient = true,
    this.onAnimationEnd,
    this.segments,
    this.showPercentage = false,
    this.percentageTextStyle,
    this.percentageDecimals = 0,
    this.addPercentSign = true,
    this.alignment = MainAxisAlignment.start,
    this.padding = EdgeInsets.zero,
    this.maskFilter,
    this.isRTL = false,
    this.barRadius,
  }) : assert(percent >= 0.0 && percent <= 1.0,
            'Percent must be between 0.0 and 1.0');

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
      duration: Duration(milliseconds: widget.animationDuration),
    );

    if (widget.animation) {
      _animation = Tween<double>(
        begin: widget.animateFromLastPercent ? _previousPercent : 0.0,
        end: widget.percent,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ));
      // ignore: discarded_futures
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

    if (oldWidget.animationDuration != widget.animationDuration) {
      _animationController.duration =
          Duration(milliseconds: widget.animationDuration);
    }

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
            begin: widget.animateFromLastPercent
                ? _previousPercent
                : oldWidget.percent,
            end: widget.percent,
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: widget.animationCurve,
          ));
          // ignore: discarded_futures
          _animationController.reset();
        }
        // ignore: discarded_futures
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

  String _formatPercent(double value) {
    final percentage = value * 100;
    final formatted = percentage.toStringAsFixed(widget.percentageDecimals);
    return widget.addPercentSign ? '$formatted%' : formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: widget.alignment,
        mainAxisSize: MainAxisSize.min,
        textDirection: widget.isRTL ? TextDirection.rtl : TextDirection.ltr,
        children: [
          if (widget.leading != null)
            Padding(
              padding: widget.leadingPadding,
              child: widget.leading,
            ),
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return _buildProgressBar(_animation.value);
              },
            ),
          ),
          if (widget.trailing != null)
            Padding(
              padding: widget.trailingPadding,
              child: widget.trailing,
            ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double currentPercent) {
    final effectiveBorderRadius = widget.borderRadius ??
        (widget.barRadius != null
            ? BorderRadius.all(widget.barRadius!)
            : BorderRadius.circular(widget.lineHeight / 2));

    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveWidth = widget.width ?? constraints.maxWidth;

        final progressBar = Container(
          width: effectiveWidth,
          height: widget.lineHeight,
          decoration: BoxDecoration(
            color: widget.backgroundGradient == null
                ? widget.backgroundColor
                : null,
            gradient: widget.backgroundGradient,
            borderRadius: effectiveBorderRadius,
          ),
          child: ClipRRect(
            borderRadius: effectiveBorderRadius,
            child: Stack(
              children: [
                // Draw segments if provided
                if (widget.segments != null)
                  ..._buildSegments(effectiveWidth, currentPercent)
                else
                  // Single progress bar
                  _buildSingleProgress(effectiveWidth, currentPercent),

                // Center widget or percentage
                if (widget.center != null || widget.showPercentage)
                  Positioned.fill(
                    child: Center(
                      child: widget.center ??
                          Text(
                            _formatPercent(currentPercent),
                            style: widget.percentageTextStyle ??
                                TextStyle(
                                  fontSize: widget.lineHeight * 0.7,
                                  fontWeight: FontWeight.bold,
                                  color: _getTextColor(currentPercent),
                                ),
                          ),
                    ),
                  ),
              ],
            ),
          ),
        );

        // Handle child position for leading/trailing
        if (widget.childPosition == LinearChildPosition.left &&
            widget.leading != null) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.leading!,
              const SizedBox(width: 8),
              Expanded(child: progressBar),
            ],
          );
        } else if (widget.childPosition == LinearChildPosition.right &&
            widget.trailing != null) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: progressBar),
              const SizedBox(width: 8),
              widget.trailing!,
            ],
          );
        }

        return progressBar;
      },
    );
  }

  Widget _buildSingleProgress(double width, double percent) {
    return Align(
      alignment: widget.isRTL ? Alignment.centerRight : Alignment.centerLeft,
      child: AnimatedContainer(
        duration: widget.animation
            ? Duration.zero
            : Duration(milliseconds: widget.animationDuration),
        width: width * percent,
        height: widget.lineHeight,
        decoration: BoxDecoration(
          color: widget.linearGradient == null ? widget.progressColor : null,
          gradient: widget.linearGradient,
        ),
      ),
    );
  }

  List<Widget> _buildSegments(double width, double currentPercent) {
    final segments = <Widget>[];

    for (final segment in widget.segments!) {
      // Only show segment up to current percent
      final effectiveEnd = segment.end.clamp(0.0, currentPercent);
      if (effectiveEnd <= segment.start) continue;

      final segmentWidth = (effectiveEnd - segment.start) * width;
      final segmentLeft = segment.start * width;

      segments.add(
        Positioned(
          left: widget.isRTL ? null : segmentLeft,
          right: widget.isRTL ? segmentLeft : null,
          top: 0,
          bottom: 0,
          child: Container(
            width: segmentWidth,
            decoration: BoxDecoration(
              color: segment.gradient == null ? segment.color : null,
              gradient: segment.gradient,
            ),
          ),
        ),
      );
    }

    return segments;
  }

  Color _getTextColor(double percent) {
    // Determine text color based on progress
    if (percent > 0.5) {
      return Colors.white;
    }
    return Colors.black87;
  }
}

/// A multi-segment linear indicator that shows multiple progress values.
///
/// This widget displays multiple progress segments in a single bar,
/// useful for showing breakdowns or multiple metrics.
///
/// Example usage:
/// ```dart
/// MultiSegmentLinearIndicator(
///   segments: [
///     LinearSegment(start: 0.0, end: 0.3, color: Colors.green, label: 'Complete'),
///     LinearSegment(start: 0.3, end: 0.6, color: Colors.yellow, label: 'In Progress'),
///     LinearSegment(start: 0.6, end: 0.8, color: Colors.orange, label: 'Pending'),
///   ],
///   width: 300,
///   lineHeight: 25,
///   showLabels: true,
/// )
/// ```
class MultiSegmentLinearIndicator extends StatefulWidget {
  /// The segments to display.
  final List<LinearSegment> segments;

  /// The width of the indicator. If null, uses available space.
  final double? width;

  /// The height of the indicator line.
  final double lineHeight;

  /// The background color.
  final Color backgroundColor;

  /// The border radius.
  final BorderRadius? borderRadius;

  /// Whether to animate segment changes.
  final bool animation;

  /// The animation duration in milliseconds.
  final int animationDuration;

  /// The animation curve.
  final Curve animationCurve;

  /// Whether to show segment labels.
  final bool showLabels;

  /// Position of labels.
  final LinearChildPosition labelPosition;

  /// Text style for labels.
  final TextStyle? labelStyle;

  /// Spacing between segments.
  final double segmentSpacing;

  /// Padding around the widget.
  final EdgeInsets padding;

  /// Creates a multi-segment linear indicator.
  // ignore: sort_constructors_first
  const MultiSegmentLinearIndicator({
    super.key,
    required this.segments,
    this.width,
    this.lineHeight = 20.0,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.borderRadius,
    this.animation = false,
    this.animationDuration = 500,
    this.animationCurve = Curves.easeInOut,
    this.showLabels = false,
    this.labelPosition = LinearChildPosition.center,
    this.labelStyle,
    this.segmentSpacing = 0.0,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<MultiSegmentLinearIndicator> createState() =>
      _MultiSegmentLinearIndicatorState();
}

class _MultiSegmentLinearIndicatorState
    extends State<MultiSegmentLinearIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );

    if (widget.animation) {
      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController, curve: widget.animationCurve),
      );
      // ignore: discarded_futures
      _animationController.forward();
    } else {
      _animation = const AlwaysStoppedAnimation(1.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(widget.lineHeight / 2);

    return Padding(
      padding: widget.padding,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final effectiveWidth = widget.width ?? constraints.maxWidth;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Labels above
                  if (widget.showLabels &&
                      widget.labelPosition == LinearChildPosition.left)
                    _buildLabels(effectiveWidth),

                  // Progress bar
                  Container(
                    width: effectiveWidth,
                    height: widget.lineHeight,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: effectiveBorderRadius,
                    ),
                    child: ClipRRect(
                      borderRadius: effectiveBorderRadius,
                      child: Stack(
                        children: widget.segments.map((segment) {
                          final segmentWidth = (segment.end - segment.start) *
                              effectiveWidth *
                              _animation.value;
                          final segmentLeft = segment.start * effectiveWidth;

                          return Positioned(
                            left: segmentLeft,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: segmentWidth,
                              margin:
                                  EdgeInsets.only(right: widget.segmentSpacing),
                              decoration: BoxDecoration(
                                color: segment.gradient == null
                                    ? segment.color
                                    : null,
                                gradient: segment.gradient,
                              ),
                              child: widget.showLabels &&
                                      widget.labelPosition ==
                                          LinearChildPosition.center &&
                                      segment.label != null
                                  ? Center(
                                      child: Text(
                                        segment.label!,
                                        style: widget.labelStyle ??
                                            TextStyle(
                                              fontSize: widget.lineHeight * 0.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Labels below
                  if (widget.showLabels &&
                      widget.labelPosition == LinearChildPosition.right)
                    _buildLabels(effectiveWidth),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLabels(double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: widget.segments.map((segment) {
          final segmentWidth = (segment.end - segment.start) * width;
          return SizedBox(
            width: segmentWidth,
            child: segment.label != null
                ? Text(
                    segment.label!,
                    style: widget.labelStyle ??
                        TextStyle(fontSize: 10, color: segment.color),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                : const SizedBox.shrink(),
          );
        }).toList(),
      ),
    );
  }
}
