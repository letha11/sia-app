import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/schedule.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/data/repository/schedule_repository.dart';

@GenerateNiceMocks([MockSpec<LocalDBRepository>()])
import 'schedule_repository_test.mocks.dart';

void main() {
  const successResponse = {
    "data": {
      "mata_kuliah": {
        "jumat": [
          {
            "dosen": "Syamsir Alam, S.Kom, MT",
            "hari": "Jumat",
            "nama_matkul":
                "PENDIDIKAN ANTI KORUPSI DAN ETIK UMB Anti-Corruption Education and UMB Ethics",
            "ruangan": "B-402",
            "time": "07:30 - 09:10"
          },
          {
            "dosen": "Dadi Waras Suhardjono, Dr. S.S, M.Pd.",
            "hari": "Jumat",
            "nama_matkul": "BAHASA INDONESIA Indonesian Language",
            "ruangan": "E-403",
            "time": "09:30 - 11:10"
          }
        ],
        "kamis": [
          {
            "dosen": "Rudi Hartono, ST, M.Kom",
            "hari": "Kamis",
            "nama_matkul":
                "PENGOLAHAN CITRA Image Processing https://fast.mercubuana.ac.id",
            "ruangan": "VT.D-101",
            "time": "07:30 - 10:00"
          },
          {
            "dosen": "Dwi Ade Handayani Capah, S.Kom, M.Kom",
            "hari": "Kamis",
            "nama_matkul":
                "PEMODELAN 2D/3D Modeling 2D/3D https://fast.mercubuana.ac.id",
            "ruangan": "VE-048",
            "time": "10:15 - 12:45"
          },
          {
            "dosen": "Sustono, Ir, MT",
            "hari": "Kamis",
            "nama_matkul": "KOMPUTASI AWAN Cloud Computing",
            "ruangan": "B-302",
            "time": "13:15 - 15:45"
          }
        ],
        "rabu": [
          {
            "dosen": "Siti Maesaroh, S.Kom., M.T.I",
            "hari": "Rabu",
            "nama_matkul":
                "ANALISA BERORIENTASI OBJEK Object Oriented Analysis",
            "ruangan": "D-308",
            "time": "07:30 - 10:00"
          },
          {
            "dosen": "Hariesa Budi Prabowo, ST., MM",
            "hari": "Rabu",
            "nama_matkul": "MOBILE PROGRAMMING Mobile Programming",
            "ruangan": "T-007",
            "time": "10:15 - 12:45"
          }
        ],
        "senin": [
          {
            "dosen": "Yayah Makiyah, SS,M.Pd",
            "hari": "Senin",
            "nama_matkul": "ENGLISH FOR COMPUTER I English for Computer I",
            "ruangan": "A-406",
            "time": "13:15 - 15:45"
          }
        ]
      },
      "periode": [
        {"label": "Gasal 2022", "value": "20221"},
        {"label": "Genap 2022", "value": "20223"},
        {"label": "Gasal 2023", "value": "20231"},
        {"label": "Genap 2023", "value": "20233"}
      ]
    },
    "success": true
  };

  late Dio dio;
  late DioAdapter dioAdapter;
  late DioClient dioClient;
  late ScheduleRepository scheduleRepository;
  late MockLocalDBRepository localDBRepository;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
    localDBRepository = MockLocalDBRepository();

    dioClient = DioClient(dio: dio, localDBRepository: localDBRepository);
    scheduleRepository = ScheduleRepository(dioClient: dioClient);
  });

  group('constructor', () {
    test('work', () {
      expect(scheduleRepository, isA<ScheduleRepository>());
    });
  });

  group('getJadwal', () {
    const route = "/jadwal";

    test(
        'should return Left(Unauthorized) when request return with 401 status code',
        () async {
      dioAdapter.onGet(route, (server) => server.reply(401, ""));

      final result = await scheduleRepository.getSchedule();

      expect(result.isLeft(), true);
      expect(result, equals(Left(Unauthorized())));
    });

    test(
        'should return Left(TimeoutFailure) when request return with 503 status code',
        () async {
      dioAdapter.onGet(route, (server) => server.reply(503, "timeout"));

      final result = await scheduleRepository.getSchedule();

      expect(result.isLeft(), true);
      expect(result, equals(Left(TimeoutFailure())));
    });

    test('should return Right(Schedule) when request are successfull',
        () async {
      dioAdapter.onGet(route, (server) => server.reply(200, successResponse));

      final result = await scheduleRepository.getSchedule();

      expect(result.isRight(), true);
      expect(result, equals(Right(Schedule.fromJson(successResponse))));
    });
  });
}
