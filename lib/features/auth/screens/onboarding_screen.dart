import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingItem> _items = const [
    _OnboardingItem(
      emoji: '🌱',
      title: 'Track Your Baby\'s Growth',
      subtitle: 'Follow your little one\'s journey week by week with beautiful visuals, fruit comparisons, and detailed milestones.',
      gradient: [Color(0xFFFCE4EC), Color(0xFFF3E5F5)],
      accentColor: NitaraColors.pink,
      features: ['Weekly baby updates', 'Fruit size comparisons', 'Development milestones'],
    ),
    _OnboardingItem(
      emoji: '💚',
      title: 'Stay Healthy & Nourished',
      subtitle: 'Monitor your weight, hydration, sleep, and mood. Get personalized nutrition tips and safe food guides.',
      gradient: [Color(0xFFE8F5E9), Color(0xFFE0F7FA)],
      accentColor: Color(0xFF26A69A),
      features: ['Weight & water tracking', 'Mood check-ins', 'Trimester meal plans'],
    ),
    _OnboardingItem(
      emoji: '🌸',
      title: 'Prepare for a Joyful Birth',
      subtitle: 'Gentle yoga, breathing exercises, and emotional support guide you to a confident, healthy, and natural delivery.',
      gradient: [Color(0xFFFFF3E0), Color(0xFFFCE4EC)],
      accentColor: NitaraColors.peach,
      features: ['Safe prenatal yoga', 'Breathing exercises', 'Daily affirmations'],
    ),
  ];

  void _nextPage() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, i) => _OnboardingPage(item: _items[i]),
          ),

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(28, 20, 28, 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.nunito(
                        color: NitaraColors.textMedium,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  // Page indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _items.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: _items[_currentPage].accentColor,
                      dotColor: _items[_currentPage].accentColor.withOpacity(0.25),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                    ),
                  ),

                  // Next button
                  GestureDetector(
                    onTap: _nextPage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentPage == _items.length - 1 ? 120 : 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _items[_currentPage].accentColor,
                            _items[_currentPage].accentColor.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: _items[_currentPage].accentColor.withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _currentPage == _items.length - 1
                            ? Text(
                                'Start',
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              )
                            : const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingItem item;
  const _OnboardingPage({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: item.gradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Illustration circle
              Container(
                width: size.width * 0.65,
                height: size.width * 0.65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.accentColor.withOpacity(0.12),
                  border: Border.all(
                    color: item.accentColor.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    item.emoji,
                    style: TextStyle(fontSize: size.width * 0.22),
                  ),
                ),
              )
                  .animate()
                  .scale(
                    duration: 700.ms,
                    curve: Curves.elasticOut,
                    begin: const Offset(0.7, 0.7),
                  )
                  .fadeIn(duration: 500.ms),

              const SizedBox(height: 40),

              Text(
                item.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: NitaraColors.textDark,
                  height: 1.2,
                ),
              ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),

              const SizedBox(height: 16),

              Text(
                item.subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 15,
                  color: NitaraColors.textMedium,
                  height: 1.6,
                ),
              ).animate(delay: 300.ms).fadeIn(duration: 500.ms),

              const SizedBox(height: 32),

              // Feature pills
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: item.features
                    .asMap()
                    .entries
                    .map((e) => _FeaturePill(
                          label: e.value,
                          color: item.accentColor,
                        )
                            .animate(delay: Duration(milliseconds: 400 + e.key * 100))
                            .fadeIn(duration: 400.ms)
                            .slideX(begin: 0.2, end: 0))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturePill extends StatelessWidget {
  final String label;
  final Color color;
  const _FeaturePill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingItem {
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final Color accentColor;
  final List<String> features;

  const _OnboardingItem({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.accentColor,
    required this.features,
  });
}
