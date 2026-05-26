import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../providers/baby_provider.dart';
import '../models/baby_data.dart';
import '../../../shared/widgets/nitara_card.dart';

class BabyGrowthScreen extends StatefulWidget {
  const BabyGrowthScreen({super.key});

  @override
  State<BabyGrowthScreen> createState() => _BabyGrowthScreenState();
}

class _BabyGrowthScreenState extends State<BabyGrowthScreen> {
  late int _selectedWeek;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedWeek = context.read<BabyProvider>().currentWeek;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final babyProv = context.watch<BabyProvider>();
    final data = babyProv.weekData(_selectedWeek);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? NitaraColors.backgroundDark : NitaraColors.background,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: isDark ? NitaraColors.backgroundDark : NitaraColors.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      NitaraColors.pink.withOpacity(0.15),
                      NitaraColors.lavender.withOpacity(0.08),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      // Fruit illustration
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: NitaraColors.babyGradient,
                          boxShadow: [
                            BoxShadow(
                              color: NitaraColors.pink.withOpacity(0.3),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(data.fruitEmoji,
                              style: const TextStyle(fontSize: 60)),
                        ),
                      ).animate(key: ValueKey(_selectedWeek))
                          .scale(duration: 400.ms, curve: Curves.elasticOut,
                              begin: const Offset(0.7, 0.7))
                          .fadeIn(duration: 300.ms),

                      const SizedBox(height: 12),

                      Text(
                        'Week $_selectedWeek',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: NitaraColors.textLight,
                          letterSpacing: 1,
                        ),
                      ),

                      Text(
                        'Size of a ${data.fruitName}',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: NitaraColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Baby Growth',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: NitaraColors.textDark,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Week selector
                _WeekSelector(
                  selectedWeek: _selectedWeek,
                  currentWeek: babyProv.currentWeek,
                  onSelect: (w) => setState(() => _selectedWeek = w),
                ),

                const SizedBox(height: 24),

                // Stats row
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: '⚖️',
                        label: 'Weight',
                        value: data.weightFormatted,
                        color: NitaraColors.babyColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: '📏',
                        label: 'Length',
                        value: data.lengthFormatted,
                        color: NitaraColors.lavender,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: '❤️',
                        label: 'Heartbeat',
                        value: data.heartbeat.split(' ').first,
                        unit: 'bpm',
                        color: NitaraColors.pink,
                      ),
                    ),
                  ],
                ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: 24),

                // Description
                NitaraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: NitaraColors.babyColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.child_care_rounded,
                                color: NitaraColors.babyColor, size: 18),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'This Week',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: NitaraColors.textDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data.description,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: NitaraColors.textMedium,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 200.ms).fadeIn(duration: 500.ms),

                const SizedBox(height: 20),

                // Milestones
                NitaraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: NitaraColors.lavender.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.star_rounded,
                                color: NitaraColors.lavender, size: 18),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Milestones',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: NitaraColors.textDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...data.milestones.asMap().entries.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: NitaraColors.babyGradient,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  e.value,
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: NitaraColors.textMedium,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 300.ms).fadeIn(duration: 500.ms),

                const SizedBox(height: 20),

                // Trimester progress
                NitaraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pregnancy Progress',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: NitaraColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _TrimesterBar(
                        label: '1st Trimester (Wk 1-13)',
                        progress: _selectedWeek <= 13
                            ? _selectedWeek / 13
                            : 1.0,
                        color: NitaraColors.pink,
                      ),
                      const SizedBox(height: 10),
                      _TrimesterBar(
                        label: '2nd Trimester (Wk 14-26)',
                        progress: _selectedWeek < 14
                            ? 0
                            : _selectedWeek <= 26
                                ? (_selectedWeek - 13) / 13
                                : 1.0,
                        color: NitaraColors.lavender,
                      ),
                      const SizedBox(height: 10),
                      _TrimesterBar(
                        label: '3rd Trimester (Wk 27-40)',
                        progress: _selectedWeek < 27
                            ? 0
                            : (_selectedWeek - 26) / 14,
                        color: NitaraColors.peach,
                      ),
                    ],
                  ),
                ).animate(delay: 400.ms).fadeIn(duration: 500.ms),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Week Selector ─────────────────────────────────────────────────────────────
class _WeekSelector extends StatefulWidget {
  final int selectedWeek;
  final int currentWeek;
  final void Function(int) onSelect;
  const _WeekSelector({
    required this.selectedWeek,
    required this.currentWeek,
    required this.onSelect,
  });

  @override
  State<_WeekSelector> createState() => _WeekSelectorState();
}

class _WeekSelectorState extends State<_WeekSelector> {
  final _ctrl = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_ctrl.hasClients) {
        _ctrl.animateTo(
          (widget.selectedWeek - 1) * 56.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NitaraSectionHeader(title: 'Select Week'),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: ListView.builder(
            controller: _ctrl,
            scrollDirection: Axis.horizontal,
            itemCount: 40,
            itemBuilder: (_, i) {
              final week = i + 1;
              final isSelected = week == widget.selectedWeek;
              final isCurrent = week == widget.currentWeek;
              return GestureDetector(
                onTap: () => widget.onSelect(week),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 46,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected ? NitaraColors.babyGradient : null,
                    color: isSelected ? null : NitaraColors.pink.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: isCurrent && !isSelected
                        ? Border.all(color: NitaraColors.pink, width: 2)
                        : null,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$week',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? Colors.white
                                : NitaraColors.textMedium,
                          ),
                        ),
                        if (isCurrent)
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? Colors.white
                                  : NitaraColors.pink,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon, label, value;
  final String? unit;
  final Color color;
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? NitaraColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          if (unit != null)
            Text(unit!, style: GoogleFonts.nunito(fontSize: 10, color: NitaraColors.textLight)),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 11,
              color: NitaraColors.textLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrimesterBar extends StatelessWidget {
  final String label;
  final double progress;
  final Color color;
  const _TrimesterBar(
      {required this.label, required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: GoogleFonts.nunito(
                    fontSize: 12, color: NitaraColors.textLight, fontWeight: FontWeight.w600)),
            Text('${(progress * 100).toStringAsFixed(0)}%',
                style: GoogleFonts.nunito(
                    fontSize: 12, color: color, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: color.withOpacity(0.12),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
