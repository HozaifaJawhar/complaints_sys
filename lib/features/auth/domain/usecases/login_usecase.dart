import 'package:complaints_sys/features/auth/domain/entities/auth_result.dart';
import 'package:complaints_sys/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:complaints_sys/core/errors/failures.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthResult>> execute(
    String email,
    String password, {
    String? deviceToken,
  }) async {
    return await repository.login(email, password, deviceToken: deviceToken);
  }
}
