import 'package:complaints_sys/features/complaints/domain/entities/complain.dart';
import 'package:flutter/material.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/get_complaints_usecase.dart';
import 'package:complaints_sys/core/errors/failures.dart';

enum ComplaintsState { initial, loading, loaded, error }

class ComplaintsProvider with ChangeNotifier {
  final GetComplaintsUseCase _getComplaints;

  ComplaintsProvider(this._getComplaints);

  // ----------------- STATE -----------------
  ComplaintsState _state = ComplaintsState.initial;
  ComplaintsState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Complaint> _complaints = [];
  List<Complaint> get complaints => _complaints;

  // ----------------- ACTION: LOAD COMPLAINTS -----------------
  Future<void> loadComplaints() async {
    if (_state == ComplaintsState.loading) return;

    _state = ComplaintsState.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _getComplaints();

    result.fold(
      (Failure failure) {
        _errorMessage = failure.message;
        _state = ComplaintsState.error;
      },
      (List<Complaint> data) {
        _complaints = data;
        _state = ComplaintsState.loaded;
      },
    );

    notifyListeners();
  }

  // ----------------- CLEAR STATE -----------------
  void clearState() {
    _state = ComplaintsState.initial;
    _errorMessage = null;
    _complaints = [];
    notifyListeners();
  }
}