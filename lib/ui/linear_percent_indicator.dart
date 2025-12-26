import 'package:flutter/material.dart';

/// The position of the child widget relative to the linear indicator.
enum LinearChildPosition {
  /// Child widget on the left side.
  left,

  /// Child widget on the right side.
  right,

  /// Child widget in the center (overlay).
  center,
}

/// The direction of the linear progress.
enum LinearProgressDirection {
  /// Progress from left to right.
  ltr,

  /// Progress from right to left.
  rtl,
}

/// Configuration for a segment in a multi-segment indicator.
class LinearSegment {
  /// The percentage value of this segment (0.0 to 1.0).
  final double value;

  /// The color of this segment.
  final Color color;

  /// Optional gradient for this segment.
  final Gradient? gradient;

  /// Optional label for this segment.
  final String? label;

  /// Creates a linear segment.
  const LinearSegment({
    required this.value,
    required this.color,
    this.gradient,
    this.label,
  });
}

/// A beautiful and customizable linear percent indicator widget.
///
/// This widget displays progress in a linear format with extensive
/// customization options including gradients, animations, multi-segment
/// support, and flexible child positioning.
///
/// Example usage:
/// ```dart
/// LinearPercentIndicator(
///   percent: 0.75,
///   lineHeight: 20,
///   progressColor: Colors.blue,
///   backgroundColor: Colors.grey.shade300,
///   center: Text('75%'),
///   animation: true,
///   leading: Icon(Icons.download),
///   trailing: Text('Download'),
/// )
/// ```
class LinearPercentIndicator extends StatefulWidget {
  /// The progress value between 0.0 and 1.0.
  final double percent;

  /// The width of the indicator.
  /// If null, it will fill the available width.
  final double? width;

  /// The height of the progress line.
  final double lineHeight;

  /// The color of the progress indicator.
  final Color progressColor;

  /// The background color of the indicator.
  final Color backgroundColor;

  /// Optional gradient for the progress indicator.
  /// If provided, overrides [progressColor].
  final Gradient? linearGradient;

  /// Optional gradient for the background.
  final Gradient? backgroundGradient;

  /// The border radius of the progress bar.
  final BorderRadius? barRadius;

  /// Whether to animate progress changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Callback when animation completes.
  final VoidCallback? onAnimationEnd;

  /// Whether to restart animation from 0 when percent changes.
  final bool restartAnimation;

  /// Whether to animate from the last percent value.
  final bool animateFromLastPercent;

  /// Widget to display in the center of the progress bar.
  final Widget? center;

  /// Widget to display on the leading side (left for LTR).
  final Widget? leading;

  /// Widget to display on the trailing side (right for LTR).
  final Widget? trailing;

  /// Padding around the indicator.
  final EdgeInsets padding;

  /// Whether to fill the background completely.
  final bool fillBackground;

  /// Whether to clip the progress bar.
  final bool clipLinearGradient;

  /// The direction of the progress.
  final LinearProgressDirection progressDirection;

  /// Segments for multi-segment indicator.
  final List<LinearSegment>? segments;

  /// Whether to add spacing between segments.
  final double segmentSpacing;

  /// Whether the indicator is determinate (shows exact progress).
  final bool isIndeterminate;

  /// The child position relative to the indicator.
  final LinearChildPosition childPosition;

  /// Custom child widget.
  final Widget? child;

  /// Spacing between child and indicator.
  final double childSpacing;

  /// Whether to add a mask to show the progress visually.
  final bool addAutomaticKeepAlive;

  /// The alignment of the progress within the track.
  final MainAxisAlignment alignment;

  /// Creates a linear percent indicator widget.
  const LinearPercentIndicator({
    super.key,
    this.percent = 0.0,
    this.width,
    this.lineHeight = 10.0,
    this.progressColor = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.linearGradient,
    this.backgroundGradient,
    this.barRadius,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.onAnimationEnd,
    this.restartAnimation = false,
    this.animateFromLastPercent = false,
    this.center,
    this.leading,
    this.trailing,
    this.padding = EdgeInsets.zero,
    this.fillBackground = true,
    this.clipLinearGradient = true,
    this.progressDirection = LinearProgressDirection.ltr,
    this.segments,
    this.segmentSpacing = 0.0,
    this.isIndeterminate = false,
    this.childPosition = LinearChildPosition.center,
    this.child,
    this.childSpacing = 8.0,
    this.addAutomaticKeepAlive = true,
    this.alignment = MainAxisAlignment.start,
  }) : assert(percent >= 0.0 && percent <= 1.0, 'Percent must be between 0.0 and 1.0');

