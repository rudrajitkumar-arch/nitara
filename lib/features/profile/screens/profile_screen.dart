import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/colors.dart';
import '../../auth/providers/auth_provider.dart';
import '../../baby_growth/providers/baby_provider.dart';
import '../providers/profile_provider.dart';
import '../../../shared/widgets/nitara_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final baby = context.watch<BabyProvider>();
    final profile = context.watch<ProfileProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? NitaraColors.backgroundDark : NitaraColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [NitaraColors.pink, NitaraColors.lavender],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                  child: Column(
                    children: [
                      // Avatar
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.25),
                          border: Border.all(color: Colors.white.withOpacity(0.5), width: 3),
                        ),
                        child: Center(
                          child: Text(
                            auth.userName.isNotEmpty ? auth.userName[0].toUpperCase() : 'M',
                            style: GoogleFonts.nunito(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),

                      const SizedBox(height: 12),

                      Text(
                        auth.userName,
                        style: GoogleFonts.nunito(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        auth.userEmail,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Stats row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _StatChip(
                            label: 'Week',
                            value: '${baby.currentWeek}',
                          ),
                          Container(height: 40, width: 1, color: Colors.white30),
                          _StatChip(
                            label: 'Trimester',
                            value: '${baby.trimester}',
                          ),
                          Container(height: 40, width: 1, color: Colors.white30),
                          _StatChip(
                            label: 'Days Left',
                            value: '${baby.daysRemaining}',
                          ),
                        ],
                      ),
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
                // Pregnancy info
                const NitaraSectionHeader(title: 'Pregnancy Info'),
                const SizedBox(height: 12),

                NitaraCard(
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.calendar_month_rounded,
                        color: NitaraColors.pink,
                        label: 'Due Date',
                        value: DateFormat('MMMM dd, yyyy').format(baby.dueDate),
                      ),
                      const Divider(height: 24),
                      _InfoRow(
                        icon: Icons.local_hospital_rounded,
                        color: NitaraColors.waterColor,
                        label: 'Doctor',
                        value: auth.profile?['doctorName']?.toString().isNotEmpty == true
                            ? auth.profile!['doctorName']
                            : 'Not set',
                      ),
                      const Divider(height: 24),
                      _InfoRow(
                        icon: Icons.favorite_rounded,
                        color: NitaraColors.peach,
                        label: 'Partner',
                        value: auth.profile?['partnerName']?.toString().isNotEmpty == true
                            ? auth.profile!['partnerName']
                            : 'Not set',
                      ),
                    ],
                  ),
                ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 24),

                // Settings
                const NitaraSectionHeader(title: 'Settings'),
                const SizedBox(height: 12),

                NitaraCard(
                  child: Column(
                    children: [
                      _ToggleRow(
                        icon: Icons.dark_mode_rounded,
                        color: NitaraColors.sleepColor,
                        label: 'Dark Mode',
                        value: profile.isDarkMode,
                        onChanged: (_) => profile.toggleDarkMode(),
                      ),
                      const Divider(height: 24),
                      _ToggleRow(
                        icon: Icons.notifications_rounded,
                        color: NitaraColors.reminderColor,
                        label: 'Push Notifications',
                        value: profile.notificationsEnabled,
                        onChanged: (_) => profile.toggleNotifications(),
                      ),
                      const Divider(height: 24),
                      _ToggleRow(
                        icon: Icons.water_drop_rounded,
                        color: NitaraColors.waterColor,
                        label: 'Water Reminders',
                        value: profile.waterRemindersEnabled,
                        onChanged: (_) => profile.toggleWaterReminders(),
                      ),
                    ],
                  ),
                ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 24),

                // Quick actions
                const NitaraSectionHeader(title: 'Account'),
                const SizedBox(height: 12),

                NitaraCard(
                  child: Column(
                    children: [
                      _ActionRow(
                        icon: Icons.edit_rounded,
                        color: NitaraColors.nutritionColor,
                        label: 'Edit Profile',
                        onTap: () => _showEditProfile(context, auth),
                      ),
                      const Divider(height: 24),
                      _ActionRow(
                        icon: Icons.info_outline_rounded,
                        color: NitaraColors.lavender,
                        label: 'About Nitara',
                        onTap: () => showAboutDialog(
                          context: context,
                          applicationName: 'Nitara',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '© 2024 Nitara App',
                        ),
                      ),
                      const Divider(height: 24),
                      _ActionRow(
                        icon: Icons.logout_rounded,
                        color: Colors.redAccent,
                        label: 'Sign Out',
                        onTap: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text('Sign Out',
                                  style: GoogleFonts.nunito(fontWeight: FontWeight.w800)),
                              content: Text(
                                'Are you sure you want to sign out?',
                                style: GoogleFonts.nunito(color: NitaraColors.textMedium),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white),
                                  child: const Text('Sign Out'),
                                ),
                              ],
                            ),
                          );
                          if (confirmed == true) {
                            await context.read<AuthProvider>().signOut();
                            if (context.mounted) context.go('/login');
                          }
                        },
                      ),
                    ],
                  ),
                ).animate(delay: 300.ms).fadeIn(duration: 400.ms),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfile(BuildContext context, AuthProvider auth) {
    final nameCtrl = TextEditingController(text: auth.userName);
    final doctorCtrl = TextEditingController(
        text: auth.profile?['doctorName']?.toString() ?? '');
    final partnerCtrl = TextEditingController(
        text: auth.profile?['partnerName']?.toString() ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Profile',
                  style: GoogleFonts.nunito(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: NitaraColors.textDark)),
              const SizedBox(height: 20),
              _EditField(controller: nameCtrl, label: 'Your Name', icon: Icons.person_outline_rounded),
              const SizedBox(height: 12),
              _EditField(controller: doctorCtrl, label: 'Doctor\'s Name', icon: Icons.local_hospital_rounded),
              const SizedBox(height: 12),
              _EditField(controller: partnerCtrl, label: 'Partner\'s Name', icon: Icons.favorite_outline_rounded),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('userName', nameCtrl.text);
                    await prefs.setString('doctorName', doctorCtrl.text);
                    await prefs.setString('partnerName', partnerCtrl.text);
                    await context.read<ProfileProvider>().updateProfile(
                      userName: nameCtrl.text,
                      doctorName: doctorCtrl.text,
                      partnerName: partnerCtrl.text,
                    );
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text('Save Changes'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label, value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(value,
              style: GoogleFonts.nunito(
                  fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
          Text(label,
              style: GoogleFonts.nunito(
                  fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w600)),
        ],
      );
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label, value;
  const _InfoRow({required this.icon, required this.color, required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label, style: GoogleFonts.nunito(fontSize: 12, color: NitaraColors.textLight, fontWeight: FontWeight.w600)),
              Text(value, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w700, color: NitaraColors.textDark)),
            ]),
          ),
        ],
      );
}

class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final bool value;
  final void Function(bool) onChanged;
  const _ToggleRow({required this.icon, required this.color, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w600, color: NitaraColors.textDark))),
          Switch.adaptive(value: value, activeColor: color, onChanged: onChanged),
        ],
      );
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  const _ActionRow({required this.icon, required this.color, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w600, color: NitaraColors.textDark))),
            Icon(Icons.chevron_right_rounded, color: NitaraColors.textLight, size: 20),
          ],
        ),
      );
}

class _EditField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  const _EditField({required this.controller, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        style: GoogleFonts.nunito(color: NitaraColors.textDark, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: NitaraColors.pink, size: 20),
          labelStyle: GoogleFonts.nunito(color: NitaraColors.textLight, fontSize: 13),
        ),
      );
}
