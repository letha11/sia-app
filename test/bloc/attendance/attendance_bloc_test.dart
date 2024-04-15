import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/bloc/attendance/attendance_bloc.dart';
import 'package:sia_app/core/connection.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/attendance.dart';
import 'package:sia_app/data/repository/attendance_repository.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/utils/constants.dart';

@GenerateNiceMocks([
  MockSpec<AttendanceRepository>(),
  MockSpec<Connection>(),
  MockSpec<LocalDBRepository>(),
])
import 'attendance_bloc_test.mocks.dart';

void main() {
  provideDummy<Either<Failure, Attendance>>(Left(InvalidCredentials()));

  final Attendance attendance = Attendance(
    data: [
      Perkuliahan(
        namaMatkul: "ENGLISH FOR COMPUTER I (1A6151CA)",
        perkuliahan: [
          Kuliah(
            kehadiran: AttendanceStatus.present,
            linkModul:
                "http://modul.mercubuana.ac.id/eDB5TndBRE13RWpNMkFqUg==/",
            materi:
                "Students are able to make introduction about themselves and others Mahasiswa mampu memperkenalkan diri sendiri dan orang lain",
            pertemuan: 1,
            tanggal: DateTime.parse("2024-03-04T00:00:00"),
          ),
          Kuliah(
            kehadiran: AttendanceStatus.noClassYet,
            linkModul:
                "https://modul.mercubuana.ac.id/modul.php?kd_mk=F062100007&namamk=ENGLISH FOR COMPUTER I&10",
            materi:
                "Students are able to understand reading text about diagram in computer application Mahasiswa mampu mengerti wacana tentang web",
            pertemuan: 10,
            tanggal: null,
          ),
        ],
      ),
      Perkuliahan(
        namaMatkul: "ANALISA BERORIENTASI OBJEK (1A4153AB)",
        perkuliahan: [
          Kuliah(
            kehadiran: AttendanceStatus.present,
            linkModul:
                "http://modul.mercubuana.ac.id/eDB5TXdBRE13RWpNMkFqUg==/",
            materi:
                "• Mampu menyebutkan berbagai model proses rancang bangun perangkat lunak dan kapan berbagai model tersebut harus dipergunakan • Mampu menjelaskan model Unified Process • Mampu menyebutkan berbagai jenis diagram dalam UML dalam kaitannya dengan tahapan proses dalam Unified Process | Materi : • Perbandingan Berbagai Model Rancang Bangun Perangkat Lunak dan Siklus Hidup Perangkat Lunak serta Pendahuluan Unified Process dan UML",
            pertemuan: 1,
            tanggal: DateTime.parse("2024-03-06T00:00:00"),
          ),
          Kuliah(
            kehadiran: AttendanceStatus.noClassYet,
            linkModul:
                "https://modul.mercubuana.ac.id/modul.php?kd_mk=F062100003&namamk=ANALISA BERORIENTASI OBJEK&11",
            materi:
                "• Mampu membuat software class diagram untuk sebuah sistem informasi | Materi : • Beberapa contoh sistem informasi serta membuat software class diagram",
            pertemuan: 11,
            tanggal: null,
          ),
        ],
      ),
    ],
    success: true,
  );

  late MockAttendanceRepository attendanceRepository;
  late MockLocalDBRepository localDBRepository;
  late MockConnection connection;
  late AttendanceBloc attendanceBloc;

  setUp(() {
    attendanceRepository = MockAttendanceRepository();
    localDBRepository = MockLocalDBRepository();
    connection = MockConnection();
    attendanceBloc = AttendanceBloc(
      attendanceRepository: attendanceRepository,
      connection: connection,
      localDBRepository: localDBRepository,
    );

    when(connection.checkConnection()).thenAnswer((_) async => true);
  });

  test('constructor works', () {
    expect(attendanceBloc, isA<AttendanceBloc>());
    expect(attendanceBloc.state, AttendanceInitial());
  });

  group(
    'FetchAttendance',
    () {
      blocTest(
        "should emit [AttendanceLoading, AttendanceFailure] when request on `attendanceRepository` went wrong or failed",
        setUp: () {
          when(attendanceRepository.getAttendance()).thenAnswer(
              (_) async => Left(UnhandledFailure(Exception('x_x'))));
        },
        act: (b) => b.add(FetchAttendance()),
        build: () => attendanceBloc,
        verify: (b) {
          verify(attendanceRepository.getAttendance()).called(1);
        },
        expect: () => <AttendanceState>[
          AttendanceLoading(),
          const AttendanceFailed(errorMessage: 'x_x'),
        ],
      );

      blocTest(
        "should emit [AttendanceLoading, AttendanceFailure] when request on `attendanceRepository` return an Left(Unauthorized)",
        setUp: () {
          when(attendanceRepository.getAttendance())
              .thenAnswer((_) async => Left(Unauthorized()));
        },
        act: (b) => b.add(FetchAttendance()),
        build: () => attendanceBloc,
        verify: (b) {
          verify(attendanceRepository.getAttendance()).called(1);
        },
        expect: () => <AttendanceState>[
          AttendanceLoading(),
          const AttendanceFailed(errorMessage: 'x_x'),
        ],
      );

      // timeout
      blocTest(
        "should emit [AttendanceLoading, AttendanceFailed] when the result of `attendanceRepository` are Left(TimeoutFailure) and `localDBRepository.get` are null",
        setUp: () async {
          when(attendanceRepository.getAttendance())
              .thenAnswer((_) async => Left(TimeoutFailure()));
          when(localDBRepository.get(any)).thenReturn(null);
          when(connection.checkConnection()).thenAnswer((_) async => true);
        },
        act: (b) => b.add(FetchAttendance()),
        build: () => attendanceBloc,
        verify: (b) {
          verify(localDBRepository.get(any)).called(1);
        },
        expect: () => <AttendanceState>[
          AttendanceLoading(),
          const AttendanceFailed(errorMessage: "x_x"),
        ],
      );
      
      blocTest(
        "should emit [AttendanceLoading, AttendanceFailed] when the result of `attendanceRepository` are Left(TimeoutFailure) and `localDBRepository.get` are stored data but `Attendance` failed to parse it",
        setUp: () async {
          when(attendanceRepository.getAttendance())
              .thenAnswer((_) async => Left(TimeoutFailure()));
          when(localDBRepository.get(any)).thenReturn("{data: }");
          when(connection.checkConnection()).thenAnswer((_) async => true);
        },
        act: (b) => b.add(FetchAttendance()),
        build: () => attendanceBloc,
        verify: (b) {
          verify(localDBRepository.get(any)).called(1);
        },
        expect: () => <AttendanceState>[
          AttendanceLoading(),
          const AttendanceFailed(errorMessage: "x_x"),
        ],
      );

      blocTest(
        "should emit [AttendanceLoading, AttendanceSuccess] when the result of `attendanceRepository` are Left(TimeoutFailure) but `localDBRepository` return stored data and `Attendance` can parse it",
        setUp: () async {
          when(attendanceRepository.getAttendance())
              .thenAnswer((_) async => Left(TimeoutFailure()));
          when(localDBRepository.get(any)).thenReturn(attendance.toJson());
          when(connection.checkConnection()).thenAnswer((_) async => true);
        },
        act: (b) => b.add(FetchAttendance()),
        build: () => attendanceBloc,
        verify: (b) {
          verify(localDBRepository.get(any)).called(1);
        },
        expect: () => <AttendanceState>[
          AttendanceLoading(),
          AttendanceSuccess(attendance),
        ],
      );

      // no connection
      blocTest(
        "should emit [AttendanceLoading, AttendanceFailed] when the result of `localDBRepository.get` are null",
        setUp: () {
          when(localDBRepository.get(any)).thenReturn(null);
          when(connection.checkConnection()).thenAnswer((_) async => false);
        },
        act: (b) => b.add(FetchAttendance()),
        build: () => attendanceBloc,
        verify: (b) {
          verify(localDBRepository.get(any)).called(1);
        },
        expect: () => <AttendanceState>[
          AttendanceLoading(),
          const AttendanceFailed(errorMessage: "x_x"),
        ],
      );

      blocTest(
        "should emit [AttendanceLoading, AttendanceFailed] when the result of `localDBRepository.get` are not null but failed on parsing the stored data",
        setUp: () {
          when(localDBRepository.get(any)).thenReturn("{data: [{no: 1}]}");
          when(connection.checkConnection()).thenAnswer((_) async => false);
        },
        act: (b) => b.add(FetchAttendance()),
        build: () => attendanceBloc,
        verify: (b) {
          verify(localDBRepository.get(any)).called(1);
        },
        expect: () => <AttendanceState>[
          AttendanceLoading(),
          const AttendanceFailed(errorMessage: "x_x"),
        ],
      );

      blocTest(
        "should emit [AttendanceLoading, AttendanceSuccess] when the result of `localDBRepository.get` are not null and success parsing",
        setUp: () {
          when(localDBRepository.get(any)).thenReturn(attendance.toJson());
          when(connection.checkConnection()).thenAnswer((_) async => false);
        },
        act: (b) => b.add(FetchAttendance()),
        build: () => attendanceBloc,
        verify: (b) {
          verify(localDBRepository.get(any)).called(1);
        },
        expect: () => <AttendanceState>[
          AttendanceLoading(),
          AttendanceSuccess(attendance),
        ],
      );

      blocTest(
        "should emit [AttendanceLoading, AttendanceSuccess] when request on `attendanceRepository` return an Right(Attendance)",
        setUp: () {
          when(attendanceRepository.getAttendance())
              .thenAnswer((_) async => Right(attendance));
        },
        act: (b) => b.add(FetchAttendance()),
        build: () => attendanceBloc,
        verify: (b) {
          verify(attendanceRepository.getAttendance()).called(1);
          verify(localDBRepository.store(any, any)).called(1);
        },
        expect: () => <AttendanceState>[
          AttendanceLoading(),
          AttendanceSuccess(attendance),
        ],
      );
    },
  );
}
