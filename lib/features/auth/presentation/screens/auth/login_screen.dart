import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_button.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart'
    show CustomTextField;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 1.sh - MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40.h),
                    Center(
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
                    SizedBox(height: 40.h),
                    Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Zain',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'مرحباً بعودتك',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.sp,
                        fontFamily: 'Zain',
                      ),
                    ),
                    SizedBox(height: 50.h),
                    const CustomTextField(
                      hintText: 'رقم الموبايل او البريد الالكتروني',
                      prefixIcon: Icons.phone_android,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16.h),
                    const CustomTextField(
                      hintText: 'كلمة المرور',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          context.push(AppRoutes.forgetPasswordScreen);
                        },
                        child: Text(
                          'نسيت كلمة المرور',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white70,
                            fontFamily: 'Zain',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomButton(
                      text: 'تسجيل الدخول',
                      onPressed: () {
                        context.push(AppRoutes.homePageScreen);
                      },
                      backgroundColor: AppColors.buttonColor,
                      textColor: AppColors.primary500,
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لديك حساب ؟ ',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.sp,
                            fontFamily: 'Zain',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.registerScreen);
                          },
                          child: Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              color: AppColors.primary400,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Zain',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
