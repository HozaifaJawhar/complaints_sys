import 'package:complaints_sys/features/complaints/domain/entities/complaint.dart';

class ComplaintModel extends Complaint {
  ComplaintModel({
    required super.state,
    required super.id,
    required super.referenceNumber,
    required super.createdAt,
    required super.locationDescription,
    required super.problemDescription,
    required super.attachments, // Fix: Pass to super
    super.complaintTypeId,
    super.governmentEntityId,
    super.complaintTypeName,
    super.governmentEntityName,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    // Robust attachment parsing
    List<String> parsedAttachments = [];
    if (json['attachments'] != null && json['attachments'] is List) {
      for (var item in json['attachments']) {
        if (item is String) {
          parsedAttachments.add(item);
        } else if (item is Map) {
          // Handle case where attachment is an object (e.g. {file_path: ...})
          // API returns: {"id": 1, "file_path": "...", ...}
          if (item['file_path'] != null) {
            parsedAttachments.add(item['file_path'].toString());
          } else if (item['url'] != null) {
            parsedAttachments.add(item['url'].toString());
          } else if (item['path'] != null) {
            parsedAttachments.add(item['path'].toString());
          }
        }
      }
    }

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
      attachments: parsedAttachments,
    );
  }
}
