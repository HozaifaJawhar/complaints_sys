import 'package:dartz/dartz.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/complaints/domain/entities/dropdown_item.dart';
import 'package:complaints_sys/features/complaints/domain/repositories/complaint_repository.dart';

class GetComplaintTypesUseCase {
  final ComplaintRepository repository;
  GetComplaintTypesUseCase(this.repository);

  Future<Either<Failure, List<DropdownItem>>> execute() async {
    return await repository.getComplaintTypes();
  }
}
