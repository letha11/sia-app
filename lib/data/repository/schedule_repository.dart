import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/schedule.dart';

abstract class ScheduleRepositoryA {
  Future<Either<Failure, Schedule>> getSchedule({String? periode});
}

class ScheduleRepository extends ScheduleRepositoryA {
  final DioClient _dioClient;

  ScheduleRepository({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<Either<Failure, Schedule>> getSchedule({String? periode}) async {
    try {
      final response = await _dioClient.dioWithToken.get(
        '/jadwal',
        queryParameters: {'periode': periode},
      );

      final schedule = Schedule.fromJson(response.data);

      return Right(schedule);
    } on DioException catch (e) {
      final response = e.response;

      if (response?.statusCode == 401) {
        bool relogNeeded = response?.data?['relog_url'] != null;

        if (relogNeeded) return Left(ReloginFailure());

        return Left(Unauthorized());
      }
      if (response?.statusCode == 503) return Left(TimeoutFailure());

      return Left(UnhandledFailure(e));
    } catch (e) {
      return Left(UnhandledFailure(e));
    }
  }
}
