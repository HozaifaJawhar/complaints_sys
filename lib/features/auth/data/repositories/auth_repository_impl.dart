import 'package:dartz/dartz.dart';
import 'package:complaints_sys/core/constants/api_constants.dart';
import 'package:complaints_sys/core/errors/exceptions.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/core/api/api_helper.dart';
import 'package:complaints_sys/core/services/secure_storage_service.dart';
import 'package:complaints_sys/features/auth/data/models/auth_result_model.dart';
import 'package:complaints_sys/features/auth/domain/entities/auth_result.dart';
import 'package:complaints_sys/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Api api;
  final SecureStorageService storage;

  AuthRepositoryImpl({required this.api, required this.storage});

  @override
  Future<Either<Failure, AuthResult>> login(
    String email,
    String password, {
    String? deviceToken,
  }) async {
    try {
      final url = ApiConstants.baseUrl + ApiConstants.loginUrl;
      final body = {
        'email': email,
        'password': password,
        if (deviceToken != null) 'device_token': deviceToken,
      };
      final response = await api.post(url: url, body: body, token: null);
      final authResult = AuthResultModel.fromJson(response);
      await storage.writeToken(authResult.token);
      return Right(authResult);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        const ServerFailure('حدث خطأ غير متوقع، يرجى المحاولة لاحقاً'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final url = ApiConstants.baseUrl + ApiConstants.registerUrl;
      final body = {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };

      await api.post(url: url, body: body, token: null);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        const ServerFailure('حدث خطأ غير متوقع، يرجى المحاولة لاحقاً'),
      );
    }
  }

  @override
  Future<Either<Failure, AuthResult>> verifyOtp({
    required String email,
    required String otpCode,
    String? deviceToken,
  }) async {
    try {
      final url = ApiConstants.baseUrl + ApiConstants.verifyOtpUrl;
      final body = {
        'email': email,
        'otp_code': otpCode,
        if (deviceToken != null) 'device_token': deviceToken,
      };
      final response = await api.post(url: url, body: body, token: null);
      final authResult = AuthResultModel.fromJson(response);
      await storage.writeToken(authResult.token);
      return Right(authResult);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        const ServerFailure('حدث خطأ غير متوقع، يرجى المحاولة لاحقاً'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // 1. الحصول على التوكن الحالي
      final token = await storage.readToken();

      // 2. استدعاء API لإعلام السيرفر بتسجيل الخروج
      if (token != null) {
        final url = ApiConstants.baseUrl + ApiConstants.logoutUrl;
        await api.post(url: url, body: {}, token: token);
      }

      // 3. حذف التوكن من الجهاز
      await storage.deleteToken();

      // 4. إرجاع نجاح
      return Right(null);
    } catch (e) {
      // 4. إرجاع خطأ في حال فشل الحذف
      return Left(
        const ServerFailure('فشل تسجيل الخروج، يرجى المحاولة لاحقاً'),
      );
    }
  }
}
