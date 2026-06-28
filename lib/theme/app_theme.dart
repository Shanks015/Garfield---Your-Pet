import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryGreen  = Color(0xFF22C55E);
  static const Color accentBlue    = Color(0xFF3B82F6);
  static const Color accentAmber   = Color(0xFFF59E0B);
  static const Color accentRed     = Color(0xFFEF4444);
  static const Color surfaceDark   = Color(0xFF0F172A);
  static const Color surfaceCard   = Color(0xFF1E293B);
  static const Color surfaceMuted  = Color(0xFF334155);
  static const Color textPrimary   = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);

  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark();
    
    return baseTheme.copyWith(
      scaffoldBackgroundColor: surfaceDark,
      primaryColor: primaryGreen,
      cardColor: surfaceCard,
      colorScheme: ColorScheme.dark(
        primary: primaryGreen,
        secondary: accentBlue,
        tertiary: accentAmber,
        error: accentRed,
        surface: surfaceCard,
        background: surfaceDark,
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(
          color: textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          color: textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.spaceGrotesk(
          color: textPrimary,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.spaceGrotesk(
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.spaceGrotesk(
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          color: textSecondary,
        ),
        bodySmall: GoogleFonts.inter(
          color: textSecondary,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: surfaceMuted,
            width: 1,
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: const BorderSide(color: surfaceMuted),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceCard,
        indicatorColor: primaryGreen.withOpacity(0.2),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return GoogleFonts.inter(color: primaryGreen, fontWeight: FontWeight.w600, fontSize: 12);
          }
          return GoogleFonts.inter(color: textSecondary, fontSize: 12);
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: primaryGreen);
          }
          return const IconThemeData(color: textSecondary);
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surfaceCard,
        indicatorColor: primaryGreen.withOpacity(0.2),
        selectedIconTheme: const IconThemeData(color: primaryGreen),
        unselectedIconTheme: const IconThemeData(color: textSecondary),
        selectedLabelTextStyle: GoogleFonts.spaceGrotesk(
          color: primaryGreen,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        unselectedLabelTextStyle: GoogleFonts.spaceGrotesk(
          color: textSecondary,
          fontSize: 13,
        ),
      ),
    );
  }
}
