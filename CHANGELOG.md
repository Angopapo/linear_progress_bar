# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2025-12-26

### Added

- **CircularPercentIndicator** - Beautiful circular progress indicator with:
  - Customizable radius and line width
  - Gradient support
  - Multiple start angles (top, right, bottom, left)
  - Reversible direction
  - Smooth animations with customizable duration and curve
  - Center, header, and footer widget slots
  - Filled background option
  - Round, square, or butt stroke caps
  
- **GaugeIndicator** - Modern speedometer-style gauge with:
  - Multiple styles (simple, ticked, segmented, modern)
  - Needle pointer with customizable color
  - Color ranges for different value segments
  - Custom value formatter
  - Min/max labels
  - Title and subtitle widgets
  - Configurable start and sweep angles
  - Tick marks with customizable count and length
  - Gradient support
  - Smooth animations
  
- **LinearPercentIndicator** - Linear progress indicator with:
  - Leading, trailing, and center widget slots
  - Child positioning (left, right, center)
  - Multi-segment support
  - Gradient progress
  - RTL (right-to-left) support
  - Smooth animations with customizable duration and curve
  - Percentage display option
  - Customizable line height and width
  
- **MultiSegmentLinearIndicator** - Multi-segment linear progress indicator with:
  - Multiple progress segments in a single bar
  - Individual colors and labels for each segment
  - Smooth animations
  - Label positioning options
  
- **LinearGauge** - Linear gauge with:
  - Horizontal and vertical orientations
  - Ruler styles (none, simple, labeled, graduated, bothSides)
  - Pointer types (triangle, diamond, arrow, circle, rectangle, invertedTriangle)
  - Value bar with gradient support
  - Range coloring for different value segments
  - Animation and interactivity (drag to change value)
  - Customizable tick marks and labels
  - Min/max value labels
  
- **RadialGauge** - Radial gauge with:
  - Customizable start position (top, right, bottom, left, custom angle)
  - Needle pointer styles (simple, tapered, triangle, diamond, flat, compass)
  - Shape pointer types (circle, triangle, diamond, rectangle, arrow, invertedTriangle)
  - Value bar with gradient support
  - Range coloring for different value segments
  - Tick marks with labels
  - Animation and interactivity (drag to change value)
  - Customizable sweep angle and track width
  
- **GaugeDecorator** - Preset configurations for gauges:
  - `GaugeDecorator.speedometer()` - Speedometer style with ranges
  - `GaugeDecorator.minimal()` - Clean minimal half-gauge
  - `GaugeDecorator.gradient()` - Modern gradient gauge
  - `GaugeDecorator.health()` - Health/fitness style
  - `GaugeDecorator.temperature()` - Temperature gauge style
  
- **CircularDecorator** - Preset configurations for circular indicators:
  - `CircularDecorator.gradient()` - Gradient style
  - `CircularDecorator.minimal()` - Minimal flat style
  - `CircularDecorator.thick()` - Thick line style
  - `CircularDecorator.thin()` - Thin line style

- **New Enums**:
  - `GaugeStyle` - simple, ticked, segmented, modern
  - `GaugeLabelPosition` - center, bottom, none
  - `CircularStrokeCap` - round, square, butt
  - `CircularStartAngle` - top, right, bottom, left
  - `CircularChildPosition` - center, top, bottom
  - `ArcType` - half, full
  - `LinearGaugeOrientation` - horizontal, vertical
  - `RulerStyle` - none, simple, labeled, graduated, bothSides
  - `RulerPosition` - start, end, both
  - `PointerStyle` - none, triangle, diamond, arrow, circle, rectangle, invertedTriangle
  - `PointerPosition` - start, center, end
  - `RadialGaugePosition` - top, right, bottom, left, custom
  - `NeedleStyle` - none, simple, tapered, triangle, diamond, flat, compass
  - `ShapePointerStyle` - none, circle, triangle, diamond, rectangle, arrow, invertedTriangle
  - `ShapePointerPosition` - inner, center, outer
  - `LinearChildPosition` - left, right, center

- **Helper Classes**:
  - `GaugeRange` - Define color ranges for gauge
  - `GaugeSegment` - Define segments for segmented gauge
  - `LinearGaugeRange` - Define color ranges for linear gauge
  - `RadialGaugeRange` - Define color ranges for radial gauge
  - `LinearSegment` - Define segments for multi-segment linear indicator
  - `PointerConfig` - Configuration for linear gauge pointer
  - `NeedleConfig` - Configuration for radial gauge needle
  - `ShapePointerConfig` - Configuration for radial gauge shape pointer

