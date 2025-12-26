// A powerful and customizable progress indicator library for Flutter.
//
// This library provides flexible progress widgets including:
// - [LinearProgressBar] - A customizable linear or dots progress indicator
// - [TitledProgressBar] - A progress bar with built-in label support
// - [DotsIndicator] - A standalone dots/step indicator widget
// - [CircularPercentIndicator] - A circular progress indicator with percentage
// - [LinearPercentIndicator] - A linear progress indicator with percentage
// - [MultiSegmentLinearIndicator] - A multi-segment linear progress indicator
// - [GaugeIndicator] - A gauge/speedometer-style progress indicator
// - [LinearGaugeIndicator] - A comprehensive linear gauge with ruler, pointer, and ranges
// - [RadialGaugeIndicator] - A comprehensive radial gauge with needle, pointer, and ranges
// - [DotsDecorator] - Configuration class for dots appearance
// - [GaugeDecorator] - Configuration class for gauge appearance
// - [CircularDecorator] - Configuration class for circular indicator appearance
//
// Example usage:
// ```dart
// import 'package:linear_progress_bar/linear_progress_bar.dart';
//
// // Linear progress bar
// LinearProgressBar(
//   maxSteps: 10,
//   currentStep: 5,
//   progressType: ProgressType.linear,
//   progressColor: Colors.blue,
// )
//
// // Circular percent indicator
// CircularPercentIndicator(
//   percent: 0.75,
//   radius: 60,
//   lineWidth: 10,
//   progressColor: Colors.blue,
//   center: Text('75%'),
// )
//
// // Linear percent indicator
// LinearPercentIndicator(
//   percent: 0.75,
//   lineHeight: 20,
//   progressColor: Colors.blue,
//   animation: true,
// )
//
// // Linear gauge indicator
// LinearGaugeIndicator(
//   value: 0.75,
//   orientation: LinearGaugeOrientation.horizontal,
//   rulerStyle: RulerStyle.ticksWithLabels,
//   pointer: LinearGaugePointer(type: LinearPointerType.triangle),
//   valueBar: LinearValueBar(color: Colors.blue),
//   interactive: true,
// )
//
// // Radial gauge indicator
// RadialGaugeIndicator(
//   value: 0.75,
//   position: RadialGaugePosition.threeQuarter,
//   needlePointer: RadialNeedlePointer(type: NeedlePointerType.tapered),
//   valueBar: RadialValueBar(color: Colors.blue),
//   interactive: true,
// )
//
// // Gauge indicator
// GaugeIndicator(
//   value: 0.65,
//   size: 200,
//   showValue: true,
//   gaugeStyle: GaugeStyle.modern,
// )
//
// // Titled progress bar with percentage
// TitledProgressBar(
//   maxSteps: 100,
//   currentStep: 75,
//   labelType: LabelType.percentage,
// )
// ```

// Export core widgets
export 'src/progress_bar.dart';
export 'src/titled_progress_bar.dart';

// Export UI components
export 'ui/dots_indicator.dart';
export 'ui/circular_percent_indicator.dart';
export 'ui/linear_percent_indicator.dart';
export 'ui/gauge_indicator.dart';
export 'ui/linear_gauge_indicator.dart';
export 'ui/radial_gauge_indicator.dart';

// Export utilities
export 'utils/dots_decorator.dart';
export 'utils/gauge_decorator.dart';
