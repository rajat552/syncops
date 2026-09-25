import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SyncOpsTheme {
  // Deep military/space ops tactical palette
  static const Color background = Color(0xFF090D16);
  static const Color surface = Color(0xFF0F172A);
  static const Color surfaceElevated = Color(0xFF1E293B);
  static const Color surfaceHighlight = Color(0xFF283548);
  static const Color border = Color(0xFF334155);
  static const Color borderBright = Color(0xFF475569);

  // Status & accent colors
  static const Color primaryCyan = Color(0xFF06B6D4);
  static const Color accentBlue = Color(0xFF38BDF8);
  static const Color criticalRed = Color(0xFFEF4444);
  static const Color alertOrange = Color(0xFFF97316);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color successGreen = Color(0xFF10B981);
  static const Color purpleNeon = Color(0xFFA855F7);

  // Text colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primaryCyan,
      cardColor: surface,
      colorScheme: const ColorScheme.dark(
        primary: primaryCyan,
        secondary: accentBlue,
        surface: surface,
        error: criticalRed,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          color: textSecondary,
        ),
        labelSmall: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textMuted,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: border, width: 1),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
      ),
    );
  }

  static Color getSeverityColor(String severity) {
    switch (severity.toUpperCase()) {
      case 'CRITICAL':
        return criticalRed;
      case 'HIGH':
        return alertOrange;
      case 'MEDIUM':
        return warningAmber;
      case 'LOW':
        return primaryCyan;
      default:
        return textSecondary;
    }
  }

  static Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return warningAmber;
      case 'ACCEPTED':
        return primaryCyan;
      case 'EN_ROUTE':
        return accentBlue;
      case 'ARRIVED':
        return purpleNeon;
      case 'IN_PROGRESS':
        return successGreen;
      case 'COMPLETED':
        return const Color(0xFF059669);
      case 'EXPIRED':
      case 'REASSIGNED':
        return criticalRed;
      default:
        return textSecondary;
    }
  }
}
