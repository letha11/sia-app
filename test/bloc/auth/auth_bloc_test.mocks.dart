// Mocks generated by Mockito 5.4.4 from annotations
// in sia_app/test/bloc/auth/auth_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:fpdart/fpdart.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:sia_app/core/failures.dart' as _i6;
import 'package:sia_app/data/repository/auth_repository.dart' as _i4;
import 'package:sia_app/data/repository/local/local_db_repository.dart' as _i2;

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

/// A class which mocks [LocalDBRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDBRepository extends _i1.Mock implements _i2.LocalDBRepository {
  @override
  _i3.Future<void> initializeBox() => (super.noSuchMethod(
        Invocation.method(
          #initializeBox,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i4.AuthRepository {
  @override
  _i3.Future<_i5.Either<_i6.Failure, (String, String)>> login({
    required String? username,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [],
          {
            #username: username,
            #password: password,
          },
        ),
        returnValue:
            _i3.Future<_i5.Either<_i6.Failure, (String, String)>>.value(
                _i7.dummyValue<_i5.Either<_i6.Failure, (String, String)>>(
          this,
          Invocation.method(
            #login,
            [],
            {
              #username: username,
              #password: password,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i5.Either<_i6.Failure, (String, String)>>.value(
                _i7.dummyValue<_i5.Either<_i6.Failure, (String, String)>>(
          this,
          Invocation.method(
            #login,
            [],
            {
              #username: username,
              #password: password,
            },
          ),
        )),
      ) as _i3.Future<_i5.Either<_i6.Failure, (String, String)>>);

  @override
  _i3.Future<_i5.Either<_i6.Failure, (String, String)>> refreshToken() =>
      (super.noSuchMethod(
        Invocation.method(
          #refreshToken,
          [],
        ),
        returnValue:
            _i3.Future<_i5.Either<_i6.Failure, (String, String)>>.value(
                _i7.dummyValue<_i5.Either<_i6.Failure, (String, String)>>(
          this,
          Invocation.method(
            #refreshToken,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i5.Either<_i6.Failure, (String, String)>>.value(
                _i7.dummyValue<_i5.Either<_i6.Failure, (String, String)>>(
          this,
          Invocation.method(
            #refreshToken,
            [],
          ),
        )),
      ) as _i3.Future<_i5.Either<_i6.Failure, (String, String)>>);
}
