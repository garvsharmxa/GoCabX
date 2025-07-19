import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF1E3A8A);        // Deep blue - trustworthy, professional
  static const Color primaryLight = Color(0xFF3B82F6);   // Lighter blue for highlights
  static const Color primaryDark = Color(0xFF1E40AF);    // Darker blue for pressed states

  // Secondary colors
  static const Color secondary = Color(0xFF10B981);      // Emerald green - success, go
  static const Color secondaryLight = Color(0xFF34D399); // Light green for success states
  static const Color accent = Color(0xFFF59E0B);         // Amber - attention, warning

  // Background colors
  static const Color background = Color(0xFFFFFFFF);     // Pure white
  static const Color backgroundLight = Color(0xFFF8FAFC); // Light gray background
  static const Color backgroundDark = Color(0xFF1F2937);  // Dark mode background
  static const Color surface = Color(0xFFF1F5F9);       // Card/surface color

  // Text colors
  static const Color textPrimary = Color(0xFF1F2937);    // Dark gray for primary text
  static const Color textSecondary = Color(0xFF6B7280);  // Medium gray for secondary text
  static const Color textMuted = Color(0xFF9CA3AF);      // Light gray for muted text
  static const Color subText = Color(0xFF6B7280);        // Sub text for descriptions, hints
  static const Color textOnPrimary = Color(0xFFFFFFFF);  // White text on primary color

  // Status colors
  static const Color success = Color(0xFF10B981);        // Success green
  static const Color warning = Color(0xFFF59E0B);        // Warning amber
  static const Color error = Color(0xFFEF4444);          // Error red
  static const Color info = Color(0xFF3B82F6);           // Info blue

  // Utility colors
  static const Color divider = Color(0xFFE5E7EB);        // Light gray for dividers
  static const Color border = Color(0xFFD1D5DB);         // Border color
  static const Color shadow = Color(0x1A000000);         // Subtle shadow
  static const Color overlay = Color(0x80000000);        // Modal overlay

  // Cab-specific colors
  static const Color availableCab = Color(0xFF10B981);   // Green for available cabs
  static const Color bookedCab = Color(0xFFF59E0B);      // Amber for booked cabs
  static const Color offlineCab = Color(0xFF6B7280);     // Gray for offline cabs
  static const Color route = Color(0xFF3B82F6);          // Blue for route lines
  static const Color pickup = Color(0xFF10B981);         // Green for pickup point
  static const Color dropoff = Color(0xFFEF4444);        // Red for drop-off point
}