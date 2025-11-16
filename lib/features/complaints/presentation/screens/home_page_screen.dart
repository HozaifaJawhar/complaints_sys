import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:complaints_sys/features/complaints/presentation/widgets/filtter_wedget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                size: 40,
                Icons.circle_notifications_sharp,
                color: AppColors.primary500,
              ),
              onPressed: () {},
            ),
          ),
        ],
        title: Column(
          children: [
            Text('مرحباً', style: TextStyle(color: AppColors.primary500)),
          ],
        ),
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
        ],
      ),
    );
  }
}
