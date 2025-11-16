import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ComlaintDetailsScreen extends StatelessWidget {
  const ComlaintDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل الشكوى',
          style: TextStyle(color: AppColors.primary500),
        ),
      ),
    );
  }
}
