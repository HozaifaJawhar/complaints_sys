import 'package:dartz/dartz.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/auth/domain/entities/auth_result.dart';
import 'package:complaints_sys/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, AuthResult>> execute({
    required String email,
    required String otpCode,
    String? deviceToken,
  }) async {
    return await repository.verifyOtp(
      email: email,
      otpCode: otpCode,
      deviceToken: deviceToken,
    );
  }
}
