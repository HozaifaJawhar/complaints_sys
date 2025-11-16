import 'package:dartz/dartz.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await repository.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
