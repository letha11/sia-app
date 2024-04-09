import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/bloc/schedule/schedule_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/schedule.dart';
import 'package:sia_app/data/repository/schedule_repository.dart';

@GenerateNiceMocks([MockSpec<ScheduleRepository>()])
import 'schedule_bloc_test.mocks.dart';

void main() {
  provideDummy<Either<Failure, Schedule>>(
      Left(UnhandledFailure(Exception('X_X'))));

  const successSchedule = Schedule(
    success: true,
    mataKuliah: {
      'senin': [
        ScheduleSubject(
          dosen: "Wawan Gunawan",
          hari: "Senin",
          namaMatkul: "Pemrograman Lanjut",
          ruangan: "A-402",
          time: "07.30-12.00",
        )
      ]
    },
    periode: [
      Period(label: 'Gasal 2022', value: "20221"),
    ],
  );

  late ScheduleBloc bloc;
  late MockScheduleRepository scheduleRepository;

  setUp(() {
    scheduleRepository = MockScheduleRepository();
    bloc = ScheduleBloc(scheduleRepository: scheduleRepository);
  });

  group('constructor', () {
    test('work', () {
      expect(ScheduleBloc(scheduleRepository: scheduleRepository),
          isA<ScheduleBloc>());
    });
  });

  group('FetchSchedule', () {
    blocTest(
      'should emit [ScheduleLoading, ScheduleFailed] when `getSchedule` returns an Left(Unauthorized)',
      build: () => bloc,
      act: (b) => b.add(const FetchSchedule()),
      setUp: () {
        when(scheduleRepository.getSchedule())
            .thenAnswer((_) async => Left(Unauthorized()));
      },
      verify: (_) {
        verify(scheduleRepository.getSchedule()).called(1);
      },
      expect: () => [
        ScheduleLoading(),
        const ScheduleFailed(errorMessage: 'x_x'),
      ],
    );

    blocTest(
      'should emit [ScheduleLoading, ScheduleFailed] when `getSchedule` returns Left(TimeoutFailure)',
      build: () => bloc,
      act: (b) => b.add(const FetchSchedule()),
      setUp: () {
        when(scheduleRepository.getSchedule())
            .thenAnswer((_) async => Left(TimeoutFailure()));
      },
      verify: (_) {
        verify(scheduleRepository.getSchedule()).called(1);
      },
      expect: () => [
        ScheduleLoading(),
        const ScheduleFailed(errorMessage: 'x_x'),
      ],
    );

    blocTest(
      'should emit [ScheduleLoading, ScheduleFailed] when `getSchedule` returns Left(UnhandledFailure)',
      build: () => bloc,
      act: (b) => b.add(const FetchSchedule()),
      setUp: () {
        when(scheduleRepository.getSchedule())
            .thenAnswer((_) async => Left(UnhandledFailure(Exception("x_x"))));
      },
      verify: (_) {
        verify(scheduleRepository.getSchedule()).called(1);
      },
      expect: () => [
        ScheduleLoading(),
        const ScheduleFailed(errorMessage: 'x_x'),
      ],
    );

    blocTest(
      'should emit [ScheduleLoading, ScheduleSuccess] when `getSchedule` returns Right(Schedule)',
      build: () => bloc,
      act: (b) => b.add(const FetchSchedule()),
      setUp: () {
        when(scheduleRepository.getSchedule()).thenAnswer(
          (_) async => const Right(successSchedule),
        );
      },
      verify: (_) {
        verify(scheduleRepository.getSchedule()).called(1);
      },
      expect: () => [
        ScheduleLoading(),
        const ScheduleSuccess(schedule: successSchedule),
      ],
    );
  });
}
