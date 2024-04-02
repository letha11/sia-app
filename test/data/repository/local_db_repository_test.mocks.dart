// Mocks generated by Mockito 5.4.4 from annotations
// in sia_app/test/data/repository/local_db_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:typed_data' as _i6;

import 'package:hive/hive.dart' as _i2;
import 'package:hive/src/box/default_compaction_strategy.dart' as _i5;
import 'package:hive/src/box/default_key_comparator.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeBox_0<E1> extends _i1.SmartFake implements _i2.Box<E1> {
  _FakeBox_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLazyBox_1<E1> extends _i1.SmartFake implements _i2.LazyBox<E1> {
  _FakeLazyBox_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HiveInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiveInterface extends _i1.Mock implements _i2.HiveInterface {
  @override
  void init(
    String? path, {
    _i2.HiveStorageBackendPreference? backendPreference =
        _i2.HiveStorageBackendPreference.native,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #init,
          [path],
          {#backendPreference: backendPreference},
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<_i2.Box<E>> openBox<E>(
    String? name, {
    _i2.HiveCipher? encryptionCipher,
    _i2.KeyComparator? keyComparator = _i4.defaultKeyComparator,
    _i2.CompactionStrategy? compactionStrategy = _i5.defaultCompactionStrategy,
    bool? crashRecovery = true,
    String? path,
    _i6.Uint8List? bytes,
    String? collection,
    List<int>? encryptionKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #openBox,
          [name],
          {
            #encryptionCipher: encryptionCipher,
            #keyComparator: keyComparator,
            #compactionStrategy: compactionStrategy,
            #crashRecovery: crashRecovery,
            #path: path,
            #bytes: bytes,
            #collection: collection,
            #encryptionKey: encryptionKey,
          },
        ),
        returnValue: _i3.Future<_i2.Box<E>>.value(_FakeBox_0<E>(
          this,
          Invocation.method(
            #openBox,
            [name],
            {
              #encryptionCipher: encryptionCipher,
              #keyComparator: keyComparator,
              #compactionStrategy: compactionStrategy,
              #crashRecovery: crashRecovery,
              #path: path,
              #bytes: bytes,
              #collection: collection,
              #encryptionKey: encryptionKey,
            },
          ),
        )),
        returnValueForMissingStub: _i3.Future<_i2.Box<E>>.value(_FakeBox_0<E>(
          this,
          Invocation.method(
            #openBox,
            [name],
            {
              #encryptionCipher: encryptionCipher,
              #keyComparator: keyComparator,
              #compactionStrategy: compactionStrategy,
              #crashRecovery: crashRecovery,
              #path: path,
              #bytes: bytes,
              #collection: collection,
              #encryptionKey: encryptionKey,
            },
          ),
        )),
      ) as _i3.Future<_i2.Box<E>>);

  @override
  _i3.Future<_i2.LazyBox<E>> openLazyBox<E>(
    String? name, {
    _i2.HiveCipher? encryptionCipher,
    _i2.KeyComparator? keyComparator = _i4.defaultKeyComparator,
    _i2.CompactionStrategy? compactionStrategy = _i5.defaultCompactionStrategy,
    bool? crashRecovery = true,
    String? path,
    String? collection,
    List<int>? encryptionKey,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #openLazyBox,
          [name],
          {
            #encryptionCipher: encryptionCipher,
            #keyComparator: keyComparator,
            #compactionStrategy: compactionStrategy,
            #crashRecovery: crashRecovery,
            #path: path,
            #collection: collection,
            #encryptionKey: encryptionKey,
          },
        ),
        returnValue: _i3.Future<_i2.LazyBox<E>>.value(_FakeLazyBox_1<E>(
          this,
          Invocation.method(
            #openLazyBox,
            [name],
            {
              #encryptionCipher: encryptionCipher,
              #keyComparator: keyComparator,
              #compactionStrategy: compactionStrategy,
              #crashRecovery: crashRecovery,
              #path: path,
              #collection: collection,
              #encryptionKey: encryptionKey,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.LazyBox<E>>.value(_FakeLazyBox_1<E>(
          this,
          Invocation.method(
            #openLazyBox,
            [name],
            {
              #encryptionCipher: encryptionCipher,
              #keyComparator: keyComparator,
              #compactionStrategy: compactionStrategy,
              #crashRecovery: crashRecovery,
              #path: path,
              #collection: collection,
              #encryptionKey: encryptionKey,
            },
          ),
        )),
      ) as _i3.Future<_i2.LazyBox<E>>);

  @override
  _i2.Box<E> box<E>(String? name) => (super.noSuchMethod(
        Invocation.method(
          #box,
          [name],
        ),
        returnValue: _FakeBox_0<E>(
          this,
          Invocation.method(
            #box,
            [name],
          ),
        ),
        returnValueForMissingStub: _FakeBox_0<E>(
          this,
          Invocation.method(
            #box,
            [name],
          ),
        ),
      ) as _i2.Box<E>);

  @override
  _i2.LazyBox<E> lazyBox<E>(String? name) => (super.noSuchMethod(
        Invocation.method(
          #lazyBox,
          [name],
        ),
        returnValue: _FakeLazyBox_1<E>(
          this,
          Invocation.method(
            #lazyBox,
            [name],
          ),
        ),
        returnValueForMissingStub: _FakeLazyBox_1<E>(
          this,
          Invocation.method(
            #lazyBox,
            [name],
          ),
        ),
      ) as _i2.LazyBox<E>);

  @override
  bool isBoxOpen(String? name) => (super.noSuchMethod(
        Invocation.method(
          #isBoxOpen,
          [name],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i3.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteBoxFromDisk(
    String? name, {
    String? path,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteBoxFromDisk,
          [name],
          {#path: path},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteFromDisk() => (super.noSuchMethod(
        Invocation.method(
          #deleteFromDisk,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  List<int> generateSecureKey() => (super.noSuchMethod(
        Invocation.method(
          #generateSecureKey,
          [],
        ),
        returnValue: <int>[],
        returnValueForMissingStub: <int>[],
      ) as List<int>);

  @override
  _i3.Future<bool> boxExists(
    String? name, {
    String? path,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #boxExists,
          [name],
          {#path: path},
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  void resetAdapters() => super.noSuchMethod(
        Invocation.method(
          #resetAdapters,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerAdapter<T>(
    _i2.TypeAdapter<T>? adapter, {
    bool? internal = false,
    bool? override = false,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerAdapter,
          [adapter],
          {
            #internal: internal,
            #override: override,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool isAdapterRegistered(int? typeId) => (super.noSuchMethod(
        Invocation.method(
          #isAdapterRegistered,
          [typeId],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void ignoreTypeId<T>(int? typeId) => super.noSuchMethod(
        Invocation.method(
          #ignoreTypeId,
          [typeId],
        ),
        returnValueForMissingStub: null,
      );
}