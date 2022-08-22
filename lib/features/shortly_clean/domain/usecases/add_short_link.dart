import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';

@injectable
class AddShortLinkToHistoryList
    extends UseCase<void, AddShortLinkToHistoryListParams> {
  final ShortLinkRemoteRepository _shortLinkRepository;

  AddShortLinkToHistoryList(
    this._shortLinkRepository,
  );

  @override
  Future<Either<Failure, void>> call(
      AddShortLinkToHistoryListParams? params) async {
    return await _shortLinkRepository.addShortLinkToHistoryList(params!.url);
  }
}

class AddShortLinkToHistoryListParams {
  final String url;

  AddShortLinkToHistoryListParams(
    this.url,
  );
}
