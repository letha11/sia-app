import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sia_app/core/dio_client.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/repository/auth/auth_repository.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/utils/constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final LocalDBRepository _localDBRepository;

  AuthBloc({
    required AuthRepository authRepository,
    required LocalDBRepository localDBRepository,
  })  : _authRepository = authRepository,
        _localDBRepository = localDBRepository,
        super(AuthInitial()) {
    on<Login>(_onLogin);
    on<AuthCheckStatus>(_onAuthCheckStatus);
  }

  _onAuthCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    final String? token = await _localDBRepository.get(HiveKey.accessToken);

    if(token != null && token.isNotEmpty) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await _authRepository.login(
      username: event.username,
      password: event.password,
    );

    response.fold(
      (err) {
        if (err is InvalidInput) {
          emit(
            AuthFailed(errorMessage: 'Username dan Password tidak boleh kosong'),
          );
        } else if (err is InvalidCredentials) {
          emit(
            AuthFailed(errorMessage: 'Username atau password salah, silahkan coba lagi'),
          );
        } else {
          final message = (err as UnhandledFailure).exception ?? '';
          emit(
            AuthFailed(errorMessage: 'Terjadi kesalahan\n$message'),
          );
        }
      },
      (token) {
        _localDBRepository.store(HiveKey.accessToken, token);
        emit(AuthSuccess());
      },
    );
  }
}
