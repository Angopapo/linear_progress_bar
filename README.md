# linear_progress_bar

Advanced linear progress indicator like Native Android Progress Bar

[![pub package](https://img.shields.io/pub/v/linear_progress_bar.svg)](https://pub.dev/packages/linear_progress_bar)

## Features

- Linear progress bar
- Set max progress value
- Set current progress value
- Color animation 
- Progress based on a current step
- Progress and background color
- Custom size

## Getting started

You should ensure that you add the router as a dependency in your flutter project.
```yaml
dependencies:
 linear_progress_bar: "^1.0.0"
```

You should then run `flutter packages upgrade` or update your packages in IntelliJ.

## Example Project

There is a example project in the `example` folder. Check it out. Otherwise, keep reading to get up and running.

## Usage

Need to include the import the package to the dart file where it will be used, use the below command,

```dart
import 'package:linear_progress_bar/linear_progress_bar.dart';
```

Basic Widget usage
```dart
new LinearProgressBar(
      maxSteps: 6,
      currentStep: 1,
      progressColor: Colors.red,
      backgroundColor: Colors.grey,
    )
```

Advanced Widget usage
```dart
new LinearProgressBar(
      maxSteps: 6,
      currentStep: currentStep,
      progressColor: Colors.red,
      backgroundColor: Colors.grey,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      semanticsLabel: "Label",
      semanticsValue: "Value",
      minHeight: 10,
  )
```

Complete example

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: new AppBar(
      title: new Text("Linear Percent Indicators"),
    ),
    body: Center(
      child: LinearProgressBar(
        maxSteps: 6,
        currentStep: currentStep,
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
```

You can follow me on twitter [@maravilhosinga](https://www.twitter.com/maravilhosinga)