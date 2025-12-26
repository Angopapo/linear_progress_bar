import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/dots_decorator.dart';

/// Callback signature for dot tap events.
typedef OnTap = void Function(double position);

/// A widget that displays a row or column of animated dots indicating the
/// current position within a series of steps.
///
/// This is commonly used for page indicators, step indicators, or any
/// progress visualization where discrete steps need to be shown.
///
/// The dots animate smoothly between states, providing visual feedback
/// as the position changes.
///
/// Example usage:
/// ```dart
/// DotsIndicator(
///   dotsCount: 5,
///   position: 2,
///   decorator: DotsDecorator(
///     activeColor: Colors.blue,
///     size: Size.square(12),
///   ),
///   onTap: (position) => print('Tapped dot at $position'),
/// )
/// ```
class DotsIndicator extends StatelessWidget {
  /// The total number of dots to display.
  ///
  /// Must be greater than 0.
  final int dotsCount;

  /// The current position/active dot index.
  ///
  /// Can be a fractional value to allow for smooth animations between positions.
  /// Must be >= 0 and < [dotsCount].
  final double position;

  /// The decorator configuration for customizing dot appearance.
  ///
  /// Defaults to [DotsDecorator()] with default values.
  final DotsDecorator decorator;

  /// The axis along which the dots are arranged.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis axis;

  /// Whether to reverse the order of dots.
  ///
  /// Defaults to false.
  final bool reversed;

  /// Callback when a dot is tapped.
  ///
  /// The callback receives the tapped dot's position as a parameter.
  final OnTap? onTap;

  /// The main axis size for the dots container.
  ///
  /// Defaults to [MainAxisSize.min].
  final MainAxisSize mainAxisSize;

  /// The main axis alignment for the dots.
  ///
  /// Defaults to [MainAxisAlignment.center].
  final MainAxisAlignment mainAxisAlignment;

  /// The cross axis alignment for the dots.
  ///
  /// Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment crossAxisAlignment;

  /// Creates a dots indicator widget.
  ///
  /// The [dotsCount] must be greater than 0.
  /// The [position] must be >= 0 and < [dotsCount].
  // ignore: sort_constructors_first
  const DotsIndicator({
    super.key,
    required this.dotsCount,
    this.position = 0.0,
    this.decorator = const DotsDecorator(),
    this.axis = Axis.horizontal,
    this.reversed = false,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.onTap,
  })  : assert(dotsCount > 0, 'dotsCount must be greater than 0'),
        assert(position >= 0, 'position must be non-negative'),
        assert(
          position < dotsCount,
          'position must be less than dotsCount (position: $position, dotsCount: $dotsCount)',
        );

  /// Builds an individual dot widget.
  Widget _buildDot(int index) {
    // Calculate interpolation state (0.0 = active, 1.0 = inactive)
    final state = min(1.0, (position - index).abs());

    // Interpolate size between active and inactive
    final size = Size.lerp(decorator.activeSize, decorator.size, state)!;

    // Interpolate color between active and inactive
    final color = Color.lerp(
      decorator.activeColor ?? Colors.blue,
      decorator.color ?? Colors.grey,
      state,
    );

    // Interpolate shape between active and inactive
    final shape = ShapeBorder.lerp(
      decorator.activeShape,
      decorator.shape,
      state,
    )!;

    final dot = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: size.width,
      height: size.height,
      margin: decorator.spacing,
      decoration: ShapeDecoration(
        color: color,
        shape: shape,
      ),
    );

    if (onTap == null) {
      return dot;
    }

    return InkWell(
      customBorder: shape is CircleBorder ? const CircleBorder() : null,
      borderRadius: shape is RoundedRectangleBorder
          ? (shape.borderRadius as BorderRadius?)
          : null,
      onTap: () => onTap!(index.toDouble()),
      child: dot,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dotsList = List<Widget>.generate(dotsCount, _buildDot);
    final dots = reversed ? dotsList.reversed.toList() : dotsList;

    return axis == Axis.vertical
        ? Column(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            children: dots,
          )
        : Row(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            children: dots,
          );
  }
}
