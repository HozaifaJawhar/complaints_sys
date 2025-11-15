import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

abstract class AppThemes {
  static ThemeData themeArabic = ThemeData(
    fontFamily: 'Zain',
    primaryColor: AppColors.primary500,
    scaffoldBackgroundColor: Colors.white,
    splashColor: AppColors.primary500.withOpacity(0.1),
    canvasColor: AppColors.fillColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary500,
      onPrimary: Colors.white,
      secondary: AppColors.primary400,
      onSecondary: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      iconTheme: const IconThemeData(color: AppColors.primary500),
      elevation: 2,
      scrolledUnderElevation: 0,
      titleSpacing: 1,
      titleTextStyle: TextStyle(
        fontFamily: 'Zain',
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.sp,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 13.sp,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 18.sp,
        color: Colors.black87,
        fontWeight: FontWeight.w700,
      ),
      labelMedium: TextStyle(
        fontSize: 16.sp,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 12.sp,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.fillColor,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontFamily: 'Zain',
        fontSize: 14.sp,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.primary500, width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary500,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        textStyle: TextStyle(
          fontFamily: 'Zain',
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary500,
      unselectedItemColor: Colors.grey.shade500,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Zain',
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(fontFamily: 'Zain', fontSize: 12.sp),
    ),
    iconTheme: const IconThemeData(color: AppColors.primary500),
    tabBarTheme: const TabBarThemeData(indicatorColor: AppColors.primary500),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    ),
  );
}
