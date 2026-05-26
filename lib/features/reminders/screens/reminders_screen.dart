import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/colors.dart';
import '../providers/reminder_provider.dart';
import '../../../shared/widgets/nitara_card.dart';
import '../../../shared/widgets/gradient_button.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  static const Map<ReminderType, Map<String, dynamic>> _typeMeta = {
    ReminderType.medicine: {'emoji': '💊', 'label': 'Medicine', 'color': Color(0xFFEC407A)},
    ReminderType.doctor: {'emoji': '👩‍⚕️', 'label': 'Doctor', 'color': Color(0xFF42A5F5)},
    ReminderType.water: {'emoji': '💧', 'label': 'Water', 'color': Color(0xFF26C6DA)},
    ReminderType.tip: {'emoji': '💡', 'label': 'Daily Tip', 'color': Color(0xFFFFCA28)},
    ReminderType.custom: {'emoji': '🔔', 'label': 'Custom', 'color': Color(0xFFAB47BC)},
  };

  @override
  Widget build(BuildContext context) {
    final reminderProv = context.watch<ReminderProvider>();
    final reminders = reminderProv.reminders;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? NitaraColors.backgroundDark : NitaraColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddReminderSheet(context),
        backgroundColor: NitaraColors.pink,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: Text('Add Reminder',
            style: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 14)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reminders',
                    style: GoogleFonts.nunito(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : NitaraColors.textDark,
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  Text(
                    '${reminderProv.activeReminders.length} active reminders',
                    style: GoogleFonts.nunito(fontSize: 14, color: NitaraColors.textLight),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (reminders.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🔔', style: TextStyle(fontSize: 64)),
                      const SizedBox(height: 16),
                      Text(
                        'No reminders yet',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: NitaraColors.textMedium,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add your first reminder to stay\non track during your pregnancy!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: NitaraColors.textLight,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                  itemCount: reminders.length,
                  itemBuilder: (_, i) {
                    final r = reminders[i];
                    final meta = _typeMeta[r.type]!;
                    final color = meta['color'] as Color;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Dismissible(
                        key: Key(r.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete_outline_rounded,
                              color: Colors.redAccent, size: 28),
                        ),
                        onDismissed: (_) => reminderProv.deleteReminder(r.id),
                        child: NitaraCard(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: r.isActive
                                      ? color.withOpacity(0.15)
                                      : Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Text(meta['emoji'],
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: r.isActive ? null : Colors.grey)),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      r.title,
                                      style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: r.isActive
                                            ? (isDark ? Colors.white : NitaraColors.textDark)
                                            : NitaraColors.textLight,
                                        decoration: r.isActive
                                            ? null
                                            : TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time_rounded,
                                            size: 12, color: color),
                                        const SizedBox(width: 4),
                                        Text(
                                          r.time.format(context),
                                          style: GoogleFonts.nunito(
                                            fontSize: 13,
                                            color: color,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        if (r.isDaily)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: color.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text('Daily',
                                                style: GoogleFonts.nunito(
                                                    fontSize: 10,
                                                    color: color,
                                                    fontWeight: FontWeight.w700)),
                                          ),
                                      ],
                                    ),
                                    if (r.description != null && r.description!.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          r.description!,
                                          style: GoogleFonts.nunito(
                                            fontSize: 12,
                                            color: NitaraColors.textLight,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Switch.adaptive(
                                value: r.isActive,
                                activeColor: color,
                                onChanged: (_) => reminderProv.toggleReminder(r.id),
                              ),
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

  void _showAddReminderSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _AddReminderSheet(),
    );
  }
}

class _AddReminderSheet extends StatefulWidget {
  const _AddReminderSheet();

  @override
  State<_AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<_AddReminderSheet> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  ReminderType _type = ReminderType.medicine;
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  bool _isDaily = true;

  static const Map<ReminderType, Map<String, dynamic>> _typeMeta = {
    ReminderType.medicine: {'emoji': '💊', 'label': 'Medicine', 'color': Color(0xFFEC407A)},
    ReminderType.doctor: {'emoji': '👩‍⚕️', 'label': 'Doctor', 'color': Color(0xFF42A5F5)},
    ReminderType.water: {'emoji': '💧', 'label': 'Water', 'color': Color(0xFF26C6DA)},
    ReminderType.tip: {'emoji': '💡', 'label': 'Daily Tip', 'color': Color(0xFFFFCA28)},
    ReminderType.custom: {'emoji': '🔔', 'label': 'Custom', 'color': Color(0xFFAB47BC)},
  };

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: NitaraColors.textLight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text('Add Reminder',
                  style: GoogleFonts.nunito(
                      fontSize: 22, fontWeight: FontWeight.w800, color: NitaraColors.textDark)),

              const SizedBox(height: 20),

              // Type selector
              Text('Type', style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w700, color: NitaraColors.textMedium)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ReminderType.values.map((t) {
                  final meta = _typeMeta[t]!;
                  final isSelected = t == _type;
                  final color = meta['color'] as Color;
                  return GestureDetector(
                    onTap: () => setState(() => _type = t),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? color : color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected ? null : Border.all(color: color.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(meta['emoji'], style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(meta['label'],
                              style: GoogleFonts.nunito(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? Colors.white : color)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Title
              Text('Title', style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w700, color: NitaraColors.textMedium)),
              const SizedBox(height: 8),
              TextField(
                controller: _titleCtrl,
                style: GoogleFonts.nunito(color: NitaraColors.textDark, fontSize: 15, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: 'e.g. Take prenatal vitamin',
                  hintStyle: GoogleFonts.nunito(color: NitaraColors.textLight, fontSize: 14),
                ),
              ),

              const SizedBox(height: 16),

              // Description
              Text('Description (optional)', style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w700, color: NitaraColors.textMedium)),
              const SizedBox(height: 8),
              TextField(
                controller: _descCtrl,
                style: GoogleFonts.nunito(color: NitaraColors.textDark, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'e.g. With food',
                  hintStyle: GoogleFonts.nunito(color: NitaraColors.textLight, fontSize: 13),
                ),
              ),

              const SizedBox(height: 16),

              // Time picker
              Text('Time', style: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w700, color: NitaraColors.textMedium)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _time,
                    builder: (ctx, child) => Theme(
                      data: Theme.of(ctx).copyWith(
                        colorScheme: const ColorScheme.light(primary: NitaraColors.pink),
                      ),
                      child: child!,
                    ),
                  );
                  if (picked != null) setState(() => _time = picked);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: NitaraColors.pinkPastel,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: NitaraColors.pinkLight.withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time_rounded, color: NitaraColors.pink),
                      const SizedBox(width: 12),
                      Text(
                        _time.format(context),
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: NitaraColors.pink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Daily toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Repeat Daily',
                      style: GoogleFonts.nunito(
                          fontSize: 15, fontWeight: FontWeight.w700, color: NitaraColors.textDark)),
                  Switch.adaptive(
                    value: _isDaily,
                    activeColor: NitaraColors.pink,
                    onChanged: (v) => setState(() => _isDaily = v),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              GradientButton(
                label: 'Save Reminder',
                onPressed: () {
                  if (_titleCtrl.text.trim().isEmpty) return;
                  context.read<ReminderProvider>().addReminder(
                    title: _titleCtrl.text.trim(),
                    description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
                    type: _type,
                    time: _time,
                    isDaily: _isDaily,
                  );
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
