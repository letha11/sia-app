import 'package:hive/hive.dart';
import 'package:sia_app/utils/constants.dart';

abstract class LocalDBRepositoryA {
  /// `key` only accepts `String` and `HiveKey` type
  get(dynamic key);

  /// `key` only accepts `String` and `HiveKey` type
  store(dynamic key, dynamic value);

  /// `key` only accepts `String` and `HiveKey` type
  remove(dynamic key);
}

class LocalDBRepository extends LocalDBRepositoryA {
  late final HiveInterface _hive;
  late final Box _box;

  LocalDBRepository._create({HiveInterface? hive}) {
    _hive = hive ?? Hive;
  }

  Future<void> initializeBox() async {
    _box = await _hive.openBox('apps_box');
  }

  static Future<LocalDBRepository> create({HiveInterface? hive}) async {
    final repository = LocalDBRepository._create(hive: hive);

    await repository.initializeBox();

    return repository;
  }

  @override
  get(key) {
    if (key is! String && key is! HiveKey) {
      throw ArgumentError("Key should be type of `string` or `HiveKey`");
    }
    if (key is HiveKey) key = key.valueAsString;

    return _box.get(key);
  }

  @override
  store(key, value) async {
    if (key is! String && key is! HiveKey) {
      throw ArgumentError("Key should be type of `string` or `HiveKey`");
    }
    if (key is HiveKey) key = key.valueAsString;

    await _box.put(key, value);
  }

  @override
  remove(key) async {
    if (key is! String && key is! HiveKey) {
      throw ArgumentError("Key should be type of `string` or `HiveKey`");
    }
    if (key is HiveKey) key = key.valueAsString;

    await _box.delete(key);
  }
}
