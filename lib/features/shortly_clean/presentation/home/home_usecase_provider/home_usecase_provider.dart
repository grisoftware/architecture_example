// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';

// import '../../../../../core/errors/failures.dart';
// import '../../../../../core/usecase/usecase.dart';
// import '../../../domain/entities/short_link_entity.dart';
// import '../../../domain/usecases/add_short_link.dart';
// import '../../../domain/usecases/get_short_link.dart';
// import '../../../domain/usecases/remove_short_link.dart';

// abstract class HomeUseCaseProvider {
//   Future<Either<Failure, void>> addShortLinkToHistoryList(
//       AddShortLinkToHistoryListParams params);
//   Future<Either<Failure, void>> removeShortLinkFromHistory(
//       RemoveShortLinkFromHistoryListParams params);
//   Future<Either<Failure, List<ShortLink>>> getShortLinksFromHistory(
//       NoParams noParams);
// }

// @injectable
// class HomeUseCaseProviderImpl implements HomeUseCaseProvider {
//   final AddShortLinkToHistoryList _addShortLinkToHistoryList;
//   final RemoveShortLinkFromHistoryList _removeShortLinkFromHistory;
//   final GetShortLinksFromHistoryList _getShortLinksFromHistoryList;

//   HomeUseCaseProviderImpl(
//     AddShortLinkToHistoryList addShortLinkToHistoryList,
//     RemoveShortLinkFromHistoryList removeShortLinkFromHistory,
//     GetShortLinksFromHistoryList getShortLinksFromHistoryList,
//   )   : _addShortLinkToHistoryList = addShortLinkToHistoryList,
//         _removeShortLinkFromHistory = removeShortLinkFromHistory,
//         _getShortLinksFromHistoryList = getShortLinksFromHistoryList;

//   @override
//   Future<Either<Failure, void>> addShortLinkToHistoryList(
//       AddShortLinkToHistoryListParams params) async {
//     return await _addShortLinkToHistoryList.call(params);
//   }

//   @override
//   Future<Either<Failure, List<ShortLink>>> getShortLinksFromHistory(
//       NoParams noParams) async {
//     return await _getShortLinksFromHistoryList(noParams);
//   }

//   @override
//   Future<Either<Failure, void>> removeShortLinkFromHistory(
//       RemoveShortLinkFromHistoryListParams params) async {
//     return await _removeShortLinkFromHistory(params);
//   }
// }




