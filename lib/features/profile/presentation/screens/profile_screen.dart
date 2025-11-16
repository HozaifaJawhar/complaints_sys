import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/profile/presentation/provider/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) async {
    final authProvider = context.read<ProfileProvider>();
    bool success = await authProvider.logout();
    if (success && context.mounted) {
      context.go(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<ProfileProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.fillColor.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        children: [
          // // صورة الحساب والاسم
          // Center(
          //   child: CircleAvatar(
          //     radius: 50.r,
          //     backgroundColor: Colors.grey.shade300,
          //     // يمكنك استخدام NetworkImage هنا
          //     backgroundImage: const NetworkImage(
          //       'https://placehold.co/100x100/EFEFEF/AAAAAA?text=User',
          //     ),
          //   ),
          // ),
          // SizedBox(height: 12.h),
          // Text(
          //   'محمد ملهم الرقمي', // TODO: استبدل بالاسم الحقيقي
          //   textAlign: TextAlign.center,
          //   style: theme.textTheme.titleLarge?.copyWith(
          //     color: Colors.black,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // SizedBox(height: 24.h),
          _buildSectionTitle('الإعدادات الرئيسية', theme),
          _buildProfileCard(
            theme: theme,
            children: [
              _buildOptionRow(
                theme: theme,
                icon: Icons.logout,
                text: 'تسجيل الخروج',
                color: Colors.red,
                trailing: authProvider.isLoading
                    ? SizedBox(
                        height: 20.r,
                        width: 20.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.red,
                        ),
                      )
                    : const Icon(Icons.arrow_back_ios_new, size: 16),
                onTap: authProvider.isLoading ? null : () => _logout(context),
              ),
              _buildOptionRow(
                theme: theme,
                icon: Icons.delete_forever,
                text: 'حذف الحساب',
                color: Colors.red,
                trailing: const Icon(Icons.arrow_back_ios_new, size: 16),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 24.h),
          // _buildSectionTitle('الخصوصية والتعديل', theme),
          // _buildProfileCard(
          //   theme: theme,
          //   children: [
          //     _buildOptionRow(
          //       theme: theme,
          //       icon: Icons.email,
          //       text: 'البريد الالكتروني',
          //       subtitle: 'molham.saad.aldien@gmail.com', // TODO: استبدل
          //       onTap: null,
          //     ),
          //     _buildOptionRow(
          //       theme: theme,
          //       icon: Icons.phone_android,
          //       text: 'رقم الموبايل',
          //       subtitle: '+963 935 650 123', // TODO: استبدل
          //       onTap: null,
          //     ),
          //     _buildOptionRow(
          //       theme: theme,
          //       icon: Icons.lock,
          //       text: 'تغيير كلمة المرور',
          //       trailing: const Icon(Icons.arrow_back_ios_new, size: 16),
          //       onTap: () {},
          //     ),
          //   ],
          // ),
          // SizedBox(height: 24.h),
          _buildSectionTitle('الدعم والاتصال', theme),
          _buildProfileCard(
            theme: theme,
            children: [
              _buildOptionRow(
                theme: theme,
                icon: Icons.support_agent,
                text: 'البريد الالكتروني',
                subtitle: 'gevernment@syComplaint.com',
                onTap: null,
              ),
              _buildOptionRow(
                theme: theme,
                icon: Icons.headset_mic,
                text: 'الخط الساخن',
                subtitle: '111',
                onTap: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w, bottom: 8.h),
      child: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade700,
          fontFamily: 'Zain',
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required ThemeData theme,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // --- ويدجت مساعد لسطر الخيارات ---
  Widget _buildOptionRow({
    required ThemeData theme,
    required IconData icon,
    required String text,
    String? subtitle,
    Color? color,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    Color itemColor = color ?? Colors.black87;

    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: itemColor, size: 24.sp),
      title: Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: itemColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Zain',
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
                fontFamily: 'Zain',
              ),
            )
          : null,
      trailing: onTap != null
          ? (trailing ?? const Icon(Icons.error, size: 16))
          : null,
      iconColor: itemColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    );
  }
}
