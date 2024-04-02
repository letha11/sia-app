import 'package:get_it/get_it.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';

final sl = GetIt.I;

void initialize() {
  sl.registerLazySingletonAsync(
    () async => await LocalDBRepository.create(),
  );
  sl.registerLazySingleton<DioClient>(() => DioClient(localDBRepository: sl()));
}
