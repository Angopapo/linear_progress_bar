import 'dart:io';
import 'package:flutter/material.dart';
import 'progress_bar.dart';

// #region agent log
void _logTitled(String location, String message, Map<String, dynamic> data, String hypothesisId) {
  try {
    final logFile = File('/Users/maravilhosinga/Projetos/Trabalhos/Interno/FlutterPackages/linear_progress_bar/.cursor/debug.log');
    final entry = '{"sessionId":"debug-session","runId":"run1","hypothesisId":"$hypothesisId","location":"$location","message":"$message","data":${_jsonEncodeTitled(data)},"timestamp":${DateTime.now().millisecondsSinceEpoch}}\n';
    logFile.writeAsStringSync('${logFile.existsSync() ? logFile.readAsStringSync() : ""}$entry', mode: FileMode.append);
  } catch (_) {}
}
String _jsonEncodeTitled(dynamic value) {
  if (value is Map) {
    final entries = value.entries.map((e) => '"${e.key}":${_jsonEncodeTitled(e.value)}').join(',');
    return '{$entries}';
  } else if (value is String) {
    return '"${value.replaceAll('"', '\\"')}"';
  } else {
    return value.toString();
  }
}
// #endregion

/// The position of the label within the progress bar.
enum LabelPosition {
  /// Label is centered in the progress bar.
  center,

  /// Label is at the start (left for LTR).
  start,

  /// Label is at the end (right for LTR).
  end,

  /// Label is above the progress bar.
  top,

  /// Label is below the progress bar.
  bottom,
}

/// The type of label to display.
enum LabelType {
  /// Shows a custom text label.
  text,

  /// Shows the current progress percentage.
  percentage,

  /// Shows the step count (e.g., "3/10").
  stepCount,

  /// Shows a custom widget.
  custom,
}

/// A progress bar with a customizable label overlay.
///
/// This widget combines a [LinearProgressBar] with a text label that can
/// display progress information, percentage, or custom text.
///
/// Example usage:
/// ```dart
/// TitledProgressBar(
///   maxSteps: 100,
///   currentStep: 65,
///   progressColor: Colors.blue,
///   label: "Loading...",
///   labelPosition: LabelPosition.center,
/// )
/// ```
class TitledProgressBar extends StatelessWidget {
  /// The maximum number of steps in the progress bar.
  ///
  /// Must be greater than 0. Defaults to 100.
  final int maxSteps;

  /// The current step value.
  ///
  /// Must be between 0 and [maxSteps]. Defaults to 0.
  final int currentStep;

  /// The color of the progress indicator.
  ///
  /// Defaults to [Colors.red].
  final Color progressColor;

  /// The background color of the progress bar.
  ///
  /// Defaults to [Colors.white].
  final Color backgroundColor;

  /// The text label to display.
  ///
  /// Used when [labelType] is [LabelType.text].
  final String? label;

  /// The font size of the label.
  ///
  /// If not specified, defaults to 70% of [minHeight].
  final double? labelSize;

  /// The color of the label text.
  ///
  /// Defaults to [Colors.black].
  final Color labelColor;

  /// The font weight of the label text.
  ///
  /// Defaults to [FontWeight.normal].
  final FontWeight labelFontWeight;

  /// The position of the label.
  ///
  /// Defaults to [LabelPosition.center].
  final LabelPosition labelPosition;

  /// The type of label to display.
  ///
  /// Defaults to [LabelType.text].
  final LabelType labelType;

  /// The minimum height of the progress bar.
  ///
  /// Defaults to 10.0.
  final double minHeight;

  /// The border radius of the progress bar.
  final BorderRadiusGeometry? borderRadius;

  /// Custom widget to use as label when [labelType] is [LabelType.custom].
  final Widget? customLabel;

  /// The gradient for the progress bar.
  ///
  /// If provided, this will be used instead of [progressColor].
  final Gradient? progressGradient;

  /// Whether to animate the progress changes.
  ///
  /// Defaults to false.
  final bool animateProgress;

  /// The duration of the progress animation.
  ///
  /// Defaults to 300 milliseconds.
  final Duration animationDuration;

  /// The curve for the progress animation.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve animationCurve;

  /// Padding around the label.
  ///
  /// Defaults to [EdgeInsets.symmetric(horizontal: 8)].
  final EdgeInsets labelPadding;

  /// Number of decimal places for percentage display.
  ///
  /// Only used when [labelType] is [LabelType.percentage].
  /// Defaults to 0.
  final int percentageDecimals;

