import 'package:rmsnewmodule/auth/loginpage.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  static const _slides = [
    _Slide(
      image: 'assets/1.jpg',
      title: 'Digital Anxiety Assessment',
      content: 'Measure dental anxiety in children using validated, AI-powered digital scales.',
    ),
    _Slide(
      image: 'assets/1.jpg',
      title: 'Multiple Proven Scales',
      content: 'RMS-DAS, RMS-DCDAS and RMS-PCDAS — all in one easy-to-use application.',
    ),
    _Slide(
      image: 'assets/1.jpg',
      title: 'Track Patient Progress',
      content: 'Store records, compare results, and monitor improvement across multiple sessions.',
    ),
  ];

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

  void _goToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _goToLogin,
                child: const Text('Skip'),
              ),
            ),
            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentIndex = i),
                itemCount: _slides.length,
                itemBuilder: (_, i) => _SlidePage(slide: _slides[i]),
              ),
            ),
            // Indicators + action
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (i) => _Indicator(active: i == _currentIndex),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _currentIndex == _slides.length - 1
                      ? AppButton(
                          label: 'Get Started',
                          onTap: _goToLogin,
                        )
                      : AppButton(
                          label: 'Next',
                          onTap: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slide {
  final String image;
  final String title;
  final String content;
  const _Slide({required this.image, required this.title, required this.content});
}

class _SlidePage extends StatelessWidget {
  final _Slide slide;
  const _SlidePage({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Image.asset(
              slide.image,
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 36),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading2.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          Text(
            slide.content,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final bool active;
  const _Indicator({required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      height: 6,
      width: active ? 28 : 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.border,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
    );
  }
}
