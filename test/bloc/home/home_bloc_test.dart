import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/bloc/home/home_bloc.dart';
import 'package:sia_app/core/connection.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/user_detail.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/data/repository/user_repository.dart';

@GenerateNiceMocks([
  MockSpec<UserRepository>(),
  MockSpec<LocalDBRepository>(),
  MockSpec<Connection>(),
])
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
    nim: "41522010137",
    pendidikanAsal: "SMU",
    periodeMasuk: "Semester Gasal 2022",
    semester: "4",
    sksTempuh: "66",
    status: "Aktif",
    success: true,
  );

  late HomeBloc bloc;
  late MockUserRepository userRepository;
  late MockLocalDBRepository localDBRepository;
  late MockConnection connection;

  setUp(() {
    userRepository = MockUserRepository();
    connection = MockConnection();
    localDBRepository = MockLocalDBRepository();
    bloc = HomeBloc(
      userRepository: userRepository,
      connection: connection,
      localDBRepository: localDBRepository,
    );
  });

  group('constructor', () {
    test('work', () {
      expect(bloc, isA<HomeBloc>());
    });
  });

  group('FetchUserDetail no connection', () {
    setUp(() {
      when(connection.checkConnection()).thenAnswer((_) async => false);
    });

    blocTest(
      'should emit [HomeLoading, HomeFailed] when `localDBRepository.get` return a null value',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(localDBRepository.get(any)).thenReturn(null);
      },
      expect: () => [
        HomeLoading(),
        HomeFailed(errorMessage: "x_x"),
      ],
    );

    blocTest(
      'should emit [HomeLoading, HomeFailed] when `UserDetail` failed to parse the stored data',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(localDBRepository.get(any)).thenReturn('{data: {no: true}}');
      },
      expect: () => [
        HomeLoading(),
        HomeFailed(errorMessage: "x_x"),
      ],
    );

    blocTest(
      'should emit [HomeLoading, HomeSuccess] when `localDBRepository.get` return the stored data',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(localDBRepository.get(any)).thenReturn(userDetail.toJson());
      },
      expect: () => [
        HomeLoading(),
        HomeSuccess(userDetail: userDetail),
      ],
    );
  });

  group('FetchUserDetail TimeoutFailure', () {
    setUp(() {
      when(connection.checkConnection()).thenAnswer((_) async => true);
    });
    
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
      'should emit [HomeLoading, HomeFailed] when userRepository.getDetail return an Left(TimeoutFailure) and `localDBRepository.get` return null',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(userRepository.getDetail())
            .thenAnswer((_) async => Left(TimeoutFailure()));
        when(localDBRepository.get(any)).thenReturn(null);
      },
      expect: () => [
        HomeLoading(),
        HomeFailed(errorMessage: "x_x"),
      ],
    );
    
    blocTest(
      'should emit [HomeLoading, HomeFailed] when userRepository.getDetail return an Left(TimeoutFailure) and `localDBRepository.get` return stored data but `UserDetail` failed parsing it',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(userRepository.getDetail())
            .thenAnswer((_) async => Left(TimeoutFailure()));
        when(localDBRepository.get(any)).thenReturn("{data:}");
      },
      expect: () => [
        HomeLoading(),
        HomeFailed(errorMessage: "x_x"),
      ],
    );

    blocTest(
      'should emit [HomeLoading, HomeSuccess] when userRepository.getDetail return an Left(TimeoutFailure) and `localDBRepository.get` return the stored UserDetail',
      build: () => bloc,
      act: (b) => b.add(FetchUserDetailEvent()),
      setUp: () {
        when(userRepository.getDetail())
            .thenAnswer((_) async => Left(TimeoutFailure()));
        when(localDBRepository.get(any)).thenReturn(userDetail.toJson());
      },
      expect: () => [
        HomeLoading(),
        HomeSuccess(userDetail: userDetail),
      ],
    );
  });

  group('FetchUserDetail connection exist', () {
    setUp(() {
      when(connection.checkConnection()).thenAnswer((_) async => true);
    });

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
