import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:complaints_sys/features/complaints/domain/entities/dropdown_item.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/get_complaint_types_usecase.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/get_government_entities_usecase.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/submit_complaint_usecase.dart';

enum DataLoadingState { initial, loading, loaded, error }

class AddComplaintProvider with ChangeNotifier {
  final GetComplaintTypesUseCase _getComplaintTypes;
  final GetGovernmentEntitiesUseCase _getGovernmentEntities;
  final SubmitComplaintUseCase _submitComplaint;

  AddComplaintProvider(
    this._getComplaintTypes,
    this._getGovernmentEntities,
    this._submitComplaint,
  );

  DataLoadingState _dataLoadingState = DataLoadingState.initial;
  DataLoadingState get dataLoadingState => _dataLoadingState;

  String _dataError = '';
  String get dataError => _dataError;

  List<DropdownItem> _complaintTypes = [];
  List<DropdownItem> get complaintTypes => _complaintTypes;

  List<DropdownItem> _governmentEntities = [];
  List<DropdownItem> get governmentEntities => _governmentEntities;

  List<String> _attachments = [];
  List<String> get attachments => _attachments;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  String? _submissionError;
  String? get submissionError => _submissionError;

  Future<void> loadInitialData() async {
    if (_dataLoadingState == DataLoadingState.loaded ||
        _dataLoadingState == DataLoadingState.loading) {
      return;
    }

    _dataLoadingState = DataLoadingState.loading;
    notifyListeners();

    final typesResult = await _getComplaintTypes.execute();
    final entitiesResult = await _getGovernmentEntities.execute();

    typesResult.fold(
      (failure) {
        _dataError = failure.message;
        _dataLoadingState = DataLoadingState.error;
      },
      (types) {
        _complaintTypes = types;
      },
    );

    entitiesResult.fold(
      (failure) {
        _dataError = failure.message;
        _dataLoadingState = DataLoadingState.error;
      },
      (entities) {
        _governmentEntities = entities;
      },
    );

    if (_dataLoadingState != DataLoadingState.error) {
      _dataLoadingState = DataLoadingState.loaded;
    }
    notifyListeners();
  }

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        _attachments.addAll(result.paths.map((path) => path!).toList());
        notifyListeners();
      } else {
        debugPrint("File picking cancelled by user.");
      }
    } catch (e) {
      debugPrint("FilePicker Error: $e");
    }
  }

  void removeFile(int index) {
    _attachments.removeAt(index);
    notifyListeners();
  }

  Future<bool> submitComplaint({
    required String name,
    required String complaintTypeId,
    required String governmentEntityId,
    required String locationDescription,
    required String problemDescription,
  }) async {
    _isSubmitting = true;
    _submissionError = null;
    notifyListeners();

    final result = await _submitComplaint.execute(
      name: name,
      complaintTypeId: complaintTypeId,
      governmentEntityId: governmentEntityId,
      locationDescription: locationDescription,
      problemDescription: problemDescription,
      attachments: _attachments,
    );

    _isSubmitting = false;

    return result.fold(
      (failure) {
        _submissionError = failure.message;
        notifyListeners();
        return false;
      },
      (successResult) {
        _submissionError = null;
        notifyListeners();
        return true;
      },
    );
  }

  void clearAttachments() {
    _attachments = [];
    notifyListeners();
  }

  void clearState() {
    _attachments = [];
    _submissionError = null;
    _isSubmitting = false;
    _dataLoadingState = DataLoadingState.initial;
    _complaintTypes = [];
    _governmentEntities = [];
  }
}