  /// Creates a titled progress bar widget.
  const TitledProgressBar({
    super.key,
    this.progressColor = Colors.red,
    this.backgroundColor = Colors.white,
    this.maxSteps = 100,
    this.currentStep = 0,
    this.minHeight = 10,
    this.label,
    this.labelSize,
    this.labelColor = Colors.black,
    this.labelFontWeight = FontWeight.normal,
    this.labelPosition = LabelPosition.center,
    this.labelType = LabelType.text,
    this.borderRadius,
    this.customLabel,
    this.progressGradient,
    this.animateProgress = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.percentageDecimals = 0,
  })  : assert(maxSteps > 0, 'maxSteps must be greater than 0'),
        assert(currentStep >= 0, 'currentStep must be non-negative'),
        assert(currentStep <= maxSteps, 'currentStep must not exceed maxSteps');

  /// Calculates the progress value as a fraction between 0.0 and 1.0.
  double get progressValue {
    if (maxSteps <= 0) return 0.0;
    return (currentStep / maxSteps).clamp(0.0, 1.0);
  }

  /// Returns the progress as a percentage (0-100).
  double get progressPercentage => progressValue * 100;

  /// Returns true if the progress is complete.
  bool get isComplete => currentStep >= maxSteps;

  /// Computes the effective label size based on minHeight.
  double get _effectiveLabelSize => labelSize ?? minHeight * 0.7;

  /// Generates the label text based on labelType.
  String get _labelText {
    switch (labelType) {
      case LabelType.percentage:
        return '${progressPercentage.toStringAsFixed(percentageDecimals)}%';
      case LabelType.stepCount:
        return '$currentStep/$maxSteps';
      case LabelType.text:
      case LabelType.custom:
        return label ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // #region agent log
    _logTitled('titled_progress_bar.dart:200', 'TitledProgressBar build entry', {'maxSteps': maxSteps, 'currentStep': currentStep, 'labelType': labelType.toString(), 'labelPosition': labelPosition.toString()}, 'B');
    // #endregion
    final progressBar = LinearProgressBar(
      maxSteps: maxSteps,
      currentStep: currentStep,
      minHeight: minHeight,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius ?? BorderRadius.zero,
      progressGradient: progressGradient,
      animateProgress: animateProgress,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
    );
    // #region agent log
    _logTitled('titled_progress_bar.dart:213', 'LinearProgressBar created', {'hasGradient': progressGradient != null, 'animateProgress': animateProgress}, 'B');
    // #endregion

    final labelWidget = _buildLabel();

    // Handle top/bottom label positions
    if (labelPosition == LabelPosition.top ||
        labelPosition == LabelPosition.bottom) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (labelPosition == LabelPosition.top && labelWidget != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: _buildExternalLabel(),
            ),
          progressBar,
          if (labelPosition == LabelPosition.bottom && labelWidget != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: _buildExternalLabel(),
            ),
        ],
      );
    }

    // Handle center/start/end label positions (overlay)
    if (labelWidget == null) {
      return progressBar;
    }

    return Stack(
      alignment: _getLabelAlignment(),
      children: [
        progressBar,
        Padding(
          padding: labelPadding,
          child: labelWidget,
        ),
      ],
    );
  }

  Widget? _buildLabel() {
    if (labelType == LabelType.custom) {
      return customLabel;
    }

    final text = _labelText;
    if (text.isEmpty) {
      return null;
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: _effectiveLabelSize,
        color: labelColor,
        fontWeight: labelFontWeight,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget? _buildExternalLabel() {
    if (labelType == LabelType.custom) {
      return customLabel;
    }

    final text = _labelText;
    if (text.isEmpty) {
      return null;
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: _effectiveLabelSize,
        color: labelColor,
        fontWeight: labelFontWeight,
      ),
      textAlign: _getTextAlign(),
    );
  }

  Alignment _getLabelAlignment() {
    switch (labelPosition) {
      case LabelPosition.start:
        return Alignment.centerLeft;
      case LabelPosition.end:
        return Alignment.centerRight;
      case LabelPosition.center:
      case LabelPosition.top:
      case LabelPosition.bottom:
        return Alignment.center;
    }
  }

  TextAlign _getTextAlign() {
    switch (labelPosition) {
      case LabelPosition.start:
        return TextAlign.start;
      case LabelPosition.end:
        return TextAlign.end;
      case LabelPosition.center:
      case LabelPosition.top:
      case LabelPosition.bottom:
        return TextAlign.center;
    }
  }
}
