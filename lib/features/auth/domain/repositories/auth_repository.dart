import 'package:dartz/dartz.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/auth/domain/entities/auth_result.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> login(String email, String password,
      {String? deviceToken});

  Future<Either<Failure, void>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, AuthResult>> verifyOtp({
    required String email,
    required String otpCode,
    String? deviceToken,
  });

  Future<Either<Failure, void>> logout();
}
