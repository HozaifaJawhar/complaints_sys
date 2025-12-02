import 'package:complaints_sys/features/complaints/domain/entities/complain.dart';

class ComplaintModel extends Complaint {
  ComplaintModel({required super.state, required super.id, required super.referenceNumber, required super.createdAt, required super.locationDescription, required super.problemDescription, required List<String> attachments, required super.complaintTypeId, required super.governmentEntityId});
 factory ComplaintModel.fromJson(Map<String, dynamic> json) {
  return ComplaintModel(
    id: json['id'],
    referenceNumber: json['reference_number'],
    state: json['status'],
    createdAt: DateTime.parse(json['created_at']),
    locationDescription: json['location_description'],
    problemDescription: json['problem_description'],
     complaintTypeId: json['complaint_type_id'],
      governmentEntityId:  json['government_entity_id'],
       attachments: List<String>.from(json['attachments'] ?? []),
  );
}
}