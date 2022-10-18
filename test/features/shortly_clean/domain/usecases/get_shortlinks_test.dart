import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shortly_clean/core/usecase/usecase.dart';
import 'package:shortly_clean/features/shortly_clean/domain/entities/short_link_entity.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/add_short_link.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/get_short_link.dart';

import 'usecase_mock_gen_test.mocks.dart';

void main() {
  GetShortLinksFromHistoryList? usecase;
  ShortLinkRemoteRepository? mockRepo;
  List<ShortLink> list = [];
  AddShortLinkToHistoryList? usecase2;
  String? url;
  late String shortLink;
  ShortLink? model;
  setUp(() {
    mockRepo = FakeRepo();
    usecase = GetShortLinksFromHistoryList(mockRepo!);

    url = 'https://pomofocus.io/';
    usecase2 = AddShortLinkToHistoryList(mockRepo!);

    model = ShortLink(id: 'm32hIZ', fullShortLink: 'https://shrtco.de/m32hIZ');

    shortLink = 'https://shrtco.de/m32hIZ';
  });

  test(
    'should GET from the  repository/datasource',
    () async {
      when(mockRepo!.addShortLinkToHistoryList(url!))
          // ignore: void_checks
          .thenAnswer((_) async => Right(model));

      await usecase2!(AddShortLinkToHistoryListParams(url!));

      list.add(model!);

      when(mockRepo!.getShortLinksFromHistory(NoParams()))
          .thenAnswer((_) async => Right(list));

      final testResult = await usecase!(NoParams());
      testResult.fold((l) => null, (r) {
        expect(shortLink, r.first.fullShortLink);
      });
      expect(testResult, Right(list));
    },
  );
}
