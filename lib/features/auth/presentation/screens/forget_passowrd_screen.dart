import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_button.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ForgetPassowrdScreen extends StatelessWidget {
  const ForgetPassowrdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إنشاء كلمة مرور جديدة'), centerTitle: true),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: 50.h),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: const Color.fromARGB(255, 247, 244, 244),
                  ),
                  width: 170.w,
                  height: 170.h,
                  child: Center(
                    child: Icon(
                      Icons.lock_reset,
                      color: AppColors.primary500,
                      size: 100.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                textAlign: TextAlign.center,
                'يجب أن تكون كلمة المرور الجديدة مختلفة عم الكلمةالسابقة المستخدمة',
                style: TextStyle(fontSize: 18.sp, fontFamily: 'Zain'),
              ),
              SizedBox(height: 60.h),
              const CustomTextField(
                hintText: 'كلمة السر الجديدة',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              SizedBox(height: 15.h),
              const CustomTextField(
                hintText: 'تأكيد كلمة السر ',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              SizedBox(height: 60.h),
              Container(
                width: 200.w,
                child: CustomButton(
                  text: 'حفظ',
                  onPressed: () {
                    context.pop();
                  },
                  backgroundColor: AppColors.primary500,
                  textColor: AppColors.fillColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
