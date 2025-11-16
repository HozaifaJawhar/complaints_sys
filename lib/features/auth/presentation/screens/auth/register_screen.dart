import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_button.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                    SizedBox(height: 30.h),
                    Text(
                      'إنشاء حساب',
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
                      'قم بإدخال معلوماتك الشخصية لتتمكن\nمن استخدام تطبيقنا',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.sp,
                        fontFamily: 'Zain',
                      ),
                    ),
                    SizedBox(height: 30.h),
                    const CustomTextField(
                      hintText: 'الاسم الثلاثي',
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 16.h),
                    const CustomTextField(
                      hintText: 'رقم الموبايل',
                      prefixIcon: Icons.phone_android,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16.h),
                    const CustomTextField(
                      hintText: 'البريد الإلكتروني',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),
                    const CustomTextField(
                      hintText: 'كلمة المرور',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    SizedBox(height: 16.h),
                    const CustomTextField(
                      hintText: 'تأكيد كلمة المرور',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    SizedBox(height: 30.h),
                    CustomButton(
                      text: 'تسجيل الدخول',
                      onPressed: () {
                        context.push(AppRoutes.otpScreen);
                      },
                      backgroundColor: AppColors.buttonColor,
                      textColor: AppColors.primary500,
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' لديك حساب ؟ ',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.sp,
                            fontFamily: 'Zain',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // العودة إلى شاشة تسجيل الدخول
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'تسجيل الدخول',
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
