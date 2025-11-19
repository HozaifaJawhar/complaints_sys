// import 'package:complaints_sys/core/constants/app_colors.dart';
// import 'package:complaints_sys/core/constants/app_routes.dart';
// import 'package:complaints_sys/features/auth/presentation/widgets/custom_button.dart';
// import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// class ForgetPasswordScreen extends StatelessWidget {
//   const ForgetPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('نسيت كلمة المرور '), centerTitle: true),
//       resizeToAvoidBottomInset: true,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,

//             children: [
//               SizedBox(height: 50.h),
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100.r),
//                     color: const Color.fromARGB(255, 247, 244, 244),
//                   ),
//                   width: 170.w,
//                   height: 170.h,
//                   child: Center(
//                     child: Icon(
//                       Icons.lock_person_outlined,
//                       color: AppColors.primary500,
//                       size: 100.sp,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30.h),
//               Text(
//                 textAlign: TextAlign.center,
//                 'الرجاء إدخال عنوان بريدك الالكتروني لتلقي رمز التحقق',
//                 style: TextStyle(fontSize: 18.sp, fontFamily: 'Zain'),
//               ),
//               SizedBox(height: 60.h),

//               const CustomTextField(
//                 hintText: 'البريد الالكتروني',
//                 prefixIcon: Icons.email_outlined,
//               ),
//               SizedBox(height: 60.h),
//               Container(
//                 width: 200.w,
//                 child: CustomButton(
//                   text: 'إرسال',
//                   onPressed: () {
//                     context.push(AppRoutes.otpPasswordScreen);
//                   },
//                   backgroundColor: AppColors.primary500,
//                   textColor: AppColors.fillColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
