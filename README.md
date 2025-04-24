# linear_progress_bar

Advanced linear progress indicator like Native Android Progress Bar

[![pub package](https://img.shields.io/pub/v/linear_progress_bar.svg)](https://pub.dev/packages/linear_progress_bar) [![CodeFactor](https://www.codefactor.io/repository/github/angopapo/linear_progress_bar/badge)](https://www.codefactor.io/repository/github/angopapo/linear_progress_bar)
<p align="center">
<img src="https://i.ibb.co/8gZpqgf/image1.png" alt="drawing" width="230px" hspace="30"/>  <img src="https://i.ibb.co/nB5YV7X/Simulator-Screen-Shot-i-Phone-12-Pro-Max-2021-07-20-at-02-23-50.png" alt="drawing" width="230px"/> <img src="https://i.ibb.co/qmMYX49/Simulator-Screen-Shot-i-Phone-13-Pro-2021-10-25-at-20-30-45.png" alt="drawing" width="230px"/> 
</p>

## Features

- Linear progress bar
- Dots progress bar
- Set max progress value
- Set current progress value
- Color animation 
- Progress based on a current step
- Progress and background color
- Custom size
- Dots progress direction (Horizontal or Vertical)

!NEW FEATURES
- Added


## Getting started

You should ensure that you add the router as a dependency in your flutter project.
```yaml
dependencies:
 linear_progress_bar: "^1.2.0"
```

You should then run `flutter packages upgrade` or update your packages in IntelliJ.

## Example Project

There is a example project in the `example` folder. Check it out. Otherwise, keep reading to get up and running.

## Usage

Need to include the import the package to the dart file where it will be used, use the below command,

```dart
import 'package:linear_progress_bar/linear_progress_bar.dart';
```

Basic Widget usage with Linear progress
```dart
 LinearProgressBar(
      maxSteps: 6,
      progressType: LinearProgressBar.progressTypeLinear, // Use Linear progress
      currentStep: 1,
      progressColor: Colors.red,
      backgroundColor: Colors.grey,
      borderRadius: BorderRadius.circular(10), //  NEW
    )
```

NEW! Basic Widget usage with Linear Dots progress
```dart
 LinearProgressBar(
      maxSteps: 6,
      progressType: LinearProgressBar.progressTypeDots, // Use Dots progress
      currentStep: 1,
      progressColor: Colors.red,
      backgroundColor: Colors.grey,
    )
```

Advanced Widget usage with Linear Progress
```dart
 LinearProgressBar(
      maxSteps: 9,
      progressType: LinearProgressBar.progressTypeLinear,
      currentStep: currentStep,
      progressColor: kPrimaryColor,
      backgroundColor: kColorsGrey400,
      borderRadius: BorderRadius.circular(10), //  NEW
  );
```

NEW! Advanced Widget usage
```dart
 LinearProgressBar(
      maxSteps: 9,
      progressType: LinearProgressBar.progressTypeDots,
      currentStep: currentStep,
      progressColor: kPrimaryColor,
      backgroundColor: kColorsGrey400,
      dotsAxis: Axis.horizontal, // OR Axis.vertical
      dotsActiveSize: 10,
      dotsInactiveSize: 10,
      dotsSpacing: EdgeInsets.only(right: 10), // also can use any EdgeInsets.
  );

NEW! Titled progress bar
```dart
 TitledProgressBar(
      maxSteps: 9,
      progressType: LinearProgressBar.progressTypeDots,
      currentStep: currentStep,
      progressColor: kPrimaryColor,
      backgroundColor: kColorsGrey400,
      label: "Title",
      labelSize: 12,
      minHeight: 10,
      borderRadius: BorderRadius.circular(10),
)
```

Complete example Linear Progress

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: new AppBar(
      title: new Text("Linear Progress Bar"),
    ),
    body: Center(
      child: LinearProgressBar(
        maxSteps: 6,
        progressType: LinearProgressBar.progressTypeLinear,
        currentStep: currentStep,
        progressColor: Colors.red,
        backgroundColor: Colors.grey,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        semanticsLabel: "Label",
        semanticsValue: "Value",
        minHeight: 10,
        borderRadius: BorderRadius.circular(10), //  NEW
      ),
    ),
  );
}
```

Complete example Linear Progress

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: new AppBar(
      title: new Text("Dots Progress Bar"),
    ),
    body: Center(
      child: LinearProgressBar(
        maxSteps: 9,
        progressType: LinearProgressBar.progressTypeDots,
        currentStep: currentStep,
        progressColor: kPrimaryColor,
        backgroundColor: kColorsGrey400,
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
  );
}
```

You can follow me on twitter [@maravilhosinga](https://www.twitter.com/maravilhosinga)
You can message me on facebook [fb.com/maravilhosinga](https://www.fb.com/maravilhosinga)