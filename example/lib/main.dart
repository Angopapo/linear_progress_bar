import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

void main() {
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  /// Creates the main application widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Indicators Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExamplesPage(),
    );
  }
}

/// The main examples page that displays different progress bar examples.
class ExamplesPage extends StatefulWidget {
  /// Creates the examples page widget.
  const ExamplesPage({super.key});

  @override
  State<ExamplesPage> createState() => _ExamplesPageState();
}

class _ExamplesPageState extends State<ExamplesPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    LinearProgressExamples(),
    DotsProgressExamples(),
    TitledProgressExamples(),
    CircularPercentExamples(),
    GaugeExamples(),
    LinearGaugeExamples(),
    RadialGaugeExamples(),
    LinearPercentExamples(),
    AnimatedProgressExamples(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Progress Indicators Demo'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildNavButton(0, Icons.linear_scale, 'Linear'),
            _buildNavButton(1, Icons.more_horiz, 'Dots'),
            _buildNavButton(2, Icons.title, 'Titled'),
            _buildNavButton(3, Icons.circle_outlined, 'Circular'),
            _buildNavButton(4, Icons.speed, 'Gauge'),
            _buildNavButton(5, Icons.straighten, 'L.Gauge'),
            _buildNavButton(6, Icons.radio_button_checked, 'R.Gauge'),
            _buildNavButton(7, Icons.percent, 'Percent'),
            _buildNavButton(8, Icons.animation, 'Animated'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Examples of linear progress bars
class LinearProgressExamples extends StatefulWidget {
  /// Creates the linear progress examples widget.
  const LinearProgressExamples({super.key});

  @override
  State<LinearProgressExamples> createState() => _LinearProgressExamplesState();
}

class _LinearProgressExamplesState extends State<LinearProgressExamples> {
  int _currentStep = 3;
  final int _maxSteps = 6;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Basic Linear Progress'),
          _buildExampleCard(
            'Simple Progress Bar',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
              minHeight: 10,
            ),
          ),

          _buildSectionTitle('Rounded Corners'),
          _buildExampleCard(
            'With Border Radius',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressColor: Colors.green,
              backgroundColor: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              minHeight: 16,
            ),
          ),

          _buildSectionTitle('Different Heights'),
          _buildExampleCard(
            'Thin (4px)',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressColor: Colors.purple,
              backgroundColor: Colors.grey.shade300,
              minHeight: 4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          _buildExampleCard(
            'Medium (12px)',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressColor: Colors.purple,
              backgroundColor: Colors.grey.shade300,
              minHeight: 12,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 8),
          _buildExampleCard(
            'Thick (24px)',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressColor: Colors.purple,
              backgroundColor: Colors.grey.shade300,
              minHeight: 24,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          _buildSectionTitle('Gradient Progress'),
          _buildExampleCard(
            'Gradient Bar',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressGradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.pink],
              ),
              backgroundColor: Colors.grey.shade300,
              minHeight: 16,
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          const SizedBox(height: 24),
          _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _currentStep > 0
              ? () => setState(() => _currentStep--)
              : null,
          icon: const Icon(Icons.remove),
          label: const Text('Decrease'),
        ),
        const SizedBox(width: 16),
        Text(
          '$_currentStep / $_maxSteps',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: _currentStep < _maxSteps
              ? () => setState(() => _currentStep++)
              : null,
          icon: const Icon(Icons.add),
          label: const Text('Increase'),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Examples of dots progress indicators
class DotsProgressExamples extends StatefulWidget {
  /// Creates the dots progress examples widget.
  const DotsProgressExamples({super.key});

  @override
  State<DotsProgressExamples> createState() => _DotsProgressExamplesState();
}

class _DotsProgressExamplesState extends State<DotsProgressExamples> {
  int _currentStep = 2;
  final int _maxSteps = 5;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Basic Dots Indicator'),
          _buildExampleCard(
            'Horizontal Dots',
            Center(
              child: LinearProgressBar(
                maxSteps: _maxSteps,
                progressType: ProgressType.dots,
                currentStep: _currentStep,
                progressColor: Colors.blue,
                backgroundColor: Colors.grey.shade400,
              ),
            ),
          ),

          _buildSectionTitle('Custom Sizes'),
          _buildExampleCard(
            'Large Active Dot',
            Center(
              child: LinearProgressBar(
                maxSteps: _maxSteps,
                progressType: ProgressType.dots,
                currentStep: _currentStep,
                progressColor: Colors.orange,
                backgroundColor: Colors.grey.shade400,
                dotsActiveSize: 16,
                dotsInactiveSize: 10,
              ),
            ),
          ),

          _buildSectionTitle('Custom Spacing'),
          _buildExampleCard(
            'Wide Spacing',
            Center(
              child: LinearProgressBar(
                maxSteps: _maxSteps,
                progressType: ProgressType.dots,
                currentStep: _currentStep,
                progressColor: Colors.green,
                backgroundColor: Colors.grey.shade400,
                dotsSpacing: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),

          _buildSectionTitle('Vertical Dots'),
          _buildExampleCard(
            'Vertical Layout',
            Center(
              child: SizedBox(
                height: 150,
                child: LinearProgressBar(
                  maxSteps: _maxSteps,
                  progressType: ProgressType.dots,
                  currentStep: _currentStep,
                  progressColor: Colors.purple,
                  backgroundColor: Colors.grey.shade400,
                  dotsAxis: Axis.vertical,
                  dotsActiveSize: 12,
                  dotsInactiveSize: 8,
                ),
              ),
            ),
          ),

          _buildSectionTitle('Interactive Dots'),
          _buildExampleCard(
            'Tap to Change Step',
            Center(
              child: LinearProgressBar(
                maxSteps: _maxSteps,
                progressType: ProgressType.dots,
                currentStep: _currentStep,
                progressColor: Colors.teal,
                backgroundColor: Colors.grey.shade400,
                dotsActiveSize: 14,
                dotsInactiveSize: 10,
                onDotTap: (position) {
                  setState(() => _currentStep = position.toInt());
                },
              ),
            ),
          ),

          const SizedBox(height: 24),
          _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _currentStep > 0
              ? () => setState(() => _currentStep--)
              : null,
          icon: const Icon(Icons.remove),
          label: const Text('Previous'),
        ),
        const SizedBox(width: 16),
        Text(
          'Step ${_currentStep + 1} of $_maxSteps',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: _currentStep < _maxSteps - 1
              ? () => setState(() => _currentStep++)
              : null,
          icon: const Icon(Icons.add),
          label: const Text('Next'),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Examples of titled progress bars
class TitledProgressExamples extends StatefulWidget {
  /// Creates the titled progress examples widget.
  const TitledProgressExamples({super.key});

  @override
  State<TitledProgressExamples> createState() => _TitledProgressExamplesState();
}

class _TitledProgressExamplesState extends State<TitledProgressExamples> {
  int _currentStep = 65;
  final int _maxSteps = 100;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Text Label'),
          _buildExampleCard(
            'Center Label',
            TitledProgressBar(
              maxSteps: _maxSteps,
              currentStep: _currentStep,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
              label: 'Loading...',
              labelColor: Colors.white,
              minHeight: 24,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          _buildSectionTitle('Percentage Display'),
          _buildExampleCard(
            'Show Percentage',
            TitledProgressBar(
              maxSteps: _maxSteps,
              currentStep: _currentStep,
              progressColor: Colors.green,
              backgroundColor: Colors.grey.shade300,
              labelType: LabelType.percentage,
              labelColor: Colors.white,
              labelFontWeight: FontWeight.bold,
              minHeight: 28,
              borderRadius: BorderRadius.circular(14),
            ),
          ),

          _buildSectionTitle('Step Count'),
          _buildExampleCard(
            'Show Step Count',
            TitledProgressBar(
              maxSteps: _maxSteps,
              currentStep: _currentStep,
              progressColor: Colors.purple,
              backgroundColor: Colors.grey.shade300,
              labelType: LabelType.stepCount,
              labelColor: Colors.white,
              minHeight: 24,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          _buildSectionTitle('Label Positions'),
          _buildExampleCard(
            'Label on Top',
            TitledProgressBar(
              maxSteps: _maxSteps,
              currentStep: _currentStep,
              progressColor: Colors.orange,
              backgroundColor: Colors.grey.shade300,
              labelType: LabelType.percentage,
              labelPosition: LabelPosition.top,
              labelColor: Colors.black87,
              minHeight: 12,
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          _buildSectionTitle('With Gradient'),
          _buildExampleCard(
            'Gradient + Percentage',
            TitledProgressBar(
              maxSteps: _maxSteps,
              currentStep: _currentStep,
              progressGradient: const LinearGradient(
                colors: [Colors.pink, Colors.purple, Colors.blue],
              ),
              backgroundColor: Colors.grey.shade300,
              labelType: LabelType.percentage,
              labelColor: Colors.white,
              labelFontWeight: FontWeight.bold,
              minHeight: 28,
              borderRadius: BorderRadius.circular(14),
            ),
          ),

          const SizedBox(height: 24),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Adjust Progress: $_currentStep%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _currentStep.toDouble(),
              min: 0,
              max: _maxSteps.toDouble(),
              divisions: _maxSteps,
              onChanged: (value) {
                setState(() => _currentStep = value.toInt());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Examples of circular percent indicators
class CircularPercentExamples extends StatefulWidget {
  /// Creates the circular percent examples widget.
  const CircularPercentExamples({super.key});

  @override
  State<CircularPercentExamples> createState() => _CircularPercentExamplesState();
}

class _CircularPercentExamplesState extends State<CircularPercentExamples> {
  double _percent = 0.75;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Basic Circular Indicator'),
          _buildExampleCard(
            'Simple Circle with Percentage',
            Center(
              child: CircularPercentIndicator(
                percent: _percent,
                radius: 60,
                lineWidth: 10,
                progressColor: Colors.blue,
                backgroundColor: Colors.grey.shade300,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '${(_percent * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),

          _buildSectionTitle('Gradient Circular'),
          _buildExampleCard(
            'With Gradient Colors',
            Center(
              child: CircularPercentIndicator(
                percent: _percent,
                radius: 70,
                lineWidth: 12,
                backgroundColor: Colors.grey.shade200,
                linearGradient: const LinearGradient(
                  colors: [Colors.purple, Colors.pink, Colors.orange],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                center: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(_percent * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Complete',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          _buildSectionTitle('Different Sizes'),
          _buildExampleCard(
            'Small, Medium, Large',
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularPercentIndicator(
                  percent: _percent,
                  radius: 30,
                  lineWidth: 6,
                  progressColor: Colors.teal,
                  backgroundColor: Colors.grey.shade300,
                  center: Text(
                    '${(_percent * 100).toInt()}%',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                CircularPercentIndicator(
                  percent: _percent,
                  radius: 50,
                  lineWidth: 8,
                  progressColor: Colors.indigo,
                  backgroundColor: Colors.grey.shade300,
                  center: Text(
                    '${(_percent * 100).toInt()}%',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                CircularPercentIndicator(
                  percent: _percent,
                  radius: 70,
                  lineWidth: 10,
                  progressColor: Colors.deepOrange,
                  backgroundColor: Colors.grey.shade300,
                  center: Text(
                    '${(_percent * 100).toInt()}%',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          _buildSectionTitle('With Header & Footer'),
          _buildExampleCard(
            'Download Progress',
            Center(
              child: CircularPercentIndicator(
                percent: _percent,
                radius: 60,
                lineWidth: 8,
                progressColor: Colors.green,
                backgroundColor: Colors.grey.shade300,
                circularStrokeCap: CircularStrokeCap.round,
                header: const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Downloading...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                center: const Icon(Icons.download, size: 32, color: Colors.green),
                footer: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${(_percent * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),

          _buildSectionTitle('Different Start Angles'),
          _buildExampleCard(
            'Start from Different Positions',
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircularPercentIndicator(
                      percent: _percent,
                      radius: 40,
                      lineWidth: 8,
                      startAngle: CircularStartAngle.top,
                      progressColor: Colors.blue,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 4),
                    const Text('Top', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      percent: _percent,
                      radius: 40,
                      lineWidth: 8,
                      startAngle: CircularStartAngle.right,
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 4),
                    const Text('Right', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      percent: _percent,
                      radius: 40,
                      lineWidth: 8,
                      startAngle: CircularStartAngle.bottom,
                      progressColor: Colors.orange,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 4),
                    const Text('Bottom', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      percent: _percent,
                      radius: 40,
                      lineWidth: 8,
                      startAngle: CircularStartAngle.left,
                      progressColor: Colors.purple,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 4),
                    const Text('Left', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          _buildSectionTitle('Filled Background'),
          _buildExampleCard(
            'With Circle Fill',
            Center(
              child: CircularPercentIndicator(
                percent: _percent,
                radius: 60,
                lineWidth: 10,
                progressColor: Colors.white,
                backgroundColor: Colors.blue.shade100,
                fillColor: true,
                circleColor: Colors.blue.shade50,
                circularStrokeCap: CircularStrokeCap.round,
                center: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.battery_charging_full, color: Colors.blue, size: 28),
                    Text(
                      '${(_percent * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          _buildSectionTitle('Reversed Direction'),
          _buildExampleCard(
            'Counter-clockwise',
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircularPercentIndicator(
                      percent: _percent,
                      radius: 50,
                      lineWidth: 8,
                      progressColor: Colors.red,
                      backgroundColor: Colors.grey.shade300,
                      reverse: false,
                    ),
                    const SizedBox(height: 4),
                    const Text('Normal', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      percent: _percent,
                      radius: 50,
                      lineWidth: 8,
                      progressColor: Colors.red,
                      backgroundColor: Colors.grey.shade300,
                      reverse: true,
                    ),
                    const SizedBox(height: 4),
                    const Text('Reversed', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Adjust Progress: ${(_percent * 100).toInt()}%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _percent,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (value) {
                setState(() => _percent = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Examples of gauge indicators
class GaugeExamples extends StatefulWidget {
  /// Creates the gauge examples widget.
  const GaugeExamples({super.key});

  @override
  State<GaugeExamples> createState() => _GaugeExamplesState();
}

class _GaugeExamplesState extends State<GaugeExamples> {
  double _value = 0.65;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Basic Gauge'),
          _buildExampleCard(
            'Simple Gauge Indicator',
            Center(
              child: GaugeIndicator(
                value: _value,
                size: 180,
                strokeWidth: 15,
                valueColor: Colors.blue,
                backgroundColor: Colors.grey.shade300,
                showValue: true,
              ),
            ),
          ),

          _buildSectionTitle('Speedometer Style'),
          _buildExampleCard(
            'With Needle Pointer',
            Center(
              child: GaugeIndicator(
                value: _value,
                size: 200,
                strokeWidth: 20,
                valueColor: Colors.green,
                backgroundColor: Colors.grey.shade200,
                showNeedle: true,
                needleColor: Colors.red,
                gaugeStyle: GaugeStyle.ticked,
                tickCount: 10,
                showMinMax: true,
                minLabel: '0',
                maxLabel: '100',
                valueFormatter: (v) => '${(v * 100).toInt()}',
              ),
            ),
          ),

          _buildSectionTitle('Half Gauge'),
          _buildExampleCard(
            '180° Sweep Angle',
            Center(
              child: GaugeIndicator(
                value: _value,
                size: 200,
                strokeWidth: 20,
                valueColor: Colors.teal,
                backgroundColor: Colors.grey.shade300,
                startAngle: 180,
                sweepAngle: 180,
                showValue: true,
                labelPosition: GaugeLabelPosition.center,
              ),
            ),
          ),

          _buildSectionTitle('Gradient Gauge'),
          _buildExampleCard(
            'With Gradient Colors',
            Center(
              child: GaugeIndicator(
                value: _value,
                size: 200,
                strokeWidth: 18,
                backgroundColor: Colors.grey.shade200,
                gradient: const SweepGradient(
                  startAngle: 2.35,
                  endAngle: 7.07,
                  colors: [
                    Colors.green,
                    Colors.yellow,
                    Colors.orange,
                    Colors.red,
                  ],
                ),
                gaugeStyle: GaugeStyle.modern,
                tickCount: 8,
                showValue: true,
              ),
            ),
          ),

          _buildSectionTitle('Range Colors'),
          _buildExampleCard(
            'With Colored Ranges',
            Center(
              child: GaugeIndicator(
                value: _value,
                size: 200,
                strokeWidth: 20,
                backgroundColor: Colors.grey.shade200,
                ranges: const [
                  GaugeRange(start: 0.0, end: 0.33, color: Colors.green),
                  GaugeRange(start: 0.33, end: 0.66, color: Colors.orange),
                  GaugeRange(start: 0.66, end: 1.0, color: Colors.red),
                ],
                showNeedle: true,
                needleColor: Colors.black87,
                showMinMax: true,
                minLabel: 'Low',
                maxLabel: 'High',
                showValue: true,
                valueFormatter: (v) {
                  if (v < 0.33) return 'Good';
                  if (v < 0.66) return 'Normal';
                  return 'Alert';
                },
              ),
            ),
          ),

          _buildSectionTitle('Modern Style'),
          _buildExampleCard(
            'Modern Ticked Gauge',
            Center(
              child: GaugeIndicator(
                value: _value,
                size: 180,
                strokeWidth: 12,
                valueColor: Colors.indigo,
                backgroundColor: Colors.grey.shade200,
                gaugeStyle: GaugeStyle.modern,
                tickCount: 12,
                tickLength: 10,
                tickColor: Colors.grey.shade400,
                showValue: true,
                valueTextStyle: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
          ),

          _buildSectionTitle('Custom Labels'),
          _buildExampleCard(
            'With Title and Subtitle',
            Center(
              child: GaugeIndicator(
                value: _value,
                size: 180,
                strokeWidth: 15,
                valueColor: Colors.deepPurple,
                backgroundColor: Colors.grey.shade300,
                showValue: true,
                valueFormatter: (v) => '${(v * 100).toInt()}°C',
                title: const Text(
                  'Temperature',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Current reading',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          _buildSectionTitle('Different Angles'),
          _buildExampleCard(
            'Various Sweep Angles',
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GaugeIndicator(
                      value: _value,
                      size: 100,
                      strokeWidth: 10,
                      valueColor: Colors.blue,
                      backgroundColor: Colors.grey.shade300,
                      startAngle: 180,
                      sweepAngle: 180,
                      showValue: false,
                    ),
                    const Text('180°', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    GaugeIndicator(
                      value: _value,
                      size: 100,
                      strokeWidth: 10,
                      valueColor: Colors.green,
                      backgroundColor: Colors.grey.shade300,
                      startAngle: 135,
                      sweepAngle: 270,
                      showValue: false,
                    ),
                    const Text('270°', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    GaugeIndicator(
                      value: _value,
                      size: 100,
                      strokeWidth: 10,
                      valueColor: Colors.orange,
                      backgroundColor: Colors.grey.shade300,
                      startAngle: 90,
                      sweepAngle: 360,
                      showValue: false,
                    ),
                    const Text('360°', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Adjust Value: ${(_value * 100).toInt()}%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _value,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (value) {
                setState(() => _value = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Examples of Linear Gauge
class LinearGaugeExamples extends StatefulWidget {
  /// Creates the linear gauge examples widget.
  const LinearGaugeExamples({super.key});

  @override
  State<LinearGaugeExamples> createState() => _LinearGaugeExamplesState();
}

class _LinearGaugeExamplesState extends State<LinearGaugeExamples> {
  double _value = 0.65;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Basic Linear Gauge'),
          _buildExampleCard(
            'Horizontal with Value Bar',
            LinearGauge(
              value: _value,
              orientation: LinearGaugeOrientation.horizontal,
              thickness: 12,
              showValueBar: true,
              valueBarColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
            ),
          ),

          _buildSectionTitle('With Ruler'),
          _buildExampleCard(
            'Ticks with Labels',
            LinearGauge(
              value: _value,
              orientation: LinearGaugeOrientation.horizontal,
              thickness: 14,
              rulerStyle: RulerStyle.ticksWithLabels,
              majorTickCount: 5,
              showValueBar: true,
              valueBarColor: Colors.green,
              backgroundColor: Colors.grey.shade200,
              minValue: 0,
              maxValue: 100,
            ),
          ),

          _buildSectionTitle('With Pointer'),
          _buildExampleCard(
            'Triangle Pointer',
            LinearGauge(
              value: _value,
              orientation: LinearGaugeOrientation.horizontal,
              thickness: 10,
              showValueBar: true,
              valueBarColor: Colors.purple,
              backgroundColor: Colors.grey.shade300,
              pointer: const LinearGaugePointer(
                type: LinearPointerType.triangle,
                color: Colors.red,
                size: 16,
                position: PointerPosition.start,
              ),
            ),
          ),

          _buildSectionTitle('Range Colors'),
          _buildExampleCard(
            'Battery Style with Ranges',
            LinearGauge(
              value: _value,
              orientation: LinearGaugeOrientation.horizontal,
              thickness: 20,
              showValueBar: true,
              useRangeColorsForValueBar: true,
              backgroundColor: Colors.grey.shade200,
              ranges: const [
                LinearGaugeRange(start: 0.0, end: 0.2, color: Colors.red),
                LinearGaugeRange(start: 0.2, end: 0.5, color: Colors.orange),
                LinearGaugeRange(start: 0.5, end: 1.0, color: Colors.green),
              ],
            ),
          ),

          _buildSectionTitle('Gradient Value Bar'),
          _buildExampleCard(
            'With Gradient',
            LinearGauge(
              value: _value,
              orientation: LinearGaugeOrientation.horizontal,
              thickness: 16,
              showValueBar: true,
              backgroundColor: Colors.grey.shade200,
              valueBarGradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.pink],
              ),
              rulerStyle: RulerStyle.ticks,
            ),
          ),

          _buildSectionTitle('Vertical Gauge'),
          _buildExampleCard(
            'Thermometer Style',
            Center(
              child: SizedBox(
                height: 200,
                child: LinearGauge(
                  value: _value,
                  orientation: LinearGaugeOrientation.vertical,
                  thickness: 16,
                  rulerStyle: RulerStyle.ticksWithLabels,
                  showValueBar: true,
                  valueBarGradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.blue, Colors.orange, Colors.red],
                  ),
                  backgroundColor: Colors.grey.shade200,
                  pointer: const LinearGaugePointer(
                    type: LinearPointerType.triangle,
                    color: Colors.red,
                    position: PointerPosition.end,
                  ),
                ),
              ),
            ),
          ),

          _buildSectionTitle('Interactive Gauge'),
          _buildExampleCard(
            'Drag to Change Value',
            LinearGauge(
              value: _value,
              orientation: LinearGaugeOrientation.horizontal,
              thickness: 14,
              showValueBar: true,
              valueBarColor: Colors.teal,
              backgroundColor: Colors.grey.shade200,
              isInteractive: true,
              animation: true,
              showValue: true,
              valuePosition: PointerPosition.end,
              pointer: const LinearGaugePointer(
                type: LinearPointerType.circle,
                color: Colors.teal,
                size: 20,
                position: PointerPosition.center,
              ),
              onValueChanged: (value) {
                setState(() => _value = value);
              },
            ),
          ),

          const SizedBox(height: 24),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Adjust Value: ${(_value * 100).toInt()}%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _value,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (value) {
                setState(() => _value = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Examples of Radial Gauge
class RadialGaugeExamples extends StatefulWidget {
  /// Creates the radial gauge examples widget.
  const RadialGaugeExamples({super.key});

  @override
  State<RadialGaugeExamples> createState() => _RadialGaugeExamplesState();
}

class _RadialGaugeExamplesState extends State<RadialGaugeExamples> {
  double _value = 0.65;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Basic Radial Gauge'),
          _buildExampleCard(
            'With Needle Pointer',
            Center(
              child: RadialGauge(
                value: _value,
                size: 200,
                position: RadialGaugePosition.bottom,
                sweepAngle: 270,
                backgroundWidth: 15,
                backgroundColor: Colors.grey.shade200,
                needlePointer: const NeedlePointer(
                  type: NeedlePointerType.triangle,
                  color: Colors.red,
                  lengthFactor: 0.7,
                  knobRadius: 12,
                ),
                showValue: true,
              ),
            ),
          ),

          _buildSectionTitle('With Value Bar'),
          _buildExampleCard(
            'Radial Value Bar',
            Center(
              child: RadialGauge(
                value: _value,
                size: 200,
                position: RadialGaugePosition.bottom,
                sweepAngle: 270,
                backgroundWidth: 20,
                backgroundColor: Colors.grey.shade200,
                valueBar: const RadialValueBar(
                  color: Colors.blue,
                  width: 15,
                  startFactor: 0.7,
                  endFactor: 0.95,
                ),
                showValue: true,
              ),
            ),
          ),

          _buildSectionTitle('Shape Pointer'),
          _buildExampleCard(
            'Circle Shape Pointer',
            Center(
              child: RadialGauge(
                value: _value,
                size: 200,
                position: RadialGaugePosition.bottom,
                sweepAngle: 270,
                backgroundWidth: 12,
                backgroundColor: Colors.grey.shade200,
                valueBar: const RadialValueBar(
                  color: Colors.purple,
                  width: 8,
                ),
                shapePointer: const ShapePointer(
                  type: ShapePointerType.circle,
                  color: Colors.purple,
                  size: 16,
                  positionFactor: 0.85,
                ),
                showValue: true,
              ),
            ),
          ),

          _buildSectionTitle('With Ranges'),
          _buildExampleCard(
            'Colored Range Sections',
            Center(
              child: RadialGauge(
                value: _value,
                size: 200,
                position: RadialGaugePosition.bottom,
                sweepAngle: 270,
                backgroundWidth: 20,
                backgroundColor: Colors.grey.shade100,
                ranges: const [
                  RadialGaugeRange(start: 0.0, end: 0.33, color: Colors.green),
                  RadialGaugeRange(start: 0.33, end: 0.66, color: Colors.orange),
                  RadialGaugeRange(start: 0.66, end: 1.0, color: Colors.red),
                ],
                needlePointer: const NeedlePointer(
                  type: NeedlePointerType.needleWithCircle,
                  color: Colors.black87,
                  lengthFactor: 0.65,
                ),
                showTicks: true,
                showLabels: true,
                showValue: true,
                valueFormatter: (v) {
                  if (v < 33) return 'Low';
                  if (v < 66) return 'Normal';
                  return 'High';
                },
              ),
            ),
          ),

          _buildSectionTitle('Different Positions'),
          _buildExampleCard(
            'Start from Different Angles',
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    RadialGauge(
                      value: _value,
                      size: 100,
                      position: RadialGaugePosition.top,
                      sweepAngle: 180,
                      backgroundWidth: 10,
                      backgroundColor: Colors.grey.shade200,
                      valueBar: const RadialValueBar(color: Colors.blue, width: 8),
                      showValue: false,
                    ),
                    const Text('Top', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    RadialGauge(
                      value: _value,
                      size: 100,
                      position: RadialGaugePosition.bottom,
                      sweepAngle: 180,
                      backgroundWidth: 10,
                      backgroundColor: Colors.grey.shade200,
                      valueBar: const RadialValueBar(color: Colors.green, width: 8),
                      showValue: false,
                    ),
                    const Text('Bottom', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          _buildSectionTitle('Interactive Gauge'),
          _buildExampleCard(
            'Tap/Drag to Change Value',
            Center(
              child: RadialGauge(
                value: _value,
                size: 200,
                position: RadialGaugePosition.bottom,
                sweepAngle: 270,
                backgroundWidth: 15,
                backgroundColor: Colors.grey.shade200,
                isInteractive: true,
                animation: true,
                valueBar: const RadialValueBar(
                  color: Colors.teal,
                  width: 12,
                ),
                shapePointer: const ShapePointer(
                  type: ShapePointerType.diamond,
                  color: Colors.teal,
                  size: 18,
                ),
                showValue: true,
                onValueChanged: (value) {
                  setState(() => _value = value);
                },
              ),
            ),
          ),

          _buildSectionTitle('Gradient Value Bar'),
          _buildExampleCard(
            'With Gradient Colors',
            Center(
              child: RadialGauge(
                value: _value,
                size: 200,
                position: RadialGaugePosition.bottom,
                sweepAngle: 270,
                backgroundWidth: 15,
                backgroundColor: Colors.grey.shade200,
                valueBar: RadialValueBar(
                  width: 12,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple, Colors.pink],
                  ),
                ),
                showTicks: true,
                majorTickCount: 10,
                showValue: true,
              ),
            ),
          ),

          const SizedBox(height: 24),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Adjust Value: ${(_value * 100).toInt()}%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _value,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (value) {
                setState(() => _value = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Examples of Linear Percent Indicator
class LinearPercentExamples extends StatefulWidget {
  /// Creates the linear percent examples widget.
  const LinearPercentExamples({super.key});

  @override
  State<LinearPercentExamples> createState() => _LinearPercentExamplesState();
}

class _LinearPercentExamplesState extends State<LinearPercentExamples> {
  double _percent = 0.65;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Basic Linear Percent Indicator'),
          _buildExampleCard(
            'Simple Progress Bar',
            LinearPercentIndicator(
              percent: _percent,
              lineHeight: 14,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
              barRadius: const Radius.circular(7),
              animation: true,
            ),
          ),

          _buildSectionTitle('With Leading & Trailing'),
          _buildExampleCard(
            'Icon and Percentage',
            LinearPercentIndicator(
              percent: _percent,
              lineHeight: 12,
              progressColor: Colors.green,
              backgroundColor: Colors.grey.shade300,
              barRadius: const Radius.circular(6),
              leading: const Icon(Icons.download, color: Colors.green),
              trailing: Text(
                '${(_percent * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              animation: true,
            ),
          ),

          _buildSectionTitle('Center Widget'),
          _buildExampleCard(
            'Text in Center',
            LinearPercentIndicator(
              percent: _percent,
              lineHeight: 24,
              progressColor: Colors.purple,
              backgroundColor: Colors.grey.shade300,
              barRadius: const Radius.circular(12),
              center: Text(
                '${(_percent * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              animation: true,
            ),
          ),

          _buildSectionTitle('Gradient Progress'),
          _buildExampleCard(
            'With Linear Gradient',
            GradientLinearProgress(
              percent: _percent,
              lineHeight: 16,
              gradientColors: const [Colors.blue, Colors.purple, Colors.pink],
              backgroundColor: Colors.grey.shade200,
              animation: true,
              center: Text(
                '${(_percent * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),

          _buildSectionTitle('Multi-Segment Indicator'),
          _buildExampleCard(
            'Multiple Colored Segments',
            MultiSegmentLinearIndicator(
              segments: const [
                LinearSegment(value: 0.3, color: Colors.blue, label: 'Blue'),
                LinearSegment(value: 0.25, color: Colors.green, label: 'Green'),
                LinearSegment(value: 0.2, color: Colors.orange, label: 'Orange'),
                LinearSegment(value: 0.25, color: Colors.red, label: 'Red'),
              ],
              height: 16,
              showLabels: true,
            ),
          ),

          _buildSectionTitle('Simple Linear Progress'),
          _buildExampleCard(
            'Convenience Widget',
            SimpleLinearProgress(
              percent: _percent,
              lineHeight: 12,
              progressColor: Colors.teal,
              animation: true,
              showPercentage: true,
            ),
          ),

          _buildSectionTitle('Different Child Positions'),
          _buildExampleCard(
            'Left, Center, Right',
            Column(
              children: [
                LinearPercentIndicator(
                  percent: _percent,
                  lineHeight: 20,
                  progressColor: Colors.indigo,
                  backgroundColor: Colors.grey.shade300,
                  barRadius: const Radius.circular(10),
                  center: const Text('Left', style: TextStyle(color: Colors.white, fontSize: 11)),
                  centerPosition: LinearChildPosition.left,
                ),
                const SizedBox(height: 12),
                LinearPercentIndicator(
                  percent: _percent,
                  lineHeight: 20,
                  progressColor: Colors.indigo,
                  backgroundColor: Colors.grey.shade300,
                  barRadius: const Radius.circular(10),
                  center: const Text('Center', style: TextStyle(color: Colors.white, fontSize: 11)),
                  centerPosition: LinearChildPosition.center,
                ),
                const SizedBox(height: 12),
                LinearPercentIndicator(
                  percent: _percent,
                  lineHeight: 20,
                  progressColor: Colors.indigo,
                  backgroundColor: Colors.grey.shade300,
                  barRadius: const Radius.circular(10),
                  center: const Text('Right', style: TextStyle(color: Colors.white, fontSize: 11)),
                  centerPosition: LinearChildPosition.right,
                ),
              ],
            ),
          ),

          _buildSectionTitle('Circular with Child Positions'),
          _buildExampleCard(
            'Top, Center, Bottom',
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircularPercentIndicator(
                      percent: _percent,
                      radius: 50,
                      lineWidth: 8,
                      progressColor: Colors.blue,
                      backgroundColor: Colors.grey.shade300,
                      showPercentage: true,
                      centerPosition: CircularChildPosition.top,
                      centerBottom: const Text('Complete', style: TextStyle(fontSize: 10)),
                    ),
                    const SizedBox(height: 4),
                    const Text('Top', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      percent: _percent,
                      radius: 50,
                      lineWidth: 8,
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey.shade300,
                      showPercentage: true,
                      centerPosition: CircularChildPosition.center,
                    ),
                    const SizedBox(height: 4),
                    const Text('Center', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      percent: _percent,
                      radius: 50,
                      lineWidth: 8,
                      progressColor: Colors.orange,
                      backgroundColor: Colors.grey.shade300,
                      showPercentage: true,
                      centerPosition: CircularChildPosition.bottom,
                      centerTop: const Icon(Icons.download, size: 20),
                    ),
                    const SizedBox(height: 4),
                    const Text('Bottom', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          _buildSectionTitle('Simple Circular Progress'),
          _buildExampleCard(
            'Convenience Widget',
            Center(
              child: SimpleCircularProgress(
                percent: _percent,
                radius: 60,
                lineWidth: 10,
                progressColor: Colors.deepOrange,
                animation: true,
                showPercentage: true,
              ),
            ),
          ),

          _buildSectionTitle('Gradient Circular Progress'),
          _buildExampleCard(
            'With Gradient Colors',
            Center(
              child: GradientCircularProgress(
                percent: _percent,
                radius: 60,
                lineWidth: 12,
                gradientColors: const [Colors.blue, Colors.purple, Colors.pink],
                animation: true,
                center: Text(
                  '${(_percent * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Adjust Progress: ${(_percent * 100).toInt()}%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _percent,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (value) {
                setState(() => _percent = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Examples of animated progress bars
class AnimatedProgressExamples extends StatefulWidget {
  /// Creates the animated progress examples widget.
  const AnimatedProgressExamples({super.key});

  @override
  State<AnimatedProgressExamples> createState() => _AnimatedProgressExamplesState();
}

class _AnimatedProgressExamplesState extends State<AnimatedProgressExamples> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Animated Linear Progress'),
          _buildExampleCard(
            'Smooth Animation',
            LinearProgressBar(
              maxSteps: 100,
              progressType: ProgressType.linear,
              currentStep: (_value * 100).toInt(),
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
              minHeight: 16,
              borderRadius: BorderRadius.circular(8),
              animateProgress: true,
              animationDuration: const Duration(milliseconds: 500),
            ),
          ),

          _buildSectionTitle('Animated Circular'),
          _buildExampleCard(
            'Circular Animation',
            Center(
              child: CircularPercentIndicator(
                percent: _value,
                radius: 70,
                lineWidth: 12,
                progressColor: Colors.purple,
                backgroundColor: Colors.grey.shade300,
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                animationDuration: const Duration(milliseconds: 800),
                animationCurve: Curves.easeInOut,
                center: Text(
                  '${(_value * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ),

          _buildSectionTitle('Animated Gauge'),
          _buildExampleCard(
            'Gauge with Animation',
            Center(
              child: GaugeIndicator(
                value: _value,
                size: 200,
                strokeWidth: 20,
                valueColor: Colors.teal,
                backgroundColor: Colors.grey.shade200,
                animation: true,
                animationDuration: const Duration(milliseconds: 600),
                animationCurve: Curves.elasticOut,
                showNeedle: true,
                needleColor: Colors.red,
                gaugeStyle: GaugeStyle.ticked,
                showValue: true,
              ),
            ),
          ),

          _buildSectionTitle('Different Animation Curves'),
          _buildExampleCard(
            'Bounce Effect',
            Center(
              child: CircularPercentIndicator(
                percent: _value,
                radius: 60,
                lineWidth: 10,
                progressColor: Colors.orange,
                backgroundColor: Colors.grey.shade300,
                animation: true,
                animationDuration: const Duration(milliseconds: 1000),
                animationCurve: Curves.bounceOut,
                center: Text(
                  '${(_value * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          _buildSectionTitle('Gradient with Animation'),
          _buildExampleCard(
            'Animated Gradient Progress',
            Column(
              children: [
                LinearProgressBar(
                  maxSteps: 100,
                  progressType: ProgressType.linear,
                  currentStep: (_value * 100).toInt(),
                  progressGradient: const LinearGradient(
                    colors: [Colors.blue, Colors.purple, Colors.pink],
                  ),
                  backgroundColor: Colors.grey.shade300,
                  minHeight: 20,
                  borderRadius: BorderRadius.circular(10),
                  animateProgress: true,
                  animationDuration: const Duration(milliseconds: 500),
                ),
                const SizedBox(height: 20),
                CircularPercentIndicator(
                  percent: _value,
                  radius: 60,
                  lineWidth: 12,
                  backgroundColor: Colors.grey.shade200,
                  linearGradient: const LinearGradient(
                    colors: [Colors.green, Colors.yellow, Colors.red],
                  ),
                  animation: true,
                  animationDuration: const Duration(milliseconds: 800),
                  center: Text(
                    '${(_value * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _buildAnimationControls(),
        ],
      ),
    );
  }

  Widget _buildAnimationControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Test Animation: ${(_value * 100).toInt()}%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _value = 0),
                  child: const Text('0%'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _value = 0.25),
                  child: const Text('25%'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _value = 0.5),
                  child: const Text('50%'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _value = 0.75),
                  child: const Text('75%'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _value = 1.0),
                  child: const Text('100%'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Slider(
              value: _value,
              min: 0,
              max: 1,
              divisions: 100,
              onChanged: (value) {
                setState(() => _value = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildExampleCard(String title, Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
