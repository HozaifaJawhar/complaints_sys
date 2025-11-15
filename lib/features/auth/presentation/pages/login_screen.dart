import 'package:complaints_sys/app/responsive/ui_helper.dart';
import 'package:complaints_sys/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logos/GCSlogo.png',
                    height: UIHelpers.h(context, 300),
                  ),

                  Text(
                    'تسجيل الدخول',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: UIHelpers.font(context, 30),

                      color: AppColors.secondaryWhite,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'مرحباً بعودتك',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.secondaryWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
