import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';

abstract class AuthRepositoryA {
  Future<Either<Failure, (String token, String refreshToken)>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, (String token, String refreshToken)>> refreshToken();
}

class AuthRepository extends AuthRepositoryA {
  final DioClient _dioClient;

  AuthRepository({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<Either<Failure, (String token, String refreshToken)>> login({
    required String username,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });
      final response = await _dioClient.dio.post(
        '/login',
        data: formData,
      );

      final String token = response.data['token'];
      final String refreshToken = response.data['refresh_token'];

      return Right((token, refreshToken));
    } on DioException catch (e) {
      final response = e.response;

      if (response?.statusCode == 400) return Left(InvalidInput());
      if (response?.statusCode == 401) return Left(InvalidCredentials());

      return Left(UnhandledFailure(e));
    } catch (e) {
      return Left(UnhandledFailure(e));
    }
  }

  @override
  Future<Either<Failure, (String token, String refreshToken)>>
      refreshToken() async {
    try {
      final response = await _dioClient.dioWithRefreshToken.post(
        '/refresh-token',
      );

      return Right((response.data['token'], response.data['refresh_token']));
    } on DioException catch (e) {
      final response = e.response;

      if (response?.statusCode == 401) return Left(Unauthorized());

      return Left(UnhandledFailure(e));
    } catch (e) {
      return Left(UnhandledFailure(e));
    }
  }
}
