import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shortly_clean/features/shortly_clean/data/model/short_link_model.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';

import '../../../../core/usecase/usecase.dart';

@injectable
class GetShortLinksFromHistoryList extends UseCase<List<ShortLinkModel>, void> {
  final ShortLinkRemoteRepository _shortLinkRepository;
  final StreamController<List<ShortLinkModel>> _controller;

  GetShortLinksFromHistoryList(
    this._shortLinkRepository,
  ) : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<ShortLinkModel>>> buildUseCaseStream(void params) async {
    try {
      _shortLinkRepository
          .getShortLinksFromHistory()
          .listen((List<ShortLinkModel> contacts) {
        if (!_controller.isClosed) _controller.add(contacts);
      });
    } catch (error, stackTrace) {
      _controller.addError(error, stackTrace);
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
