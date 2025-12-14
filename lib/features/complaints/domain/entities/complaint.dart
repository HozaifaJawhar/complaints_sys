class Complaint {
  final int id;
  final String referenceNumber;
  final DateTime createdAt;
  final String state;
  final int? complaintTypeId;
  final int? governmentEntityId;
  final String? complaintTypeName;
  final String? governmentEntityName;
  final String locationDescription;
  final String problemDescription;
   List<String>? attachments;

  Complaint({
    required this.id,
    required this.referenceNumber,
    required this.createdAt,
    required this.state,
    required this.locationDescription,
    required this.problemDescription,
    this.complaintTypeId,
    this.governmentEntityId,
    this.complaintTypeName,
    this.governmentEntityName,
    this.attachments,
  });
}
