import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:complaints_sys/features/complaints/presentation/widgets/filtter_wedget.dart';
import 'package:complaints_sys/features/notifications/presentation/wedgets/notify_wedget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('الإعلانات', style: TextStyle(color: AppColors.primary500)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 300.w,
                  child: CustomTextField(
                    hintText: 'ابحث هنا',
                    prefixIcon: Icons.search,
                  ),
                ),
                FiltterWedget(),
              ],
            ),
          ),
          // SizedBox(height: 4.h),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return NotifyWedget();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
