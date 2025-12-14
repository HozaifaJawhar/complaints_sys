import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/complaints/domain/entities/add_atachments_result.dart';
import 'package:complaints_sys/features/complaints/domain/repositories/complaint_repository.dart';
import 'package:dartz/dartz.dart';

class AddAttachmentsUseCase {
  final ComplaintRepository repository;

  AddAttachmentsUseCase({required this.repository});

  Future<Either<Failure, AddAtachmentsResult>> execute({
    required int complaintId,
    required List<String> attachments,
  }) async {
    return await repository.addAttachments(
      complaintId: complaintId,
      attachments: attachments,
    );
  }
}
