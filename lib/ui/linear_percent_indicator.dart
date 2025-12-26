import 'package:flutter/material.dart';

/// The position of the child widget in a linear percent indicator.
enum LinearChildPosition {
  /// Child positioned to the left of the progress bar.
  left,

  /// Child positioned to the right of the progress bar.
  right,

  /// Child positioned at the center of the progress bar.
  center,
}

/// Configuration for a segment in a multi-segment linear indicator.
class LinearSegment {
  /// The percentage value of this segment (0.0 to 1.0).
  final double value;

  /// The color of this segment.
  final Color color;

  /// Optional gradient for this segment.
  final Gradient? gradient;

  /// Optional label for this segment.
  final String? label;

  /// Creates a linear segment configuration.
  const LinearSegment({
    required this.value,
    required this.color,
    this.gradient,
    this.label,
  }) : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0.0 and 1.0');
}

/// A beautiful and customizable linear percent indicator widget.
///
/// This widget displays progress in a linear/horizontal format with extensive
/// customization options including gradients, animations, multiple segments,
/// and child widget positioning.
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
///   animationDuration: Duration(milliseconds: 500),
/// )
/// ```
class LinearPercentIndicator extends StatefulWidget {
  /// The progress value between 0.0 and 1.0.
  final double percent;

  /// The width of the progress bar. If null, expands to available width.
  final double? width;

  /// The height/thickness of the progress bar.
  final double lineHeight;

  /// The color of the progress indicator.
  final Color progressColor;

  /// The background color of the progress bar.
  final Color backgroundColor;

  /// Optional gradient for the progress indicator.
  /// If provided, overrides [progressColor].
  final Gradient? linearGradient;

  /// Optional gradient for the background.
  final Gradient? backgroundGradient;

  /// The border radius of the progress bar.
  final BorderRadius? barRadius;

  /// Whether to clip the progress to the bar bounds.
  final bool clipLinearGradient;

  /// The style of the line cap.
  final LinearStrokeCap linearStrokeCap;

  /// Whether to animate progress changes.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve curve;

  /// Whether to restart animation from 0 when percent changes.
  final bool restartAnimation;

  /// Whether to animate from last percent or from 0.
  final bool animateFromLastPercent;

  /// Callback when animation completes.
  final VoidCallback? onAnimationEnd;

  /// Widget to display in the center of the progress bar.
  final Widget? center;

  /// Widget to display on the left side of the progress bar.
  final Widget? leading;

  /// Widget to display on the right side of the progress bar.
  final Widget? trailing;

  /// Padding around the widget.
  final EdgeInsets padding;

  /// The alignment of the progress bar within its container.
  final MainAxisAlignment alignment;

  /// Fill color behind the progress bar.
  final Color? fillColor;

  /// Whether the progress bar is displayed in reverse.
  final bool isRTL;

  /// Child widget to display.
  final Widget? child;

  /// Position of the child widget.
  final LinearChildPosition childPosition;

  /// Spacing between child and progress bar.
  final double childSpacing;

  /// List of segments for multi-segment indicator.
  final List<LinearSegment>? segments;

  /// Whether to show segment dividers.
  final bool showSegmentDividers;

  /// The width of segment dividers.
  final double segmentDividerWidth;

  /// The color of segment dividers.
  final Color segmentDividerColor;

