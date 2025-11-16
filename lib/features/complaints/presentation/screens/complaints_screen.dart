import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:complaints_sys/core/constants/app_colors.dart';

class ComplaintsListScreen extends StatelessWidget {
  const ComplaintsListScreen({super.key});

  static final List<Map<String, String>> _mockComplaints = [
    {
      "title": "تعطل إنارة الشارع",
      "status": "قيد المعالجة",
      "date": "2025-11-15",
    },
    {"title": "حفرة في الطريق العام", "status": "منجزة", "date": "2025-11-10"},
    {"title": "تأخر في جمع القمامة", "status": "مرفوضة", "date": "2025-11-05"},
    {"title": "انقطاع مياه", "status": "قيد المعالجة", "date": "2025-11-02"},
    {"title": "طلب صيانة", "status": "منجزة", "date": "2025-10-28"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.fillColor.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('الشكاوى السابقة'),
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        itemCount: _mockComplaints.length,
        itemBuilder: (context, index) {
          final complaint = _mockComplaints[index];
          return _buildComplaintCard(
            theme: theme,
            title: complaint['title']!,
            status: complaint['status']!,
            date: complaint['date']!,
          );
        },
      ),
    );
  }

  Widget _buildComplaintCard({
    required ThemeData theme,
    required String title,
    required String status,
    required String date,
  }) {
    Color statusColor;
    switch (status) {
      case "منجزة":
        statusColor = Colors.lightGreenAccent.shade400;
        break;
      case "مرفوضة":
        statusColor = Colors.redAccent.shade200;
        break;
      default:
        statusColor = Colors.yellowAccent.shade400;
    }

    return Card(
      color: AppColors.primary500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: () {
          // TODO: إضافة الانتقال لصفحة تفاصيل الشكوى
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Zain',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      status,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Zain',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                date,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
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
