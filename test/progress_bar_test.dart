import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

void main() {
  runApp(LinearProgressBar());
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: new AppBar(
      title: new Text("Linear Indicators"),
    ),
    body: Column(
      children: [
        Center(
          child: LinearProgressBar(
            maxSteps: 6,
            currentStep: 1,
            progressColor: Colors.red,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            semanticsLabel: "Label",
            semanticsValue: "Value",
            minHeight: 10,
          ),
        ),

        Center(
          child: LinearProgressBar(
            maxSteps: 9,
            progressType: LinearProgressBar.progressTypeDots,
            currentStep: 2,
            progressColor: Colors.red,
            backgroundColor: Colors.grey,
            dotsAxis: Axis.horizontal, // OR Axis.vertical
            dotsActiveSize: 10,
            dotsInactiveSize: 10,
            dotsSpacing: EdgeInsets.only(right: 10), // also can use any EdgeInsets.
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            semanticsLabel: "Label",
            semanticsValue: "Value",
            minHeight: 10,
          ),
        ),
      ],
    ),
  );
}
