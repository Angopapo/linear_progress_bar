// A powerful and customizable progress indicator library for Flutter.
//
// This library provides flexible progress widgets including:
// - [LinearProgressBar] - A customizable linear or dots progress indicator
// - [TitledProgressBar] - A progress bar with built-in label support
// - [DotsIndicator] - A standalone dots/step indicator widget
// - [CircularPercentIndicator] - A circular progress indicator with percentage
// - [GaugeIndicator] - A gauge/speedometer-style progress indicator
// - [LinearGauge] - A customizable linear gauge with rulers and pointers
// - [RadialGauge] - A customizable radial gauge with needles and shape pointers
// - [LinearPercentIndicator] - A linear percent indicator with gradients
// - [DotsDecorator] - Configuration class for dots appearance
// - [GaugeDecorator] - Configuration class for gauge appearance
// - [CircularDecorator] - Configuration class for circular indicator appearance
// - [LinearGaugeDecorator] - Configuration class for linear gauge appearance
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
// // Gauge indicator
// GaugeIndicator(
//   value: 0.65,
//   size: 200,
//   showValue: true,
//   gaugeStyle: GaugeStyle.modern,
// )
//
// // Linear Gauge with ruler and pointer
// LinearGauge(
//   value: 0.65,
//   orientation: LinearGaugeOrientation.horizontal,
//   rulerStyle: RulerStyle.ticksWithLabels,
//   pointer: LinearGaugePointer(type: LinearPointerType.triangle),
//   showValueBar: true,
// )
//
// // Radial Gauge with needle
// RadialGauge(
//   value: 0.75,
//   size: 200,
//   needlePointer: NeedlePointer(type: NeedlePointerType.triangle),
//   valueBar: RadialValueBar(color: Colors.blue),
// )
//
// // Linear Percent Indicator with gradient
// LinearPercentIndicator(
//   percent: 0.65,
//   lineHeight: 14,
//   linearGradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
//   barRadius: Radius.circular(7),
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
export 'ui/gauge_indicator.dart';
export 'ui/linear_gauge.dart';
export 'ui/radial_gauge.dart';
export 'ui/linear_percent_indicator.dart';

// Export utilities
export 'utils/dots_decorator.dart';
export 'utils/gauge_decorator.dart';
export 'utils/linear_gauge_decorator.dart';
