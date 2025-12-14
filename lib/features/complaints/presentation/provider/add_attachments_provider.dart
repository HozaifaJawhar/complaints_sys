import 'package:flutter/material.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/add_attachments_usecase.dart';
import 'package:dartz/dartz.dart';

class AddAttachmentsProvider with ChangeNotifier {
  final AddAttachmentsUseCase _useCase;

  AddAttachmentsProvider(this._useCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  /// رفع المرفقات
  Future<void> uploadAttachments({
    required int complaintId,
    required List<String> attachments,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    final Either<Failure, dynamic> result = await _useCase.execute(
      complaintId: complaintId,
      attachments: attachments,
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
      },
      (success) {
        _successMessage = success.message;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  /// إعادة تهيئة الحالة
  void clearState() {
    _isLoading = false;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
}
