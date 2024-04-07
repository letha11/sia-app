import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/repository/auth_repository.dart';
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
    on<Logout>(_onLogout);
  }

  _onLogout(Logout event, Emitter<AuthState> emit) async {
    await _localDBRepository.remove(HiveKey.accessToken);
    await _localDBRepository.remove(HiveKey.refreshToken);

    emit(AuthUnauthenticated());
  }

  _onAuthCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    final String? token = await _localDBRepository.get(HiveKey.refreshToken);

    if (token != null && token.isNotEmpty) {
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
            AuthFailed(
              error: err,
              errorMessage: 'Username dan Password tidak boleh kosong',
            ),
          );
        } else if (err is InvalidCredentials) {
          emit(
            AuthFailed(
              error: err,
              errorMessage: 'Username atau password salah, silahkan coba lagi',
            ),
          );
        } else {
          final message = (err as UnhandledFailure).exception ?? '';
          emit(
            AuthFailed(
              error: err,
              errorMessage: 'Terjadi kesalahan\n$message',
            ),
          );
        }
      },
      (data) {
        final (token, refreshToken) = data;
        _localDBRepository.store(HiveKey.accessToken, token);
        _localDBRepository.store(HiveKey.refreshToken, refreshToken);
        emit(AuthSuccess());
      },
    );
  }
}
