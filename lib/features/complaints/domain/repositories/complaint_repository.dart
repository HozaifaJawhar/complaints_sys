import 'package:complaints_sys/features/complaints/domain/entities/complaint.dart';
import 'package:dartz/dartz.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/complaints/domain/entities/complaint_submission_result.dart';
import 'package:complaints_sys/features/complaints/domain/entities/dropdown_item.dart';

abstract class ComplaintRepository {
  // --- GET ---
  Future<Either<Failure, List<DropdownItem>>> getComplaintTypes();
  Future<Either<Failure, List<DropdownItem>>> getGovernmentEntities();
  Future<Either<Failure, List<Complaint>>> getComplaints({String? status});

  // --- POST ---
  Future<Either<Failure, ComplaintSubmissionResult>> submitComplaint({
    required String name,
    required String complaintTypeId,
    required String governmentEntityId,
    required String locationDescription,
    required String problemDescription,
    required List<String> attachments,
  });
}
