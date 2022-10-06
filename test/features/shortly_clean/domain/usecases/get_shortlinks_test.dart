import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shortly_clean/core/usecase/usecase.dart';
import 'package:shortly_clean/features/shortly_clean/domain/entities/short_link_entity.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/get_short_link.dart';

import 'usecase_mock_gen_test.mocks.dart';

void main() {
  GetShortLinksFromHistoryList? usecase;
  ShortLinkRemoteRepository? mockRepo;
  List<ShortLink> list = [];

  setUp(() {
    mockRepo = FakeRepo();
    usecase = GetShortLinksFromHistoryList(mockRepo!);
  });

  test(
    'should GET from the  repository/datasource',
    () async {
      when(mockRepo!.getShortLinksFromHistory(NoParams()))
          .thenAnswer((_) async => Right(list));

      final testResult = await usecase!(NoParams());

      expect(testResult, Right(list));
    },
  );
}
