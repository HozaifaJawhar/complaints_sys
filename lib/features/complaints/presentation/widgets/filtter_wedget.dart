import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiltterWedget extends StatelessWidget {
  const FiltterWedget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Container(
        height: 58.h,
        width: 50.w,
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Icon(
            size: 30,
            Icons.filter_alt_outlined,
            color: AppColors.primary400,
          ),
        ),
      ),
    );
  }
}
