import 'package:complaints_sys/features/notifications/data/models/notification_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationStorageService {
  static const String _boxName = 'notifications_box';

  Future<void> init() async {
    await Hive.openBox<NotificationItem>(_boxName);
  }

  Box<NotificationItem> get _box => Hive.box<NotificationItem>(_boxName);

  List<NotificationItem> getNotifications() {
    if (!Hive.isBoxOpen(_boxName)) return [];
    // Return reversed list to show newest first
    return _box.values.toList().reversed.toList();
  }

  Future<void> saveNotification({
    required String title,
    required String body,
  }) async {
    if (!Hive.isBoxOpen(_boxName)) await init();

    final notification = NotificationItem(
      title: title,
      body: body,
      timestamp: DateTime.now(),
    );

    await _box.add(notification);
  }

  Future<void> clear() async {
    if (Hive.isBoxOpen(_boxName)) {
      await _box.clear();
    }
  }
}
