import 'package:complaints_sys/features/complaints/domain/entities/add_atachments_result.dart';

class AddAtachmentsResultModel extends AddAtachmentsResult {
  AddAtachmentsResultModel({required super.message, required super.addedAttachmentsCount});
  factory AddAtachmentsResultModel.fromJson(Map<String, dynamic> json) {
    return AddAtachmentsResultModel(
      message: json['message'],
      addedAttachmentsCount: json['added_attachments_count'],
    );
  }
}