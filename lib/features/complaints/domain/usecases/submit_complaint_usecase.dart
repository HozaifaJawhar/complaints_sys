import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/complaints/domain/entities/complaint_submission_result.dart';
import 'package:complaints_sys/features/complaints/domain/repositories/complaint_repository.dart';
import 'package:dartz/dartz.dart';

class SubmitComplaintUseCase {
  final ComplaintRepository repository;
  SubmitComplaintUseCase(this.repository);

  Future<Either<Failure, ComplaintSubmissionResult>> execute({
    required String name,
    required String complaintTypeId,
    required String governmentEntityId,
    required String locationDescription,
    required String problemDescription,
    required List<String> attachments,
  }) async {
    return await repository.submitComplaint(
      name: name,
      complaintTypeId: complaintTypeId,
      governmentEntityId: governmentEntityId,
      locationDescription: locationDescription,
      problemDescription: problemDescription,
      attachments: attachments,
    );
  }
}
