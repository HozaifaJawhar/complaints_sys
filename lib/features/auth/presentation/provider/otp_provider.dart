import 'package:flutter/material.dart';
import 'package:complaints_sys/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:complaints_sys/core/services/notification_service.dart';

class OtpProvider with ChangeNotifier {
  final VerifyOtpUseCase _verifyOtpUseCase;
  final NotificationService _notificationService;

  OtpProvider(this._verifyOtpUseCase, this._notificationService);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String email, String otpCode) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final token = await _notificationService.getToken();
    final result = await _verifyOtpUseCase.execute(
      email: email,
      otpCode: otpCode,
      deviceToken: token,
    );
    _isLoading = false;

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (authResult) {
        notifyListeners();
        return true;
      },
    );
  }
}
