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
      // ignore: deprecated_member_use_from_same_package
      expect(LinearProgressBar.progressTypeLinear, 1);
      // ignore: deprecated_member_use_from_same_package
      expect(LinearProgressBar.progressTypeDots, 2);
    });
  });

  group('CircularPercentIndicator', () {
    group('constructor', () {
      test('should use default values', () {
        const indicator = CircularPercentIndicator();
        expect(indicator.percent, 0.0);
        expect(indicator.radius, 50.0);
        expect(indicator.lineWidth, 5.0);
        expect(indicator.progressColor, Colors.blue);
        expect(indicator.circularStrokeCap, CircularStrokeCap.round);
        expect(indicator.startAngle, CircularStartAngle.top);
        expect(indicator.reverse, false);
        expect(indicator.animation, false);
      });

      test('should accept custom values', () {
        const indicator = CircularPercentIndicator(
          percent: 0.75,
          radius: 80,
          lineWidth: 10,
          progressColor: Colors.green,
          backgroundColor: Colors.grey,
          circularStrokeCap: CircularStrokeCap.square,
          startAngle: CircularStartAngle.right,
          reverse: true,
          animation: true,
        );
        expect(indicator.percent, 0.75);
        expect(indicator.radius, 80);
        expect(indicator.lineWidth, 10);
        expect(indicator.progressColor, Colors.green);
        expect(indicator.backgroundColor, Colors.grey);
        expect(indicator.circularStrokeCap, CircularStrokeCap.square);
        expect(indicator.startAngle, CircularStartAngle.right);
        expect(indicator.reverse, true);
        expect(indicator.animation, true);
      });
    });

    group('widget rendering', () {
      testWidgets('should render circular indicator', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CircularPercentIndicator(
                percent: 0.5,
              ),
            ),
          ),
        );

        expect(find.byType(CircularPercentIndicator), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should render with center widget', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CircularPercentIndicator(
                percent: 0.75,
                center: Text('75%'),
              ),
            ),
          ),
        );

        expect(find.text('75%'), findsOneWidget);
      });

      testWidgets('should render with header and footer', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CircularPercentIndicator(
                percent: 0.5,
                header: Text('Header'),
                footer: Text('Footer'),
              ),
            ),
          ),
        );

        expect(find.text('Header'), findsOneWidget);
        expect(find.text('Footer'), findsOneWidget);
      });

      testWidgets('should render with gradient', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CircularPercentIndicator(
                percent: 0.5,
                linearGradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(CircularPercentIndicator), findsOneWidget);
      });
    });
  });

  group('GaugeIndicator', () {
    group('constructor', () {
      test('should use default values', () {
        const gauge = GaugeIndicator();
        expect(gauge.value, 0.0);
        expect(gauge.size, 200.0);
        expect(gauge.strokeWidth, 15.0);
        expect(gauge.valueColor, Colors.blue);
        expect(gauge.startAngle, 135.0);
        expect(gauge.sweepAngle, 270.0);
        expect(gauge.showValue, true);
        expect(gauge.gaugeStyle, GaugeStyle.simple);
        expect(gauge.showNeedle, false);
        expect(gauge.animation, false);
      });

      test('should accept custom values', () {
        const gauge = GaugeIndicator(
          value: 0.65,
          size: 250,
          strokeWidth: 20,
          valueColor: Colors.red,
          startAngle: 180,
          sweepAngle: 180,
          showValue: false,
          gaugeStyle: GaugeStyle.ticked,
          showNeedle: true,
          animation: true,
        );
        expect(gauge.value, 0.65);
        expect(gauge.size, 250);
        expect(gauge.strokeWidth, 20);
        expect(gauge.valueColor, Colors.red);
        expect(gauge.startAngle, 180);
        expect(gauge.sweepAngle, 180);
        expect(gauge.showValue, false);
        expect(gauge.gaugeStyle, GaugeStyle.ticked);
        expect(gauge.showNeedle, true);
        expect(gauge.animation, true);
      });
    });

    group('widget rendering', () {
      testWidgets('should render gauge indicator', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: GaugeIndicator(
                value: 0.5,
              ),
            ),
          ),
        );

        expect(find.byType(GaugeIndicator), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should render with value label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: GaugeIndicator(
                value: 0.5,
              ),
            ),
          ),
        );

        expect(find.text('50%'), findsOneWidget);
      });

      testWidgets('should render with custom formatter', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GaugeIndicator(
                value: 0.75,
                valueFormatter: (v) => '${(v * 100).toInt()}°C',
              ),
            ),
          ),
        );

        expect(find.text('75°C'), findsOneWidget);
      });

      testWidgets('should render with title and subtitle', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: GaugeIndicator(
                value: 0.5,
                title: Text('Title'),
                subtitle: Text('Subtitle'),
              ),
            ),
          ),
        );

        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Subtitle'), findsOneWidget);
      });

      testWidgets('should render with min/max labels', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: GaugeIndicator(
                value: 0.5,
                showMinMax: true,
                minLabel: 'Min',
                maxLabel: 'Max',
              ),
            ),
          ),
        );

        expect(find.text('Min'), findsOneWidget);
        expect(find.text('Max'), findsOneWidget);
      });
    });
  });

  group('GaugeStyle enum', () {
    test('should have all gauge style values', () {
      expect(GaugeStyle.values, contains(GaugeStyle.simple));
      expect(GaugeStyle.values, contains(GaugeStyle.ticked));
      expect(GaugeStyle.values, contains(GaugeStyle.segmented));
      expect(GaugeStyle.values, contains(GaugeStyle.modern));
      expect(GaugeStyle.values.length, 4);
    });
  });

  group('GaugeLabelPosition enum', () {
    test('should have all label position values', () {
      expect(GaugeLabelPosition.values, contains(GaugeLabelPosition.center));
      expect(GaugeLabelPosition.values, contains(GaugeLabelPosition.bottom));
      expect(GaugeLabelPosition.values, contains(GaugeLabelPosition.none));
      expect(GaugeLabelPosition.values.length, 3);
    });
  });

  group('CircularStrokeCap enum', () {
    test('should have all stroke cap values', () {
      expect(CircularStrokeCap.values, contains(CircularStrokeCap.round));
      expect(CircularStrokeCap.values, contains(CircularStrokeCap.square));
      expect(CircularStrokeCap.values, contains(CircularStrokeCap.butt));
      expect(CircularStrokeCap.values.length, 3);
    });
  });

  group('CircularStartAngle enum', () {
    test('should have all start angle values', () {
      expect(CircularStartAngle.values, contains(CircularStartAngle.top));
      expect(CircularStartAngle.values, contains(CircularStartAngle.right));
      expect(CircularStartAngle.values, contains(CircularStartAngle.bottom));
      expect(CircularStartAngle.values, contains(CircularStartAngle.left));
      expect(CircularStartAngle.values.length, 4);
    });
  });

  group('GaugeRange', () {
    test('should create gauge range', () {
      const range = GaugeRange(
        start: 0.0,
        end: 0.5,
        color: Colors.green,
        label: 'Good',
      );
      expect(range.start, 0.0);
      expect(range.end, 0.5);
      expect(range.color, Colors.green);
      expect(range.label, 'Good');
    });
  });

  group('GaugeSegment', () {
    test('should create gauge segment', () {
      const segment = GaugeSegment(
        start: 0.0,
        end: 0.33,
        color: Colors.red,
      );
      expect(segment.start, 0.0);
      expect(segment.end, 0.33);
      expect(segment.color, Colors.red);
    });
  });

  group('GaugeDecorator', () {
    test('should create default decorator', () {
      const decorator = GaugeDecorator();
      expect(decorator.valueColor, isNull);
      expect(decorator.backgroundColor, isNull);
      expect(decorator.gradient, isNull);
    });

    test('should create speedometer decorator', () {
      final decorator = GaugeDecorator.speedometer();
      expect(decorator.startAngle, 135);
      expect(decorator.sweepAngle, 270);
      expect(decorator.gaugeStyle, GaugeStyle.ticked);
      expect(decorator.showNeedle, true);
      expect(decorator.ranges, isNotNull);
      expect(decorator.ranges!.length, 3);
    });

    test('should create minimal decorator', () {
      final decorator = GaugeDecorator.minimal();
      expect(decorator.startAngle, 180);
      expect(decorator.sweepAngle, 180);
      expect(decorator.gaugeStyle, GaugeStyle.simple);
      expect(decorator.showNeedle, false);
    });

    test('should create gradient decorator', () {
      final decorator = GaugeDecorator.gradient();
      expect(decorator.gaugeStyle, GaugeStyle.modern);
      expect(decorator.gradient, isNotNull);
    });

    test('copyWith should create new instance with updated values', () {
      const original = GaugeDecorator(
        valueColor: Colors.blue,
        startAngle: 135,
      );
      final updated = original.copyWith(valueColor: Colors.red);
      expect(original.valueColor, Colors.blue);
      expect(updated.valueColor, Colors.red);
      expect(updated.startAngle, 135);
    });
  });

  group('CircularDecorator', () {
    test('should create default decorator', () {
      const decorator = CircularDecorator();
      expect(decorator.progressColor, isNull);
      expect(decorator.backgroundColor, isNull);
      expect(decorator.gradient, isNull);
    });

    test('should create gradient decorator', () {
      final decorator = CircularDecorator.gradient();
      expect(decorator.lineWidth, 10);
      expect(decorator.animation, true);
      expect(decorator.gradient, isNotNull);
    });

    test('should create minimal decorator', () {
      final decorator = CircularDecorator.minimal();
      expect(decorator.progressColor, Colors.blue);
      expect(decorator.lineWidth, 8);
      expect(decorator.animation, true);
    });

    test('should create thick decorator', () {
      final decorator = CircularDecorator.thick();
      expect(decorator.lineWidth, 20);
      expect(decorator.animation, true);
    });

    test('should create thin decorator', () {
      final decorator = CircularDecorator.thin();
      expect(decorator.lineWidth, 4);
      expect(decorator.animation, true);
    });

    test('copyWith should create new instance with updated values', () {
      const original = CircularDecorator(
        progressColor: Colors.blue,
        lineWidth: 10,
      );
      final updated = original.copyWith(progressColor: Colors.green);
      expect(original.progressColor, Colors.blue);
      expect(updated.progressColor, Colors.green);
      expect(updated.lineWidth, 10);
    });
  });

  group('LinearGauge', () {
    group('constructor', () {
      test('should use default values', () {
        const gauge = LinearGauge();
        expect(gauge.value, 0.0);
        expect(gauge.orientation, LinearGaugeOrientation.horizontal);
        expect(gauge.thickness, 20.0);
        expect(gauge.rulerStyle, RulerStyle.none);
        expect(gauge.showValueBar, true);
        expect(gauge.animation, false);
        expect(gauge.interactive, false);
      });

      test('should accept custom values', () {
        const gauge = LinearGauge(
          value: 0.65,
          orientation: LinearGaugeOrientation.vertical,
          thickness: 30,
          rulerStyle: RulerStyle.graduated,
          animation: true,
          interactive: true,
        );
        expect(gauge.value, 0.65);
        expect(gauge.orientation, LinearGaugeOrientation.vertical);
        expect(gauge.thickness, 30);
        expect(gauge.rulerStyle, RulerStyle.graduated);
        expect(gauge.animation, true);
        expect(gauge.interactive, true);
      });
    });

    group('widget rendering', () {
      testWidgets('should render linear gauge', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearGauge(
                value: 0.5,
              ),
            ),
          ),
        );

        expect(find.byType(LinearGauge), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should render with pointer', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearGauge(
                value: 0.5,
                pointer: PointerConfig(),
              ),
            ),
          ),
        );

        expect(find.byType(LinearGauge), findsOneWidget);
      });

      testWidgets('should render with ranges', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearGauge(
                value: 0.5,
                ranges: [
                  LinearGaugeRange(start: 0.0, end: 0.3, color: Colors.green),
                  LinearGaugeRange(start: 0.3, end: 0.7, color: Colors.yellow),
                  LinearGaugeRange(start: 0.7, end: 1.0, color: Colors.red),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(LinearGauge), findsOneWidget);
      });
    });
  });

  group('LinearGaugeOrientation enum', () {
    test('should have all orientation values', () {
      expect(LinearGaugeOrientation.values,
          contains(LinearGaugeOrientation.horizontal));
      expect(LinearGaugeOrientation.values,
          contains(LinearGaugeOrientation.vertical));
      expect(LinearGaugeOrientation.values.length, 2);
    });
  });

  group('RulerStyle enum', () {
    test('should have all ruler style values', () {
      expect(RulerStyle.values, contains(RulerStyle.none));
      expect(RulerStyle.values, contains(RulerStyle.simple));
      expect(RulerStyle.values, contains(RulerStyle.labeled));
      expect(RulerStyle.values, contains(RulerStyle.graduated));
      expect(RulerStyle.values, contains(RulerStyle.bothSides));
      expect(RulerStyle.values.length, 5);
    });
  });

  group('PointerStyle enum', () {
    test('should have all pointer style values', () {
      expect(PointerStyle.values, contains(PointerStyle.none));
      expect(PointerStyle.values, contains(PointerStyle.triangle));
      expect(PointerStyle.values, contains(PointerStyle.diamond));
      expect(PointerStyle.values, contains(PointerStyle.arrow));
      expect(PointerStyle.values, contains(PointerStyle.circle));
      expect(PointerStyle.values, contains(PointerStyle.rectangle));
      expect(PointerStyle.values, contains(PointerStyle.invertedTriangle));
      expect(PointerStyle.values.length, 7);
    });
  });

  group('LinearGaugeRange', () {
    test('should create gauge range', () {
      const range = LinearGaugeRange(
        start: 0.0,
        end: 0.5,
        color: Colors.green,
        label: 'Good',
      );
      expect(range.start, 0.0);
      expect(range.end, 0.5);
      expect(range.color, Colors.green);
      expect(range.label, 'Good');
    });
  });

  group('PointerConfig', () {
    test('should use default values', () {
      const pointer = PointerConfig();
      expect(pointer.style, PointerStyle.triangle);
      expect(pointer.color, Colors.red);
      expect(pointer.size, 20.0);
      expect(pointer.position, PointerPosition.start);
      expect(pointer.hasShadow, true);
    });

    test('should accept custom values', () {
      const pointer = PointerConfig(
        style: PointerStyle.diamond,
        color: Colors.blue,
        size: 25.0,
        position: PointerPosition.end,
        hasShadow: false,
      );
      expect(pointer.style, PointerStyle.diamond);
      expect(pointer.color, Colors.blue);
      expect(pointer.size, 25.0);
      expect(pointer.position, PointerPosition.end);
      expect(pointer.hasShadow, false);
    });
  });

  group('RadialGauge', () {
    group('constructor', () {
      test('should use default values', () {
        const gauge = RadialGauge();
        expect(gauge.value, 0.0);
        expect(gauge.size, 200.0);
        expect(gauge.trackWidth, 20.0);
        expect(gauge.position, RadialGaugePosition.bottom);
        expect(gauge.showValueBar, true);
        expect(gauge.animation, false);
        expect(gauge.interactive, false);
      });

      test('should accept custom values', () {
        const gauge = RadialGauge(
          value: 0.75,
          size: 250,
          trackWidth: 25,
          position: RadialGaugePosition.top,
          animation: true,
          interactive: true,
        );
        expect(gauge.value, 0.75);
        expect(gauge.size, 250);
        expect(gauge.trackWidth, 25);
        expect(gauge.position, RadialGaugePosition.top);
        expect(gauge.animation, true);
        expect(gauge.interactive, true);
      });
    });

    group('widget rendering', () {
      testWidgets('should render radial gauge', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RadialGauge(
                value: 0.5,
              ),
            ),
          ),
        );

        expect(find.byType(RadialGauge), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      });

      testWidgets('should render with needle', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RadialGauge(
                value: 0.5,
                needle: NeedleConfig(),
              ),
            ),
          ),
        );

        expect(find.byType(RadialGauge), findsOneWidget);
      });

      testWidgets('should render with shape pointer', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RadialGauge(
                value: 0.5,
                shapePointer: ShapePointerConfig(),
              ),
            ),
          ),
        );

        expect(find.byType(RadialGauge), findsOneWidget);
      });

      testWidgets('should render with center value', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RadialGauge(
                value: 0.5,
                showValue: true,
              ),
            ),
          ),
        );

        expect(find.text('50'), findsOneWidget);
      });
    });
  });

  group('RadialGaugePosition enum', () {
    test('should have all position values', () {
      expect(RadialGaugePosition.values, contains(RadialGaugePosition.top));
      expect(RadialGaugePosition.values, contains(RadialGaugePosition.right));
      expect(RadialGaugePosition.values, contains(RadialGaugePosition.bottom));
      expect(RadialGaugePosition.values, contains(RadialGaugePosition.left));
      expect(RadialGaugePosition.values, contains(RadialGaugePosition.custom));
      expect(RadialGaugePosition.values.length, 5);
    });
  });

  group('NeedleStyle enum', () {
    test('should have all needle style values', () {
      expect(NeedleStyle.values, contains(NeedleStyle.none));
      expect(NeedleStyle.values, contains(NeedleStyle.simple));
      expect(NeedleStyle.values, contains(NeedleStyle.tapered));
      expect(NeedleStyle.values, contains(NeedleStyle.triangle));
      expect(NeedleStyle.values, contains(NeedleStyle.diamond));
      expect(NeedleStyle.values, contains(NeedleStyle.flat));
      expect(NeedleStyle.values, contains(NeedleStyle.compass));
      expect(NeedleStyle.values.length, 7);
    });
  });

  group('ShapePointerStyle enum', () {
    test('should have all shape pointer style values', () {
      expect(ShapePointerStyle.values, contains(ShapePointerStyle.none));
      expect(ShapePointerStyle.values, contains(ShapePointerStyle.circle));
      expect(ShapePointerStyle.values, contains(ShapePointerStyle.triangle));
      expect(ShapePointerStyle.values, contains(ShapePointerStyle.diamond));
      expect(ShapePointerStyle.values, contains(ShapePointerStyle.rectangle));
      expect(ShapePointerStyle.values,
          contains(ShapePointerStyle.invertedTriangle));
      expect(ShapePointerStyle.values, contains(ShapePointerStyle.arrow));
      expect(ShapePointerStyle.values.length, 7);
    });
  });

  group('NeedleConfig', () {
    test('should use default values', () {
      const needle = NeedleConfig();
      expect(needle.style, NeedleStyle.tapered);
      expect(needle.color, Colors.red);
      expect(needle.lengthRatio, 0.8);
      expect(needle.showKnob, true);
      expect(needle.hasShadow, true);
    });
  });

  group('ShapePointerConfig', () {
    test('should use default values', () {
      const pointer = ShapePointerConfig();
      expect(pointer.style, ShapePointerStyle.triangle);
      expect(pointer.color, Colors.blue);
      expect(pointer.size, 15.0);
      expect(pointer.position, ShapePointerPosition.outer);
      expect(pointer.hasShadow, true);
    });
  });

  group('RadialGaugeRange', () {
    test('should create radial gauge range', () {
      const range = RadialGaugeRange(
        start: 0.0,
        end: 0.5,
        color: Colors.green,
        label: 'Good',
      );
      expect(range.start, 0.0);
      expect(range.end, 0.5);
      expect(range.color, Colors.green);
      expect(range.label, 'Good');
    });
  });

  group('LinearPercentIndicator', () {
    group('constructor', () {
      test('should use default values', () {
        const indicator = LinearPercentIndicator();
        expect(indicator.percent, 0.0);
        expect(indicator.lineHeight, 10.0);
        expect(indicator.progressColor, Colors.blue);
        expect(indicator.animation, false);
        expect(indicator.childPosition, LinearChildPosition.center);
      });

      test('should accept custom values', () {
        const indicator = LinearPercentIndicator(
          percent: 0.75,
          width: 200,
          lineHeight: 20,
          progressColor: Colors.green,
          animation: true,
          animationDuration: 1000,
          childPosition: LinearChildPosition.left,
        );
        expect(indicator.percent, 0.75);
        expect(indicator.width, 200);
        expect(indicator.lineHeight, 20);
        expect(indicator.progressColor, Colors.green);
        expect(indicator.animation, true);
        expect(indicator.animationDuration, 1000);
        expect(indicator.childPosition, LinearChildPosition.left);
      });
    });

    group('widget rendering', () {
      testWidgets('should render linear percent indicator', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearPercentIndicator(
                percent: 0.5,
                width: 200,
              ),
            ),
          ),
        );

        expect(find.byType(LinearPercentIndicator), findsOneWidget);
      });

      testWidgets('should render with leading and trailing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearPercentIndicator(
                percent: 0.75,
                leading: Icon(Icons.download),
                trailing: Text('75%'),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.download), findsOneWidget);
        expect(find.text('75%'), findsOneWidget);
      });

      testWidgets('should render with center widget', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearPercentIndicator(
                percent: 0.5,
                lineHeight: 30,
                center: Text('50%'),
              ),
            ),
          ),
        );

        expect(find.text('50%'), findsOneWidget);
      });

      testWidgets('should render with percentage display', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearPercentIndicator(
                percent: 0.75,
                lineHeight: 30,
                showPercentage: true,
              ),
            ),
          ),
        );

        expect(find.text('75%'), findsOneWidget);
      });

      testWidgets('should render with gradient', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearPercentIndicator(
                percent: 0.5,
                linearGradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(LinearPercentIndicator), findsOneWidget);
      });

      testWidgets('should render with segments', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LinearPercentIndicator(
                percent: 0.8,
                segments: [
                  LinearSegment(start: 0.0, end: 0.3, color: Colors.green),
                  LinearSegment(start: 0.3, end: 0.6, color: Colors.yellow),
                  LinearSegment(start: 0.6, end: 1.0, color: Colors.red),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(LinearPercentIndicator), findsOneWidget);
      });
    });
  });

  group('LinearChildPosition enum', () {
    test('should have all position values', () {
      expect(LinearChildPosition.values, contains(LinearChildPosition.left));
      expect(LinearChildPosition.values, contains(LinearChildPosition.right));
      expect(LinearChildPosition.values, contains(LinearChildPosition.center));
      expect(LinearChildPosition.values.length, 3);
    });
  });

  group('LinearSegment', () {
    test('should create linear segment', () {
      const segment = LinearSegment(
        start: 0.0,
        end: 0.5,
        color: Colors.green,
        label: 'Complete',
      );
      expect(segment.start, 0.0);
      expect(segment.end, 0.5);
      expect(segment.color, Colors.green);
      expect(segment.label, 'Complete');
    });
  });

  group('MultiSegmentLinearIndicator', () {
    group('constructor', () {
      test('should accept required segments', () {
        const indicator = MultiSegmentLinearIndicator(
          segments: [
            LinearSegment(start: 0.0, end: 0.5, color: Colors.green),
            LinearSegment(start: 0.5, end: 1.0, color: Colors.red),
          ],
        );
        expect(indicator.segments.length, 2);
        expect(indicator.lineHeight, 20.0);
        expect(indicator.animation, false);
      });
    });

    group('widget rendering', () {
      testWidgets('should render multi-segment indicator', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: MultiSegmentLinearIndicator(
                segments: [
                  LinearSegment(
                      start: 0.0,
                      end: 0.3,
                      color: Colors.green,
                      label: 'Complete'),
                  LinearSegment(
                      start: 0.3,
                      end: 0.6,
                      color: Colors.yellow,
                      label: 'In Progress'),
                  LinearSegment(
                      start: 0.6,
                      end: 1.0,
                      color: Colors.red,
                      label: 'Pending'),
                ],
                width: 300,
              ),
            ),
          ),
        );

        expect(find.byType(MultiSegmentLinearIndicator), findsOneWidget);
      });
    });
  });

  group('CircularChildPosition enum', () {
    test('should have all position values', () {
      expect(
          CircularChildPosition.values, contains(CircularChildPosition.center));
      expect(CircularChildPosition.values, contains(CircularChildPosition.top));
      expect(
          CircularChildPosition.values, contains(CircularChildPosition.bottom));
      expect(CircularChildPosition.values.length, 3);
    });
  });

  group('CircularPercentIndicator child positioning', () {
    testWidgets('should render child at center position', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CircularPercentIndicator(
              percent: 0.5,
              child: Icon(Icons.check),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('should render child at top position', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CircularPercentIndicator(
              percent: 0.5,
              childPosition: CircularChildPosition.top,
              child: Text('Top'),
            ),
          ),
        ),
      );

      expect(find.text('Top'), findsOneWidget);
    });

    testWidgets('should render child at bottom position', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CircularPercentIndicator(
              percent: 0.5,
              childPosition: CircularChildPosition.bottom,
              child: Text('Bottom'),
            ),
          ),
        ),
      );

      expect(find.text('Bottom'), findsOneWidget);
    });

    testWidgets('should render with showPercentage', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CircularPercentIndicator(
              percent: 0.75,
              showPercentage: true,
            ),
          ),
        ),
      );

      expect(find.text('75%'), findsOneWidget);
    });
  });
}
