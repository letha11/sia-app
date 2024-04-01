import 'package:hive/hive.dart';
import 'package:sia_app/utils/constants.dart';

abstract class LocalDBRepositoryA {
  /// `key` only accepts `String` and `HiveKey` type
  get(dynamic key);

  /// `key` only accepts `String` and `HiveKey` type
  store(dynamic key);
}

class LocalDBRepository extends LocalDBRepositoryA {
  late final HiveInterface _hive;

  LocalDBRepository._create({HiveInterface? hive}) {
    _hive = hive ?? Hive;
  }

  Future<void> initializeBox() async {
    // do something
  }

  static Future<LocalDBRepository> create({HiveInterface? hive}) async {
    final repository = LocalDBRepository._create(hive: hive);

    await repository.initializeBox();

    return repository;
  }

  @override
  get(key) {
    if (key is! String && key is! HiveKey) throw ArgumentError("Key should be type of `string` or `HiveKey`");
    if (key is HiveKey) key = key.valueAsString;
  }

  @override
  store(key) {
    if (key is! String && key is! HiveKey) throw ArgumentError("Key should be type of `string` or `HiveKey`");
    if (key is HiveKey) key = key.valueAsString;
  }
}
