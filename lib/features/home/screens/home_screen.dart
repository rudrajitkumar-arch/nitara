import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/colors.dart';
import '../../auth/providers/auth_provider.dart';
import '../../baby_growth/providers/baby_provider.dart';
import '../../health/providers/health_provider.dart';
import '../../../shared/widgets/nitara_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final baby = context.watch<BabyProvider>();
    final health = context.watch<HealthProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? NitaraColors.backgroundDark : NitaraColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [NitaraColors.cardDark, NitaraColors.backgroundDark]
                      : [const Color(0xFFFFF0F5), NitaraColors.background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_greeting,',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: NitaraColors.textLight,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                auth.userName,
                                style: GoogleFonts.nunito(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : NitaraColors.textDark,
                                ),
                              ),
                            ],
                          ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1, end: 0),

                          // Profile avatar
                          GestureDetector(
                            onTap: () => context.go('/profile'),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: NitaraColors.primaryGradient,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: NitaraColors.pink.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  auth.userName.isNotEmpty
                                      ? auth.userName[0].toUpperCase()
                                      : 'M',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ).animate(delay: 100.ms).fadeIn(duration: 500.ms).scale(),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Week + days card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: NitaraColors.babyGradient,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: NitaraColors.pink.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            // Big week number
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Week',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${baby.currentWeek}',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w900,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  baby.trimesterLabel,
                                  style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            // Right side
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Fruit emoji
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      baby.currentWeekData.fruitEmoji,
                                      style: const TextStyle(fontSize: 38),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${baby.daysRemaining} days to go',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Due: ${DateFormat('MMM dd, yyyy').format(baby.dueDate)}',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                          .animate(delay: 200.ms)
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.2, end: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quick health stats
                const NitaraSectionHeader(title: 'Today\'s Health'),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children: [
                    NitaraStatTile(
                      label: 'Water',
                      value: '${health.todayWaterGlasses}',
                      unit: '/ 8 glasses',
                      icon: Icons.water_drop_rounded,
                      color: NitaraColors.waterColor,
                      onTap: () => context.go('/health'),
                    ),
                    NitaraStatTile(
                      label: 'Weight',
                      value: health.latestWeight > 0
                          ? health.latestWeight.toStringAsFixed(1)
                          : '--',
                      unit: 'kg',
                      icon: Icons.monitor_weight_rounded,
                      color: NitaraColors.weightColor,
                      onTap: () => context.go('/health'),
                    ),
                    NitaraStatTile(
                      label: 'Sleep',
                      value: health.lastSleepHours > 0
                          ? health.lastSleepHours.toStringAsFixed(1)
                          : '--',
                      unit: 'hrs',
                      icon: Icons.bedtime_rounded,
                      color: NitaraColors.sleepColor,
                      onTap: () => context.go('/health'),
                    ),
                    NitaraStatTile(
                      label: 'Mood',
                      value: health.todayMoodEmoji,
                      unit: '',
                      icon: Icons.emoji_emotions_rounded,
                      color: NitaraColors.moodColor,
                      onTap: () => context.go('/health'),
                    ),
                  ],
                ).animate(delay: 300.ms).fadeIn(duration: 600.ms),

                const SizedBox(height: 24),

                // Baby this week
                const NitaraSectionHeader(title: 'Baby This Week', actionLabel: 'See All'),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => context.go('/baby'),
                  child: NitaraCard(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            gradient: NitaraColors.babyGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              baby.currentWeekData.fruitEmoji,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Size of a ${baby.currentWeekData.fruitName}',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? Colors.white : NitaraColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${baby.currentWeekData.weightFormatted} · ${baby.currentWeekData.lengthFormatted}',
                                style: GoogleFonts.nunito(
                                  fontSize: 13,
                                  color: NitaraColors.textLight,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                baby.currentWeekData.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  color: NitaraColors.textMedium,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: NitaraColors.textLight),
                      ],
                    ),
                  ),
                ).animate(delay: 400.ms).fadeIn(duration: 600.ms),

                const SizedBox(height: 24),

                // Quick nav grid
                const NitaraSectionHeader(title: 'Quick Access'),
                const SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                  children: [
                    _QuickNavCard(
                      emoji: '🥗',
                      label: 'Nutrition',
                      gradient: NitaraColors.nutritionGradient,
                      onTap: () => context.go('/nutrition'),
                    ),
                    _QuickNavCard(
                      emoji: '🧘',
                      label: 'Yoga',
                      gradient: NitaraColors.yogaGradient,
                      onTap: () => context.go('/yoga'),
                    ),
                    _QuickNavCard(
                      emoji: '🔔',
                      label: 'Reminders',
                      gradient: NitaraColors.primaryGradient,
                      onTap: () => context.go('/reminders'),
                    ),
                    _QuickNavCard(
                      emoji: '💆',
                      label: 'Self Care',
                      gradient: NitaraColors.emotionalGradient,
                      onTap: () => context.go('/emotional'),
                    ),
                    _QuickNavCard(
                      emoji: '👤',
                      label: 'Profile',
                      gradient: NitaraColors.healthGradient,
                      onTap: () => context.go('/profile'),
                    ),
                    _QuickNavCard(
                      emoji: '❤️',
                      label: 'Health',
                      gradient: NitaraColors.babyGradient,
                      onTap: () => context.go('/health'),
                    ),
                  ],
                ).animate(delay: 500.ms).fadeIn(duration: 600.ms),

                const SizedBox(height: 24),

                // Daily tip
                _DailyTipCard(week: baby.currentWeek),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickNavCard extends StatelessWidget {
  final String emoji, label;
  final Gradient gradient;
  final VoidCallback onTap;

  const _QuickNavCard({
    required this.emoji,
    required this.label,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyTipCard extends StatelessWidget {
  final int week;
  const _DailyTipCard({required this.week});

  static final List<String> _tips = [
    'Stay hydrated! Drink at least 8 glasses of water today. 💧',
    'Take a 20-minute walk today — gentle movement helps circulation and mood! 🚶‍♀️',
    'Practice deep belly breathing for 5 minutes to help with relaxation. 🧘',
    'Call or message your doctor if you have any unusual symptoms. 👩‍⚕️',
    'Get plenty of iron-rich foods today — spinach, lentils, and fortified cereals. 🌿',
    'Rest when you need to. Your body is doing incredible work! 😴',
    'Talk to your baby today — they can hear you and recognize your voice! 💬',
    'Do your pelvic floor exercises today — 3 sets of 10 Kegel exercises! 💪',
    'Eat small, frequent meals to manage nausea and heartburn. 🥗',
    'Take your prenatal vitamins if you haven\'t yet today! 💊',
  ];

  @override
  Widget build(BuildContext context) {
    final tip = _tips[week % _tips.length];
    return NitaraCard(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFCE4EC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('💡', style: TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Tip',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: NitaraColors.peach,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: NitaraColors.textDark,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: 600.ms).fadeIn(duration: 600.ms);
  }
}
