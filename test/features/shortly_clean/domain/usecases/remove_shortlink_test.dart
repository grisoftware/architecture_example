import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/remove_short_link.dart';

import 'usecase_mock_gen_test.mocks.dart';

void main() {
  RemoveShortLinkFromHistoryList? usecase;
  ShortLinkRemoteRepository? mockRepo;
  late String mockId;

  setUp(() {
    mockId = '1';

    mockRepo = FakeRepo();
    usecase = RemoveShortLinkFromHistoryList(mockRepo!);
  });

  test(
    'should remove from the mock repository/datasource',
    () async {
      // remove function has void return type
      // It Returns Right not failure
      when(mockRepo!.removeShortLinkFromHistory(mockId))
          .thenAnswer((_) async => const Right(null));

      final testResult =
          await usecase!(RemoveShortLinkFromHistoryListParams(mockId));

      expect(testResult, const Right(null));
    },
  );
}
