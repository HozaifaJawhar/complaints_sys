import 'package:flutter/material.dart';
import 'package:complaints_sys/features/auth/domain/usecases/register_usecase.dart';

class RegisterProvider with ChangeNotifier {
  final RegisterUseCase _registerUseCase;

  RegisterProvider(this._registerUseCase);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _registerUseCase.execute(
      name: name,
      email: email,
      phone: phone,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    _isLoading = false;

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (success) {
        notifyListeners();
        return true;
      },
    );
  }
}
