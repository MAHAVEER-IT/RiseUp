import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: [
          _buildWelcomePage(),
          _buildSchedulePage(),
          _buildGoalsPage(),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: _currentPage > 0
                  ? () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )
                  : null,
              child: const Text('Back'),
            ),
            Text('${_currentPage + 1}/3'),
            ElevatedButton(
              onPressed: _currentPage < 2
                  ? () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )
                  : null,
              child: Text(_currentPage == 2 ? 'Get Started' : 'Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wb_sunny, size: 80, color: Color(0xFF88A992)),
            SizedBox(height: 24),
            Text(
              'Hi. I\'m RiseUp.',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Text(
              'I\'m here to help you grow, at your own pace.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Color(0xFF979B9A)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchedulePage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'When do you usually start and end your day?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Wake Up:'),
                        Text(
                          '6:00 AM',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Sleep:'),
                        Text(
                          '11:00 PM',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What\'s the one thing you want to feel more confident about?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _GoalCard(label: '📚 English Speaking'),
            _GoalCard(label: '💻 Tech Skills (DSA)'),
            _GoalCard(label: '🎯 Discipline'),
          ],
        ),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final String label;

  const _GoalCard({required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(label),
        trailing: Icon(
          Icons.check_circle_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () {},
      ),
    );
  }
}
