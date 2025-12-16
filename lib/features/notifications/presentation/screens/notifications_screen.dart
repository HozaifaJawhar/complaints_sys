import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:complaints_sys/features/complaints/presentation/widgets/filtter_wedget.dart';
import 'package:complaints_sys/features/notifications/presentation/wedgets/notify_wedget.dart';
import 'package:complaints_sys/features/notifications/data/models/notification_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('الاشعارات', style: TextStyle(color: AppColors.primary500)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<NotificationItem>('notifications_box').listenable(),
              builder: (context, Box<NotificationItem> box, _) {
                final notifications = box.values.toList().reversed.toList();

                if (notifications.isEmpty) {
                  return const Center(child: Text("لا توجد إشعارات"));
                }

                return ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: NotifyWedget(
                        title: notification.title,
                        body: notification.body,
                        date: notification.timestamp,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
