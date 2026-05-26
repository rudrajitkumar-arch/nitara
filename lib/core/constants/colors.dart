import 'package:flutter/material.dart';

class NitaraColors {
  NitaraColors._();

  // ─── Primary Palette ──────────────────────────────────────────────────────
  static const Color pink = Color(0xFFE91E8C);
  static const Color pinkLight = Color(0xFFF8BBD0);
  static const Color pinkPastel = Color(0xFFFCE4EC);
  static const Color pinkDark = Color(0xFFC2185B);

  static const Color lavender = Color(0xFF9C27B0);
  static const Color lavenderLight = Color(0xFFE1BEE7);
  static const Color lavenderPastel = Color(0xFFF3E5F5);
  static const Color lavenderDark = Color(0xFF7B1FA2);

  static const Color peach = Color(0xFFFF7043);
  static const Color peachLight = Color(0xFFFFCCBC);
  static const Color peachPastel = Color(0xFFFBE9E7);

  static const Color rose = Color(0xFFEC407A);
  static const Color rosePastel = Color(0xFFFCE4EC);

  // ─── Neutral ──────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFFFF5F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2D1F2A);
  static const Color textMedium = Color(0xFF6B4D6E);
  static const Color textLight = Color(0xFFBBA0BD);

  // ─── Dark Mode ────────────────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0F0A10);
  static const Color surfaceDark = Color(0xFF1E1520);
  static const Color cardDark = Color(0xFF2D1F2A);

  // ─── Category Colors ──────────────────────────────────────────────────────
  static const Color weightColor = Color(0xFF42A5F5);
  static const Color waterColor = Color(0xFF26C6DA);
  static const Color sleepColor = Color(0xFF7E57C2);
  static const Color moodColor = Color(0xFFFFCA28);
  static const Color nutritionColor = Color(0xFF66BB6A);
  static const Color yogaColor = Color(0xFFFF7043);
  static const Color babyColor = Color(0xFFEC407A);
  static const Color reminderColor = Color(0xFFAB47BC);

  // ─── Gradient Helpers ─────────────────────────────────────────────────────
  static const Gradient primaryGradient = LinearGradient(
    colors: [pink, lavender],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient babyGradient = LinearGradient(
    colors: [Color(0xFFF48FB1), Color(0xFFCE93D8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient healthGradient = LinearGradient(
    colors: [Color(0xFF80DEEA), Color(0xFF80CBC4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient nutritionGradient = LinearGradient(
    colors: [Color(0xFFA5D6A7), Color(0xFF80CBC4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient yogaGradient = LinearGradient(
    colors: [Color(0xFFFFAB91), Color(0xFFF48FB1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient emotionalGradient = LinearGradient(
    colors: [Color(0xFFCE93D8), Color(0xFFEF9A9A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient cardGradient(Color base) => LinearGradient(
        colors: [base.withOpacity(0.08), base.withOpacity(0.02)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
