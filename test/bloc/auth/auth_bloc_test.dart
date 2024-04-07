import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/bloc/auth/auth_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/repository/auth_repository.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';

@GenerateNiceMocks([MockSpec<LocalDBRepository>(), MockSpec<AuthRepository>()])
import 'auth_bloc_test.mocks.dart';

void main() {
  provideDummy<Either<Failure, (String, String)>>(Left(InvalidCredentials()));

  late MockAuthRepository authRepository;
  late MockLocalDBRepository localDBRepository;
  late AuthBloc bloc;

  setUp(() {
    authRepository = MockAuthRepository();
    localDBRepository = MockLocalDBRepository();

    bloc = AuthBloc(
      authRepository: authRepository,
      localDBRepository: localDBRepository,
    );
  });

  group('constructor', () {
    test('work', () {
      expect(
        AuthBloc(
            authRepository: authRepository,
            localDBRepository: localDBRepository),
        isA<AuthBloc>(),
      );
    });
  });

  group('Logout', () {
    blocTest(
      'should emit [AuthUnauthenticated]',
      build: () => bloc,
      act: (b) => b.add(Logout()),
      setUp: () {
        when(localDBRepository.remove(any)).thenReturn(null);
      },
      verify: (_) {
        verify(localDBRepository.remove(any)).called(2);
      },
      expect: () => [
        AuthUnauthenticated(),
      ],
    );
  });

  group('AuthCheckStatus', () {
    blocTest(
        'should emit [AuthUnauthenticated] when `accessToken` doesn\' exists in localDBRepository',
        build: () => bloc,
        act: (b) => b.add(AuthCheckStatus()),
        setUp: () {
          when(localDBRepository.get(any)).thenReturn(null);
        },
        expect: () => [
              AuthUnauthenticated(),
            ]);

    blocTest(
        'should emit [AuthAuthenticated] when `accessToken` exists in localDBRepository',
        build: () => bloc,
        act: (b) => b.add(AuthCheckStatus()),
        setUp: () {
          when(localDBRepository.get(any)).thenReturn('token is here!');
        },
        expect: () => [
              AuthAuthenticated(),
            ]);
  });

  group('Login', () {
    blocTest(
      'should emit [AuthLoading, AuthFailed] when authRepository.login return an `Left(InvalidCredentials)`',
      build: () => bloc,
      act: (b) => b.add(Login(username: 'asd', password: 'asd')),
      setUp: () {
        when(authRepository.login(
          username: anyNamed('username'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => Left(InvalidCredentials()));
      },
      expect: () => <AuthState>[
        AuthLoading(),
        AuthFailed(errorMessage: 'anything!'),
      ],
    );

    blocTest(
      'should emit [AuthLoading, AuthFailed] when authRepository.login return an `Left(InvalidInput)`',
      build: () => bloc,
      act: (b) => b.add(Login(username: 'asd', password: 'asd')),
      setUp: () {
        when(authRepository.login(
          username: anyNamed('username'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => Left(InvalidInput()));
      },
      expect: () => <AuthState>[
        AuthLoading(),
        AuthFailed(errorMessage: 'anything!'),
      ],
    );

    blocTest(
      'should emit [AuthLoading, AuthFailed] when authRepository.login return an `Left(UnhandledError)`',
      build: () => bloc,
      act: (b) => b.add(Login(username: 'asd', password: 'asd')),
      setUp: () {
        when(authRepository.login(
          username: anyNamed('username'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => Left(UnhandledFailure(Exception('x_x'))));
      },
      expect: () => <AuthState>[
        AuthLoading(),
        AuthFailed(errorMessage: 'anything!'),
      ],
    );

    blocTest(
      'should call `localDBRepository.store` and emit [AuthLoading, AuthSuccess] when authRepository.login return an `Right(token)`',
      build: () => bloc,
      act: (b) => b.add(Login(username: 'asd', password: 'asd')),
      setUp: () {
        when(authRepository.login(
          username: anyNamed('username'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => const Right(('token', 'refreshToken')));
      },
      verify: (_) {
        verify(localDBRepository.store(any, any)).called(2);
      },
      expect: () => <AuthState>[
        AuthLoading(),
        AuthSuccess(),
      ],
    );
  });
}
