import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiltterWedget extends StatelessWidget {
  final Function(String?) onFilterSelected;

  const FiltterWedget({super.key, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: GestureDetector(
        onTap: () {
          _showFilterDialog(context);
        },
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
              Icons.filter_alt_outlined,
              size: 30,
              color: AppColors.primary400,
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    String? selectedStatus;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('اختر حالة الشكوى'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('قيد الانتطار'),
                  value: 'انتظار',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('قيد المعالجة'),
                  value: 'قيد المعالجة',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('منجزة'),
                  value: 'منجزة',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('مرفوضة'),
                  value: 'مرفوضة',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('الكل'),
                  value: '',
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // الغاء
                },
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () {
                  // هنا يمكنك تطبيق الفلترة حسب selectedStatus
                  print('تم اختيار: $selectedStatus');
                  onFilterSelected(selectedStatus);
                  Navigator.pop(context);
                },
                child: const Text('تأكيد'),
              ),
            ],
          ),
        );
      },
    );
  }
}
