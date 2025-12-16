import 'package:flutter/material.dart';
import 'package:complaints_sys/core/services/notification_storage_service.dart';
import 'package:complaints_sys/features/auth/domain/usecases/logout_usecase.dart';

class ProfileProvider with ChangeNotifier {
  final LogoutUseCase _logoutUseCase;
  final NotificationStorageService _notificationStorageService;

  ProfileProvider(this._logoutUseCase, this._notificationStorageService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> logout() async {
    _isLoading = true;
    notifyListeners();

    final result = await _logoutUseCase.execute();

    if (result.isRight()) {
      await _notificationStorageService.clear();
    }

    _isLoading = false;
    notifyListeners();

    return result.isRight();
  }
}
