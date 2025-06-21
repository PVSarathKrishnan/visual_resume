import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Base palette
  static const ghostWhite = Color(0xFFF7F7FF); // Light background, dark-mode text
  static const night = Color(0xFF071108);      // Dark background, light-mode text

  // Accent for highlights and CTAs
  static const sunshine = Color(0xFFF7CB15);

  // Convenience getters
  static Color get lightBackground => ghostWhite;
  static Color get darkBackground => night;

  static Color get lightText => night;
  static Color get darkText => ghostWhite;
} 