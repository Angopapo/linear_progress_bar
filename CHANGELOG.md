# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
