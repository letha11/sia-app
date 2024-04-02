import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/repository/auth/auth_repository.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';

@GenerateNiceMocks([MockSpec<DioClient>(), MockSpec<LocalDBRepository>()])
import 'auth_repository_test.mocks.dart';

void main() {
  late DioClient dioClient;
  late Dio dio;
  late DioAdapter dioAdapter;
  late AuthRepository authRepository;
  late MockLocalDBRepository localDBRepository;

  setUpAll(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
    dio.httpClientAdapter = dioAdapter;

    localDBRepository = MockLocalDBRepository();
    dioClient = DioClient(dio: dio, localDBRepository: localDBRepository);
    authRepository = AuthRepository(dioClient: dioClient);
  });

  group('constructor', () {
    test('work', () {
      expect(AuthRepository(dioClient: dioClient), isA<AuthRepositoryA>());
      expect(AuthRepository(dioClient: dioClient), isA<AuthRepository>());
    });
  });

  group('login', () {
    const route = "/login";

    test('should return Left(Failure()) when something went wrong', () async {
      dioAdapter.onPost(route, (server) {
        server.throws(500, DioException(requestOptions: RequestOptions()));
      });

      final result = await authRepository.login(username: 'dummy', password: 'dummy');

      expect(result.isLeft(), true);
      result.fold(
        (err) => expect(err, isA<UnhandledFailure>()),
        (_) => null,
      );
    });

    test('should return Left(InvalidInput()) when `login` returns with 400 status code', () async {
      dioAdapter.onPost(route, (server) => server.reply(400, ''));

      final result = await authRepository.login(username: 'dummy', password: 'dummy');

      expect(result.isLeft(), true);
      expect(result, equals(Left(InvalidInput())));
    });

    test('should return Left(InvalidCredentials()) when `login` returns with 401 status code', () async {
      dioAdapter.onPost(route, (server) => server.reply(401, ''));

      final result = await authRepository.login(username: 'dummy', password: 'dummy');

      expect(result.isLeft(), true);
      expect(result, equals(Left(InvalidCredentials())));
    });

    test('should return Right(token) when `login` success', () async {
      const token = 'yup';

      dioAdapter.onPost(route, (server) => server.reply(200, {'token': token}));

      final result = await authRepository.login(username: 'dummy', password: 'dummy');

      expect(result.isRight(), true);
      expect(result, equals(const Right(token)));
    });

  });
}
