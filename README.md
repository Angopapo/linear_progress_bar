# Linear Progress Bar

[![pub package](https://img.shields.io/pub/v/linear_progress_bar.svg)](https://pub.dev/packages/linear_progress_bar)
[![CodeFactor](https://www.codefactor.io/repository/github/angopapo/linear_progress_bar/badge)](https://www.codefactor.io/repository/github/angopapo/linear_progress_bar)

A powerful and customizable progress indicator library for Flutter. Supports linear progress bars, circular percent indicators, gauges, dots indicators, titled progress bars, gradient colors, and smooth animations.

<p align="center">
<img src="https://i.ibb.co/8gZpqgf/image1.png" alt="Linear Progress Bar" width="230px" hspace="30"/>
<img src="https://i.ibb.co/nB5YV7X/Simulator-Screen-Shot-i-Phone-12-Pro-Max-2021-07-20-at-02-23-50.png" alt="Dots Progress" width="230px"/>
<img src="https://i.ibb.co/qmMYX49/Simulator-Screen-Shot-i-Phone-13-Pro-2021-10-25-at-20-30-45.png" alt="Titled Progress" width="230px"/>
</p>

## Features

- ✅ **Linear Progress Bar** - Traditional horizontal progress indicator
- ✅ **Circular Percent Indicator** - Beautiful circular progress with percentage display
- ✅ **Gauge Indicator** - Modern speedometer-style gauge with needle and ranges
- ✅ **Dots Progress Indicator** - Step-based dots indicator
- ✅ **Titled Progress Bar** - Progress bar with customizable labels
- ✅ **Gradient Support** - Apply beautiful gradients to all progress indicators
- ✅ **Smooth Animations** - Animated progress transitions with customizable curves
- ✅ **Multiple Label Types** - Text, percentage, step count, or custom widgets
- ✅ **Flexible Label Positioning** - Center, start, end, top, or bottom
- ✅ **Interactive Components** - Tap handlers for dots indicator
- ✅ **Customizable Appearance** - Colors, sizes, shapes, borders, and more
- ✅ **Accessibility Support** - Semantic labels and values

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  linear_progress_bar: ^3.0.0
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

### Circular Percent Indicator

```dart
CircularPercentIndicator(
  percent: 0.75,
  radius: 60,
  lineWidth: 10,
  progressColor: Colors.blue,
  backgroundColor: Colors.grey.shade300,
  circularStrokeCap: CircularStrokeCap.round,
  center: Text(
    '75%',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
)
```

### Gauge Indicator

```dart
GaugeIndicator(
  value: 0.65,
  size: 200,
  strokeWidth: 20,
  valueColor: Colors.blue,
  backgroundColor: Colors.grey.shade300,
  showValue: true,
  gaugeStyle: GaugeStyle.modern,
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

### Circular Percent Indicator

#### Basic Circle with Percentage

```dart
CircularPercentIndicator(
  percent: 0.75,
  radius: 60,
  lineWidth: 10,
  progressColor: Colors.blue,
  backgroundColor: Colors.grey.shade300,
  circularStrokeCap: CircularStrokeCap.round,
  center: Text('75%'),
)
```

#### With Gradient Colors

```dart
CircularPercentIndicator(
  percent: 0.75,
  radius: 70,
  lineWidth: 12,
  backgroundColor: Colors.grey.shade200,
  linearGradient: LinearGradient(
    colors: [Colors.purple, Colors.pink, Colors.orange],
  ),
  circularStrokeCap: CircularStrokeCap.round,
  center: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('75%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      Text('Complete', style: TextStyle(fontSize: 12, color: Colors.grey)),
    ],
  ),
)
```

#### With Header and Footer

```dart
CircularPercentIndicator(
  percent: 0.75,
  radius: 60,
  lineWidth: 8,
  progressColor: Colors.green,
  backgroundColor: Colors.grey.shade300,
  header: Text('Downloading...', style: TextStyle(fontWeight: FontWeight.bold)),
  center: Icon(Icons.download, size: 32, color: Colors.green),
  footer: Text('75%', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
)
```

#### Animated Circular Progress

```dart
CircularPercentIndicator(
  percent: 0.75,
  radius: 60,
  lineWidth: 10,
  progressColor: Colors.purple,
  backgroundColor: Colors.grey.shade300,
  animation: true,
  animationDuration: Duration(milliseconds: 800),
  animationCurve: Curves.easeInOut,
)
```

### Gauge Indicator

#### Simple Gauge

```dart
GaugeIndicator(
  value: 0.65,
  size: 200,
  strokeWidth: 15,
  valueColor: Colors.blue,
  backgroundColor: Colors.grey.shade300,
  showValue: true,
)
```

#### Speedometer Style with Needle

```dart
GaugeIndicator(
  value: 0.65,
  size: 200,
  strokeWidth: 20,
  valueColor: Colors.green,
  backgroundColor: Colors.grey.shade200,
  showNeedle: true,
  needleColor: Colors.red,
  gaugeStyle: GaugeStyle.ticked,
  tickCount: 10,
  showMinMax: true,
  minLabel: '0',
  maxLabel: '100',
)
```

#### Half Gauge (180°)

```dart
GaugeIndicator(
  value: 0.65,
  size: 200,
  strokeWidth: 20,
  valueColor: Colors.teal,
  backgroundColor: Colors.grey.shade300,
  startAngle: 180,
  sweepAngle: 180,
  showValue: true,
)
```

#### Gradient Gauge

```dart
GaugeIndicator(
  value: 0.65,
  size: 200,
  strokeWidth: 18,
  backgroundColor: Colors.grey.shade200,
  gradient: SweepGradient(
    startAngle: 2.35,
    endAngle: 7.07,
    colors: [Colors.green, Colors.yellow, Colors.orange, Colors.red],
  ),
  gaugeStyle: GaugeStyle.modern,
  tickCount: 8,
  showValue: true,
)
```

#### Range Colors Gauge

```dart
GaugeIndicator(
  value: 0.65,
  size: 200,
  strokeWidth: 20,
  backgroundColor: Colors.grey.shade200,
  ranges: [
    GaugeRange(start: 0.0, end: 0.33, color: Colors.green),
    GaugeRange(start: 0.33, end: 0.66, color: Colors.orange),
    GaugeRange(start: 0.66, end: 1.0, color: Colors.red),
  ],
  showNeedle: true,
  needleColor: Colors.black87,
  showMinMax: true,
  minLabel: 'Low',
  maxLabel: 'High',
  showValue: true,
  valueFormatter: (v) {
    if (v < 0.33) return 'Good';
    if (v < 0.66) return 'Normal';
    return 'Alert';
  },
)
```

#### With Title and Subtitle

```dart
GaugeIndicator(
  value: 0.65,
  size: 180,
  strokeWidth: 15,
  valueColor: Colors.deepPurple,
  backgroundColor: Colors.grey.shade300,
  showValue: true,
  valueFormatter: (v) => '${(v * 100).toInt()}°C',
  title: Text('Temperature', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  subtitle: Text('Current reading', style: TextStyle(fontSize: 12, color: Colors.grey)),
)
```

### Linear Progress Bar

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

## API Reference

### CircularPercentIndicator

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `percent` | `double` | `0.0` | Progress value (0.0 to 1.0) |
| `radius` | `double` | `50.0` | Radius of the circle |
| `lineWidth` | `double` | `5.0` | Width of the progress line |
| `backgroundWidth` | `double?` | `lineWidth` | Width of background circle |
| `progressColor` | `Color` | `Colors.blue` | Progress indicator color |
| `backgroundColor` | `Color` | `grey` | Background color |
| `linearGradient` | `Gradient?` | `null` | Gradient for progress |
| `circularStrokeCap` | `CircularStrokeCap` | `round` | Line cap style |
| `startAngle` | `CircularStartAngle` | `top` | Starting position |
| `reverse` | `bool` | `false` | Reverse direction |
| `animation` | `bool` | `false` | Enable animation |
| `animationDuration` | `Duration` | `500ms` | Animation duration |
| `animationCurve` | `Curve` | `easeInOut` | Animation curve |
| `center` | `Widget?` | `null` | Widget in the center |
| `header` | `Widget?` | `null` | Widget above circle |
| `footer` | `Widget?` | `null` | Widget below circle |
| `fillColor` | `bool` | `false` | Fill background |
| `circleColor` | `Color?` | `null` | Fill color |

### GaugeIndicator

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `double` | `0.0` | Current value (0.0 to 1.0) |
| `size` | `double` | `200.0` | Size of the gauge |
| `strokeWidth` | `double` | `15.0` | Width of the arc |
| `valueColor` | `Color` | `Colors.blue` | Value indicator color |
| `backgroundColor` | `Color` | `grey` | Background color |
| `gradient` | `Gradient?` | `null` | Gradient for value arc |
| `startAngle` | `double` | `135.0` | Start angle in degrees |
| `sweepAngle` | `double` | `270.0` | Sweep angle in degrees |
| `showValue` | `bool` | `true` | Show value label |
| `labelPosition` | `GaugeLabelPosition` | `center` | Label position |
| `valueFormatter` | `Function?` | `null` | Custom value formatter |
| `valueTextStyle` | `TextStyle?` | `null` | Value text style |
| `center` | `Widget?` | `null` | Custom center widget |
| `animation` | `bool` | `false` | Enable animation |
| `animationDuration` | `Duration` | `500ms` | Animation duration |
| `gaugeStyle` | `GaugeStyle` | `simple` | Gauge style |
| `tickCount` | `int` | `10` | Number of tick marks |
| `tickLength` | `double` | `8.0` | Length of tick marks |
| `ranges` | `List<GaugeRange>?` | `null` | Color ranges |
| `showNeedle` | `bool` | `false` | Show needle pointer |
| `needleColor` | `Color` | `Colors.red` | Needle color |
| `showMinMax` | `bool` | `false` | Show min/max labels |
| `title` | `Widget?` | `null` | Title widget |
| `subtitle` | `Widget?` | `null` | Subtitle widget |

### LinearProgressBar

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `maxSteps` | `int` | `1` | Maximum number of steps |
| `currentStep` | `int` | `0` | Current step (0 to maxSteps) |
| `progressType` | `ProgressType` | `linear` | Type of progress bar |
| `progressColor` | `Color` | `Colors.red` | Progress indicator color |
| `backgroundColor` | `Color` | `Colors.white` | Background color |
| `minHeight` | `double` | `10` | Minimum height of the bar |
| `borderRadius` | `BorderRadiusGeometry` | `zero` | Border radius |
| `progressGradient` | `Gradient?` | `null` | Gradient for progress |
| `animateProgress` | `bool` | `false` | Enable animations |
| `animationDuration` | `Duration` | `300ms` | Animation duration |
| `animationCurve` | `Curve` | `easeInOut` | Animation curve |
| `dotsAxis` | `Axis` | `horizontal` | Dots orientation |
| `dotsActiveSize` | `double` | `8` | Active dot size |
| `dotsInactiveSize` | `double` | `8` | Inactive dot size |
| `dotsSpacing` | `EdgeInsets` | `zero` | Spacing around dots |
| `onDotTap` | `OnTap?` | `null` | Dot tap callback |

### Enums

#### GaugeStyle

- `GaugeStyle.simple` - Simple arc gauge
- `GaugeStyle.ticked` - Gauge with tick marks
- `GaugeStyle.segmented` - Gauge with segments
- `GaugeStyle.modern` - Modern gradient gauge

#### GaugeLabelPosition

- `GaugeLabelPosition.center` - Label at center
- `GaugeLabelPosition.bottom` - Label below gauge
- `GaugeLabelPosition.none` - No label

#### CircularStrokeCap

- `CircularStrokeCap.round` - Rounded cap
- `CircularStrokeCap.square` - Square cap
- `CircularStrokeCap.butt` - No cap

#### CircularStartAngle

- `CircularStartAngle.top` - Start from top (12 o'clock)
- `CircularStartAngle.right` - Start from right (3 o'clock)
- `CircularStartAngle.bottom` - Start from bottom (6 o'clock)
- `CircularStartAngle.left` - Start from left (9 o'clock)

### Helper Classes

#### GaugeRange

```dart
GaugeRange(
  start: 0.0,
  end: 0.33,
  color: Colors.green,
  label: 'Low',
)
```

#### GaugeSegment

```dart
GaugeSegment(
  start: 0.0,
  end: 0.33,
  color: Colors.red,
)
```

#### GaugeDecorator

Preset configurations for gauge styles:

```dart
// Speedometer style
final decorator = GaugeDecorator.speedometer();

// Minimal flat style
final decorator = GaugeDecorator.minimal();

// Gradient style
final decorator = GaugeDecorator.gradient();

// Health/fitness style
final decorator = GaugeDecorator.health();

// Temperature style
final decorator = GaugeDecorator.temperature();
```

#### CircularDecorator

Preset configurations for circular indicators:

```dart
// Gradient style
final decorator = CircularDecorator.gradient();

// Minimal style
final decorator = CircularDecorator.minimal();

// Thick line style
final decorator = CircularDecorator.thick();

// Thin line style
final decorator = CircularDecorator.thin();
```

## Migration from v2.x

If you're upgrading from version 2.x:

### New Features in v3.0

- **CircularPercentIndicator** - Beautiful circular progress indicators
- **GaugeIndicator** - Modern speedometer-style gauges with:
  - Multiple styles (simple, ticked, segmented, modern)
  - Needle pointer support
  - Range colors
  - Custom value formatting
- **GaugeDecorator** - Preset gauge configurations
- **CircularDecorator** - Preset circular indicator configurations
- Improved animations and customization options

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
