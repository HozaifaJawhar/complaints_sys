import 'package:complaints_sys/core/constants/api_constants.dart';
import 'package:complaints_sys/core/errors/exceptions.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/core/api/api_helper.dart';
import 'package:complaints_sys/core/services/secure_storage_service.dart';
import 'package:complaints_sys/features/complaints/data/models/complaint_submission_result_model.dart';
import 'package:complaints_sys/features/complaints/data/models/dropdown_item_model.dart';
import 'package:complaints_sys/features/complaints/domain/entities/complaint_submission_result.dart';
import 'package:complaints_sys/features/complaints/domain/entities/dropdown_item.dart';
import 'package:complaints_sys/features/complaints/domain/repositories/complaint_repository.dart';
import 'package:dartz/dartz.dart';

class ComplaintRepositoryImpl implements ComplaintRepository {
  final Api api;
  final SecureStorageService storage;

  ComplaintRepositoryImpl({required this.api, required this.storage});

  @override
  Future<Either<Failure, List<DropdownItem>>> getComplaintTypes() async {
    try {
      final token = await storage.readToken();
      final url = ApiConstants.baseUrl + ApiConstants.getComplaintTypesUrl;
      final response = await api.get(url: url, token: token);

      final List<dynamic> data = response['data'];
      final List<DropdownItem> types = data
          .map((itemJson) => DropdownItemModel.fromJson(itemJson))
          .toList();

      return Right(types);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        const ServerFailure('حدث خطأ غير متوقع أثناء جلب أنواع الشكاوى'),
      );
    }
  }

  @override
  Future<Either<Failure, List<DropdownItem>>> getGovernmentEntities() async {
    try {
      final token = await storage.readToken();
      final url = ApiConstants.baseUrl + ApiConstants.getGovEntitiesUrl;
      final response = await api.get(url: url, token: token);

      final List<dynamic> data = response['data'];
      final List<DropdownItem> entities = data
          .map((itemJson) => DropdownItemModel.fromJson(itemJson))
          .toList();

      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        const ServerFailure('حدث خطأ غير متوقع أثناء جلب الجهات الحكومية'),
      );
    }
  }

  @override
  Future<Either<Failure, ComplaintSubmissionResult>> submitComplaint({
    required String name,
    required String complaintTypeId,
    required String governmentEntityId,
    required String locationDescription,
    required String problemDescription,
    required List<String> attachments,
  }) async {
    try {
      final token = await storage.readToken();
      final url = ApiConstants.baseUrl + ApiConstants.addComplaintUrl;

      // تجميع الحقول النصية
      final fields = {
        'name': name,
        'complaint_type_id': complaintTypeId,
        'government_entity_id': governmentEntityId,
        'location_description': locationDescription,
        'problem_description': problemDescription,
      };

      // استدعاء دالة postMultipart
      final response = await api.postMultipart(
        url: url,
        fields: fields,
        filePaths: attachments,
        filesKey: 'attachments', // المفتاح الذي يتوقعه السيرفر للملفات
        token: token,
      );

      // تحليل الاستجابة الناجحة
      final result = ComplaintSubmissionResultModel.fromJson(response);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(const ServerFailure('حدث خطأ غير متوقع أثناء إرسال الشكوى'));
    }
  }
}
