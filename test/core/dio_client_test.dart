import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';

@GenerateNiceMocks(
    [MockSpec<Dio>(), MockSpec<LocalDBRepository>(), MockSpec<Interceptors>()])
import 'dio_client_test.mocks.dart';

void main() {
  late MockDio dio;
  late MockLocalDBRepository localDBRepository;
  late DioClient dioClient;
  late MockInterceptors fakeInterceptors;

  setUp(() {
    dio = MockDio();
    localDBRepository = MockLocalDBRepository();
    fakeInterceptors = MockInterceptors();

    when(dio.interceptors).thenReturn(fakeInterceptors);

    dioClient = DioClient(localDBRepository: localDBRepository, dio: dio);
  });

  group('constructor', () {
    test('works', () {
      final result = DioClient(localDBRepository: localDBRepository, dio: dio);

      expect(result, isA<DioClient>());
    });
  });
}
