import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/core/services/secure_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  void _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      final storage = context.read<SecureStorageService>();
      final token = await storage.readToken();
      if (mounted) {
        if (token != null) {
          context.go(AppRoutes.complaintsListScreen);
        } else {
          context.go(AppRoutes.loginScreen);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary500,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primary500,
        body: Center(
          child: Image.asset(
            'assets/logos/logo.png',
            height: 120.h,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.gavel_rounded,
                  color: Colors.white,
                  size: 100.sp,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
