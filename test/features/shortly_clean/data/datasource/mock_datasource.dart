// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:mockito/mockito.dart';
// import 'package:shortly_clean/core/usecase/usecase.dart';
// import 'package:shortly_clean/features/shortly_clean/data/datasource/remote/short_link_remote_datasource.dart';
// import 'package:shortly_clean/features/shortly_clean/data/model/short_link_model.dart';


// class MockDataSource extends Mock implements ShortLinkRemoteDataSource {
//   static final _instance = MockDataSource._internal();
//   MockDataSource._internal();
//   factory MockDataSource() => _instance;

//   List<ShortLinkModel> shortLinkModelList = [];

//   var header = {
//     "Access-Control_Allow_Origin": "*",
//     "Content-Type": "application/json",
//   };
//   final String baseUrl = "https://api.shrtco.de/v2/shorten?url=";

//   @override
//   Future<List<ShortLinkModel>> getShortLinksFromHistory(NoParams noParams) {
//     return Future.value(shortLinkModelList);
//   }

//   @override
//   Future<void> addShortLinkToHistoryList(String path) async {
//     List<String> shortLinkIds = [];

//     Response response;
//     var url = Uri.parse(baseUrl + path);

//     response = await http.get(url);

//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       List<ShortLinkModel> shortLinks = [];

//       Map<String, dynamic> map = json.decode(response.body);
//       List<dynamic> data = [map['result']];

//       for (int i = 0; i < shortLinkModelList.length; i++) {
//         shortLinkIds.add(shortLinkModelList[i].id);
//       }

//       if (data.isNotEmpty) {
//         data.map((shortLink) {
//           ShortLinkModel addedLink = ShortLinkModel.fromJson(shortLink);
//           // if (!shortLinkIds.contains(addedLink.id)) {
//           shortLinks.add(addedLink);
//           // }
//         }).toList();

//         shortLinkModelList.addAll(shortLinks);
//       }
//     }
//   }

//   @override
//   Future<void> removeShortLinkFromHistory(String shortLinkId) async {
//     int index = shortLinkModelList
//         .indexWhere((shortLink) => shortLink.id == shortLinkId);
//     shortLinkModelList.removeAt(index);
//   }
// }
