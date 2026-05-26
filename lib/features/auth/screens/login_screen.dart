import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../providers/auth_provider.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/nitara_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final success = await auth.signIn(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
    );
    if (!mounted) return;
    if (success) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.error ?? 'Sign in failed'),
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

                  // Back
                  GestureDetector(
                    onTap: () => context.go('/onboarding'),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: NitaraColors.pink.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: NitaraColors.pink),
                    ),
                  ).animate().fadeIn(duration: 400.ms),

                  const SizedBox(height: 32),

                  // Header
                  Text(
                    'Welcome Back! 💕',
                    style: GoogleFonts.nunito(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: NitaraColors.textDark,
                    ),
                  ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 8),

                  Text(
                    'Sign in to continue your pregnancy journey',
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      color: NitaraColors.textMedium,
                    ),
                  ).animate(delay: 200.ms).fadeIn(duration: 500.ms),

                  const SizedBox(height: 40),

                  // Email field
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
                  ).animate(delay: 300.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 16),

                  // Password field
                  NitaraTextField(
                    controller: _passwordCtrl,
                    label: 'Password',
                    hint: '••••••••',
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
                      if (v == null || v.isEmpty) return 'Please enter your password';
                      if (v.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ).animate(delay: 400.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 12),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.nunito(
                          color: NitaraColors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ).animate(delay: 500.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  // Sign in button
                  Consumer<AuthProvider>(
                    builder: (_, auth, __) => GradientButton(
                      label: 'Sign In',
                      isLoading: auth.isLoading,
                      onPressed: _signIn,
                    ),
                  ).animate(delay: 600.ms).fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 32),

                  // Sign up link
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: GoogleFonts.nunito(
                          color: NitaraColors.textMedium,
                          fontSize: 14,
                        ),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => context.go('/signup'),
                              child: Text(
                                'Join Nitara',
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
                  ).animate(delay: 700.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 40),

                  // Decorative flower
                  Center(
                    child: Text('🌸', style: TextStyle(fontSize: 28))
                        .animate(delay: 800.ms)
                        .fadeIn(duration: 500.ms)
                        .scale(begin: const Offset(0.5, 0.5)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
