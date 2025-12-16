import 'package:hive/hive.dart';
import 'package:complaints_sys/features/notifications/data/models/notification_item.dart';

class NotificationItemAdapter extends TypeAdapter<NotificationItem> {
  @override
  final int typeId = 0;

  @override
  NotificationItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationItem(
      title: fields[0] as String,
      body: fields[1] as String,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.timestamp);
  }
}
