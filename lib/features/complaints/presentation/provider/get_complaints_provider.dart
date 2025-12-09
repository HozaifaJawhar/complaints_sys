import 'package:complaints_sys/features/complaints/domain/entities/complaint.dart';
import 'package:flutter/material.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/get_complaints_usecase.dart';

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
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String? _currentStatus;
  String? get currentStatus => _currentStatus;

  List<Complaint> get filteredComplaints {
    final q = _searchQuery.trim().toLowerCase();
    // Strict prefix search: case-insensitive, starts with query.
    return _complaints.where((c) {
      return c.referenceNumber.toLowerCase().startsWith(q);
    }).toList();
  }

  // ----------------- ACTION: LOAD COMPLAINTS -----------------
  Future<void> loadComplaints({String? status}) async {
    // If status is provided, update current status.
    // If status is NOT provided (null), keep using _currentStatus (unless we want to clear it? No, usually we want to refresh current view).
    // But wait, if we want to clear filter, we pass empty string or specific value?
    // The UI passes '' for "All".

    if (status != null) {
      _currentStatus = status.isEmpty ? null : status;
    }

    print(
        "🔥 loadComplaints CALLED with status: $status, current: $_currentStatus");

    _state = ComplaintsState.loading;
    _searchQuery = '';
    notifyListeners();

    final result = await _getComplaints(status: _currentStatus);

    result.fold(
      (failure) {
        print("🔥 ERROR: ${failure.message}");
        _errorMessage = failure.message;
        _state = ComplaintsState.error;
      },
      (data) {
        print("🔥 complaints loaded: ${data.length}");
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
    _searchQuery = '';
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
