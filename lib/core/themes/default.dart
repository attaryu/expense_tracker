import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme() {
  final Color primaryColor = Color(0xFF181815);
  final Color secondaryColor = Color(0xFFF8F9FA);

  return ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      labelMedium: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryColor.withValues(alpha: 0.7),
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryColor.withValues(alpha: 0.7),
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: primaryColor.withValues(alpha: 0.7),
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: Colors.white,
      onPrimary: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: secondaryColor,
      filled: true,
      focusColor: primaryColor,
      contentPadding: const EdgeInsets.all(12),
      errorStyle: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: Colors.red.withValues(alpha: 0.8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: primaryColor.withValues(alpha: 0.8),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.red.withValues(alpha: 0.8),
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.red.withValues(alpha: 0.8),
          width: 1.5,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(20),
      ),
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      textStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
      borderRadius: BorderRadius.circular(10),
      borderColor: primaryColor,
      selectedBorderColor: primaryColor,
      color: primaryColor,
      selectedColor: Colors.white,
      fillColor: primaryColor,
    ),
    snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating),
  );
}