- Comprehensive test coverage for all new widgets
- Updated example app with new Circular and Gauge tabs
- Updated README with complete documentation

### Changed

- Updated package description to reflect new features
- Cleaned up debug logging code from progress_bar.dart and titled_progress_bar.dart
- Improved code organization with separate files for new widgets

## [2.0.0+2] - 2025-12-26

### Fixed

- Fixed all analyzer warnings and linting issues
- Added documentation comments to example app classes
- Fixed raw string usage in JSON encoding functions
- Suppressed false positive constructor ordering warnings

## [2.0.0+1] - 2025-12-26

### Fixed

- Fixed linting issues: removed unnecessary library declaration
- Fixed `prefer_const_declarations`: changed static final to static const for deprecated fields
- Fixed `omit_local_variable_types` in progress_bar.dart
- Fixed `avoid_redundant_argument_values` in multiple files
- Fixed `prefer_const_constructors` in test files
- Removed deprecated `package_api_docs` rule from analysis_options.yaml (removed in Dart 3.7.0)

### Changed

- Improved code quality by addressing all analyzer warnings and info messages
- Removed unused test function

## [2.0.0] - 2025-12-21

### Added

- **Smooth Animations** - New `animateProgress` property for animated progress transitions
- **Animation Customization** - `animationDuration` and `animationCurve` properties
- **Gradient Support** - New `progressGradient` property for beautiful gradient progress bars
- **Label Types** - `LabelType` enum with `text`, `percentage`, `stepCount`, and `custom` options
- **Label Positioning** - `LabelPosition` enum with `center`, `start`, `end`, `top`, and `bottom` options
- **Interactive Dots** - `onDotTap` callback for handling dot tap events
- **Dots Customization** - `dotsActiveShape`, `dotsShape`, and `dotsReversed` properties
- **Progress Helpers** - `progressValue`, `progressPercentage`, and `isComplete` getters
- **DotsDecorator Enhancements** - `copyWith`, equality operators, and `effectiveColor` getters
- **Comprehensive Unit Tests** - Full test coverage for all components
- **API Documentation** - Detailed dartdoc comments for all public APIs

### Changed

- **ProgressType Enum** - Replaced integer constants with proper `ProgressType` enum
- **TitledProgressBar** - Now uses const constructor with computed label size
- **Improved Null Safety** - Better assertions and null handling throughout
- **Code Quality** - Removed redundant code and improved overall structure

### Deprecated

- `LinearProgressBar.progressTypeLinear` - Use `ProgressType.linear` instead
- `LinearProgressBar.progressTypeDots` - Use `ProgressType.dots` instead

### Fixed

- Fixed DotsIndicator position assertion bug when currentStep equals maxSteps
- Fixed TitledProgressBar non-const constructor issue
- Fixed potential null safety issues in LinearProgressBar
- Fixed redundant code in typeChooser method

## [1.2.0] - 2025-04-24

### Added

- Added TitledProgressBar widget with label support

### Changed

- Updated Flutter and Dart version requirements
- Improved code structure and features

## [1.1.3] - 2024-12-24

### Fixed

- Fixed null pointer issues

### Changed

- Updated Flutter and Dart version requirements
- Improved code quality

## [1.1.2] - 2024-07-13

### Added

- Added `borderRadius` property to LinearProgressBar

### Changed

- Updated Flutter and Dart version requirements

## [1.1.1] - 2023-01-04

### Changed

- Updated Flutter and Dart version requirements

## [1.1.0] - 2021-10-25

### Added

- Added DotsIndicator progress bar type
- Added `dotsAxis` property (horizontal or vertical)
- Added `dotsActiveSize` property
- Added `dotsInactiveSize` property
- Added `dotsSpacing` property

## [1.0.0+3] - 2021-07-20

### Changed

- Updated package information

## [1.0.0+2] - 2021-07-20

### Changed

- Updated package information

## [1.0.0+1] - 2021-07-20

### Changed

- Updated package information

## [1.0.0] - 2021-07-20

### Added

- Initial release
- Linear progress bar with step-based progress
- Customizable colors and sizes
- Semantic accessibility support
