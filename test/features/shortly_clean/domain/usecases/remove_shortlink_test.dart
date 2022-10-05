// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:shortly_clean/core/observer/observer.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/remove_short_link.dart';

import 'add_short_link_usecase_test.mocks.dart';

void main() {
  group('RemoveShortLinkUseCase', () {
    RemoveShortLinkFromHistoryList? removeShortLinkFromHistoryList;

    _Observer? observer;

    setUp(() {
      var repo = FakeRepo();
      removeShortLinkFromHistoryList = RemoveShortLinkFromHistoryList(repo);
      observer = _Observer();
    });

    test('removes a shortlink from list', () async {
      removeShortLinkFromHistoryList!
          .execute(observer!, RemoveShortLinkFromHistoryListParams(''));
      await Future.delayed(const Duration(milliseconds: 1000), () {
        // expect(addShortLinkToHistoryListObserver, 2);
        expect(observer!.done, true);
        expect(observer!.error, false);
      });
      // a.dispose();
    });
  });
}

class _Observer implements Observer<void> {
  bool done = false;
  bool error = false;

  @override
  void onComplete() {
    done = true;
    print('Complete');
  }

  @override
  void onError(e) {
    error = true;
    throw e;
  }

  @override
  void onNext(_) {}
}
