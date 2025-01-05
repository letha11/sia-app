import 'package:get_it/get_it.dart';
import 'package:sia_app/bloc/attendance/attendance_bloc.dart';
import 'package:sia_app/bloc/auth/auth_bloc.dart';
import 'package:sia_app/bloc/home/home_bloc.dart';
import 'package:sia_app/bloc/schedule/schedule_bloc.dart';
import 'package:sia_app/bloc/transcript/transcript_bloc.dart';
import 'package:sia_app/core/connection.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/data/repository/attendance_repository.dart';
import 'package:sia_app/data/repository/auth_repository.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/data/repository/schedule_repository.dart';
import 'package:sia_app/data/repository/transcript_repository.dart';
import 'package:sia_app/data/repository/user_repository.dart';

final sl = GetIt.I;

void initialize() {
  sl.registerSingletonAsync(
    () async => await LocalDBRepository.create(),
  );

  sl.registerLazySingleton<Connection>(() => Connection());
  sl.registerLazySingleton<DioClient>(
    () => DioClient(localDBRepository: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(dioClient: sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepository(dioClient: sl()),
  );
  sl.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepository(dioClient: sl()),
  );
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepository(dioClient: sl()),
  );
  sl.registerLazySingleton<TranscriptRepository>(
    () => TranscriptRepository(dioClient: sl()),
  );

  sl.registerFactory(
    () => AuthBloc(
      authRepository: sl(),
      localDBRepository: sl(),
      connection: sl(),
    ),
  );

  sl.registerFactory(
    () => HomeBloc(
      userRepository: sl(),
      localDBRepository: sl(),
      connection: sl(),
    ),
  );

  sl.registerFactory(
    () => ScheduleBloc(
      scheduleRepository: sl(),
      localDBRepository: sl(),
      connection: sl(),
    ),
  );

  sl.registerFactory(
    () => AttendanceBloc(
      attendanceRepository: sl(),
      connection: sl(),
      localDBRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => TranscriptBloc(
      transcriptRepository: sl(),
      connection: sl(),
      localDBRepository: sl(),
    ),
  );
}
