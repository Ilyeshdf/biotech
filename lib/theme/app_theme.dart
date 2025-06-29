import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Colors
  static const Color primary = Color(0xFF4CAF50);
  static const Color accent = Color(0xFF8BC34A);
  static const Color error = Color(0xFFE57373);

  // Light Theme Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color grey = Color(0xFF9E9E9E);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2D2D2D);
  static const Color darkSurfaceVariant2 = Color(0xFF3D3D3D);
  static const Color darkGrey = Color(0xFF757575);
  static const Color darkGreyLight = Color(0xFF9E9E9E);

  // Gradients
  static const List<Color> darkGradient = [
    Color(0xFF121212),
    Color(0xFF1E1E1E),
  ];

  static const List<Color> darkSurfaceGradient = [
    Color(0xFF1E1E1E),
    Color(0xFF2D2D2D),
  ];

  // Shadows
  static List<BoxShadow> darkShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  // Border Radius
  static const double borderRadius = 12.0;
  static const double borderRadiusLarge = 24.0;
  static const double borderRadiusSmall = 8.0;

  // Spacing
  static const double spacing = 16.0;
  static const double spacingSmall = 8.0;
  static const double spacingLarge = 24.0;

  // Animation
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOut;

  // Medical Green Palette
  static const Color primaryLight = Color(0xFFA5D6A7); // Light Green
  static const Color primaryDark = Color(0xFF1B5E20); // Dark Green
  static const Color mint = Color(0xFFB2DFDB); // Mint
  static const Color teal = Color(0xFF009688); // Teal
  static const Color forest = Color(0xFF2E7D32); // Forest Green

  // Semantic Colors
  static const Color success = Color(0xFF81C784);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF64B5F6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFA5D6A7), Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Typography
  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
        height: 1.2,
      );

  static TextStyle get heading2 => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        height: 1.3,
      );

  static TextStyle get heading3 => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
        height: 1.4,
      );

  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.5,
      );

  // Button Styles
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        textStyle: bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: white,
        ),
      ).copyWith(
        overlayColor: MaterialStateProperty.all(white.withOpacity(0.1)),
        shadowColor: MaterialStateProperty.all(primary.withOpacity(0.3)),
      );

  static ButtonStyle get secondaryButton => OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: primary,
        ),
      );

  // Input Decoration
  static InputDecorationTheme get inputDecoration => InputDecorationTheme(
        filled: true,
        fillColor: lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: bodyMedium.copyWith(color: grey),
      );

  // Card Decoration
  static CardThemeData get cardTheme => CardThemeData(
        color: white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: black.withOpacity(0.1),
      );

  // Light Theme
  static ThemeData get lightTheme => ThemeData(
        primaryColor: primary,
        scaffoldBackgroundColor: white,
        colorScheme: ColorScheme.light(
          primary: primary,
          secondary: accent,
          surface: white,
          background: lightGrey,
          error: error,
          onPrimary: white,
          onSecondary: white,
          onSurface: black,
          onBackground: black,
          onError: white,
        ),
        textTheme: TextTheme(
          displayLarge: heading1.copyWith(color: black),
          displayMedium: heading2.copyWith(color: black),
          displaySmall: heading3.copyWith(color: black),
          bodyLarge: bodyLarge.copyWith(color: black),
          bodyMedium: bodyMedium.copyWith(color: black),
          bodySmall: bodySmall.copyWith(color: black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: primaryButton,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: secondaryButton,
        ),
        inputDecorationTheme: inputDecoration,
        cardTheme: cardTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          foregroundColor: white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: heading2.copyWith(color: white),
          iconTheme: const IconThemeData(color: white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: white,
          selectedItemColor: primary,
          unselectedItemColor: grey,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        dividerTheme: const DividerThemeData(
          color: lightGrey,
          thickness: 1,
          space: 1,
        ),
        iconTheme: const IconThemeData(
          color: primary,
          size: 24,
        ),
      );

  // Dark Theme
  static ThemeData get darkTheme => ThemeData(
        primaryColor: primary,
        scaffoldBackgroundColor: darkBackground,
        colorScheme: ColorScheme.dark(
          primary: primary,
          secondary: accent,
          surface: darkSurface,
          background: darkBackground,
          error: error,
          onPrimary: white,
          onSecondary: white,
          onSurface: white,
          onBackground: white,
          onError: white,
        ),
        textTheme: TextTheme(
          displayLarge: heading1.copyWith(color: white),
          displayMedium: heading2.copyWith(color: white),
          displaySmall: heading3.copyWith(color: white),
          bodyLarge: bodyLarge.copyWith(color: white),
          bodyMedium: bodyMedium.copyWith(color: white),
          bodySmall: bodySmall.copyWith(color: white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: primaryButton,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: secondaryButton,
        ),
        inputDecorationTheme: inputDecoration.copyWith(
          fillColor: darkSurface,
        ),
        cardTheme: cardTheme.copyWith(
          color: darkSurfaceVariant,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkSurface,
          foregroundColor: white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: heading2.copyWith(color: white),
          iconTheme: const IconThemeData(color: white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: darkSurface,
          selectedItemColor: primary,
          unselectedItemColor: grey,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        dividerTheme: const DividerThemeData(
          color: darkGrey,
          thickness: 1,
          space: 1,
        ),
        iconTheme: const IconThemeData(
          color: primary,
          size: 24,
        ),
      );
}
