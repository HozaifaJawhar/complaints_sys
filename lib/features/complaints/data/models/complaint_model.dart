import 'package:complaints_sys/features/complaints/domain/entities/complain.dart';

class ComplaintModel extends Complaint {
  ComplaintModel({required super.state, required super.id, required super.referenceNumber, required super.createdAt});
  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      referenceNumber: json['reference_number'],
      state: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}