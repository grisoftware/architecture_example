import 'package:flutter_test/flutter_test.dart';
import 'package:shortly_clean/features/shortly_clean/data/model/short_link_model.dart';

void main() {
  final ShortLinkModel testModel =
      ShortLinkModel(id: "1", fullShortLink: "https://test");

  test('should be a subclass of a model', () async {
    expect(testModel, isA<ShortLinkModel>());
  });
}
