import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../providers/yoga_provider.dart';
import '../models/exercise.dart';
import '../../../shared/widgets/nitara_card.dart';

class YogaScreen extends StatefulWidget {
  const YogaScreen({super.key});

  @override
  State<YogaScreen> createState() => _YogaScreenState();
}

class _YogaScreenState extends State<YogaScreen> {
  bool _safetyAccepted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSafetyDialog();
    });
  }

  void _showSafetyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Safety First!',
                style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        content: Text(
          '⚠️ Always consult your doctor or midwife before starting any exercise routine during pregnancy.\n\n'
          '🛑 Stop immediately if you feel:\n'
          '• Pain or discomfort\n'
          '• Dizziness or shortness of breath\n'
          '• Vaginal bleeding\n'
          '• Contractions\n\n'
          '✅ These exercises are designed for healthy pregnancies without complications.',
          style: GoogleFonts.nunito(fontSize: 13, color: NitaraColors.textMedium, height: 1.6),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() => _safetyAccepted = true);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: NitaraColors.pink,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('I Understand', style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  static const Map<YogaCategory, Map<String, dynamic>> _categoryMeta = {
    YogaCategory.breathing: {'label': 'Breathing', 'emoji': '🌬️', 'color': Color(0xFF80DEEA)},
    YogaCategory.stretching: {'label': 'Stretching', 'emoji': '🤸', 'color': Color(0xFFA5D6A7)},
    YogaCategory.pelvicFloor: {'label': 'Pelvic Floor', 'emoji': '💪', 'color': Color(0xFFFFAB91)},
    YogaCategory.prenatalYoga: {'label': 'Yoga', 'emoji': '🧘', 'color': Color(0xFFCE93D8)},
  };

  @override
  Widget build(BuildContext context) {
    final yogaProv = context.watch<YogaProvider>();
    final exercises = yogaProv.filteredExercises;
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
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yoga & Exercise',
                            style: GoogleFonts.nunito(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : NitaraColors.textDark,
                            ),
                          ),
                          Text(
                            '${yogaProv.currentTrimester.name.replaceAll('f', 'F').replaceAll('s', 'S').replaceAll('t', 'T')} Trimester',
                            style: GoogleFonts.nunito(fontSize: 14, color: NitaraColors.textLight),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _showSafetyDialog,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.warning_amber_rounded,
                              color: Colors.orange, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms),
            ),

            const SizedBox(height: 16),

            // Category filter
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // All
                  _CategoryChip(
                    label: 'All',
                    emoji: '✨',
                    color: NitaraColors.pink,
                    isSelected: yogaProv.selectedCategory == null,
                    onTap: () => yogaProv.setCategory(null),
                  ),
                  ...YogaCategory.values.map((cat) {
                    final meta = _categoryMeta[cat]!;
                    return _CategoryChip(
                      label: meta['label'],
                      emoji: meta['emoji'],
                      color: meta['color'],
                      isSelected: yogaProv.selectedCategory == cat,
                      onTap: () => yogaProv.setCategory(cat),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Exercise count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${exercises.length} exercises available',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: NitaraColors.textLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Exercise list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                itemCount: exercises.length,
                itemBuilder: (_, i) {
                  final e = exercises[i];
                  final meta = _categoryMeta[e.category]!;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => _showExerciseDetail(context, e, meta),
                      child: NitaraCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: (meta['color'] as Color).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(e.emoji,
                                    style: const TextStyle(fontSize: 26)),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name,
                                    style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: isDark ? Colors.white : NitaraColors.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    e.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      color: NitaraColors.textLight,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      _Tag(e.duration, NitaraColors.pink),
                                      const SizedBox(width: 6),
                                      _Tag(e.difficulty, meta['color']),
                                      const SizedBox(width: 6),
                                      _Tag(meta['label'], meta['color']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded,
                                color: NitaraColors.textLight),
                          ],
                        ),
                      ),
                    ).animate(delay: Duration(milliseconds: i * 60)).fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExerciseDetail(
      BuildContext context, Exercise e, Map<String, dynamic> meta) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ExerciseSheet(exercise: e, meta: meta),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label, emoji;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.emoji,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [color, color.withOpacity(0.7)])
              : null,
          color: isSelected ? null : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? null : Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: TextStyle(fontSize: isSelected ? 20 : 18)),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag(this.label, this.color);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      );
}

class _ExerciseSheet extends StatelessWidget {
  final Exercise exercise;
  final Map<String, dynamic> meta;
  const _ExerciseSheet({required this.exercise, required this.meta});

  @override
  Widget build(BuildContext context) {
    final color = meta['color'] as Color;
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: NitaraColors.textLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(exercise.emoji,
                              style: const TextStyle(fontSize: 36)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(exercise.name,
                                style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: NitaraColors.textDark)),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              children: [
                                _SheetTag(exercise.duration, NitaraColors.pink),
                                _SheetTag(exercise.difficulty, color),
                                _SheetTag(meta['label'], color),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(exercise.description,
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: NitaraColors.textMedium,
                          height: 1.6)),

                  const SizedBox(height: 20),

                  // Benefits
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('✨', style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(exercise.benefits,
                              style: GoogleFonts.nunito(
                                  fontSize: 13,
                                  color: color,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Step-by-Step Instructions',
                    style: GoogleFonts.nunito(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: NitaraColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...exercise.steps.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color, color.withOpacity(0.7)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: GoogleFonts.nunito(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                entry.value,
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: NitaraColors.textMedium,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetTag extends StatelessWidget {
  final String label;
  final Color color;
  const _SheetTag(this.label, this.color);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label,
            style: GoogleFonts.nunito(
                fontSize: 11, fontWeight: FontWeight.w700, color: color)),
      );
}
