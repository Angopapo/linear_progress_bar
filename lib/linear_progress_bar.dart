library linear_progress_bar;

import 'package:flutter/material.dart';

import 'ui/dots_indicator.dart';
import 'utils/dots_decorator.dart';

class LinearProgressBar extends StatelessWidget {
  final int? maxSteps;
  final int? currentStep;
  final Color? progressColor;
  final Color? backgroundColor;
  final String? semanticsLabel;
  final String? semanticsValue;
  final double? minHeight;
  final int? progressType;
  final Animation<Color?>? valueColor;
  final BorderRadiusGeometry? borderRadius;
  final Axis? dotsAxis;
  final EdgeInsets? dotsSpacing;
  final double dotsActiveSize;
  final double dotsInactiveSize;

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
    this.progressType,
    this.dotsAxis = Axis.horizontal,
    this.dotsSpacing = EdgeInsets.zero,
    this.dotsActiveSize = 8,
    this.dotsInactiveSize = 8,
    this.borderRadius,
  }) : super(key: key);

  static final int progressTypeLinear = 1;
  static final int progressTypeDots = 2;

  @override
  Widget build(BuildContext context) {
    final DotsDecorator decorator = DotsDecorator(
      activeColor: progressColor!,
      color: backgroundColor!,
      spacing: dotsSpacing!,
      activeSize: Size.square(dotsActiveSize),
      size: Size.square(dotsInactiveSize),
    );

    double value = 1;
    double current = 1;

    if (maxSteps != null) {
      value = 1 / maxSteps!;
    } else {
      value = 1 / 1;
    }

    if (currentStep != null) {
      current = value * currentStep!;
    } else {
      current = value * 1;
    }

    return typeChooser(current, currentStep!.ceilToDouble(), decorator);
  }

  Widget typeChooser(double current, double dotsStep, DotsDecorator decorator) {
    if (progressType == progressTypeDots) {
      return DotsIndicator(
        dotsCount: maxSteps!,
        position: dotsStep,
        axis: dotsAxis!,
        decorator: decorator,
        onTap: (pos) {
          //setState(() => _currentPosition = pos);
        },
      );
    } else if (progressType == progressTypeLinear) {
      return LinearProgressIndicator(
        value: current,
        backgroundColor: backgroundColor,
        color: progressColor,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
        minHeight: minHeight,
        valueColor: valueColor,
        borderRadius: borderRadius ?? BorderRadius.zero,
      );
    }

    return LinearProgressIndicator(
      value: current,
      backgroundColor: backgroundColor,
      color: progressColor,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      minHeight: minHeight,
      valueColor: valueColor,
      borderRadius: borderRadius ?? BorderRadius.zero,
    );
  }
}
