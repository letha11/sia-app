import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/user_detail.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/data/repository/user_repository.dart';

@GenerateNiceMocks([MockSpec<LocalDBRepository>()])
import 'user_repository_test.mocks.dart';

void main() {
  late Dio dio;
  late DioClient dioClient;
  late DioAdapter dioAdapter;
  late UserRepository userRepository;
  late MockLocalDBRepository localDBRepository;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
    dio.httpClientAdapter = dioAdapter;

    localDBRepository = MockLocalDBRepository();
    dioClient = DioClient(dio: dio, localDBRepository: localDBRepository);
    userRepository = UserRepository(dioClient: dioClient);
  });

  group('constructor', () {
    test('work', () {
      expect(UserRepository(dioClient: dioClient), isA<UserRepository>());
    });
  });

  group('getDetail', () {
    const route = "/detail";

    test(
        'should return Left(Unauthorized) when request return with 401 status code',
        () async {
      dioAdapter.onGet(route, (server) => server.reply(401, ""));

      final result = await userRepository.getDetail();

      expect(result.isLeft(), true);
      expect(result, equals(Left(Unauthorized())));
    });

    test(
        'should return Left(TimeoutFailure) when request return with 503 status code',
        () async {
      dioAdapter.onGet(route, (server) => server.reply(503, "timeout"));

      final result = await userRepository.getDetail();

      expect(result.isLeft(), true);
      expect(result, equals(Left(TimeoutFailure())));
    });

    test('should return Right(UserDetail) when request are successful',
        () async {
      final resultExpected = UserDetail(
        fakultas: "Ilmu Komputer",
        ipk: "3.86",
        ipsTerakhir: "3.87",
        jurusan: "Teknik Informatika",
        kampus: "Meruya",
        kelas: "Reguler",
        kurikulum: "1521 - Kurikulum 2021 Reguler",
        nama: "IBKA ANHAR FATCHA(Lapor BAP, ijazah)",
        nim: "41522010137",
        pendidikanAsal: "SMU",
        periodeMasuk: "Semester Gasal 2022",
        semester: "4",
        sksTempuh: "66",
        status: "Aktif",
        success: true,
      );

      dioAdapter.onGet(
        route,
        (server) => server.reply(200, {
          "data": {
            "fakultas": "Ilmu Komputer",
            "ipk": "3.86",
            "ips_terakhir": "3.87",
            "jurusan": "Teknik Informatika",
            "kampus": "Meruya",
            "kelas": "Reguler",
            "kurikulum": "1521 - Kurikulum 2021 Reguler",
            "nama": "IBKA ANHAR FATCHA(Lapor BAP, ijazah)",
            "nim": "41522010137",
            "pendidikan_asal": "SMU",
            "periode_masuk": "Semester Gasal 2022",
            "semester": "4",
            "sks_tempuh": "66",
            "status": "Aktif",
          },
          "success": true,
        }),
      );

      final result = await userRepository.getDetail();

      expect(result.isRight(), true);
      expect(result, equals(Right(resultExpected)));
    });
  });
}
