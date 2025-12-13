import 'package:flutter/material.dart';
import 'package:complaints_sys/features/auth/domain/usecases/login_usecase.dart';
import 'package:complaints_sys/core/services/notification_service.dart';

class LoginProvider with ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final NotificationService _notificationService;

  LoginProvider(this._loginUseCase, this._notificationService);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final token = await _notificationService.getToken();
    final result =
        await _loginUseCase.execute(email, password, deviceToken: token);
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
