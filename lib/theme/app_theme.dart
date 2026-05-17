import 'package:flutter/material.dart';

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
  static final _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Cormorant Garamond',
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: AppColors.emerald600,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Cormorant Garamond',
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.emerald900,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Cormorant Garamond',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.emerald800,
    ),
    titleLarge: TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: AppColors.emerald900,
    ),
    titleMedium: TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.emerald900,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 14,
      color: AppColors.emerald700,
    ),
    bodySmall: TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 12,
      color: AppColors.emerald600,
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
        onSurface: AppColors.emerald900,
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
        clipBehavior: Clip.hardEdge,
      ),
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.emerald700),
        titleTextStyle: TextStyle(fontFamily: 'Cormorant Garamond', 
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.emerald600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.emerald50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.emerald200, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.emerald500, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFFCA5A5), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFF87171), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(fontFamily: 'DM Sans', 
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.emerald700,
        ),
        hintStyle: TextStyle(fontFamily: 'DM Sans', 
          fontSize: 13,
          color: AppColors.emerald400,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: AppColors.emerald800,
        contentTextStyle: TextStyle(fontFamily: 'DM Sans', 
          fontSize: 13,
          color: Colors.white,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.white,
        indicatorColor: AppColors.emerald100,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.emerald700);
          }
          return const IconThemeData(color: AppColors.emerald400);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(fontFamily: 'DM Sans', 
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.emerald700,
            );
          }
          return TextStyle(fontFamily: 'DM Sans', 
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.emerald400,
          );
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.emerald100,
        thickness: 1,
        space: 0,
      ),
    );
  }
}
