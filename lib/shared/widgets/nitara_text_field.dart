import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class NitaraTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;

  const NitaraTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    this.textInputAction,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: NitaraColors.textMedium,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textInputAction: textInputAction,
          validator: validator,
          onChanged: onChanged,
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: NitaraColors.textDark,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: NitaraColors.pink, size: 20),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
