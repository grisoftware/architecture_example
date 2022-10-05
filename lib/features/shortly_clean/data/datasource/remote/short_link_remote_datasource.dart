import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:injectable/injectable.dart';
import 'package:shortly_clean/core/usecase/usecase.dart';
import 'package:shortly_clean/features/shortly_clean/data/model/short_link_model.dart';

abstract class ShortLinkRemoteDataSource {
  Stream<List<ShortLinkModel>> getShortLinksFromHistory(NoParams noParams);
  Future<void> addShortLinkToHistoryList(String url);
  Future<void> removeShortLinkFromHistory(String shortLinkId);
}

@Injectable(as: ShortLinkRemoteDataSource)
class ShortLinkRemoteDataSourceImpl implements ShortLinkRemoteDataSource {
  //Singleton Pattern
  static final _instance = ShortLinkRemoteDataSourceImpl._internal();
  ShortLinkRemoteDataSourceImpl._internal();
  factory ShortLinkRemoteDataSourceImpl() => _instance;

  List<ShortLinkModel> shortLinkModelList = [
    ShortLinkModel(fullShortLink: 'test', id: '1', isCopied: false)
  ];

  final StreamController<List<ShortLinkModel>> _streamController =
      StreamController.broadcast();

  var header = {
    "Access-Control_Allow_Origin": "*",
    "Content-Type": "application/json",
  };
  final String baseUrl = "https://api.shrtco.de/v2/shorten?url=";

  @override
  Stream<List<ShortLinkModel>> getShortLinksFromHistory(NoParams noParams) {
    _streamController.add(shortLinkModelList);
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

      for (int i = 0; i < shortLinkModelList.length; i++) {
        shortLinkIds.add(shortLinkModelList[i].id);
      }

      if (data.isNotEmpty) {
        data.map((shortLink) {
          ShortLinkModel addedLink = ShortLinkModel.fromJson(shortLink);
          // if (!shortLinkIds.contains(addedLink.id)) {
          shortLinks.add(addedLink);
          // }
        }).toList();

        shortLinkModelList.addAll(shortLinks);
        _streamController.add(shortLinkModelList);
      }
    }
  }

  @override
  Future<void> removeShortLinkFromHistory(String shortLinkId) async {
    int index = shortLinkModelList
        .indexWhere((shortLink) => shortLink.id == shortLinkId);
    shortLinkModelList.removeAt(index);

    _streamController.add(shortLinkModelList);
  }
}
