import 'package:get_it/get_it.dart';
import 'package:sia_app/bloc/auth/auth_bloc.dart';
import 'package:sia_app/bloc/home/bloc/home_bloc.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/data/repository/auth_repository.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/data/repository/user_repository.dart';

final sl = GetIt.I;

void initialize() {
  sl.registerSingletonAsync(
    () async => await LocalDBRepository.create(),
  );
  sl.registerLazySingleton<DioClient>(
    () => DioClient(localDBRepository: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(dioClient: sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepository(dioClient: sl()),
  );

  sl.registerFactory(
    () => AuthBloc(
      authRepository: sl(),
      localDBRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => HomeBloc(
      userRepository: sl(),
    ),
  );
}
