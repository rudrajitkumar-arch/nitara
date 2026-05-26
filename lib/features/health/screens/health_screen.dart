import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/colors.dart';
import '../providers/health_provider.dart';
import '../../../shared/widgets/nitara_card.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? NitaraColors.backgroundDark : NitaraColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Health Tracker',
                    style: GoogleFonts.nunito(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : NitaraColors.textDark,
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
                  Text(
                    'Track your daily wellness',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: NitaraColors.textLight,
                    ),
                  ).animate(delay: 100.ms).fadeIn(duration: 400.ms),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Tab bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: isDark ? NitaraColors.surfaceDark : NitaraColors.pinkPastel,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: NitaraColors.textMedium,
                  indicator: BoxDecoration(
                    gradient: NitaraColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: const [
                    Tab(text: 'Water'),
                    Tab(text: 'Weight'),
                    Tab(text: 'Sleep'),
                    Tab(text: 'Mood'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _WaterTab(),
                  _WeightTab(),
                  _SleepTab(),
                  _MoodTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Water Tab ──────────────────────────────────────────────────────────────
class _WaterTab extends StatelessWidget {
  const _WaterTab();

  @override
  Widget build(BuildContext context) {
    final health = context.watch<HealthProvider>();
    final glasses = health.todayWaterGlasses;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          NitaraCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: NitaraColors.waterColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.water_drop_rounded,
                          color: NitaraColors.waterColor),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Water Intake',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: NitaraColors.textDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Big counter
                Text(
                  '$glasses',
                  style: GoogleFonts.nunito(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: NitaraColors.waterColor,
                    height: 1,
                  ),
                ),
                Text(
                  'of 8 glasses today',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: NitaraColors.textLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                // Glass row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    8,
                    (i) => GestureDetector(
                      onTap: () {
                        final newGlasses = i < glasses ? i : i + 1;
                        context.read<HealthProvider>().logWater(newGlasses);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          color: i < glasses
                              ? NitaraColors.waterColor
                              : NitaraColors.waterColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '💧',
                            style: TextStyle(
                              fontSize: i < glasses ? 16 : 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: glasses > 0
                            ? () => context.read<HealthProvider>().logWater(glasses - 1)
                            : null,
                        icon: const Icon(Icons.remove, size: 18),
                        label: const Text('Remove'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.15),
                          foregroundColor: NitaraColors.textMedium,
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: glasses < 8
                            ? () => context.read<HealthProvider>().logWater(glasses + 1)
                            : null,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add Glass'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: NitaraColors.waterColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),

          NitaraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 Why Hydration Matters',
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: NitaraColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'During pregnancy, your blood volume increases by 50%. Staying hydrated helps prevent urinary tract infections, constipation, and preterm labor. Aim for 8-10 glasses daily.',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: NitaraColors.textMedium,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ─── Weight Tab ─────────────────────────────────────────────────────────────
class _WeightTab extends StatefulWidget {
  const _WeightTab();

  @override
  State<_WeightTab> createState() => _WeightTabState();
}

class _WeightTabState extends State<_WeightTab> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _logWeight() {
    final val = double.tryParse(_ctrl.text);
    if (val != null && val > 0) {
      context.read<HealthProvider>().logWeight(val);
      _ctrl.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final health = context.watch<HealthProvider>();
    final entries = health.getLastNEntries(7).where((e) => e.weight > 0).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Log weight
          NitaraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: NitaraColors.weightColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.monitor_weight_rounded,
                          color: NitaraColors.weightColor),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Log Weight',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: NitaraColors.textDark,
                      ),
                    ),
                    const Spacer(),
                    if (health.latestWeight > 0)
                      Text(
                        '${health.latestWeight.toStringAsFixed(1)} kg',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: NitaraColors.weightColor,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: NitaraColors.textDark,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter weight in kg',
                          hintStyle: GoogleFonts.nunito(
                              color: NitaraColors.textLight, fontSize: 14),
                          suffixText: 'kg',
                          suffixStyle: GoogleFonts.nunito(
                              color: NitaraColors.textLight, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _logWeight,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NitaraColors.weightColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      child: const Icon(Icons.check_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // Chart
          if (entries.isNotEmpty)
            NitaraCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weight History',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: NitaraColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 180,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (v) => FlLine(
                            color: NitaraColors.pink.withOpacity(0.1),
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (v, m) => Text(
                                v.toStringAsFixed(0),
                                style: GoogleFonts.nunito(
                                    fontSize: 10, color: NitaraColors.textLight),
                              ),
                            ),
                          ),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: entries.asMap().entries.map((e) =>
                                FlSpot(e.key.toDouble(), e.value.weight)).toList(),
                            isCurved: true,
                            gradient: const LinearGradient(
                              colors: [NitaraColors.weightColor, NitaraColors.lavender],
                            ),
                            barWidth: 3,
                            dotData: FlDotData(
                              getDotPainter: (s, x, b, i) => FlDotCirclePainter(
                                radius: 4,
                                color: Colors.white,
                                strokeWidth: 2,
                                strokeColor: NitaraColors.weightColor,
                              ),
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  NitaraColors.weightColor.withOpacity(0.15),
                                  NitaraColors.weightColor.withOpacity(0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ─── Sleep Tab ───────────────────────────────────────────────────────────────
class _SleepTab extends StatefulWidget {
  const _SleepTab();

  @override
  State<_SleepTab> createState() => _SleepTabState();
}

class _SleepTabState extends State<_SleepTab> {
  double _hours = 7;

  @override
  Widget build(BuildContext context) {
    final health = context.watch<HealthProvider>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          NitaraCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: NitaraColors.sleepColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.bedtime_rounded,
                          color: NitaraColors.sleepColor),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Sleep Tracker',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: NitaraColors.textDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  '${_hours.toStringAsFixed(1)} hrs',
                  style: GoogleFonts.nunito(
                    fontSize: 56,
                    fontWeight: FontWeight.w900,
                    color: NitaraColors.sleepColor,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  health.lastSleepHours > 0
                      ? 'Last logged: ${health.lastSleepHours.toStringAsFixed(1)} hrs'
                      : 'Not logged today',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: NitaraColors.textLight,
                  ),
                ),
                const SizedBox(height: 20),
                Slider(
                  value: _hours,
                  min: 0,
                  max: 12,
                  divisions: 24,
                  activeColor: NitaraColors.sleepColor,
                  inactiveColor: NitaraColors.sleepColor.withOpacity(0.15),
                  onChanged: (v) => setState(() => _hours = v),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0 hrs', style: GoogleFonts.nunito(fontSize: 11, color: NitaraColors.textLight)),
                    Text('12 hrs', style: GoogleFonts.nunito(fontSize: 11, color: NitaraColors.textLight)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<HealthProvider>().logSleep(_hours);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sleep logged: ${_hours.toStringAsFixed(1)} hrs 😴'),
                          backgroundColor: NitaraColors.sleepColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NitaraColors.sleepColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Log Sleep'),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          NitaraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('😴 Sleep Tips for Mama',
                    style: GoogleFonts.nunito(
                        fontSize: 15, fontWeight: FontWeight.w700, color: NitaraColors.textDark)),
                const SizedBox(height: 12),
                for (final tip in [
                  'Sleep on your left side to improve blood flow to baby',
                  'Use a pregnancy pillow for extra support',
                  'Keep the room cool and dark',
                  'Avoid screens 30 minutes before bed',
                  'Aim for 8-10 hours of sleep during pregnancy',
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🌙', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(tip,
                              style: GoogleFonts.nunito(
                                  fontSize: 13, color: NitaraColors.textMedium, height: 1.4)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ─── Mood Tab ────────────────────────────────────────────────────────────────
class _MoodTab extends StatelessWidget {
  const _MoodTab();

  @override
  Widget build(BuildContext context) {
    final health = context.watch<HealthProvider>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          NitaraCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: NitaraColors.moodColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.emoji_emotions_rounded,
                          color: NitaraColors.moodColor),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'How are you feeling?',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: NitaraColors.textDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  HealthProvider.moodEmojis[health.todayMoodIndex],
                  style: const TextStyle(fontSize: 64),
                ),
                const SizedBox(height: 8),
                Text(
                  HealthProvider.moodLabels[health.todayMoodIndex],
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: NitaraColors.moodColor,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: HealthProvider.moodEmojis.asMap().entries.map((e) {
                    final isSelected = e.key == health.todayMoodIndex;
                    return GestureDetector(
                      onTap: () => context.read<HealthProvider>().logMood(e.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? NitaraColors.moodColor.withOpacity(0.15)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: NitaraColors.moodColor, width: 2)
                              : null,
                        ),
                        child: Center(
                          child: Text(e.value,
                              style: TextStyle(fontSize: isSelected ? 30 : 24)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          NitaraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💕 Emotional Wellness Tips',
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: NitaraColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                for (final tip in [
                  'Mood changes during pregnancy are completely normal',
                  'Share your feelings with your partner or a trusted friend',
                  'Consider joining a prenatal support group',
                  'Practice mindfulness and gratitude daily',
                  'Seek help if you feel consistently sad or anxious',
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🌸', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(tip,
                              style: GoogleFonts.nunito(
                                  fontSize: 13, color: NitaraColors.textMedium, height: 1.4)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
