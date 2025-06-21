import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';

/// App Theme Configuration
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Palette comes from AppColors
  static const Color primaryColor = AppColors.night;
  static const Color secondaryColor = AppColors.sunshine;

  // Light Theme Colors
  static const Color lightBackgroundColor = AppColors.ghostWhite;
  static const Color lightSurfaceColor = AppColors.ghostWhite;
  static const Color lightTextColor = AppColors.night;
  static const Color lightSecondaryTextColor = Color(0xFF666666);
  
  // Dark Theme Colors
  static const Color darkBackgroundColor = AppColors.night;
  static const Color darkSurfaceColor = AppColors.night;
  static const Color darkTextColor = AppColors.ghostWhite;
  static const Color darkSecondaryTextColor = Color(0xFFB0B0B0);

  /// Light Theme Configuration
  static ThemeData get lightTheme {
    // Custom light color scheme derived from our seed but with richer surfaces
    final baseLightScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    );

    final colorScheme = baseLightScheme.copyWith(
      background: lightBackgroundColor,
      surface: lightSurfaceColor,
      secondary: secondaryColor,
      primaryContainer: lightSurfaceColor,
      secondaryContainer: lightSurfaceColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.light,
      
      // Text Theme
      textTheme: _buildTextTheme(lightTextColor, lightSecondaryTextColor),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: lightSurfaceColor,
        foregroundColor: lightTextColor,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: AppConstants.fontSizeXL,
          fontWeight: FontWeight.w600,
          color: lightTextColor,
        ),
        iconTheme: const IconThemeData(color: lightTextColor),
      ),
      
      // Card Theme
      cardTheme: const CardTheme(
        elevation: 0,
        color: Colors.white,
        margin: EdgeInsets.zero,
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: AppColors.ghostWhite,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppConstants.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppConstants.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppConstants.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: Colors.red),
        ),
        labelStyle: GoogleFonts.poppins(
          color: lightSecondaryTextColor,
        ),
        hintStyle: GoogleFonts.poppins(
          color: lightSecondaryTextColor,
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: lightTextColor,
      ),
      
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
        thickness: 1,
      ),
    );
  }

  /// Dark Theme Configuration
  static ThemeData get darkTheme {
    // Custom dark color scheme with vibrant accent containers
    final baseDarkScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    );

    final colorScheme = baseDarkScheme.copyWith(
      background: darkBackgroundColor,
      surface: darkSurfaceColor,
      secondary: secondaryColor,
      primaryContainer: darkSurfaceColor,
      secondaryContainer: darkSurfaceColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      
      // Text Theme
      textTheme: _buildTextTheme(darkTextColor, darkSecondaryTextColor),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: darkSurfaceColor,
        foregroundColor: darkTextColor,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: AppConstants.fontSizeXL,
          fontWeight: FontWeight.w600,
          color: darkTextColor,
        ),
        iconTheme: const IconThemeData(color: darkTextColor),
      ),
      
      // Card Theme
      cardTheme: const CardTheme(
        elevation: 0,
        color: Colors.black,
        margin: EdgeInsets.zero,
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.ghostWhite,
          foregroundColor: AppColors.night,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppConstants.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppConstants.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.ghostWhite,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppConstants.fontSizeM,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: Colors.red),
        ),
        labelStyle: GoogleFonts.poppins(
          color: darkSecondaryTextColor,
        ),
        hintStyle: GoogleFonts.poppins(
          color: darkSecondaryTextColor,
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: darkTextColor,
      ),
      
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade700,
        thickness: 1,
      ),
    );
  }

  /// Build Text Theme
  static TextTheme _buildTextTheme(Color primaryTextColor, Color secondaryTextColor) {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: AppConstants.fontSizeHeading1,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: AppConstants.fontSizeHeading2,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: AppConstants.fontSizeHeading3,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: AppConstants.fontSizeHeading4,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: AppConstants.fontSizeHeading5,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: AppConstants.fontSizeHeading6,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: AppConstants.fontSizeXXL,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: AppConstants.fontSizeXL,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: AppConstants.fontSizeL,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: AppConstants.fontSizeL,
        fontWeight: FontWeight.normal,
        color: primaryTextColor,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: AppConstants.fontSizeM,
        fontWeight: FontWeight.normal,
        color: primaryTextColor,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: AppConstants.fontSizeS,
        fontWeight: FontWeight.normal,
        color: secondaryTextColor,
      ),
      labelLarge: GoogleFonts.roboto(
        fontSize: AppConstants.fontSizeM,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: AppConstants.fontSizeS,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
      ),
      labelSmall: GoogleFonts.roboto(
        fontSize: AppConstants.fontSizeXS,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
      ),
    );
  }
} 