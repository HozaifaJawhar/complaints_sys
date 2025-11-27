class Complaint {
  final int id;
  final String referenceNumber;
  final DateTime createdAt;
  final String state;

  
  const Complaint({
    required this.state, 
    required this.id,
    required this.referenceNumber,
    required this.createdAt,
  });
}