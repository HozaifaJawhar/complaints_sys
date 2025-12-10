import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/complaints/domain/entities/complaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;

  const ComplaintCard({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          FocusScope.of(context).unfocus();
        context.push(AppRoutes.complaintDetailsScreen, extra: complaint);
      },
      child: Container(
        height: 92.h,
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
              width: 30.w,
              height: 30.w,
              decoration: const BoxDecoration(
                color: AppColors.buttonColor,
                shape: BoxShape.rectangle,
              ),
              child: const Icon(
                Icons.description,
                color: AppColors.primary500,
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
                  /// Complaint id
                  Text(
                    'الشكوى:  ${complaint.referenceNumber}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 6.h),

                  /// Status
                  Row(
                    children: [
                      const Icon(
                        Icons.info,
                        size: 16,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'حالة الشكوى: ${complaint.state}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.buttonColor,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
                        'تاريخ التقديم:  ${complaint.createdAt.year}/${complaint.createdAt.month}/${complaint.createdAt.day}',
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
