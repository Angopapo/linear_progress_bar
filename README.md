# Linear Progress Bar

[![pub package](https://img.shields.io/pub/v/linear_progress_bar.svg)](https://pub.dev/packages/linear_progress_bar)
[![CodeFactor](https://www.codefactor.io/repository/github/angopapo/linear_progress_bar/badge)](https://www.codefactor.io/repository/github/angopapo/linear_progress_bar)

A powerful and customizable linear progress bar widget for Flutter. Supports linear progress bars, dots indicators, titled progress bars with labels, gradient colors, and smooth animations.

<p align="center">
<img src="https://i.ibb.co/8gZpqgf/image1.png" alt="Linear Progress Bar" width="230px" hspace="30"/>
<img src="https://i.ibb.co/nB5YV7X/Simulator-Screen-Shot-i-Phone-12-Pro-Max-2021-07-20-at-02-23-50.png" alt="Dots Progress" width="230px"/>
<img src="https://i.ibb.co/qmMYX49/Simulator-Screen-Shot-i-Phone-13-Pro-2021-10-25-at-20-30-45.png" alt="Titled Progress" width="230px"/>
</p>

## Features

- ✅ **Linear Progress Bar** - Traditional horizontal progress indicator
- ✅ **Dots Progress Indicator** - Step-based dots indicator
- ✅ **Titled Progress Bar** - Progress bar with customizable labels
- ✅ **Gradient Support** - Apply beautiful gradients to progress bars
- ✅ **Smooth Animations** - Animated progress transitions with customizable curves
- ✅ **Multiple Label Types** - Text, percentage, step count, or custom widgets
- ✅ **Flexible Label Positioning** - Center, start, end, top, or bottom
- ✅ **Interactive Dots** - Tap handlers for dots indicator
- ✅ **Customizable Appearance** - Colors, sizes, shapes, borders, and more
- ✅ **Horizontal/Vertical Dots** - Choose dots orientation
- ✅ **Accessibility Support** - Semantic labels and values

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  linear_progress_bar: ^2.0.0+1
```

Then run:

```bash
flutter pub get
```

## Quick Start

Import the package:

```dart
import 'package:linear_progress_bar/linear_progress_bar.dart';
```

### Basic Linear Progress Bar

```dart
LinearProgressBar(
  maxSteps: 6,
  progressType: ProgressType.linear,
  currentStep: 3,
  progressColor: Colors.blue,
  backgroundColor: Colors.grey,
  borderRadius: BorderRadius.circular(10),
  minHeight: 12,
)
```

### Dots Progress Indicator

```dart
LinearProgressBar(
  maxSteps: 5,
  progressType: ProgressType.dots,
  currentStep: 2,
  progressColor: Colors.blue,
  backgroundColor: Colors.grey,
  dotsActiveSize: 12,
  dotsInactiveSize: 8,
)
```

### Titled Progress Bar with Percentage

```dart
TitledProgressBar(
  maxSteps: 100,
  currentStep: 75,
  progressColor: Colors.green,
  backgroundColor: Colors.grey.shade300,
  labelType: LabelType.percentage,
  labelColor: Colors.white,
  labelFontWeight: FontWeight.bold,
  minHeight: 24,
  borderRadius: BorderRadius.circular(12),
)
```

## Usage Examples

### Linear Progress Bar

#### Basic Usage

```dart
LinearProgressBar(
  maxSteps: 10,
  progressType: ProgressType.linear,
  currentStep: 5,
  progressColor: Colors.blue,
  backgroundColor: Colors.grey.shade300,
)
```

#### With Border Radius

```dart
LinearProgressBar(
  maxSteps: 10,
  progressType: ProgressType.linear,
  currentStep: 5,
  progressColor: Colors.blue,
  backgroundColor: Colors.grey.shade300,
  borderRadius: BorderRadius.circular(8),
  minHeight: 16,
)
```

#### With Gradient

```dart
LinearProgressBar(
  maxSteps: 100,
  progressType: ProgressType.linear,
  currentStep: 65,
  progressGradient: LinearGradient(
    colors: [Colors.blue, Colors.purple, Colors.pink],
  ),
  backgroundColor: Colors.grey.shade300,
  borderRadius: BorderRadius.circular(10),
  minHeight: 16,
)
```

#### With Animation

```dart
LinearProgressBar(
  maxSteps: 100,
  progressType: ProgressType.linear,
  currentStep: currentStep,
  progressColor: Colors.blue,
  backgroundColor: Colors.grey.shade300,
  animateProgress: true,
  animationDuration: Duration(milliseconds: 500),
  animationCurve: Curves.easeInOut,
)
```

### Dots Progress Indicator

#### Horizontal Dots

```dart
LinearProgressBar(
  maxSteps: 5,
  progressType: ProgressType.dots,
  currentStep: 2,
  progressColor: Colors.blue,
  backgroundColor: Colors.grey,
  dotsActiveSize: 12,
  dotsInactiveSize: 8,
  dotsSpacing: EdgeInsets.symmetric(horizontal: 8),
)
```

#### Vertical Dots

```dart
LinearProgressBar(
  maxSteps: 5,
  progressType: ProgressType.dots,
  currentStep: 2,
  progressColor: Colors.purple,
  backgroundColor: Colors.grey,
  dotsAxis: Axis.vertical,
  dotsActiveSize: 12,
  dotsInactiveSize: 8,
)
```

#### Interactive Dots

```dart
LinearProgressBar(
  maxSteps: 5,
  progressType: ProgressType.dots,
  currentStep: currentStep,
  progressColor: Colors.teal,
  backgroundColor: Colors.grey,
  onDotTap: (position) {
    setState(() {
      currentStep = position.toInt();
    });
  },
)
```

### Titled Progress Bar

#### Text Label

```dart
TitledProgressBar(
  maxSteps: 100,
  currentStep: 50,
  progressColor: Colors.blue,
  backgroundColor: Colors.grey.shade300,
  label: "Loading...",
  labelColor: Colors.white,
  minHeight: 24,
  borderRadius: BorderRadius.circular(12),
)
```

#### Percentage Label

```dart
TitledProgressBar(
  maxSteps: 100,
  currentStep: 75,
  progressColor: Colors.green,
  backgroundColor: Colors.grey.shade300,
  labelType: LabelType.percentage,
  labelColor: Colors.white,
  labelFontWeight: FontWeight.bold,
  minHeight: 28,
  borderRadius: BorderRadius.circular(14),
)
```

#### Step Count Label

```dart
TitledProgressBar(
  maxSteps: 10,
  currentStep: 7,
  progressColor: Colors.purple,
  backgroundColor: Colors.grey.shade300,
  labelType: LabelType.stepCount,
  labelColor: Colors.white,
  minHeight: 24,
  borderRadius: BorderRadius.circular(12),
)
```

#### Label at Top

```dart
TitledProgressBar(
  maxSteps: 100,
  currentStep: 65,
  progressColor: Colors.orange,
  backgroundColor: Colors.grey.shade300,
  labelType: LabelType.percentage,
  labelPosition: LabelPosition.top,
  labelColor: Colors.black87,
  minHeight: 12,
  borderRadius: BorderRadius.circular(6),
)
```

#### With Gradient and Animation

```dart
TitledProgressBar(
  maxSteps: 100,
  currentStep: currentStep,
  progressGradient: LinearGradient(
    colors: [Colors.pink, Colors.purple, Colors.blue],
  ),
  backgroundColor: Colors.grey.shade300,
  labelType: LabelType.percentage,
  labelColor: Colors.white,
  labelFontWeight: FontWeight.bold,
  minHeight: 28,
  borderRadius: BorderRadius.circular(14),
  animateProgress: true,
  animationDuration: Duration(milliseconds: 400),
)
```

## API Reference

### LinearProgressBar

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `maxSteps` | `int` | `1` | Maximum number of steps |
| `currentStep` | `int` | `0` | Current step (0 to maxSteps) |
| `progressType` | `ProgressType` | `ProgressType.linear` | Type of progress bar |
| `progressColor` | `Color` | `Colors.red` | Progress indicator color |
| `backgroundColor` | `Color` | `Colors.white` | Background color |
| `minHeight` | `double` | `10` | Minimum height of the bar |
| `borderRadius` | `BorderRadiusGeometry` | `BorderRadius.zero` | Border radius for linear type |
| `progressGradient` | `Gradient?` | `null` | Gradient for progress (overrides progressColor) |
| `animateProgress` | `bool` | `false` | Enable smooth animations |
| `animationDuration` | `Duration` | `300ms` | Animation duration |
| `animationCurve` | `Curve` | `Curves.easeInOut` | Animation curve |
| `dotsAxis` | `Axis` | `Axis.horizontal` | Dots orientation |
| `dotsActiveSize` | `double` | `8` | Active dot size |
| `dotsInactiveSize` | `double` | `8` | Inactive dot size |
| `dotsSpacing` | `EdgeInsets` | `EdgeInsets.zero` | Spacing around dots |
| `dotsReversed` | `bool` | `false` | Reverse dots order |
| `onDotTap` | `OnTap?` | `null` | Callback when dot is tapped |
| `valueColor` | `Animation<Color?>?` | `null` | Animated color |
| `semanticsLabel` | `String?` | `null` | Accessibility label |
| `semanticsValue` | `String?` | `null` | Accessibility value |

### TitledProgressBar

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `maxSteps` | `int` | `100` | Maximum number of steps |
| `currentStep` | `int` | `0` | Current step (0 to maxSteps) |
| `progressColor` | `Color` | `Colors.red` | Progress indicator color |
| `backgroundColor` | `Color` | `Colors.white` | Background color |
| `minHeight` | `double` | `10` | Minimum height of the bar |
| `borderRadius` | `BorderRadiusGeometry?` | `null` | Border radius |
| `label` | `String?` | `null` | Text label (for LabelType.text) |
| `labelSize` | `double?` | `minHeight * 0.7` | Label font size |
| `labelColor` | `Color` | `Colors.black` | Label color |
| `labelFontWeight` | `FontWeight` | `FontWeight.normal` | Label font weight |
| `labelType` | `LabelType` | `LabelType.text` | Type of label to display |
| `labelPosition` | `LabelPosition` | `LabelPosition.center` | Position of the label |
| `customLabel` | `Widget?` | `null` | Custom widget label |
| `progressGradient` | `Gradient?` | `null` | Gradient for progress |
| `animateProgress` | `bool` | `false` | Enable smooth animations |
| `animationDuration` | `Duration` | `300ms` | Animation duration |
| `animationCurve` | `Curve` | `Curves.easeInOut` | Animation curve |
| `percentageDecimals` | `int` | `0` | Decimal places for percentage |

### Enums

#### ProgressType

- `ProgressType.linear` - Traditional linear progress bar
- `ProgressType.dots` - Dots/step indicator

#### LabelType

- `LabelType.text` - Custom text label
- `LabelType.percentage` - Shows percentage (e.g., "75%")
- `LabelType.stepCount` - Shows step count (e.g., "7/10")
- `LabelType.custom` - Use customLabel widget

#### LabelPosition

- `LabelPosition.center` - Label centered in progress bar
- `LabelPosition.start` - Label at the start (left for LTR)
- `LabelPosition.end` - Label at the end (right for LTR)
- `LabelPosition.top` - Label above the progress bar
- `LabelPosition.bottom` - Label below the progress bar

### DotsDecorator

For advanced dots customization:

```dart
DotsDecorator(
  color: Colors.grey,
  activeColor: Colors.blue,
  size: Size.square(10),
  activeSize: Size.square(15),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  spacing: EdgeInsets.all(4),
)
```

## Migration from v1.x

If you're upgrading from version 1.x:

### Breaking Changes

1. **ProgressType Enum**: Replace integer constants with enum values:

```dart
// Old (deprecated)
progressType: LinearProgressBar.progressTypeLinear

// New
progressType: ProgressType.linear
```

2. **TitledProgressBar**: Now uses `const` constructor and has additional features.

### New Features in v2.0

- `animateProgress` - Enable smooth progress animations
- `progressGradient` - Apply gradients to progress bars
- `LabelType.percentage` and `LabelType.stepCount` for TitledProgressBar
- `LabelPosition` for flexible label placement
- `onDotTap` callback for interactive dots
- Improved null safety and assertions

## Example Project

Check out the `example` folder for a complete demo app showcasing all features.

```bash
cd example
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by [@maravilhosinga](https://www.twitter.com/maravilhosinga)

- Twitter: [@maravilhosinga](https://www.twitter.com/maravilhosinga)
- Facebook: [fb.com/maravilhosinga](https://www.fb.com/maravilhosinga)
- Website: [angopapo.com](https://www.angopapo.com)
