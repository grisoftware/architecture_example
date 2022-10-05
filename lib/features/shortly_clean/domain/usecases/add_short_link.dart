// ignore_for_file: avoid_print

import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';

import '../../../../core/usecase/usecase.dart';

@injectable
class AddShortLinkToHistoryList
    extends UseCase<void, AddShortLinkToHistoryListParams> {
  final ShortLinkRemoteRepository _shortLinkRepository;

  AddShortLinkToHistoryList(
    this._shortLinkRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(
      AddShortLinkToHistoryListParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      final result =
          await _shortLinkRepository.addShortLinkToHistoryList(params!.url);
      controller.add(result);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class AddShortLinkToHistoryListParams {
  final String url;

  AddShortLinkToHistoryListParams(
    this.url,
  );
}
