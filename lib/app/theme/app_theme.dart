import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color greyText = Color(0xFFB8B8C6);
  static const Color primary = Color.fromARGB(255, 3, 70, 82);
  //(0xFF003B35);
  static const Color white = Color(0xFFFFFFFF);
  static const Color secondaryWhite = Color(0xFFD8C87A);
  static const Color secondary = Color.fromARGB(255, 122, 236, 15);
  static const Color grey2 = Color.fromARGB(255, 221, 214, 214);
  static const Color darkGreen = Color.fromARGB(255, 11, 83, 4);
  static const Color secondaryBlack = Color(0xF0484747);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.white,

    // TEXT THEME (Responsive)
    textTheme: TextTheme(
      // العنوان الرئيسي (Titles)
      titleLarge: GoogleFonts.almarai(
        fontSize: 100,
        fontWeight: FontWeight.bold,
      ),

      // العنوان الفرعي (Subtitles)
      titleMedium: GoogleFonts.almarai(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),

      // النص العادي (Body / Normal Text)
      bodyMedium: GoogleFonts.almarai(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),

      // نص أقل أهمية
      bodySmall: GoogleFonts.almarai(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.white,
      error: Colors.red,
      onError: AppColors.white,
      surface: AppColors.grey2,
      onSurface: AppColors.black,
      background: Colors.transparent,
      onBackground: Colors.transparent,
    ),

    // APP BAR
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
    ),

    // INPUT FIELDS (Responsive)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey2,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: AppColors.greyText),
    ),

    // ELEVATED BUTTONS
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primary),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 16)),
      ),
    ),
  );
}
