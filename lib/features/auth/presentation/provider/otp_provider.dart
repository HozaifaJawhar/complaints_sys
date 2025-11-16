import 'package:flutter/material.dart';
import 'package:complaints_sys/features/auth/domain/usecases/verify_otp_usecase.dart';

class OtpProvider with ChangeNotifier {
  final VerifyOtpUseCase _verifyOtpUseCase;

  OtpProvider(this._verifyOtpUseCase);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String email, String otpCode) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _verifyOtpUseCase.execute(
      email: email,
      otpCode: otpCode,
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
