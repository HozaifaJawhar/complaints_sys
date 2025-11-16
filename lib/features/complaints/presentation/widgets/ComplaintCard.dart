import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ComplaintCard extends StatelessWidget {
  // final String title;
  // final String date;
  // final VoidCallback? onTap;

  const ComplaintCard({
    super.key,
    // required this.title,
    // required this.date,
    // this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.complaintDetailsScreen);
      },
      child: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.primary500,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Icon Circle
            Container(
              width: 45.w,
              height: 45.w,
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.description,
                color: AppColors.buttonColor,
                size: 24,
              ),
            ),

            SizedBox(width: 12.w),

            /// Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Complaint title
                  Text(
                    'شكوى رقم 1',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 6.h),

                  /// Date Row
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '11/11/2011',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
