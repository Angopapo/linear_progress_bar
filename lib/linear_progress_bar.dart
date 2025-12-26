// A powerful and customizable progress indicator library for Flutter.
//
// This library provides flexible progress widgets including:
//
// ## Progress Bars
// - [LinearProgressBar] - A customizable linear or dots progress indicator
// - [TitledProgressBar] - A progress bar with built-in label support
// - [DotsIndicator] - A standalone dots/step indicator widget
//
// ## Percent Indicators
// - [CircularPercentIndicator] - A circular progress indicator with percentage
// - [LinearPercentIndicator] - A linear progress indicator with percentage
// - [MultiLinearPercentIndicator] - Multiple segments in a linear indicator
// - [StackedLinearPercentIndicator] - Stacked/layered linear indicator
//
// ## Gauges
// - [GaugeIndicator] - A gauge/speedometer-style progress indicator
// - [LinearGauge] - A linear gauge with ruler, pointer, and value bar
// - [RadialGauge] - A radial gauge with needle and shape pointers
//
// ## Decorators & Configuration
// - [DotsDecorator] - Configuration class for dots appearance
// - [GaugeDecorator] - Configuration class for gauge appearance
// - [CircularDecorator] - Configuration class for circular indicator appearance
// - [LinearGaugeDecorator] - Configuration class for linear gauge appearance
// - [RadialGaugeDecorator] - Configuration class for radial gauge appearance
// - [PercentIndicatorDecorator] - Configuration class for percent indicators
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
// // Linear percent indicator with child
// LinearPercentIndicator(
//   percent: 0.65,
//   lineHeight: 20,
//   progressColor: Colors.green,
//   animation: true,
//   leading: Icon(Icons.download),
//   trailing: Text('65%'),
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
// // Linear gauge with pointer
// LinearGauge(
//   value: 0.7,
//   orientation: LinearGaugeOrientation.horizontal,
//   showValueBar: true,
//   pointerConfig: PointerConfig(type: PointerType.triangle),
//   animation: true,
// )
//
// // Radial gauge with needle
// RadialGauge(
//   value: 0.65,
//   position: RadialGaugePosition.threeQuarters,
//   needleConfig: NeedleConfig(type: NeedleType.tapered),
//   showValue: true,
//   animation: true,
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

// Export utilities and decorators
export 'utils/dots_decorator.dart';
export 'utils/gauge_decorator.dart';
export 'utils/linear_gauge_decorator.dart';
export 'utils/radial_gauge_decorator.dart';
export 'utils/percent_indicator_decorator.dart';
