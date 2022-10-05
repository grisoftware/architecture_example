import 'package:shortly_clean/features/shortly_clean/data/model/short_link_model.dart';

abstract class ShortLinkRemoteRepository {
  // Future<Either<Failure, void>> addShortLinkToHistoryList(String url);
  // Future<Either<Failure, void>> removeShortLinkFromHistory(String shortLinkId);
  // Future<Either<Failure, List<ShortLink>>> getShortLinksFromHistory(
  //     NoParams noParams);
  Future<void> addShortLinkToHistoryList(String url);
  Future<void> removeShortLinkFromHistory(String shortLinkId);

  Stream<List<ShortLinkModel>> getShortLinksFromHistory();
}
