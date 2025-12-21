import 'package:flutter/material.dart';

/// Default size for dots.
const Size kDefaultSize = Size.square(9.0);

/// Default spacing around dots.
const EdgeInsets kDefaultSpacing = EdgeInsets.all(6.0);

/// Default shape for dots (circle).
const ShapeBorder kDefaultShape = CircleBorder();

/// Configuration class for customizing the appearance of dots in [DotsIndicator].
///
/// This class provides extensive customization options for both active and
/// inactive dot states.
///
/// Example usage:
/// ```dart
/// DotsDecorator(
///   color: Colors.grey,
///   activeColor: Colors.blue,
///   size: Size.square(10),
///   activeSize: Size.square(15),
///   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
///   activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
/// )
/// ```
class DotsDecorator {
  /// The color of inactive dots.
  ///
  /// Defaults to [Colors.grey] if not specified.
  final Color? color;

  /// The color of the active dot.
  ///
  /// Defaults to [Colors.blue] if not specified.
  final Color? activeColor;

  /// The size of inactive dots.
  ///
  /// Defaults to [kDefaultSize] (9x9).
  final Size size;

  /// The size of the active dot.
  ///
  /// Defaults to [kDefaultSize] (9x9).
  final Size activeSize;

  /// The shape of inactive dots.
  ///
  /// Defaults to [CircleBorder].
  final ShapeBorder shape;

  /// The shape of the active dot.
  ///
  /// Defaults to [CircleBorder].
  final ShapeBorder activeShape;

  /// The spacing around each dot.
  ///
  /// Defaults to [kDefaultSpacing] (6.0 all sides).
  final EdgeInsets spacing;

  /// Creates a dots decorator configuration.
  ///
  /// All parameters are optional and will use sensible defaults if not provided.
  const DotsDecorator({
    this.color,
    this.activeColor,
    this.size = kDefaultSize,
    this.activeSize = kDefaultSize,
    this.shape = kDefaultShape,
    this.activeShape = kDefaultShape,
    this.spacing = kDefaultSpacing,
  });

  /// Creates a copy of this decorator with the given fields replaced.
  DotsDecorator copyWith({
    Color? color,
    Color? activeColor,
    Size? size,
    Size? activeSize,
    ShapeBorder? shape,
    ShapeBorder? activeShape,
    EdgeInsets? spacing,
  }) {
    return DotsDecorator(
      color: color ?? this.color,
      activeColor: activeColor ?? this.activeColor,
      size: size ?? this.size,
      activeSize: activeSize ?? this.activeSize,
      shape: shape ?? this.shape,
      activeShape: activeShape ?? this.activeShape,
      spacing: spacing ?? this.spacing,
    );
  }

  /// Returns the effective inactive color (with fallback to grey).
  Color get effectiveColor => color ?? Colors.grey;

  /// Returns the effective active color (with fallback to blue).
  Color get effectiveActiveColor => activeColor ?? Colors.blue;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DotsDecorator &&
        other.color == color &&
        other.activeColor == activeColor &&
        other.size == size &&
        other.activeSize == activeSize &&
        other.shape == shape &&
        other.activeShape == activeShape &&
        other.spacing == spacing;
  }

  @override
  int get hashCode {
    return Object.hash(
      color,
      activeColor,
      size,
      activeSize,
      shape,
      activeShape,
      spacing,
    );
  }

  @override
  String toString() {
    return 'DotsDecorator('
        'color: $color, '
        'activeColor: $activeColor, '
        'size: $size, '
        'activeSize: $activeSize, '
        'shape: $shape, '
        'activeShape: $activeShape, '
        'spacing: $spacing)';
  }
}
