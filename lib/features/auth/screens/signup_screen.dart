import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../providers/auth_provider.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/nitara_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please agree to the terms to continue'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    final auth = context.read<AuthProvider>();
    final success = await auth.signUp(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
    );
    if (!mounted) return;
    if (success) {
      context.go('/setup');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.error ?? 'Sign up failed'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: NitaraColors.pink.withOpacity(0.1),
                              blurRadius: 10)
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: NitaraColors.pink),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text(
                    'Join Nitara 🌸',
                    style: GoogleFonts.nunito(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: NitaraColors.textDark,
                    ),
                  ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 8),
                  Text(
                    'Create your account and begin your journey',
                    style: GoogleFonts.nunito(
                        fontSize: 15, color: NitaraColors.textMedium),
                  ).animate(delay: 200.ms).fadeIn(duration: 500.ms),

                  const SizedBox(height: 36),

                  NitaraTextField(
                    controller: _nameCtrl,
                    label: 'Your name',
                    hint: 'Enter your name',
                    icon: Icons.person_outline_rounded,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Please enter your name' : null,
                  ).animate(delay: 300.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 16),

                  NitaraTextField(
                    controller: _emailCtrl,
                    label: 'Email address',
                    hint: 'you@example.com',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Please enter your email';
                      if (!v.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ).animate(delay: 350.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 16),

                  NitaraTextField(
                    controller: _passwordCtrl,
                    label: 'Password',
                    hint: 'Min. 6 characters',
                    icon: Icons.lock_outline_rounded,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: NitaraColors.textLight,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Please enter a password';
                      if (v.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ).animate(delay: 400.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 20),

                  // Terms agreement
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _agreeToTerms,
                          onChanged: (v) =>
                              setState(() => _agreeToTerms = v ?? false),
                          activeColor: NitaraColors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'I agree to the ',
                            style: GoogleFonts.nunito(
                              color: NitaraColors.textMedium,
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                style: GoogleFonts.nunito(
                                  color: NitaraColors.pink,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: GoogleFonts.nunito(
                                  color: NitaraColors.pink,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).animate(delay: 450.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 28),

                  Consumer<AuthProvider>(
                    builder: (_, auth, __) => GradientButton(
                      label: 'Create Account',
                      isLoading: auth.isLoading,
                      onPressed: _signUp,
                    ),
                  ).animate(delay: 500.ms).fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 24),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.nunito(
                          color: NitaraColors.textMedium,
                          fontSize: 14,
                        ),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => context.go('/login'),
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.nunito(
                                  color: NitaraColors.pink,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate(delay: 600.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
