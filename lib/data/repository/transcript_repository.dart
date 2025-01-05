import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/transcript.dart';

abstract class TranscriptRepositoryA {
  Future<Either<Failure, Transcript>> getTranscript();
}

class TranscriptRepository extends TranscriptRepositoryA {
  final DioClient _dioClient;

  TranscriptRepository({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<Either<Failure, Transcript>> getTranscript() async {
    try {
      final response = await _dioClient.dioWithToken.get(
        '/transcript',
      );

      final transcript = Transcript.fromJson(response.data);

      return Right(transcript);
    } on DioException catch (e) {
      final response = e.response;

      if (response?.statusCode == 401) {
        bool relogNeeded = response?.data?['relog_url'] != null;

        if (relogNeeded) return Left(ReloginFailure());

        return Left(Unauthorized());
      }
      if (response?.statusCode == 503) return Left(TimeoutFailure());

      return Left(UnhandledFailure(e));
    } on Exception catch (e) {
      return Left(UnhandledFailure(e));
    }
  }
}
