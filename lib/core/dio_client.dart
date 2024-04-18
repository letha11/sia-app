import 'package:dio/dio.dart';
import 'package:sia_app/core/environment.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/utils/constants.dart';

class DioClient {
  late final Dio _dio;
  late final LocalDBRepository _localDB;

  final _options = BaseOptions(
    baseUrl: Environment.baseUrl,
  );

  DioClient({
    Dio? dio,
    required LocalDBRepository localDBRepository,
  }) {
    _dio = dio ?? Dio(_options);
    _dio.interceptors.add(_acceptJsonOnlyInterceptor());
    _localDB = localDBRepository;
  }

  InterceptorsWrapper _acceptJsonOnlyInterceptor() =>
      InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) {
        options.headers['Accept'] = 'application/json';
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      });

  InterceptorsWrapper _tokenInterceptor() => InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers['Authorization'] =
              'Bearer ${_localDB.get(HiveKey.accessToken)}';
          return handler.next(options);
        },
      );

  InterceptorsWrapper _refreshTokenInterceptor() => InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers['Authorization'] =
              'Bearer ${_localDB.get(HiveKey.refreshToken)}';
          return handler.next(options);
        },
      );

  Dio get dio => _dio;

  Dio get dioWithRefreshToken {
    _dio.interceptors.add(_refreshTokenInterceptor());

    return _dio;
  }

  Dio get dioWithToken {
    _dio.interceptors.add(_tokenInterceptor());

    return _dio;
  }
}
