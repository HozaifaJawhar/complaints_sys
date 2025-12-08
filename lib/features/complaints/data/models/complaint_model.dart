import 'package:complaints_sys/features/complaints/domain/entities/complaint.dart';

class ComplaintModel extends Complaint {
  ComplaintModel({
    required super.state,
    required super.id,
    required super.referenceNumber,
    required super.createdAt,
    required super.locationDescription,
    required super.problemDescription,
    required List<String> attachments,
    super.complaintTypeId,
    super.governmentEntityId,
    super.complaintTypeName,
    super.governmentEntityName,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      referenceNumber: json['reference_number'],
      state: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      locationDescription: json['location_description'] ?? '',
      problemDescription: json['problem_description'] ?? '',
      complaintTypeId: json['complaint_type_id'],
      governmentEntityId: json['government_entity_id'],
      complaintTypeName: json['complaint_type'],
      governmentEntityName: json['government_entity'],
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }
}
