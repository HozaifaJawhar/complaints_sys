import 'package:complaints_sys/core/api/api_helper.dart';
import 'package:complaints_sys/core/constants/api_constants.dart';
import 'package:complaints_sys/core/services/secure_storage_service.dart';
import 'package:complaints_sys/features/complaints/data/repositories/complaint_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'complaint_repository_impl_test.mocks.dart';

@GenerateMocks([Api, SecureStorageService])
void main() {
  late ComplaintRepositoryImpl repository;
  late MockApi mockApi;
  late MockSecureStorageService mockStorage;

  setUp(() {
    mockApi = MockApi();
    mockStorage = MockSecureStorageService();
    repository = ComplaintRepositoryImpl(api: mockApi, storage: mockStorage);
  });

  group('getComplaints', () {
    const tToken = 'test_token';

    test('should call getComplaintsUrl when no status is provided', () async {
      // Arrange
      when(mockStorage.readToken()).thenAnswer((_) async => tToken);
      when(mockApi.get(url: anyNamed('url'), token: anyNamed('token')))
          .thenAnswer((_) async => {'data': []});

      // Act
      await repository.getComplaints();

      // Assert
      verify(mockApi.get(
        url: ApiConstants.baseUrl + ApiConstants.getComplaintsUrl,
        token: tToken,
      ));
    });

    test(
        'should call filterComplaintStatusUrl with status query param when status is provided',
        () async {
      // Arrange
      when(mockStorage.readToken()).thenAnswer((_) async => tToken);
      when(mockApi.get(url: anyNamed('url'), token: anyNamed('token')))
          .thenAnswer((_) async => {'data': []});

      const tStatus = 'انتظار';

      // Act
      await repository.getComplaints(status: tStatus);

      // Assert
      final expectedUri =
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getComplaintsUrl}')
              .replace(queryParameters: {'status': tStatus});

      verify(mockApi.get(
        url: expectedUri.toString(),
        token: tToken,
      ));
    });
  });
}
