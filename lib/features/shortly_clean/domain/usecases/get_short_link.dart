import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly_clean/features/shortly_clean/domain/entities/short_link_entity.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';

@injectable
class GetShortLinksFromHistoryList extends UseCase<List<ShortLink>, void> {
  final ShortLinkRemoteRepository _shortLinkRepository;

  GetShortLinksFromHistoryList(
    this._shortLinkRepository,
  );

  @override
  Future<Either<Failure, List<ShortLink>>> call(void params) async {
    return await Future.value(
        _shortLinkRepository.getShortLinksFromHistory(NoParams()));
  }
}
