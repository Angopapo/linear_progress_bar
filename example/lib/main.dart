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
      title: 'Linear Progress Bar Demo',
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
    AnimatedProgressExamples(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Linear Progress Bar Demo'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.linear_scale),
            label: 'Linear',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            label: 'Dots',
          ),
          NavigationDestination(
            icon: Icon(Icons.title),
            label: 'Titled',
          ),
          NavigationDestination(
            icon: Icon(Icons.animation),
            label: 'Animated',
          ),
        ],
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

          _buildSectionTitle('Reversed Dots'),
          _buildExampleCard(
            'Reversed Order',
            Center(
              child: LinearProgressBar(
                maxSteps: _maxSteps,
                progressType: ProgressType.dots,
                currentStep: _currentStep,
                progressColor: Colors.red,
                backgroundColor: Colors.grey.shade400,
                dotsReversed: true,
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
          const SizedBox(height: 8),
          _buildExampleCard(
            'Label at Start',
            TitledProgressBar(
              maxSteps: _maxSteps,
              currentStep: _currentStep,
              progressColor: Colors.teal,
              backgroundColor: Colors.grey.shade300,
              labelType: LabelType.percentage,
              labelPosition: LabelPosition.start,
              labelColor: Colors.white,
              minHeight: 24,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 8),
          _buildExampleCard(
            'Label at End',
            TitledProgressBar(
              maxSteps: _maxSteps,
              currentStep: _currentStep,
              progressColor: Colors.indigo,
              backgroundColor: Colors.grey.shade300,
              labelType: LabelType.percentage,
              labelPosition: LabelPosition.end,
              labelColor: Colors.white,
              minHeight: 24,
              borderRadius: BorderRadius.circular(12),
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

/// Examples of animated progress bars
class AnimatedProgressExamples extends StatefulWidget {
  /// Creates the animated progress examples widget.
  const AnimatedProgressExamples({super.key});

  @override
  State<AnimatedProgressExamples> createState() =>
      _AnimatedProgressExamplesState();
}

class _AnimatedProgressExamplesState extends State<AnimatedProgressExamples> {
  int _currentStep = 50;
  final int _maxSteps = 100;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Smooth Animation'),
          _buildExampleCard(
            'Default Animation (300ms)',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
              minHeight: 16,
              borderRadius: BorderRadius.circular(8),
              animateProgress: true,
            ),
          ),

          _buildSectionTitle('Slow Animation'),
          _buildExampleCard(
            'Slow Animation (1 second)',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressColor: Colors.green,
              backgroundColor: Colors.grey.shade300,
              minHeight: 16,
              borderRadius: BorderRadius.circular(8),
              animateProgress: true,
              animationDuration: const Duration(seconds: 1),
            ),
          ),

          _buildSectionTitle('Custom Animation Curve'),
          _buildExampleCard(
            'Bounce Out Curve',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressColor: Colors.orange,
              backgroundColor: Colors.grey.shade300,
              minHeight: 16,
              borderRadius: BorderRadius.circular(8),
              animateProgress: true,
              animationDuration: const Duration(milliseconds: 800),
              animationCurve: Curves.bounceOut,
            ),
          ),
          const SizedBox(height: 8),
          _buildExampleCard(
            'Elastic Out Curve',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressColor: Colors.purple,
              backgroundColor: Colors.grey.shade300,
              minHeight: 16,
              borderRadius: BorderRadius.circular(8),
              animateProgress: true,
              animationDuration: const Duration(milliseconds: 600),
              animationCurve: Curves.elasticOut,
            ),
          ),

          _buildSectionTitle('Animated Gradient'),
          _buildExampleCard(
            'Gradient with Animation',
            LinearProgressBar(
              maxSteps: _maxSteps,
              progressType: ProgressType.linear,
              currentStep: _currentStep,
              progressGradient: const LinearGradient(
                colors: [Colors.cyan, Colors.blue, Colors.purple],
              ),
              backgroundColor: Colors.grey.shade300,
              minHeight: 20,
              borderRadius: BorderRadius.circular(10),
              animateProgress: true,
              animationDuration: const Duration(milliseconds: 500),
            ),
          ),

          _buildSectionTitle('Animated Titled Progress'),
          _buildExampleCard(
            'Percentage with Animation',
            TitledProgressBar(
              maxSteps: _maxSteps,
              currentStep: _currentStep,
              progressColor: Colors.teal,
              backgroundColor: Colors.grey.shade300,
              labelType: LabelType.percentage,
              labelColor: Colors.white,
              labelFontWeight: FontWeight.bold,
              minHeight: 28,
              borderRadius: BorderRadius.circular(14),
              animateProgress: true,
              animationDuration: const Duration(milliseconds: 400),
            ),
          ),

          const SizedBox(height: 24),
          _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Test Animation: $_currentStep%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _currentStep = 0),
                  child: const Text('0%'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _currentStep = 25),
                  child: const Text('25%'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _currentStep = 50),
                  child: const Text('50%'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _currentStep = 75),
                  child: const Text('75%'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _currentStep = 100),
                  child: const Text('100%'),
                ),
              ],
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
