import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final List<Color>? gradientColors;
  final double? width;
  final double height;
  final Widget? icon;

  const GradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.gradientColors,
    this.width,
    this.height = 56,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? [NitaraColors.pink, NitaraColors.lavender];
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLoading
                ? colors.map((c) => c.withOpacity(0.6)).toList()
                : colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: colors.first.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[icon!, const SizedBox(width: 8)],
                    Text(
                      label,
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
