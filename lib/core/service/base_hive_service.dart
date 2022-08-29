import 'package:hive/hive.dart';

abstract class BaseHiveService<T> {
  final String key;
  Box<T>? box;

  BaseHiveService(this.key);
  Future<void> init() async {
    registerAdapters();
    if (!(box?.isOpen ?? false)) {
      box = await Hive.openBox(key);
    }
  }

  /// [Hive.registerAdapter(MyObjectAdapter())]
  /// When you want Hive to use a [TypeAdapter], you have to register it.
  /// Two things are needed for that: An instance of the adapter and a [typeId].
  /// Every type has a unique [typeId] which is used to find the
  /// correct adapter when a value is brought back from disk.
  /// All [typeId]s between 0 and 223 are allowed.
  void registerAdapters();

  Future<void> clearAll() async {
    await box?.clear();
  }

  Future<void> addItems(List<T> items);

  ///
  /// [await _box?.putAll(Map.fromEntries())]
  ///
  Future<void> putItems(List<T> items);

  T? getItem(String key);
  List<T>? getValues();

  Future<void> putItem(String key, T item);
  Future<void> removeItem(String key);
}
