import 'package:dio/dio.dart';
import 'package:sia_app/data/repository/local_db_repository.dart';
import 'package:sia_app/utils/constants.dart';

class DioClient {
  late final Dio _dio;
  late final LocalDBRepository _localDB;

  final _options = BaseOptions(
    baseUrl: baseUrl,
  );

  DioClient({
    Dio? dio,
    required LocalDBRepository localDBRepository,
  }) {
    _dio = dio ?? Dio(_options);
    _dio.interceptors.add(_tokenInterceptor());
    _localDB = localDBRepository;
  }

  InterceptorsWrapper _tokenInterceptor() => InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers['Authorization'] = 'Bearer ${_localDB.get(HiveKey.accessToken)}';
          return handler.next(options);
        },
      );

  Dio get dio => _dio;
}