  /// Whether to add a mask for gradient alignment.
  final bool addAutomaticKeepAlive;

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
    this.clipLinearGradient = true,
    this.linearStrokeCap = LinearStrokeCap.round,
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.restartAnimation = false,
    this.animateFromLastPercent = false,
    this.onAnimationEnd,
    this.center,
    this.leading,
    this.trailing,
    this.padding = EdgeInsets.zero,
    this.alignment = MainAxisAlignment.start,
    this.fillColor,
    this.isRTL = false,
    this.child,
    this.childPosition = LinearChildPosition.center,
    this.childSpacing = 8.0,
    this.segments,
    this.showSegmentDividers = false,
    this.segmentDividerWidth = 2.0,
    this.segmentDividerColor = Colors.white,
    this.addAutomaticKeepAlive = true,
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
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget progressBar = AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return _buildProgressBar(_animation.value);
      },
    );

    // Add child based on position
    if (widget.child != null) {
      switch (widget.childPosition) {
        case LinearChildPosition.left:
          progressBar = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.child!,
              SizedBox(width: widget.childSpacing),
              Expanded(child: progressBar),
            ],
          );
          break;
        case LinearChildPosition.right:
          progressBar = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: progressBar),
              SizedBox(width: widget.childSpacing),
              widget.child!,
            ],
          );
          break;
        case LinearChildPosition.center:
          // Center is handled inside the progress bar
          break;
      }
    }

    // Add leading and trailing
    if (widget.leading != null || widget.trailing != null) {
      progressBar = Row(
        mainAxisAlignment: widget.alignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.leading != null) ...[
            widget.leading!,
            const SizedBox(width: 8),
          ],
          Expanded(child: progressBar),
          if (widget.trailing != null) ...[
            const SizedBox(width: 8),
            widget.trailing!,
          ],
        ],
      );
    }

    return Directionality(
      textDirection: widget.isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: widget.padding,
        child: progressBar,
      ),
    );
  }

  Widget _buildProgressBar(double percent) {
    final radius = widget.barRadius ?? 
        (widget.linearStrokeCap == LinearStrokeCap.round
            ? BorderRadius.circular(widget.lineHeight / 2)
            : BorderRadius.zero);

    return Container(
      width: widget.width,
      height: widget.lineHeight,
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius: radius,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            // Background
            _buildBackground(radius),
            
            // Progress or Segments
            if (widget.segments != null && widget.segments!.isNotEmpty)
              _buildSegments(radius)
            else
              _buildProgress(percent, radius),
            
            // Center widget
            if (widget.center != null ||
                (widget.child != null && widget.childPosition == LinearChildPosition.center))
              Positioned.fill(
                child: Center(
                  child: widget.center ?? widget.child,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(BorderRadius radius) {
    if (widget.backgroundGradient != null) {
      return Container(
        decoration: BoxDecoration(
          gradient: widget.backgroundGradient,
          borderRadius: radius,
        ),
      );
    }
    return Container(
      color: widget.backgroundColor,
    );
  }

  Widget _buildProgress(double percent, BorderRadius radius) {
    if (percent <= 0) return const SizedBox.shrink();

    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: percent.clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: widget.linearGradient,
          color: widget.linearGradient == null ? widget.progressColor : null,
          borderRadius: widget.clipLinearGradient
              ? radius
              : BorderRadius.only(
                  topLeft: radius.topLeft,
                  bottomLeft: radius.bottomLeft,
                ),
        ),
      ),
    );
  }

  Widget _buildSegments(BorderRadius radius) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        double currentPosition = 0.0;
        
        return Stack(
          children: [
            for (int i = 0; i < widget.segments!.length; i++) ...[
              // Segment
              Positioned(
                left: currentPosition,
                top: 0,
                bottom: 0,
                width: (() {
                  final width = totalWidth * widget.segments![i].value;
                  currentPosition += width;
                  return width;
                })(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: widget.segments![i].gradient,
                    color: widget.segments![i].gradient == null
                        ? widget.segments![i].color
                        : null,
                  ),
                ),
              ),
            ],
            // Segment dividers
            if (widget.showSegmentDividers)
              ..._buildSegmentDividers(totalWidth),
          ],
        );
      },
    );
  }

  List<Widget> _buildSegmentDividers(double totalWidth) {
    final dividers = <Widget>[];
    double position = 0.0;
    
    for (int i = 0; i < widget.segments!.length - 1; i++) {
      position += totalWidth * widget.segments![i].value;
      dividers.add(
        Positioned(
          left: position - widget.segmentDividerWidth / 2,
          top: 0,
          bottom: 0,
          width: widget.segmentDividerWidth,
          child: Container(
            color: widget.segmentDividerColor,
          ),
        ),
      );
    }
    
    return dividers;
  }
}

/// The style of the line cap for the linear progress indicator.
enum LinearStrokeCap {
  /// Rounded cap at the ends.
  round,

  /// Square cap at the ends.
  square,

  /// No cap at the ends.
  butt,
}

/// A multi-segment linear indicator that shows multiple progress values.
///
/// This is useful for showing multiple categories or breakdown of a total.
///
/// Example usage:
/// ```dart
/// MultiSegmentLinearIndicator(
///   segments: [
///     LinearSegment(value: 0.3, color: Colors.red, label: 'Red'),
///     LinearSegment(value: 0.2, color: Colors.yellow, label: 'Yellow'),
///     LinearSegment(value: 0.5, color: Colors.green, label: 'Green'),
///   ],
///   height: 20,
///   animation: true,
/// )
/// ```
class MultiSegmentLinearIndicator extends StatefulWidget {
  /// The segments to display.
  final List<LinearSegment> segments;

  /// The height of the indicator.
  final double height;

  /// The border radius of the indicator.
  final BorderRadius? borderRadius;

  /// The background color.
  final Color backgroundColor;

  /// Whether to animate the segments.
  final bool animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The curve for the animation.
  final Curve animationCurve;

  /// Whether to show segment dividers.
  final bool showDividers;

  /// The width of dividers.
  final double dividerWidth;

  /// The color of dividers.
  final Color dividerColor;

