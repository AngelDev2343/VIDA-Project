import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const emerald50  = Color(0xFFECFDF5);
  static const emerald100 = Color(0xFFD1FAE5);
  static const emerald200 = Color(0xFFA7F3D0);
  static const emerald300 = Color(0xFF6EE7B7);
  static const emerald400 = Color(0xFF34D399);
  static const emerald500 = Color(0xFF10B981);
  static const emerald600 = Color(0xFF059669);
  static const emerald700 = Color(0xFF047857);
  static const emerald800 = Color(0xFF065F46);
  static const emerald900 = Color(0xFF064E3B);

  static const amber400 = Color(0xFFFBBF24);
}

class AppTheme {
  static final _textTheme = GoogleFonts.dmSansTextTheme().copyWith(
    displayLarge: GoogleFonts.cormorantGaramond(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: AppColors.emerald600,
    ),
    headlineMedium: GoogleFonts.cormorantGaramond(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF0A1F12),
    ),
  );

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.emerald600,
        onPrimary: Colors.white,
        secondary: AppColors.emerald400,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Color(0xFF0A1F12),
        surfaceContainerLowest: Colors.white,
        surfaceContainerLow: Colors.white,
        surfaceContainer: Colors.white,
        surfaceContainerHigh: Colors.white,
        surfaceContainerHighest: Colors.white,
        outline: AppColors.emerald200,
      ),
      scaffoldBackgroundColor: Colors.white,
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.emerald700),
        titleTextStyle: GoogleFonts.cormorantGaramond(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: AppColors.emerald600,
        ),
      ),
    );
  }
}
