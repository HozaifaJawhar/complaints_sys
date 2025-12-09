import 'package:complaints_sys/features/complaints/domain/entities/complaint.dart';
import 'package:complaints_sys/features/complaints/domain/repositories/complaint_repository.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class GetComplaintsUseCase {
  final ComplaintRepository repository;

  GetComplaintsUseCase({required this.repository});

  Future<Either<Failure, List<Complaint>>> call({String? status}) async {
    return await repository.getComplaints(status: status);
  }
}
