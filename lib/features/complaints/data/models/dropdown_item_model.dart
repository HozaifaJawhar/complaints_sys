import 'package:complaints_sys/features/complaints/domain/entities/dropdown_item.dart';

class DropdownItemModel extends DropdownItem {
  const DropdownItemModel({required int id, required String name})
    : super(id: id, name: name);

  factory DropdownItemModel.fromJson(Map<String, dynamic> json) {
    return DropdownItemModel(id: json['id'], name: json['name']);
  }
}
