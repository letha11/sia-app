import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';

abstract class AuthRepositoryA {
  Future<Either<Failure, String>> login({
    required String username,
    required String password,
  });
}

class AuthRepository extends AuthRepositoryA {
  final DioClient _dioClient;

  AuthRepository({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<Either<Failure, String>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        '/login',
        data: {
          username: username,
          password: password,
        },
      );

      final String token = response.data['token'];

      return Right(token);
    } on DioException catch (e) {
      final response = e.response;

      if(response?.statusCode == 400) return Left(InvalidInput());
      if(response?.statusCode == 401) return Left(InvalidCredentials());

      return Left(UnhandledFailure(e));
    } catch (e) {
      return Left(UnhandledFailure(e));
    }
  }
}
