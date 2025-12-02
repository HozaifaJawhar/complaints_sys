class Complaint {
  final int id;
  final String referenceNumber;
  final DateTime createdAt;
  final String state;
 final int complaintTypeId;
 final int governmentEntityId;
  final String locationDescription;
  final String problemDescription;
  final List<String>? attachments;

  Complaint({required this.complaintTypeId, required this.governmentEntityId, 
    required this.id,
    required this.referenceNumber,
    required this.createdAt,
    required this.state,
   required this.locationDescription,
    required this.problemDescription,
    this.attachments,
  });
}