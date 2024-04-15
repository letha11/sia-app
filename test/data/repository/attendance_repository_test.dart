import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/attendance.dart';
import 'package:sia_app/data/repository/attendance_repository.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';

@GenerateNiceMocks([MockSpec<LocalDBRepository>()])
import 'attendance_repository_test.mocks.dart';

void main() {
  const json = {
    "data": [
      {
        "nama_matkul": "ENGLISH FOR COMPUTER I (1A6151CA)",
        "perkuliahan": [
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/eDB5TndBRE13RWpNMkFqUg==/",
            "materi":
                "Students are able to make introduction about themselves and others Mahasiswa mampu memperkenalkan diri sendiri dan orang lain",
            "pertemuan": 1,
            "tanggal": "2024-03-04T00:00:00"
          },
          {
            "kehadiran": "Belum Dilaksanakan",
            "link_modul":
                "https://modul.mercubuana.ac.id/modul.php?kd_mk=F062100007&namamk=ENGLISH FOR COMPUTER I&10",
            "materi":
                "Students are able to understand reading text about diagram in computer application Mahasiswa mampu mengerti wacana tentang web",
            "pertemuan": 10,
            "tanggal": null
          },
        ]
      },
      {
        "nama_matkul": "ANALISA BERORIENTASI OBJEK (1A4153AB)",
        "perkuliahan": [
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/eDB5TXdBRE13RWpNMkFqUg==/",
            "materi":
                "• Mampu menyebutkan berbagai model proses rancang bangun perangkat lunak dan kapan berbagai model tersebut harus dipergunakan • Mampu menjelaskan model Unified Process • Mampu menyebutkan berbagai jenis diagram dalam UML dalam kaitannya dengan tahapan proses dalam Unified Process | Materi : • Perbandingan Berbagai Model Rancang Bangun Perangkat Lunak dan Siklus Hidup Perangkat Lunak serta Pendahuluan Unified Process dan UML",
            "pertemuan": 1,
            "tanggal": "2024-03-06T00:00:00"
          },
          {
            "kehadiran": "Belum Dilaksanakan",
            "link_modul":
                "https://modul.mercubuana.ac.id/modul.php?kd_mk=F062100003&namamk=ANALISA BERORIENTASI OBJEK&11",
            "materi":
                "• Mampu membuat software class diagram untuk sebuah sistem informasi | Materi : • Beberapa contoh sistem informasi serta membuat software class diagram",
            "pertemuan": 11,
            "tanggal": null
          }
        ]
      },
    ],
    "success": true
  };


  late Dio dio;
  late DioAdapter dioAdapter;
  late MockLocalDBRepository localDBRepository;
  late AttendanceRepository attendanceRepository;
  late DioClient dioClient;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
    localDBRepository = MockLocalDBRepository();
    dioClient = DioClient(dio: dio, localDBRepository: localDBRepository);
    attendanceRepository = AttendanceRepository(dioClient: dioClient);
  });

  test('constructor works', () {
    expect(AttendanceRepository(dioClient: dioClient),
        isA<AttendanceRepositoryA>());
  });

  group('getAttendance', () {
    const route = "/attendance";

    test('should return Left(UnhandledFailure) when something went wrong',
        () async {
      final exc = Exception('x_x');
      when(localDBRepository.get(any)).thenThrow(exc);

      final result = await attendanceRepository.getAttendance();

      expect(result.isLeft(), true);
      result.fold((l) => expect(l, isA<UnhandledFailure>()), (r) => null);
    });

    test('should return Left(UnhandledFailure) when dio throws an exception',
        () async {
      dioAdapter.onGet(route, (server) {
        server.throws(500, DioException(requestOptions: RequestOptions()));
      });

      final result = await attendanceRepository.getAttendance();

      expect(result.isLeft(), true);
      result.fold((l) => expect(l, isA<UnhandledFailure>()), (r) => null);
    });

    test(
        'should return Left(TimeoutFailure) when server return a response with a 503 status code',
        () async {
      dioAdapter.onGet(route, (server) {
        server.reply(503, '');
      });

      final result = await attendanceRepository.getAttendance();

      expect(result.isLeft(), true);
      expect(result, equals(Left(TimeoutFailure())));
    });

    test(
        'should return Left(Unauthorized) when servers return a response with a 401 status code',
        () async {
      dioAdapter.onGet(route, (server) => server.reply(401, ''));

      final result = await attendanceRepository.getAttendance();

      expect(result.isLeft(), true);
      expect(result, equals(Left(Unauthorized())));
    });

    test('should return Right(Attendance) when request are successful',
        () async {
      dioAdapter.onGet(route, (server) {
        server.reply(200, json);
      });

      final result = await attendanceRepository.getAttendance();

      expect(result.isRight(), true);
      expect(result, equals(Right(Attendance.fromJson(json))));
    });
  });
}
