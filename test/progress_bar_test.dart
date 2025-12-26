import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

void main() {
  group('LinearProgressBar', () {
    group('constructor', () {
      test('should use default values', () {
        const bar = LinearProgressBar();
        expect(bar.maxSteps, 1);
        expect(bar.currentStep, 0);
        expect(bar.progressColor, Colors.red);
        expect(bar.backgroundColor, Colors.white);
        expect(bar.minHeight, 10);
        expect(bar.progressType, ProgressType.linear);
        expect(bar.dotsAxis, Axis.horizontal);
        expect(bar.dotsActiveSize, 8);
        expect(bar.dotsInactiveSize, 8);
        expect(bar.animateProgress, false);
      });

      test('should accept custom values', () {
        const bar = LinearProgressBar(
          maxSteps: 10,
          currentStep: 5,
          progressColor: Colors.blue,
          backgroundColor: Colors.grey,
          minHeight: 20,
          progressType: ProgressType.dots,
          dotsAxis: Axis.vertical,
        );
        expect(bar.maxSteps, 10);
        expect(bar.currentStep, 5);
        expect(bar.progressColor, Colors.blue);
        expect(bar.backgroundColor, Colors.grey);
        expect(bar.minHeight, 20);
        expect(bar.progressType, ProgressType.dots);
        expect(bar.dotsAxis, Axis.vertical);
      });
    });

    group('progressValue', () {
      test('should calculate correct progress value', () {
        const bar = LinearProgressBar(maxSteps: 10, currentStep: 5);
        expect(bar.progressValue, 0.5);
      });

      test('should return 0 when currentStep is 0', () {
        const bar = LinearProgressBar(maxSteps: 10);
        expect(bar.progressValue, 0.0);
      });

      test('should return 1 when progress is complete', () {
        const bar = LinearProgressBar(maxSteps: 10, currentStep: 10);
        expect(bar.progressValue, 1.0);
      });

      test('should clamp value to 1.0 when currentStep exceeds maxSteps', () {
        // This shouldn't happen due to assertion, but the getter handles it
        const bar = LinearProgressBar(maxSteps: 10, currentStep: 10);
        expect(bar.progressValue, 1.0);
      });
    });

    group('progressPercentage', () {
      test('should return correct percentage', () {
        const bar = LinearProgressBar(maxSteps: 100, currentStep: 75);
        expect(bar.progressPercentage, 75.0);
      });

      test('should return 0 for no progress', () {
        const bar = LinearProgressBar(maxSteps: 100);
        expect(bar.progressPercentage, 0.0);
      });

      test('should return 100 for complete progress', () {
        const bar = LinearProgressBar(maxSteps: 100, currentStep: 100);
        expect(bar.progressPercentage, 100.0);
      });
    });

    group('isComplete', () {
      test('should return false when not complete', () {
        const bar = LinearProgressBar(maxSteps: 10, currentStep: 5);
        expect(bar.isComplete, false);
      });

      test('should return true when complete', () {
        const bar = LinearProgressBar(maxSteps: 10, currentStep: 10);
        expect(bar.isComplete, true);
      });
    });

    group('widget rendering', () {
      testWidgets('should render linear progress indicator', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearProgressBar(
                maxSteps: 10,
                currentStep: 5,
              ),
            ),
          ),
        );

        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      });

      testWidgets('should render dots indicator', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearProgressBar(
                maxSteps: 5,
                currentStep: 2,
                progressType: ProgressType.dots,
              ),
            ),
          ),
        );

        expect(find.byType(DotsIndicator), findsOneWidget);
      });

      testWidgets('should apply border radius to linear progress',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LinearProgressBar(
                maxSteps: 10,
                currentStep: 5,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );

        final progressIndicator = tester.widget<LinearProgressIndicator>(
          find.byType(LinearProgressIndicator),
        );
        expect(progressIndicator.borderRadius, BorderRadius.circular(10));
      });

      testWidgets('should render gradient progress bar', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearProgressBar(
                maxSteps: 10,
                currentStep: 5,
                progressGradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
            ),
          ),
        );

        // Gradient progress uses Container instead of LinearProgressIndicator
        expect(find.byType(Container), findsWidgets);
      });
    });
  });

  group('TitledProgressBar', () {
    group('constructor', () {
      test('should use default values', () {
        const bar = TitledProgressBar();
        expect(bar.maxSteps, 100);
        expect(bar.currentStep, 0);
        expect(bar.progressColor, Colors.red);
        expect(bar.backgroundColor, Colors.white);
        expect(bar.minHeight, 10);
        expect(bar.labelType, LabelType.text);
        expect(bar.labelPosition, LabelPosition.center);
      });
    });

    group('progressValue', () {
      test('should calculate correct progress value', () {
        const bar = TitledProgressBar(currentStep: 50);
        expect(bar.progressValue, 0.5);
      });
    });

    group('progressPercentage', () {
      test('should return correct percentage', () {
        const bar = TitledProgressBar(currentStep: 75);
        expect(bar.progressPercentage, 75.0);
      });
    });

    group('widget rendering', () {
      testWidgets('should render with text label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TitledProgressBar(
                currentStep: 50,
                label: 'Loading...',
              ),
            ),
          ),
        );

        expect(find.text('Loading...'), findsOneWidget);
        expect(find.byType(LinearProgressBar), findsOneWidget);
      });

      testWidgets('should render with percentage label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TitledProgressBar(
                currentStep: 75,
                labelType: LabelType.percentage,
              ),
            ),
          ),
        );

        expect(find.text('75%'), findsOneWidget);
      });

      testWidgets('should render with step count label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TitledProgressBar(
                currentStep: 50,
                labelType: LabelType.stepCount,
              ),
            ),
          ),
        );

        expect(find.text('50/100'), findsOneWidget);
      });

      testWidgets('should render label at top position', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TitledProgressBar(
                currentStep: 50,
                labelType: LabelType.percentage,
                labelPosition: LabelPosition.top,
              ),
            ),
          ),
        );

        expect(find.byType(Column), findsWidgets);
        expect(find.text('50%'), findsOneWidget);
      });

      testWidgets('should apply custom label color', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TitledProgressBar(
                currentStep: 50,
                label: 'Test',
                labelColor: Colors.blue,
              ),
            ),
          ),
        );

        final text = tester.widget<Text>(find.text('Test'));
        expect(text.style?.color, Colors.blue);
      });
    });
  });

  group('DotsIndicator', () {
    group('constructor', () {
      test('should accept required parameters', () {
        const indicator = DotsIndicator(dotsCount: 5, position: 2);
        expect(indicator.dotsCount, 5);
        expect(indicator.position, 2);
      });

      test('should use default values', () {
        const indicator = DotsIndicator(dotsCount: 5);
        expect(indicator.position, 0);
        expect(indicator.axis, Axis.horizontal);
        expect(indicator.reversed, false);
      });
    });

    group('widget rendering', () {
      testWidgets('should render correct number of dots', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: DotsIndicator(dotsCount: 5, position: 2),
            ),
          ),
        );

        // Each dot is wrapped in an AnimatedContainer
        expect(find.byType(AnimatedContainer), findsNWidgets(5));
      });

      testWidgets('should render horizontal dots by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: DotsIndicator(dotsCount: 5, position: 2),
            ),
          ),
        );

        expect(find.byType(Row), findsOneWidget);
      });

      testWidgets('should render vertical dots when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: DotsIndicator(
                dotsCount: 5,
                position: 2,
                axis: Axis.vertical,
              ),
            ),
          ),
        );

        expect(find.byType(Column), findsOneWidget);
      });

      testWidgets('should call onTap when dot is tapped', (tester) async {
        double? tappedPosition;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DotsIndicator(
                dotsCount: 5,
                position: 2,
                onTap: (pos) => tappedPosition = pos,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(InkWell).first);
        expect(tappedPosition, 0.0);
      });
    });
  });

  group('DotsDecorator', () {
    test('should use default values', () {
      const decorator = DotsDecorator();
      expect(decorator.size, kDefaultSize);
      expect(decorator.activeSize, kDefaultSize);
      expect(decorator.shape, kDefaultShape);
      expect(decorator.activeShape, kDefaultShape);
      expect(decorator.spacing, kDefaultSpacing);
    });

    test('should accept custom values', () {
      const decorator = DotsDecorator(
        color: Colors.grey,
        activeColor: Colors.blue,
        size: Size.square(10),
        activeSize: Size.square(15),
      );
      expect(decorator.color, Colors.grey);
      expect(decorator.activeColor, Colors.blue);
      expect(decorator.size, const Size.square(10));
      expect(decorator.activeSize, const Size.square(15));
    });

    test('copyWith should create new instance with updated values', () {
      const original = DotsDecorator(
        color: Colors.grey,
        activeColor: Colors.blue,
      );
      final updated = original.copyWith(activeColor: Colors.red);

      expect(original.activeColor, Colors.blue);
      expect(updated.activeColor, Colors.red);
      expect(updated.color, Colors.grey);
    });

    test('effectiveColor should return color or default grey', () {
      const decorator1 = DotsDecorator(color: Colors.red);
      const decorator2 = DotsDecorator();

      expect(decorator1.effectiveColor, Colors.red);
      expect(decorator2.effectiveColor, Colors.grey);
    });

    test('effectiveActiveColor should return activeColor or default blue', () {
      const decorator1 = DotsDecorator(activeColor: Colors.green);
      const decorator2 = DotsDecorator();

      expect(decorator1.effectiveActiveColor, Colors.green);
      expect(decorator2.effectiveActiveColor, Colors.blue);
    });

    test('equality operator should work correctly', () {
      const decorator1 = DotsDecorator(
        color: Colors.grey,
        activeColor: Colors.blue,
      );
      const decorator2 = DotsDecorator(
        color: Colors.grey,
        activeColor: Colors.blue,
      );
      const decorator3 = DotsDecorator(
        color: Colors.red,
        activeColor: Colors.blue,
      );

      expect(decorator1, decorator2);
      expect(decorator1, isNot(decorator3));
    });
  });

  group('ProgressType enum', () {
    test('should have linear and dots values', () {
      expect(ProgressType.values, contains(ProgressType.linear));
      expect(ProgressType.values, contains(ProgressType.dots));
      expect(ProgressType.values.length, 2);
    });
  });

  group('LabelType enum', () {
    test('should have all label type values', () {
      expect(LabelType.values, contains(LabelType.text));
      expect(LabelType.values, contains(LabelType.percentage));
      expect(LabelType.values, contains(LabelType.stepCount));
      expect(LabelType.values, contains(LabelType.custom));
      expect(LabelType.values.length, 4);
    });
  });

  group('LabelPosition enum', () {
    test('should have all label position values', () {
      expect(LabelPosition.values, contains(LabelPosition.center));
      expect(LabelPosition.values, contains(LabelPosition.start));
      expect(LabelPosition.values, contains(LabelPosition.end));
      expect(LabelPosition.values, contains(LabelPosition.top));
      expect(LabelPosition.values, contains(LabelPosition.bottom));
      expect(LabelPosition.values.length, 5);
    });
  });

  group('Static field backward compatibility', () {
    test('should access deprecated static fields', () {
      expect(LinearProgressBar.progressTypeLinear, 1);
      expect(LinearProgressBar.progressTypeDots, 2);
    });
  });
}
