import 'package:complaints_sys/features/complaints/domain/entities/complaint_submission_result.dart';

class ComplaintSubmissionResultModel extends ComplaintSubmissionResult {
  const ComplaintSubmissionResultModel({
    required String message,
    required String referenceNumber,
    required int complaintId,
  }) : super(
         message: message,
         referenceNumber: referenceNumber,
         complaintId: complaintId,
       );

  factory ComplaintSubmissionResultModel.fromJson(Map<String, dynamic> json) {
    return ComplaintSubmissionResultModel(
      message: json['message'],
      referenceNumber: json['reference_number'],
      complaintId: json['complaint_id'],
    );
  }
}
