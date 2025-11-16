import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/provider/login_provider.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_button.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) async {
    final authProvider = context.read<LoginProvider>();
    if (_formKey.currentState!.validate()) {
      bool success = await authProvider.login(
        _emailController.text,
        _passwordController.text,
      );
      if (success && mounted) {
        context.go(AppRoutes.homeScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, authProvider, child) {
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
                    child: Form(
                      key: _formKey,
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
                          CustomTextField(
                            hintText: 'البريد الإلكتروني',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال البريد الإلكتروني';
                              }
                              if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+',
                              ).hasMatch(value)) {
                                return 'الرجاء إدخال بريد إلكتروني صحيح';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            hintText: 'كلمة المرور',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال كلمة المرور';
                              }
                              if (value.length < 8) {
                                return 'يجب أن تكون كلمة المرور 8 محارف على الأقل';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12.h),
                          Align(
                            alignment: Alignment.centerRight,
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
                          if (authProvider.errorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                              child: Text(
                                authProvider.errorMessage!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red[300],
                                  fontSize: 15.sp,
                                  fontFamily: 'Zain',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (authProvider.errorMessage == null)
                            SizedBox(height: 30.h),
                          CustomButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : () => _login(context),
                            backgroundColor: AppColors.buttonColor,
                            textColor: AppColors.primary500,
                            child: authProvider.isLoading
                                ? SizedBox(
                                    height: 25.h,
                                    width: 25.w,
                                    child: const CircularProgressIndicator(
                                      color: AppColors.primary500,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      color: AppColors.primary500,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Zain',
                                    ),
                                  ),
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
                                onTap: authProvider.isLoading
                                    ? null // منع الضغط أثناء التحميل
                                    : () {
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
          ),
        );
      },
    );
  }
}
