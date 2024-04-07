import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/user_detail.dart';
import 'package:sia_app/data/repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;

  HomeBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(HomeInitial()) {
    on<FetchUserDetailEvent>(_onFetchUserDetailEvent);
  }

  _onFetchUserDetailEvent(
      FetchUserDetailEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final result = await _userRepository.getDetail();

    result.fold(
      (err) {
        if (err is Unauthorized) {
          emit(
            HomeFailed(
              error: err,
              errorMessage: "Silahkan login ulang untuk mengakses halaman ini",
            ),
          );
        } else if (err is TimeoutFailure) {
          emit(
            HomeFailed(
              error: err,
              errorMessage: "Periksa kembali koneksi anda dan coba lagi",
            ),
          );
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
        emit(
          HomeSuccess(
            userDetail: data,
          ),
        );
      },
    );
  }
}
