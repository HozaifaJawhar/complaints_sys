import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/provider/register_provider.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_button.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register(BuildContext context) async {
    final authProvider = context.read<RegisterProvider>();
    if (_formKey.currentState!.validate()) {
      bool success = await authProvider.register(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
      );

      if (success && mounted) {
        context.push(AppRoutes.otpScreen, extra: _emailController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
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
                          CustomTextField(
                            hintText: 'الاسم الثلاثي',
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            validator: (value) => value == null || value.isEmpty
                                ? 'الرجاء إدخال الاسم'
                                : null,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            hintText: 'رقم الموبايل',
                            prefixIcon: Icons.phone_android,
                            keyboardType: TextInputType.phone,
                            controller: _phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال رقم الموبايل';
                              }
                              if (value.length != 10) {
                                return 'يجب أن يكون الرقم 10 أرقام';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
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
                                return 'يجب أن تكون 8 محارف على الأقل';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            hintText: 'تأكيد كلمة المرور',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء تأكيد كلمة المرور';
                              }
                              if (value != _passwordController.text) {
                                return 'كلمتا المرور غير متطابقتين';
                              }
                              return null;
                            },
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
                                : () => _register(context),
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
                                    'إنشاء حساب',
                                    style: TextStyle(
                                      color: AppColors.primary500,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Zain',
                                    ),
                                  ),
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
                                onTap: authProvider.isLoading
                                    ? null
                                    : () {
                                        context.pop();
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
          ),
        );
      },
    );
  }
}