  @override
  State<LinearPercentIndicator> createState() => _LinearPercentIndicatorState();
}

class _LinearPercentIndicatorState extends State<LinearPercentIndicator>
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: widget.alignment,
        mainAxisSize: MainAxisSize.min,
        children: _buildRowChildren(),
      ),
    );
  }

  List<Widget> _buildRowChildren() {
    final List<Widget> children = [];

    // Add leading widget
    if (widget.leading != null) {
      children.add(widget.leading!);
      children.add(SizedBox(width: widget.childSpacing));
    }

    // Add left child if specified
    if (widget.child != null && widget.childPosition == LinearChildPosition.left) {
      children.add(widget.child!);
      children.add(SizedBox(width: widget.childSpacing));
    }

    // Add progress indicator
    children.add(_buildProgressIndicator());

    // Add right child if specified
    if (widget.child != null && widget.childPosition == LinearChildPosition.right) {
      children.add(SizedBox(width: widget.childSpacing));
      children.add(widget.child!);
    }

    // Add trailing widget
    if (widget.trailing != null) {
      children.add(SizedBox(width: widget.childSpacing));
      children.add(widget.trailing!);
    }

    return children;
  }

  Widget _buildProgressIndicator() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        Widget progressBar;

        if (widget.segments != null && widget.segments!.isNotEmpty) {
          progressBar = _buildMultiSegmentIndicator();
        } else {
          progressBar = _buildSingleIndicator();
        }

        // Add center widget if specified
        if (widget.center != null || 
            (widget.child != null && widget.childPosition == LinearChildPosition.center)) {
          progressBar = Stack(
            alignment: Alignment.center,
            children: [
              progressBar,
              widget.center ?? widget.child!,
            ],
          );
        }

        return progressBar;
      },
    );
  }

  Widget _buildSingleIndicator() {
    final radius = widget.barRadius ?? BorderRadius.circular(widget.lineHeight / 2);
    final isRtl = widget.progressDirection == LinearProgressDirection.rtl;

    return SizedBox(
      width: widget.width,
      height: widget.lineHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = widget.width ?? constraints.maxWidth;
          final progressWidth = availableWidth * _animation.value;

          return Stack(
            children: [
              // Background
              Container(
                width: availableWidth,
                height: widget.lineHeight,
                decoration: BoxDecoration(
                  borderRadius: radius,
                  color: widget.backgroundGradient == null ? widget.backgroundColor : null,
                  gradient: widget.backgroundGradient,
                ),
              ),
              // Progress
              Positioned(
                left: isRtl ? null : 0,
                right: isRtl ? 0 : null,
                child: ClipRRect(
                  borderRadius: radius,
                  child: Container(
                    width: progressWidth,
                    height: widget.lineHeight,
                    decoration: BoxDecoration(
                      borderRadius: radius,
                      color: widget.linearGradient == null ? widget.progressColor : null,
                      gradient: widget.linearGradient,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMultiSegmentIndicator() {
    final radius = widget.barRadius ?? BorderRadius.circular(widget.lineHeight / 2);
    final segments = widget.segments!;

    return SizedBox(
      width: widget.width,
      height: widget.lineHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = widget.width ?? constraints.maxWidth;

          return Stack(
            children: [
              // Background
              Container(
                width: availableWidth,
                height: widget.lineHeight,
                decoration: BoxDecoration(
                  borderRadius: radius,
                  color: widget.backgroundColor,
                ),
              ),
              // Segments
              ClipRRect(
                borderRadius: radius,
                child: Row(
                  children: _buildSegments(availableWidth),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildSegments(double totalWidth) {
    final segments = widget.segments!;
    final List<Widget> segmentWidgets = [];
    double currentOffset = 0;

    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final segmentWidth = totalWidth * segment.value;
      
      // Only show segments up to the current animation value
      final visibleWidth = (currentOffset + segmentWidth <= totalWidth * _animation.value)
          ? segmentWidth
          : (totalWidth * _animation.value - currentOffset).clamp(0.0, segmentWidth);

      if (visibleWidth > 0) {
        if (i > 0 && widget.segmentSpacing > 0) {
          segmentWidgets.add(SizedBox(width: widget.segmentSpacing));
        }

        segmentWidgets.add(
          Container(
            width: visibleWidth,
            height: widget.lineHeight,
            decoration: BoxDecoration(
              color: segment.gradient == null ? segment.color : null,
              gradient: segment.gradient,
            ),
          ),
        );
      }

      currentOffset += segmentWidth;
      if (currentOffset >= totalWidth * _animation.value) break;
    }

    return segmentWidgets;
  }
}

/// A widget that displays multiple linear progress indicators stacked.
///
/// Useful for showing multiple progress values in a single indicator.
class MultiLinearPercentIndicator extends StatelessWidget {
  /// The list of progress values and their configurations.
  final List<LinearSegment> segments;

  /// The height of the indicator.
  final double lineHeight;

  /// The width of the indicator.
  final double? width;

  /// The background color.
  final Color backgroundColor;

  /// The border radius.
  final BorderRadius? barRadius;

  /// Whether to animate changes.
  final bool animation;

  /// The animation duration.
  final Duration animationDuration;

  /// The animation curve.
  final Curve animationCurve;

  /// Creates a multi-linear percent indicator.
  const MultiLinearPercentIndicator({
    super.key,
    required this.segments,
    this.lineHeight = 10.0,
    this.width,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.barRadius,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final radius = barRadius ?? BorderRadius.circular(lineHeight / 2);

    return SizedBox(
      width: width,
      height: lineHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = width ?? constraints.maxWidth;

          return Stack(
            children: [
              // Background
              Container(
                width: availableWidth,
                height: lineHeight,
                decoration: BoxDecoration(
                  borderRadius: radius,
                  color: backgroundColor,
                ),
              ),
              // Segments
              ClipRRect(
                borderRadius: radius,
                child: SizedBox(
                  width: availableWidth,
                  height: lineHeight,
                  child: Row(
                    children: segments.map((segment) {
                      final segmentWidth = availableWidth * segment.value;
                      if (animation) {
                        return TweenAnimationBuilder<double>(
                          duration: animationDuration,
                          curve: animationCurve,
                          tween: Tween<double>(begin: 0, end: segmentWidth),
                          builder: (context, value, child) {
                            return Container(
                              width: value,
                              height: lineHeight,
                              decoration: BoxDecoration(
                                color: segment.gradient == null ? segment.color : null,
                                gradient: segment.gradient,
                              ),
                            );
                          },
                        );
                      }
                      return Container(
                        width: segmentWidth,
                        height: lineHeight,
                        decoration: BoxDecoration(
                          color: segment.gradient == null ? segment.color : null,
                          gradient: segment.gradient,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// A widget that displays a stacked/layered linear progress indicator.
///
/// Useful for showing overlapping progress values.
class StackedLinearPercentIndicator extends StatelessWidget {
  /// The list of progress values and their configurations.
  /// Segments are drawn in order (first at bottom, last on top).
  final List<LinearSegment> segments;

  /// The height of the indicator.
  final double lineHeight;

  /// The width of the indicator.
  final double? width;

  /// The background color.
  final Color backgroundColor;

  /// The border radius.
  final BorderRadius? barRadius;

  /// Whether to animate changes.
  final bool animation;

  /// The animation duration.
  final Duration animationDuration;

  /// The animation curve.
  final Curve animationCurve;

  /// Creates a stacked linear percent indicator.
  const StackedLinearPercentIndicator({
    super.key,
    required this.segments,
    this.lineHeight = 10.0,
    this.width,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.barRadius,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final radius = barRadius ?? BorderRadius.circular(lineHeight / 2);

    return SizedBox(
      width: width,
      height: lineHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = width ?? constraints.maxWidth;

          return ClipRRect(
            borderRadius: radius,
            child: Stack(
              children: [
                // Background
                Container(
                  width: availableWidth,
                  height: lineHeight,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                ),
                // Segments (stacked)
                ...segments.map((segment) {
                  if (animation) {
                    return TweenAnimationBuilder<double>(
                      duration: animationDuration,
                      curve: animationCurve,
                      tween: Tween<double>(begin: 0, end: segment.value),
                      builder: (context, value, child) {
                        return Container(
                          width: availableWidth * value,
                          height: lineHeight,
                          decoration: BoxDecoration(
                            color: segment.gradient == null ? segment.color : null,
                            gradient: segment.gradient,
                          ),
                        );
                      },
                    );
                  }
                  return Container(
                    width: availableWidth * segment.value,
                    height: lineHeight,
                    decoration: BoxDecoration(
                      color: segment.gradient == null ? segment.color : null,
                      gradient: segment.gradient,
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
