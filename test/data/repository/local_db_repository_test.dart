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
    hive.init('apps');
    repository = await LocalDBRepository.create(hive: hive);
  });


  group('constructor', () {
    test('works', () async {
      final result = await LocalDBRepository.create(hive: hive);

      expect(result, isA<LocalDBRepository>());
    });

    test('should open a hive box when new instance being made', () async {
      final _hive = MockHiveInterface();

      _hive.init('apps');
      await LocalDBRepository.create(hive: _hive);

      verify(_hive.openBox('apps_box')).called(1);
    });
  });

  group('get method', () {
    test('should throw an error when the `key` arguments are not a type of `string` or `LocalDBRepository`', () async {
      expect(() => repository.get(123), throwsA(isA<ArgumentError>()));
      expect(() => repository.get(true), throwsA(isA<ArgumentError>()));
    });
  });

  group('store method', () {
    test('should throw an error when the `key` arguments are not a type of `string` or `LocalDBRepository`', () async {
      expect(() => repository.store(123, 'testing_value'), throwsA(isA<ArgumentError>()));
      expect(() => repository.store(true, 'testing_value'), throwsA(isA<ArgumentError>()));
    });
  });
}
