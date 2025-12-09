import 'package:complaints_sys/core/constants/api_constants.dart';
import 'package:complaints_sys/core/errors/exceptions.dart';
import 'package:complaints_sys/core/errors/failures.dart';
import 'package:complaints_sys/core/api/api_helper.dart';
import 'package:complaints_sys/core/services/secure_storage_service.dart';
import 'package:complaints_sys/features/complaints/data/models/complaint_model.dart';
import 'package:complaints_sys/features/complaints/data/models/complaint_submission_result_model.dart';
import 'package:complaints_sys/features/complaints/data/models/dropdown_item_model.dart';
import 'package:complaints_sys/features/complaints/domain/entities/complaint.dart';
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
      final List<DropdownItem> types =
          data.map((itemJson) => DropdownItemModel.fromJson(itemJson)).toList();

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
      final List<DropdownItem> entities =
          data.map((itemJson) => DropdownItemModel.fromJson(itemJson)).toList();

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
      return const Left(ServerFailure('حدث خطأ غير متوقع أثناء إرسال الشكوى'));
    }
  }

  @override
  Future<Either<Failure, List<Complaint>>> getComplaints(
      {String? status}) async {
    try {
      final token = await storage.readToken();
      final uri =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getComplaintsUrl)
              .replace(queryParameters: {
        if (status != null && status.isNotEmpty) 'status': status,
      });

      // We need to convert Uri to string because api.get takes a string (based on my reading of Api class)
      // Wait, api.get takes a String url and does Uri.parse(url).
      // If I pass uri.toString(), it will be encoded.
      // e.g. ...?status=%D8%...
      // Uri.parse() on that string should work.

      final response = await api.get(url: uri.toString(), token: token);

      // API may return the list directly or wrap it inside a `data` object.
      List<dynamic>? items;
      if (response is List) {
        items = response;
      } else if (response is Map<String, dynamic>) {
        if (response['data'] is List) {
          items = response['data'] as List<dynamic>;
        } else if (response['data'] is Map<String, dynamic> &&
            (response['data'] as Map<String, dynamic>)['data'] is List) {
          items = (response['data'] as Map<String, dynamic>)['data'] as List;
        }
      }

      if (items != null) {
        final list =
            items.map((json) => ComplaintModel.fromJson(json)).toList();
        return Right(list);
      }

      return Left(ServerFailure("صيغة رد غير متوقعة"));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("خطأ غير متوقع أثناء جلب الشكاوى"));
    }
  }
}
