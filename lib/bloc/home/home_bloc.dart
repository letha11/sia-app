import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/connection.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/user_detail.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/data/repository/user_repository.dart';
import 'package:sia_app/utils/constants.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;
  final LocalDBRepository _localDBRepository;
  final Connection _connection;

  HomeBloc({
    required UserRepository userRepository,
    required LocalDBRepository localDBRepository,
    required Connection connection,
  })  : _userRepository = userRepository,
        _localDBRepository = localDBRepository,
        _connection = connection,
        super(HomeInitial()) {
    on<FetchUserDetailEvent>(_onFetchUserDetailEvent);
  }

  _onFetchUserDetailEvent(
      FetchUserDetailEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final isConnected = await _connection.checkConnection();
    final result = await _getDetailData(isConnected);

    await result.fold(
      (err) async {
        if (err is Unauthorized) {
          emit(
            HomeFailed(
              error: err,
              errorMessage: "Silahkan login ulang untuk mengakses halaman ini",
            ),
          );
        } else if (err is NoDataFailure) {
          emit(HomeFailed(error: err, errorMessage: err.defaultMessage));
        } else if (err is TimeoutFailure) {
          try {
            final userDetail = await _getUserDetailLocal();

            if (userDetail != null) {
              emit(HomeSuccess(userDetail: userDetail));
            } else {
              emit(
                HomeFailed(
                  error: err,
                  errorMessage:
                      "Website host sedang tidak aktif, mohon coba lagi beberapa saat",
                ),
              );
            }
          } catch (e, stackTrace) {
            emit(
              HomeFailed(
                error: err,
                errorMessage:
                    "Terjadi kesalahan:\n$stackTrace",
              ),
            );
          }
        } else {
          emit(
            HomeFailed(
              error: err,
              errorMessage:
                  "Terjadi kesalahan:\n${(err as UnhandledFailure).exception ?? ''}",
            ),
          );
        }
      },
      (data) {
        _localDBRepository.store(HiveKey.detailJson, data.toJson());
        emit(
          HomeSuccess(
            userDetail: data,
          ),
        );
      },
    );
  }

  Future<UserDetail?> _getUserDetailLocal() async {
    final storedUserDetail = await _localDBRepository.get(HiveKey.detailJson);

    return storedUserDetail != null
        ? UserDetail.fromJson(storedUserDetail)
        : null;
  }

  Future<Either<Failure, UserDetail>> _getDetailData(bool isConnected) async {
    if (isConnected) {
      return _userRepository.getDetail();
    } else {
      try {
        final localDetail = await _getUserDetailLocal();
        return localDetail != null ? Right(localDetail) : Left(NoDataFailure());
      } catch (e) {
        return Left(UnhandledFailure(e));
      }
    }
  }
}
