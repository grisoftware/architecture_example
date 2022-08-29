import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly_clean/features/shortly_clean/data/model/short_link_model.dart';

import '../../../../../core/config/constants/hive_type_constants.dart';
import '../../services/base_hive_service.dart';

@lazySingleton
class ShortlyCacheDataSource extends BaseHiveService<ShortLinkModel> {
  ShortlyCacheDataSource() : super('shortlink');

  @override
  Future<void> addItems(List<ShortLinkModel> items) async {
    await box?.addAll(items);
  }

  @override
  ShortLinkModel? getItem(String key) {
    throw UnimplementedError();
  }

  @override
  List<ShortLinkModel>? getValues() {
    return box?.values.toList();
  }

  @override
  Future<void> putItem(String key, ShortLinkModel item) async {
    await box?.put(key, item);
  }

  @override
  Future<void> putItems(List<ShortLinkModel> items) {
    throw UnimplementedError();
  }

  Future<void> removeAt(int index) async {
    await box?.deleteAt(index);
  }

  Future<void> addItem(ShortLinkModel item) async {
    await box?.add(item);
  }

  @override
  void registerAdapters() {
    if (Hive.isAdapterRegistered(
      HiveTypeConstants.shortLinkTypeId,
    )) {
      return;
    }
    // if (Hive.isAdapterRegistered(
    //   HiveTypeConstants.dayTypeId,
    // )) {
    //   return;
    // }

    Hive.registerAdapter(ShortLinkModelAdapter());
  }

  @override
  Future<void> removeItem(String key) {
    throw UnimplementedError();
  }
}
