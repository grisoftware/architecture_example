// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:shortly_clean/core/usecase/usecase.dart';
// import 'package:shortly_clean/features/shortly_clean/domain/entities/short_link_entity.dart';
// import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';
// import 'package:shortly_clean/features/shortly_clean/domain/usecases/add_short_link.dart';
// import 'package:shortly_clean/features/shortly_clean/domain/usecases/get_short_link.dart';

// class MockShortLinkRepository extends Mock
//     implements ShortLinkRemoteRepository {}

// void main() {
//   AddShortLinkToHistoryList? usecase;
//   GetShortLinksFromHistoryList? getShortlink;
//   MockShortLinkRepository? mockShortLinkRepository;

//   setUp(() {
//     mockShortLinkRepository = MockShortLinkRepository();
//     usecase = AddShortLinkToHistoryList(mockShortLinkRepository!);
//     getShortlink = GetShortLinksFromHistoryList(mockShortLinkRepository!);
//   });

//   final tNumber = 'https://pomofocus.io/';
//   final tNumberTrivia =
//       ShortLink(id: 'm32hIZ', fullShortLink: 'https://shrtco.de/m32hIZ');

//   test(
//     'should get trivia for the number from the repository',
//     () async {
//       // arrange

//       when(mockShortLinkRepository!.getShortLinksFromHistory(NoParams()))
//           .thenAnswer((_) async => Right([tNumberTrivia]));

//       // act
//       final result = await getShortlink!(NoParams());

//       // assert
//       expect(result, Right(tNumberTrivia));
//       verify(mockShortLinkRepository!.addShortLinkToHistoryList(tNumber));
//       verifyNoMoreInteractions(mockShortLinkRepository);
//     },
//   );
// }
