import 'package:flutter/material.dart';
import 'package:complaints_sys/features/auth/domain/usecases/logout_usecase.dart';

class ProfileProvider with ChangeNotifier {
  final LogoutUseCase _logoutUseCase;

  ProfileProvider(this._logoutUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> logout() async {
    _isLoading = true;
    notifyListeners();

    final result = await _logoutUseCase.execute();

    _isLoading = false;
    notifyListeners();

    return result.isRight();
  }
}
