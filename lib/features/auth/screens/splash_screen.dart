import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    if (mounted) context.go('/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF0F5),
              Color(0xFFF3E5F5),
              Color(0xFFFFF0F5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo container
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [NitaraColors.pink, NitaraColors.lavender],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: NitaraColors.pink.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '🌸',
                  style: TextStyle(fontSize: 52),
                ),
              ),
            )
                .animate()
                .scale(
                  duration: 800.ms,
                  curve: Curves.elasticOut,
                  begin: const Offset(0.4, 0.4),
                  end: const Offset(1, 1),
                )
                .fadeIn(duration: 600.ms),

            const SizedBox(height: 28),

            // App name
            Text(
              'Nitara',
              style: GoogleFonts.nunito(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [NitaraColors.pink, NitaraColors.lavender],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              ),
            )
                .animate(delay: 400.ms)
                .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(duration: 600.ms),

            const SizedBox(height: 8),

            Text(
              'Your Beautiful Pregnancy Companion',
              style: GoogleFonts.nunito(
                fontSize: 15,
                color: NitaraColors.textMedium,
                fontWeight: FontWeight.w500,
              ),
            )
                .animate(delay: 700.ms)
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),

            const SizedBox(height: 60),

            // Loading indicator
            SizedBox(
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  backgroundColor: NitaraColors.pinkLight.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(NitaraColors.pink),
                  minHeight: 4,
                ),
              ),
            )
                .animate(delay: 1000.ms)
                .fadeIn(duration: 500.ms),
          ],
        ),
      ),
    );
  }
}
