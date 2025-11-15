import 'package:complaints_sys/app/responsive/ui_helper.dart';
import 'package:complaints_sys/app/theme/app_theme.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/login_widgets/textfield.dart';
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

                      color: AppColors.secondary,
                    ),
                  ),

                  const SizedBox(height: 25),
                  SizedBox(
                    width: UIHelpers.w(context, 350),
                    child: CustomTextField(hintText: 'رقم الهاتف'),
                  ),
                  const SizedBox(height: 9),
                  SizedBox(
                    width: UIHelpers.w(context, 350),
                    child: CustomTextField(
                      hintText: 'كلمة المرور',

                      isPassword: true,
                    ),
                  ),
                  SizedBox(height: 7),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 19),
                      child: GestureDetector(
                        onTap: () {},

                        child: Text(
                          'هل نسيت كلمة المرور',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.secondary),

                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: UIHelpers.h(context, 50)),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryWhite,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: UIHelpers.h(context, 60),
                    width: UIHelpers.h(context, 180),

                    child: Center(
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 99),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'إنشاء حساب جديد',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                fontSize: UIHelpers.font(context, 12),
                                color: const Color.fromARGB(255, 158, 135, 18),
                              ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            ' ليس لديك حساب؟',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(
                                  fontSize: UIHelpers.font(context, 12),
                                  color: AppColors.secondary,
                                ),
                          ),
                        ),
                      ],
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
