import 'package:dartz/dartz.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> execute() async {
    return await repository.logout();
  }
}
