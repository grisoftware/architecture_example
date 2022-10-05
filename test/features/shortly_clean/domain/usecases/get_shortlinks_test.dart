// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:shortly_clean/core/observer/observer.dart';
import 'package:shortly_clean/features/shortly_clean/data/model/short_link_model.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/add_short_link.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/get_short_link.dart';
import 'package:http/http.dart' as http;

// We need this because after null safety we should use generatedMocks or overriden methods for our mock repo
// We didnt use the generatedMocks annotation for here because this is an open stream function and we need to listen it
// for listening we should append shortLink to stream
// Afterall we can test it easly
class MockRepo extends Mock implements ShortLinkRemoteRepository {
  List<ShortLinkModel> modelList = [];
  final StreamController<List<ShortLinkModel>> _streamController =
      StreamController.broadcast();

  var header = {
    "Access-Control_Allow_Origin": "*",
    "Content-Type": "application/json",
  };
  final String baseUrl = "https://api.shrtco.de/v2/shorten?url=";

  @override
  Stream<List<ShortLinkModel>> getShortLinksFromHistory() {
    _streamController.add(modelList);

    return _streamController.stream;
  }

  @override
  Future<void> addShortLinkToHistoryList(String path) async {
    List<String> shortLinkIds = [];

    Response response;
    var url = Uri.parse(baseUrl + path);

    response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<ShortLinkModel> shortLinks = [];

      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = [map['result']];

      for (int i = 0; i < modelList.length; i++) {
        shortLinkIds.add(modelList[i].id);
      }

      if (data.isNotEmpty) {
        data.map((shortLink) {
          ShortLinkModel addedLink = ShortLinkModel.fromJson(shortLink);
          // if (!shortLinkIds.contains(addedLink.id)) {
          shortLinks.add(addedLink);
          // }
        }).toList();

        modelList.addAll(shortLinks);
        _streamController.add(modelList);
      }
    }
  }
}

void main() {
  group('GetShortlinkGroup', () {
    GetShortLinksFromHistoryList? getShortLinksFromHistoryList;
    AddShortLinkToHistoryList? addShortLinkToHistoryList;
    _Observer? observer;
    _ObserverSecond? secondObserver;

    setUp(() {
      var repo = MockRepo();
      addShortLinkToHistoryList = AddShortLinkToHistoryList(repo);
      getShortLinksFromHistoryList = GetShortLinksFromHistoryList(repo);
      observer = _Observer();
      secondObserver = _ObserverSecond();
    });

    test('gets a open stream shortlink  list', () async {
      addShortLinkToHistoryList!.execute(secondObserver!,
          AddShortLinkToHistoryListParams('https://github.com/'));

      getShortLinksFromHistoryList!.execute(observer!);
      await Future.delayed(const Duration(milliseconds: 1000), () {
        expect(observer!.onNextResponse, true);
        expect(observer!.error, false);
      });

      // a.dispose();
    });
  });
}

class _Observer implements Observer<List<ShortLinkModel>> {
  bool done = false;
  bool error = false;
  bool onNextResponse = false;

  @override
  void onComplete() {
    done = true;
    print('getShortlİnksOnComplete');
  }

  @override
  void onError(e) {
    error = true;
    throw e;
  }

  @override
  void onNext(List<ShortLinkModel>? response) {
    onNextResponse = true;
    print("onNext");
    // expect(response, isA<List<ShortLinkModel>>());
  }
}

class _ObserverSecond implements Observer<void> {
  bool done = false;
  bool error = false;
  bool onNextResponse = false;

  @override
  void onComplete() {
    done = true;
    print('addOnComplete');
  }

  @override
  void onError(e) {
    error = true;
    throw e;
  }

  @override
  void onNext(_) {
    onNextResponse = true;
  }
}
