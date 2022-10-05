import 'package:injectable/injectable.dart';
import 'package:shortly_clean/core/observer/observer.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/add_short_link.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/get_short_link.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/remove_short_link.dart';

import '../../data/model/short_link_model.dart';
import '../../domain/repository/remote/short_link_remote_repository.dart';

@injectable
class HomePresenter {
  late Function getShortLinkOnNext;
  late Function getShortLinkOnError;

  late Function addShortLinkOnComplete;
  late Function addShortLinkOnError;

  late Function removeShortLinkOnComplete;
  late Function removeShortLinkOnError;

  final GetShortLinksFromHistoryList _getShortLinksFromHistoryList;
  final RemoveShortLinkFromHistoryList _removeShortLinkFromHistoryList;
  final AddShortLinkToHistoryList _addShortLinkToHistoryList;

  HomePresenter(ShortLinkRemoteRepository shortLinkRemoteRepository)
      : _getShortLinksFromHistoryList =
            GetShortLinksFromHistoryList(shortLinkRemoteRepository),
        _addShortLinkToHistoryList =
            AddShortLinkToHistoryList(shortLinkRemoteRepository),
        _removeShortLinkFromHistoryList =
            RemoveShortLinkFromHistoryList(shortLinkRemoteRepository);

  void getShortLinks() {
    _getShortLinksFromHistoryList.execute(_GetShortLinksObserver(this));
  }

  void addShortLinks(String url) {
    _addShortLinkToHistoryList.execute(_AddShortLinkToHistoryListObserver(this),
        AddShortLinkToHistoryListParams(url));
  }

  void removeShortLink(String id) {
    _removeShortLinkFromHistoryList.execute(
        _RemoveShortLinkFromHistoryObserver(this),
        RemoveShortLinkFromHistoryListParams(id));
  }
}

class _GetShortLinksObserver extends Observer<List<ShortLinkModel>> {
  final HomePresenter _presenter;

  _GetShortLinksObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getShortLinkOnError(e);
  }

  @override
  void onNext(List<ShortLinkModel>? response) {
    _presenter.getShortLinkOnNext(response);
  }
}

class _AddShortLinkToHistoryListObserver extends Observer<void> {
  final HomePresenter _presenter;

  _AddShortLinkToHistoryListObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.addShortLinkOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addShortLinkOnError(e);
  }

  @override
  void onNext(_) {}
}

class _RemoveShortLinkFromHistoryObserver extends Observer<void> {
  final HomePresenter _presenter;

  _RemoveShortLinkFromHistoryObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.removeShortLinkOnComplete();
  }

  @override
  void onError(e) {
    _presenter.removeShortLinkOnError(e);
  }

  @override
  void onNext(_) {}
}
