import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/user_detail.dart';

abstract class UserRepositoryA {
  Future<Either<Failure, UserDetail>> getDetail();
}

class UserRepository extends UserRepositoryA {
  final DioClient _dioClient;

  UserRepository({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<Either<Failure, UserDetail>> getDetail() async {
    try {
      final response = await _dioClient.dioWithToken.get('/detail');

      final userDetail = UserDetail.fromJson(response.data);

      return Right(userDetail);
    } on DioException catch (e) {
      final response = e.response;

      if (response?.statusCode == 401) return Left(Unauthorized());
      if (response?.statusCode == 503) return Left(TimeoutFailure());

      return Left(UnhandledFailure(e));
    } catch (e) {
      return Left(UnhandledFailure(e));
    }
  }
}
