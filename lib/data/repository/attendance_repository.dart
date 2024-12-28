import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/attendance.dart';

abstract class AttendanceRepositoryA {
  Future<Either<Failure, Attendance>> getAttendance();
}

class AttendanceRepository implements AttendanceRepositoryA {
  final DioClient _dioClient;

  AttendanceRepository({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<Either<Failure, Attendance>> getAttendance() async {
    try {
      final response = await _dioClient.dioWithToken.get("/attendance");

      final attendance = Attendance.fromJson(response.data);

      return Right(attendance);
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
