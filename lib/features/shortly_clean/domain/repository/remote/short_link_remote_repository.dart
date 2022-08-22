import 'package:dartz/dartz.dart';
import 'package:shortly_clean/core/usecase/usecase.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/short_link_entity.dart';

abstract class ShortLinkRemoteRepository {
  Future<Either<Failure, void>> addShortLinkToHistoryList(String url);
  Future<Either<Failure, void>> removeShortLinkFromHistory(String shortLinkId);
  Future<Either<Failure, List<ShortLink>>> getShortLinksFromHistory(
      NoParams noParams);
}
