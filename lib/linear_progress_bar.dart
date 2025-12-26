// A powerful and customizable progress indicator library for Flutter.
//
// This library provides flexible progress widgets including:
//
// ## Progress Bars
// - [LinearProgressBar] - A customizable linear or dots progress indicator
// - [TitledProgressBar] - A progress bar with built-in label support
//
// ## Percent Indicators
// - [CircularPercentIndicator] - A circular progress indicator with percentage
// - [LinearPercentIndicator] - A linear progress indicator with percentage
// - [MultiSegmentLinearIndicator] - Multi-segment linear progress indicator
//
// ## Gauges
// - [GaugeIndicator] - A gauge/speedometer-style progress indicator
// - [LinearGauge] - A linear gauge with ruler, pointer, and ranges
// - [RadialGauge] - A radial gauge with needle and shape pointers
//
// ## Other Indicators
// - [DotsIndicator] - A standalone dots/step indicator widget
//
// ## Configuration Classes
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
//   width: 200,
//   lineHeight: 20,
//   progressColor: Colors.blue,
//   animation: true,
//   leading: Icon(Icons.download),
//   center: Text('75%'),
// )
//
// // Linear gauge with ruler and pointer
// LinearGauge(
//   value: 0.65,
//   orientation: LinearGaugeOrientation.horizontal,
//   rulerStyle: RulerStyle.graduated,
//   pointer: PointerConfig(style: PointerStyle.triangle),
//   ranges: [
//     LinearGaugeRange(start: 0.0, end: 0.3, color: Colors.green),
//     LinearGaugeRange(start: 0.3, end: 0.7, color: Colors.yellow),
//     LinearGaugeRange(start: 0.7, end: 1.0, color: Colors.red),
//   ],
//   animation: true,
//   interactive: true,
// )
//
// // Radial gauge with needle
// RadialGauge(
//   value: 0.75,
//   size: 250,
//   needle: NeedleConfig(style: NeedleStyle.tapered),
//   shapePointer: ShapePointerConfig(style: ShapePointerStyle.triangle),
//   ranges: [
//     RadialGaugeRange(start: 0.0, end: 0.3, color: Colors.green),
//     RadialGaugeRange(start: 0.3, end: 0.7, color: Colors.yellow),
//     RadialGaugeRange(start: 0.7, end: 1.0, color: Colors.red),
//   ],
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
export 'ui/linear_gauge.dart';
export 'ui/radial_gauge.dart';

// Export utilities
export 'utils/dots_decorator.dart';
export 'utils/gauge_decorator.dart';
