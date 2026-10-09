import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SyncOpsTheme {
  // SyncOps warm light theme — "Operations Center Daylight" palette.
  // Readable on standard monitors in bright field environments.
  static const Color background = Color(0xFFFFF7F2); // Soft warm white
  static const Color surface = Color(0xFFFFFFFF); // White cards
  static const Color surfaceElevated = Color(0xFFFFF0E6); // Warm elevated card
  static const Color surfaceHighlight = Color(0xFFFFE5D4); // Warm highlight
  static const Color border = Color(0xFFDCA685); // Warm amber border
  static const Color borderBright = Color(0xFFF4C5A8); // Light border

  // Semantic accent colors — named after their actual visual appearance
  /// Primary brand orange — used for interactive elements, highlights, FABs.
  static const Color primaryCyan = Color(
    0xFFF9944F,
  ); // Orange (legacy name kept for compatibility)
  static const Color primaryOrange = Color(
    0xFFF9944F,
  ); // Orange — primary brand color
  static const Color accentTeal = Color(0xFF26B6B5); // Teal — "en-route" status
  static const Color accentBlue = Color(
    0xFF26B6B5,
  ); // alias for accentTeal (legacy)
  static const Color emergencyRed = Color(
    0xFFFF7582,
  ); // Coral-red — critical/expired states
  static const Color criticalRed = Color(
    0xFFFF7582,
  ); // alias for emergencyRed (legacy)
  static const Color alertOrange = Color(
    0xFFF9944F,
  ); // Orange — alert/accepted state
  static const Color warningAmber = Color(
    0xFFFFB84D,
  ); // Amber — pending/medium severity
  static const Color successGreen = Color(
    0xFF4ADE80,
  ); // Green — completed/arrived
  static const Color purpleNeon = Color(
    0xFFB485FF,
  ); // Purple — "arrived" status

  // Text hierarchy
  static const Color textPrimary = Color(0xFF2D3748); // Dark slate — headings
  static const Color textSecondary = Color(0xFF718096); // Medium gray — body
  static const Color textMuted = Color(
    0xFFA0AEC0,
  ); // Light gray — labels/metadata

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      primaryColor: primaryCyan,
      cardColor: surface,
      colorScheme: const ColorScheme.light(
        primary: primaryCyan,
        secondary: accentBlue,
        surface: surface,
        error: criticalRed,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.nunito(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.nunito(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),
        titleLarge: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleMedium: GoogleFonts.nunito(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
        labelSmall: GoogleFonts.nunito(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textMuted,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 8,
        shadowColor: const Color(
          0x33000000,
        ), // 20% opacity for better visibility
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: border, width: 2),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryCyan,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: textSecondary,
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