  /// Whether to show labels below segments.
  final bool showLabels;

  /// The text style for labels.
  final TextStyle? labelStyle;

  /// Spacing between segments (if no dividers).
  final double segmentSpacing;

  /// Creates a multi-segment linear indicator.
  const MultiSegmentLinearIndicator({
    super.key,
    required this.segments,
    this.height = 16.0,
    this.borderRadius,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.showDividers = false,
    this.dividerWidth = 2.0,
    this.dividerColor = Colors.white,
    this.showLabels = false,
    this.labelStyle,
    this.segmentSpacing = 0.0,
  });

  @override
  State<MultiSegmentLinearIndicator> createState() => _MultiSegmentLinearIndicatorState();
}

class _MultiSegmentLinearIndicatorState extends State<MultiSegmentLinearIndicator>
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
      _animation = CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      );
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
    final radius = widget.borderRadius ?? BorderRadius.circular(widget.height / 2);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: radius,
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return _buildSegments(constraints.maxWidth);
                  },
                );
              },
            ),
          ),
        ),
        if (widget.showLabels) ...[
          const SizedBox(height: 4),
          _buildLabels(),
        ],
      ],
    );
  }

  Widget _buildSegments(double totalWidth) {
    final List<Widget> segmentWidgets = [];
    double currentPosition = 0.0;
    final animatedFactor = _animation.value;

    for (int i = 0; i < widget.segments.length; i++) {
      final segment = widget.segments[i];
      final segmentWidth = totalWidth * segment.value * animatedFactor;
      
      segmentWidgets.add(
        Positioned(
          left: currentPosition,
          top: 0,
          bottom: 0,
          width: segmentWidth,
          child: Container(
            margin: EdgeInsets.only(
              left: i > 0 && widget.segmentSpacing > 0 ? widget.segmentSpacing / 2 : 0,
              right: i < widget.segments.length - 1 && widget.segmentSpacing > 0
                  ? widget.segmentSpacing / 2
                  : 0,
            ),
            decoration: BoxDecoration(
              gradient: segment.gradient,
              color: segment.gradient == null ? segment.color : null,
            ),
          ),
        ),
      );
      
      // Add divider
      if (widget.showDividers && i < widget.segments.length - 1 && segmentWidth > 0) {
        segmentWidgets.add(
          Positioned(
            left: currentPosition + segmentWidth - widget.dividerWidth / 2,
            top: 0,
            bottom: 0,
            width: widget.dividerWidth,
            child: Container(color: widget.dividerColor),
          ),
        );
      }
      
      currentPosition += segmentWidth + widget.segmentSpacing;
    }

    return Stack(children: segmentWidgets);
  }

  Widget _buildLabels() {
    return Row(
      children: widget.segments.map((segment) {
        return Expanded(
          flex: (segment.value * 100).toInt(),
          child: Text(
            segment.label ?? '',
            style: widget.labelStyle ?? const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}

/// Extension to create common linear percent indicator styles.
extension LinearPercentIndicatorStyles on LinearPercentIndicator {
  /// Creates a minimal flat style indicator.
  static LinearPercentIndicator minimal({
    Key? key,
    required double percent,
    double lineHeight = 8.0,
    Color progressColor = Colors.blue,
    Color backgroundColor = const Color(0xFFE0E0E0),
    bool animation = true,
    Duration animationDuration = const Duration(milliseconds: 500),
  }) {
    return LinearPercentIndicator(
      key: key,
      percent: percent,
      lineHeight: lineHeight,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      animation: animation,
      animationDuration: animationDuration,
      linearStrokeCap: LinearStrokeCap.round,
    );
  }

  /// Creates a gradient style indicator.
  static LinearPercentIndicator gradient({
    Key? key,
    required double percent,
    double lineHeight = 12.0,
    List<Color> colors = const [Colors.blue, Colors.purple],
    Color backgroundColor = const Color(0xFFE0E0E0),
    bool animation = true,
  }) {
    return LinearPercentIndicator(
      key: key,
      percent: percent,
      lineHeight: lineHeight,
      linearGradient: LinearGradient(colors: colors),
      backgroundColor: backgroundColor,
      animation: animation,
      linearStrokeCap: LinearStrokeCap.round,
    );
  }

  /// Creates a thick style indicator.
  static LinearPercentIndicator thick({
    Key? key,
    required double percent,
    Color progressColor = Colors.teal,
    Color backgroundColor = const Color(0xFFE0E0E0),
    bool animation = true,
    Widget? center,
  }) {
    return LinearPercentIndicator(
      key: key,
      percent: percent,
      lineHeight: 24.0,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      animation: animation,
      linearStrokeCap: LinearStrokeCap.round,
      center: center,
    );
  }
}
