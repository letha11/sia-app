import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/data/repository/local_db_repository.dart';

@GenerateNiceMocks([MockSpec<HiveInterface>()])
import 'local_db_repository_test.mocks.dart';

void main() {
  late MockHiveInterface hive;
  late LocalDBRepository repository;

  setUpAll(() async {
    hive = MockHiveInterface();
    repository = await LocalDBRepository.create(hive: hive);
  });

  test('constructor', () async {
    final result = await LocalDBRepository.create();

    expect(result, isA<LocalDBRepository>());
  });

  group('get method', () {
    test('should throw an error when the `key` arguments are not a type of `string` or `LocalDBRepository`', () async {
      expect(() => repository.get(123), throwsA(isA<ArgumentError>()));
      expect(() => repository.get(true), throwsA(isA<ArgumentError>()));
    });
  });

  group('store method', () {
    test('should throw an error when the `key` arguments are not a type of `string` or `LocalDBRepository`', () async {
      expect(() => repository.store(123), throwsA(isA<ArgumentError>()));
      expect(() => repository.store(true), throwsA(isA<ArgumentError>()));
    });
  });

}
