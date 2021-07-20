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
      title: new Text("Linear Percent Indicators"),
    ),
    body: Center(
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
  );
}
