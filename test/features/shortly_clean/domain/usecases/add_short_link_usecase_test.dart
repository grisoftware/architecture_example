import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shortly_clean/features/shortly_clean/data/model/short_link_model.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/add_short_link.dart';

import 'usecase_mock_gen_test.mocks.dart';

void main() {
  AddShortLinkToHistoryList? usecase;
  ShortLinkRemoteRepository? mockRepo;
  String? url;
  ShortLinkModel? model;

  setUp(() {
    url = 'https://pomofocus.io/';
    mockRepo = FakeRepo();
    usecase = AddShortLinkToHistoryList(mockRepo!);

    model =
        ShortLinkModel(id: 'm32hIZ', fullShortLink: 'https://shrtco.de/m32hIZ');
  });

  test(
    'should add Shortlink for the given url to the repository/datasource',
    () async {
      when(mockRepo!.addShortLinkToHistoryList(url!))
          // ignore: void_checks
          .thenAnswer((_) async => Right(model));
      // act
      final result = await usecase!(AddShortLinkToHistoryListParams(url!));

      // assert
      expect(result, Right(model));
      // verify(mockRepo!.addShortLinkToHistoryList());
      // verifyNoMoreInteractions(mockRepo);
    },
  );
}
