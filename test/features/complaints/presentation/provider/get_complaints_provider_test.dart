import 'package:complaints_sys/features/complaints/domain/entities/complaint.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/get_complaints_usecase.dart';
import 'package:complaints_sys/features/complaints/presentation/provider/get_complaints_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_complaints_provider_test.mocks.dart';

@GenerateMocks([GetComplaintsUseCase])
void main() {
  late ComplaintsProvider provider;
  late MockGetComplaintsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetComplaintsUseCase();
    provider = ComplaintsProvider(mockUseCase);
  });

  group('filteredComplaints', () {
    final complaint1 = Complaint(
      id: 1,
      referenceNumber: 'CMP-123',
      createdAt: DateTime.now(),
      state: 'Pending',
      locationDescription: 'Loc 1',
      problemDescription: 'Prob 1',
      complaintTypeName: 'Type A',
      governmentEntityName: 'Entity X',
    );

    final complaint2 = Complaint(
      id: 2,
      referenceNumber: 'CMP-456',
      createdAt: DateTime.now(),
      state: 'Resolved',
      locationDescription: 'Loc 2',
      problemDescription: 'Prob 2',
      complaintTypeName: 'Type B',
      governmentEntityName: 'Entity Y',
    );

    test('should return all complaints when query is empty', () async {
      // Arrange
      when(mockUseCase(status: anyNamed('status')))
          .thenAnswer((_) async => Right([complaint1, complaint2]));
      await provider.loadComplaints();

      // Act
      final result = provider.filteredComplaints;

      // Assert
      expect(result.length, 2);
    });

    test('should filter by reference number using strict prefix match',
        () async {
      // Generic examples to test strict prefix logic
      final c1 = Complaint(
        id: 1,
        referenceNumber: 'ABC-123',
        createdAt: DateTime.now(),
        state: 'Pending',
        locationDescription: '',
        problemDescription: '',
      );
      final c2 = Complaint(
        id: 2,
        referenceNumber: 'ABC-456',
        createdAt: DateTime.now(),
        state: 'Pending',
        locationDescription: '',
        problemDescription: '',
      );
      final c3 = Complaint(
        id: 3,
        referenceNumber: 'DEF-123',
        createdAt: DateTime.now(),
        state: 'Pending',
        locationDescription: '',
        problemDescription: '',
      );

      when(mockUseCase(status: anyNamed('status')))
          .thenAnswer((_) async => Right([c1, c2, c3]));
      await provider.loadComplaints();

      // 1. Prefix match "abc" -> should match c1 and c2
      provider.updateSearchQuery('abc');
      expect(provider.filteredComplaints.length, 2);
      expect(
          provider.filteredComplaints
              .any((c) => c.referenceNumber == 'ABC-123'),
          true);
      expect(
          provider.filteredComplaints
              .any((c) => c.referenceNumber == 'ABC-456'),
          true);

      // 2. Prefix match "abc-" -> should match c1 and c2
      provider.updateSearchQuery('abc-');
      expect(provider.filteredComplaints.length, 2);

      // 3. Specific prefix "abc-1" -> should match c1 only
      provider.updateSearchQuery('abc-1');
      expect(provider.filteredComplaints.length, 1);
      expect(provider.filteredComplaints.first.referenceNumber, 'ABC-123');

      // 4. Non-matching prefix "abc-9" -> should match nothing
      provider.updateSearchQuery('abc-9');
      expect(provider.filteredComplaints.length, 0);

      // 5. Symbol sensitivity "abc 1" (space instead of hyphen) -> should match nothing
      provider.updateSearchQuery('abc 1');
      expect(provider.filteredComplaints.length, 0);

      // 6. Partial match not at start "123" -> should match nothing (strict prefix)
      provider.updateSearchQuery('123');
      expect(provider.filteredComplaints.length, 0);
    });
  });
}
