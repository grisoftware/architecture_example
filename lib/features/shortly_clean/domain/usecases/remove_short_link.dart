// ignore_for_file: avoid_print

import 'dart:async';

import 'package:injectable/injectable.dart';

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
  Future<Stream<void>> buildUseCaseStream(
      RemoveShortLinkFromHistoryListParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      final result = await _shortLinkRepository
          .removeShortLinkFromHistory(params!.shortLinkId);
      controller.add(result);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return controller.stream;
  }
}

class RemoveShortLinkFromHistoryListParams {
  final String shortLinkId;

  RemoveShortLinkFromHistoryListParams(this.shortLinkId);
}
