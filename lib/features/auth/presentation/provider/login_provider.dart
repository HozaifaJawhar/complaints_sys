import 'package:flutter/material.dart';
import 'package:complaints_sys/features/auth/domain/usecases/login_usecase.dart';

class LoginProvider with ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginProvider(this._loginUseCase);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _loginUseCase.execute(email, password);
    _isLoading = false;

    return result.fold(
      (failure) {
        _errorMessage = 'البريد الالكتروني أو كلمة المرور خاطئة';
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
