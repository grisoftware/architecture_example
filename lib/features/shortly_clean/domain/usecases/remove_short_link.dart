import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/remote/short_link_remote_repository.dart';

@injectable
class RemoveShortLinkFromHistoryList
    extends UseCase<void, RemoveShortLinkFromHistoryListParams> {
  final ShortLinkRemoteRepository _shortLinkRepository;

  RemoveShortLinkFromHistoryList(
    this._shortLinkRepository,
  );

  @override
  Future<Either<Failure, void>> call(params) async {
    return await _shortLinkRepository
        .removeShortLinkFromHistory(params.shortLinkId);
  }
}

class RemoveShortLinkFromHistoryListParams {
  final String shortLinkId;

  RemoveShortLinkFromHistoryListParams(this.shortLinkId);
}
