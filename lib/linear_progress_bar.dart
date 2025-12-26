// A powerful and customizable linear progress bar library for Flutter.
//
// This library provides flexible progress bar widgets including:
// - [LinearProgressBar] - A customizable linear or dots progress indicator
// - [TitledProgressBar] - A progress bar with built-in label support
// - [DotsIndicator] - A standalone dots/step indicator widget
// - [DotsDecorator] - Configuration class for dots appearance
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
// // Dots indicator
// LinearProgressBar(
//   maxSteps: 5,
//   currentStep: 2,
//   progressType: ProgressType.dots,
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

// Export utilities
export 'utils/dots_decorator.dart';
