library linear_progress_bar;

import 'package:flutter/material.dart';

class LinearProgressBar extends StatelessWidget {
  final int? maxSteps;
  final int? currentStep;
  final Color? progressColor;
  final Color? backgroundColor;
  final String? semanticsLabel;
  final String? semanticsValue;
  final double? minHeight;
  final Animation<Color?>? valueColor;


  const LinearProgressBar({
    Key? key,
    this.progressColor,
    this.backgroundColor,
    this.maxSteps,
    this.currentStep,
    this.minHeight,
    this.semanticsLabel,
    this.semanticsValue,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double value = 1;
    double current = 1;

    if(maxSteps != null){
      value = 1/maxSteps!;
    } else {
      value = 1/1;
    }

    if(currentStep != null){
      current = value * currentStep!;
    } else {
      current = value * 1;
    }

    return LinearProgressIndicator(
      value: current,
      backgroundColor: backgroundColor,
      color: progressColor,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      minHeight: minHeight,
      valueColor: valueColor,
    );
  }
}
