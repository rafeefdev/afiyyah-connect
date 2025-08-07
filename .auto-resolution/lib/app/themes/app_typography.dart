import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme plusJakartaTextTheme = TextTheme(
    //judul halaman utama
    displayLarge: GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      height: 1.3,
    ),
    //judul sub section
    headlineMedium: GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w600, // SemiBold
      height: 1.4,
    ),
    //label tambahan
    titleMedium: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w500, // Medium
      height: 1.4,
    ),
    //teks biasa/form/info
    bodyLarge: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.5,
    ),
    //informasi tambahan
    bodyMedium: GoogleFonts.plusJakartaSans(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 1.5,
    ),
    labelLarge: GoogleFonts.plusJakartaSans(
      fontSize: 10,
      fontWeight: FontWeight.w300,
      height: 1.3,
    ),
  );
}
