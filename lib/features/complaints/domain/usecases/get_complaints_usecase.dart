import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/complaints/domain/entities/complain.dart';
import 'package:complaints_sys/features/complaints/domain/repositories/complaint_repository.dart';
import 'package:dartz/dartz.dart';

class GetComplaintsUseCase {
    final ComplaintRepository repository;

  GetComplaintsUseCase({required this.repository});
   Future<Either<Failure, List<Complaint>>> call() async {
    return await repository.getComplaints();
  }
    
}