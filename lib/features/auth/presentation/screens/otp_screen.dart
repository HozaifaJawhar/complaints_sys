import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/provider/otp_provider.dart';

class OTPScreen extends StatefulWidget {
  final String email;

  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _verifyOtp(BuildContext context) async {
    final otpProvider = context.read<OtpProvider>();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    bool success = await otpProvider.verifyOtp(
      widget.email,
      _pinController.text,
    );

    if (success && mounted) {
      context.go(AppRoutes.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<OtpProvider>(
      builder: (context, otpProvider, child) {
        final defaultPinTheme = PinTheme(
          width: 56.w,
          height: 60.h,
          textStyle: theme.textTheme.headlineMedium?.copyWith(
            fontFamily: 'Zain',
          ),
          decoration: BoxDecoration(
            color: AppColors.fillColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.transparent),
          ),
        );

        return Scaffold(
          appBar: AppBar(title: const Text('التحقق من بريدك الإلكتروني')),
          body: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.fillColor,
                      ),
                      child: Icon(
                        Icons.mark_email_read_outlined,
                        size: 80.sp,
                        color: AppColors.primary500,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'الرجاء إدخال الرمز المكون من 6 أرقام المرسل إلى',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.email,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontFamily: 'Zain',
                        color: AppColors.primary500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 6,
                        controller: _pinController,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(color: AppColors.primary500),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(color: AppColors.primary400),
                          ),
                        ),
                        validator: (s) {
                          if (s?.length != 6) {
                            return 'Error';
                          }
                          return null;
                        },
                        errorTextStyle: const TextStyle(fontSize: 0, height: 0),
                      ),
                    ),
                    if (otpProvider.errorMessage != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          otpProvider.errorMessage!,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.red,
                            fontFamily: 'Zain',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      SizedBox(height: 40.h),
                    SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: otpProvider.isLoading
                            ? null
                            : () => _verifyOtp(context),
                        child: otpProvider.isLoading
                            ? SizedBox(
                                height: 25.h,
                                width: 25.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text('تأكيد'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
