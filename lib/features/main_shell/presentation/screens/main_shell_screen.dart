import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:complaints_sys/core/constants/app_colors.dart';

class MainShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final bool isAddPage = (navigationShell.currentIndex == 2);

    return Scaffold(
      body: navigationShell,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isAddPage
          ? null // (إخفاء الزر)
          : FloatingActionButton(
              onPressed: () {
                navigationShell.goBranch(2, initialLocation: true);
              },
              backgroundColor: AppColors.primary500,
              shape: const CircleBorder(),
              elevation: 4.0,
              child: Icon(
                Icons.description_rounded,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 65.h,
        elevation: 8,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildBottomNavItem(
              context: context,
              icon: Icons.home_rounded,
              label: 'الرئيسية',
              index: 0,
              isActive: navigationShell.currentIndex == 0,
              onTap: () => navigationShell.goBranch(0, initialLocation: true),
            ),
            // _buildBottomNavItem(
            //   context: context,
            //   icon: Icons.article_rounded,
            //   label: 'الشكاوى',
            //   index: 1,
            //   isActive: navigationShell.currentIndex == 1,
            //   onTap: () => navigationShell.goBranch(1, initialLocation: true),
            // ),
            SizedBox(width: 40.w),
            _buildBottomNavItem(
              context: context,
              icon: Icons.person_rounded,
              label: 'الملف الشخصي',
              index: 3,
              isActive: navigationShell.currentIndex == 3,
              onTap: () => navigationShell.goBranch(3, initialLocation: true),
            ),
            // _buildBottomNavItem(
            //   context: context,
            //   icon: Icons.notifications_rounded,
            //   label: 'الإشعارات',
            //   index: 4,
            //   isActive: navigationShell.currentIndex == 4,
            //   onTap: () => navigationShell.goBranch(4, initialLocation: true),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final color = isActive ? AppColors.primary500 : Colors.grey.shade500;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 24.sp),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10.sp,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Zain',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
