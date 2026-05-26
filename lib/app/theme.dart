import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/colors.dart';

class NitaraTheme {
  NitaraTheme._();

  // ─── Light Theme ────────────────────────────────────────────────────────────
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: NitaraColors.pink,
          primary: NitaraColors.pink,
          secondary: NitaraColors.lavender,
          tertiary: NitaraColors.peach,
          surface: NitaraColors.surface,
          background: NitaraColors.background,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: NitaraColors.textDark,
        ),
        scaffoldBackgroundColor: NitaraColors.background,
        textTheme: _buildTextTheme(NitaraColors.textDark),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: NitaraColors.textDark,
          ),
          iconTheme: const IconThemeData(color: NitaraColors.textDark),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: NitaraColors.pink.withOpacity(0.15),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: NitaraColors.pink,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: NitaraColors.pink.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: NitaraColors.pink.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: NitaraColors.pink, width: 2),
          ),
          hintStyle: GoogleFonts.nunito(
            color: NitaraColors.textLight,
            fontSize: 14,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: NitaraColors.pink,
          unselectedItemColor: NitaraColors.textLight,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: NitaraColors.pink.withOpacity(0.1),
          selectedColor: NitaraColors.pink,
          labelStyle: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        dividerTheme: DividerThemeData(
          color: NitaraColors.pink.withOpacity(0.15),
          thickness: 1,
        ),
        extensions: [NitaraThemeExtension.light],
      );

  // ─── Dark Theme ─────────────────────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: NitaraColors.pinkDark,
          brightness: Brightness.dark,
          primary: NitaraColors.pinkDark,
          secondary: NitaraColors.lavenderDark,
          surface: NitaraColors.surfaceDark,
          background: NitaraColors.backgroundDark,
          onPrimary: Colors.white,
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: NitaraColors.backgroundDark,
        textTheme: _buildTextTheme(Colors.white),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(
          color: NitaraColors.surfaceDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: NitaraColors.pinkDark,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: NitaraColors.surfaceDark,
          selectedItemColor: NitaraColors.pinkDark,
          unselectedItemColor: Colors.white54,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        extensions: [NitaraThemeExtension.dark],
      );

  static TextTheme _buildTextTheme(Color color) => TextTheme(
        displayLarge: GoogleFonts.nunito(
          fontSize: 57, fontWeight: FontWeight.w800, color: color,
        ),
        displayMedium: GoogleFonts.nunito(
          fontSize: 45, fontWeight: FontWeight.w700, color: color,
        ),
        headlineLarge: GoogleFonts.nunito(
          fontSize: 32, fontWeight: FontWeight.w700, color: color,
        ),
        headlineMedium: GoogleFonts.nunito(
          fontSize: 26, fontWeight: FontWeight.w700, color: color,
        ),
        headlineSmall: GoogleFonts.nunito(
          fontSize: 22, fontWeight: FontWeight.w700, color: color,
        ),
        titleLarge: GoogleFonts.nunito(
          fontSize: 20, fontWeight: FontWeight.w700, color: color,
        ),
        titleMedium: GoogleFonts.nunito(
          fontSize: 16, fontWeight: FontWeight.w600, color: color,
        ),
        titleSmall: GoogleFonts.nunito(
          fontSize: 14, fontWeight: FontWeight.w600, color: color,
        ),
        bodyLarge: GoogleFonts.nunito(
          fontSize: 16, fontWeight: FontWeight.w400, color: color,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: 14, fontWeight: FontWeight.w400, color: color,
        ),
        bodySmall: GoogleFonts.nunito(
          fontSize: 12, fontWeight: FontWeight.w400, color: color.withOpacity(0.7),
        ),
        labelLarge: GoogleFonts.nunito(
          fontSize: 14, fontWeight: FontWeight.w700, color: color,
        ),
      );
}

// ─── Theme Extension ──────────────────────────────────────────────────────────
@immutable
class NitaraThemeExtension extends ThemeExtension<NitaraThemeExtension> {
  const NitaraThemeExtension({
    required this.gradientPrimary,
    required this.gradientSecondary,
    required this.cardGradient,
    required this.surfaceWithOpacity,
    required this.chipBackground,
  });

  final Gradient gradientPrimary;
  final Gradient gradientSecondary;
  final Gradient cardGradient;
  final Color surfaceWithOpacity;
  final Color chipBackground;

  static const light = NitaraThemeExtension(
    gradientPrimary: LinearGradient(
      colors: [Color(0xFFF8BBD0), Color(0xFFE1BEE7)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    gradientSecondary: LinearGradient(
      colors: [Color(0xFFFFCCBC), Color(0xFFF8BBD0)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardGradient: LinearGradient(
      colors: [Colors.white, Color(0xFFFCE4EC)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    surfaceWithOpacity: Color(0xFFFFF0F5),
    chipBackground: Color(0xFFFCE4EC),
  );

  static const dark = NitaraThemeExtension(
    gradientPrimary: LinearGradient(
      colors: [Color(0xFF8B2252), Color(0xFF5C1A6B)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    gradientSecondary: LinearGradient(
      colors: [Color(0xFF7B3F00), Color(0xFF8B2252)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardGradient: LinearGradient(
      colors: [Color(0xFF2D1F2A), Color(0xFF1A1020)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    surfaceWithOpacity: Color(0xFF2D1F2A),
    chipBackground: Color(0xFF3D2030),
  );

  @override
  NitaraThemeExtension copyWith({
    Gradient? gradientPrimary,
    Gradient? gradientSecondary,
    Gradient? cardGradient,
    Color? surfaceWithOpacity,
    Color? chipBackground,
  }) =>
      NitaraThemeExtension(
        gradientPrimary: gradientPrimary ?? this.gradientPrimary,
        gradientSecondary: gradientSecondary ?? this.gradientSecondary,
        cardGradient: cardGradient ?? this.cardGradient,
        surfaceWithOpacity: surfaceWithOpacity ?? this.surfaceWithOpacity,
        chipBackground: chipBackground ?? this.chipBackground,
      );

  @override
  NitaraThemeExtension lerp(NitaraThemeExtension? other, double t) => this;
}
