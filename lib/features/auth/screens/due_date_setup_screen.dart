import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/colors.dart';
import '../providers/auth_provider.dart';
import '../../../shared/widgets/gradient_button.dart';

class DueDateSetupScreen extends StatefulWidget {
  const DueDateSetupScreen({super.key});

  @override
  State<DueDateSetupScreen> createState() => _DueDateSetupScreenState();
}

class _DueDateSetupScreenState extends State<DueDateSetupScreen> {
  DateTime? _selectedLmp;
  final _partnerCtrl = TextEditingController();
  final _doctorCtrl = TextEditingController();
  int _step = 0;

  @override
  void dispose() {
    _partnerCtrl.dispose();
    _doctorCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.subtract(const Duration(days: 60)),
      firstDate: now.subtract(const Duration(days: 280)),
      lastDate: now,
      helpText: 'Select your LMP date',
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: NitaraColors.pink,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedLmp = picked);
  }

  Future<void> _save() async {
    if (_selectedLmp == null) return;
    final auth = context.read<AuthProvider>();
    final success = await auth.savePregnancyProfile(
      lmpDate: _selectedLmp!,
      partnerName: _partnerCtrl.text.trim(),
      doctorName: _doctorCtrl.text.trim(),
    );
    if (!mounted) return;
    if (success) context.go('/home');
  }

  Widget _buildStep0() {
    final dueDate = _selectedLmp?.add(const Duration(days: 280));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'When did your last period start?',
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: NitaraColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This helps us calculate your pregnancy week and due date accurately.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: NitaraColors.textMedium,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Date picker card
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _selectedLmp != null
                    ? NitaraColors.pink
                    : NitaraColors.pinkLight.withOpacity(0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: NitaraColors.pink.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: NitaraColors.pinkPastel,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.calendar_month_rounded,
                      color: NitaraColors.pink),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Menstrual Period (LMP)',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: NitaraColors.textLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedLmp != null
                            ? DateFormat('MMMM dd, yyyy').format(_selectedLmp!)
                            : 'Tap to select date',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _selectedLmp != null
                              ? NitaraColors.textDark
                              : NitaraColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: NitaraColors.textLight),
              ],
            ),
          ),
        ),

        if (_selectedLmp != null) ...[
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: NitaraColors.cardGradient(NitaraColors.pink),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NitaraColors.pinkLight.withOpacity(0.4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InfoChip(
                  label: 'Due Date',
                  value: DateFormat('MMM dd, yyyy').format(dueDate!),
                  icon: '🗓️',
                ),
                Container(height: 40, width: 1, color: NitaraColors.pinkLight),
                _InfoChip(
                  label: 'Days to Go',
                  value: dueDate.difference(DateTime.now()).inDays.clamp(0, 280).toString(),
                  icon: '⏳',
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A little more about you 💕',
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: NitaraColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'These are optional — you can always add them later in your profile.',
          style: GoogleFonts.nunito(
            fontSize: 14,
            color: NitaraColors.textMedium,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),
        _FieldCard(
          controller: _partnerCtrl,
          icon: '💑',
          label: "Partner's name (optional)",
          hint: "Your partner's name",
        ),
        const SizedBox(height: 16),
        _FieldCard(
          controller: _doctorCtrl,
          icon: '👩‍⚕️',
          label: "Doctor's name (optional)",
          hint: "Your OB/GYN's name",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF0F5), Color(0xFFF3E5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress indicator
                Row(
                  children: [
                    Text(
                      'Step ${_step + 1} of 2',
                      style: GoogleFonts.nunito(
                        color: NitaraColors.textLight,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (_step + 1) / 2,
                          backgroundColor: NitaraColors.pinkLight.withOpacity(0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(NitaraColors.pink),
                          minHeight: 6,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: _step == 0
                        ? _buildStep0().animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0)
                        : _buildStep1().animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
                  ),
                ),

                const SizedBox(height: 24),

                Consumer<AuthProvider>(
                  builder: (_, auth, __) => GradientButton(
                    label: _step == 0 ? 'Continue' : 'Start My Journey 🌸',
                    isLoading: auth.isLoading,
                    onPressed: () {
                      if (_step == 0) {
                        if (_selectedLmp == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Please select your LMP date'),
                              backgroundColor: Colors.orange,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                          return;
                        }
                        setState(() => _step = 1);
                      } else {
                        _save();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),

                if (_step == 1)
                  Center(
                    child: TextButton(
                      onPressed: () => setState(() => _step = 0),
                      child: Text(
                        '← Back',
                        style: GoogleFonts.nunito(
                          color: NitaraColors.textMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label, value, icon;
  const _InfoChip({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(label,
            style: GoogleFonts.nunito(
                fontSize: 11, color: NitaraColors.textLight, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(value,
            style: GoogleFonts.nunito(
                fontSize: 14, color: NitaraColors.pink, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _FieldCard extends StatelessWidget {
  final TextEditingController controller;
  final String icon, label, hint;
  const _FieldCard(
      {required this.controller,
      required this.icon,
      required this.label,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: NitaraColors.pink.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              style: GoogleFonts.nunito(
                  color: NitaraColors.textDark, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: label,
                hintText: hint,
                border: InputBorder.none,
                filled: false,
                labelStyle: GoogleFonts.nunito(
                    color: NitaraColors.textLight, fontSize: 13),
                hintStyle: GoogleFonts.nunito(color: NitaraColors.textLight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
