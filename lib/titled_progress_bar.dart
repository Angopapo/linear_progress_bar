import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class TitledProgressBar extends StatelessWidget {
  final int maxSteps;
  final int currentStep;
  final Color progressColor;
  final Color backgroundColor;
  final String? label;
  double? labelSize;
  final double minHeight;
  final BorderRadiusGeometry? borderRadius;

  TitledProgressBar({
    super.key,
    this.progressColor = Colors.red,
    this.backgroundColor = Colors.white,
    this.maxSteps = 100,
    this.currentStep = 0,
    this.minHeight = 10,
    this.label,
    this.labelSize,
    this.borderRadius,
  }) {
    labelSize = labelSize ?? minHeight * .7;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LinearProgressBar(
          maxSteps: maxSteps,
          progressType: LinearProgressBar.progressTypeLinear,
          currentStep: currentStep,
          minHeight: minHeight,
          progressColor: progressColor,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
        ),
        if (label != null)
          Center(
            child: Text(
              label!,
              style: TextStyle(fontSize: labelSize, backgroundColor: Colors.transparent),
            ),
          ),
      ],
    );
  }
}
