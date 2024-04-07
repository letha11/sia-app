import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/bloc/home/bloc/home_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/user_detail.dart';
import 'package:sia_app/data/repository/user_repository.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
import 'home_bloc_test.mocks.dart';

void main() {
  provideDummy<Either<Failure, UserDetail>>(Left(TimeoutFailure()));

  final userDetail = UserDetail(
    fakultas: "Ilmu Komputer",
    ipk: "3.86",
    ipsTerakhir: "3.87",
    jurusan: "Teknik Informatika",
    kampus: "Meruya",
    kelas: "Reguler",
    kurikulum: "1521 - Kurikulum 2021 Reguler",
    nama: "IBKA ANHAR FATCHA(Lapor BAP, ijazah)",
    pendidikanAsal: "SMU",
    periodeMasuk: "Semester Gasal 2022",
    semester: "4",
    sksTempuh: "66",
    status: "Aktif",
    success: true,
  );

  late HomeBloc bloc;
  late MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    bloc = HomeBloc(
      userRepository: userRepository,
    );
  });

  group('constructor', () {
    test('work', () {
      expect(HomeBloc(userRepository: userRepository), isA<HomeBloc>());
    });
  });

  group('FetchUserDetail', () {
    blocTest(
      'should emit [HomeLoading, HomeFailed] when userRepository.getDetail return an Left(Unauthorized)',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(userRepository.getDetail())
            .thenAnswer((_) async => Left(Unauthorized()));
      },
      expect: () => [
        HomeLoading(),
        HomeFailed(errorMessage: "x_x"),
      ],
    );

    blocTest(
      'should emit [HomeLoading, HomeFailed] when userRepository.getDetail return an Left(TimeoutFailure)',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(userRepository.getDetail())
            .thenAnswer((_) async => Left(TimeoutFailure()));
      },
      expect: () => [
        HomeLoading(),
        HomeFailed(errorMessage: "x_x"),
      ],
    );

    blocTest(
      'should emit [HomeLoading, HomeFailed] when userRepository.getDetail return an Left(UnhandledFailure)',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(userRepository.getDetail())
            .thenAnswer((_) async => Left(UnhandledFailure(Exception("x_X"))));
      },
      expect: () => [
        HomeLoading(),
        HomeFailed(errorMessage: "x_x"),
      ],
    );

    blocTest(
      'should emit [HomeLoading, HomeSuccess] when userRepository.getDetail return an Right(UserDetail)',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(userRepository.getDetail())
            .thenAnswer((_) async => Right(userDetail));
      },
      expect: () => [
        HomeLoading(),
        HomeSuccess(userDetail: userDetail),
      ],
    );
  });
}
