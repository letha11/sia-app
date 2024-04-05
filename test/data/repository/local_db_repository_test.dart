import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';

@GenerateNiceMocks([MockSpec<HiveInterface>(), MockSpec<Box>()])
import 'local_db_repository_test.mocks.dart';

void main() {
  late MockHiveInterface hive;
  late LocalDBRepository repository;
  late MockBox box;

  setUpAll(() async {
    hive = MockHiveInterface();
    box = MockBox();
    hive.init('apps');
    when(hive.openBox(any)).thenAnswer((_) async => box);
    repository = await LocalDBRepository.create(hive: hive);
  });

  tearDown(() {
    hive.close();
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
    test(
        'should throw an error when the `key` arguments are not a type of `string` or `LocalDBRepository`',
        () async {
      expect(() => repository.get(123), throwsA(isA<ArgumentError>()));
      expect(() => repository.get(true), throwsA(isA<ArgumentError>()));
    });

    test('should not return anything on success', () async {
      when(box.get(any)).thenAnswer((_) async => true);

      final result = await repository.get('test');

      verify(box.get(any)).called(1);
      expect(result, true);
    });

  });

  group('store method', () {
    test(
        'should throw an error when the `key` arguments are not a type of `string` or `LocalDBRepository`',
        () async {
      expect(() => repository.store(123, 'testing_value'),
          throwsA(isA<ArgumentError>()));
      expect(() => repository.store(true, 'testing_value'),
          throwsA(isA<ArgumentError>()));
    });

    test('should not return anything on success', () async {
      when(box.put(any, any)).thenAnswer((_) async => true);

      final result = await repository.store('test', 'value');

      verify(box.put(any, any)).called(1);
      expect(result, null);
    });
  });

  group('remove method', () {
    test(
        'should throw an error when the `key` arguments are not a type of `string` or `LocalDBRepository`',
        () async {
      expect(() => repository.remove(123),
          throwsA(isA<ArgumentError>()));
    });

    test('should not return anything on success', () async {
      when(box.delete(any)).thenAnswer((_) async => true);

      final result = await repository.remove('ea');

      verify(box.delete(any)).called(1);
      expect(result, null);
    });
  });
}
