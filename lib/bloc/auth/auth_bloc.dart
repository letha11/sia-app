import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/core/connection.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/repository/auth_repository.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/utils/constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final LocalDBRepository _localDBRepository;
  final Connection _connection;

  AuthBloc({
    required AuthRepository authRepository,
    required LocalDBRepository localDBRepository,
    required Connection connection,
  })  : _authRepository = authRepository,
        _localDBRepository = localDBRepository,
        _connection = connection,
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
    final String? refreshToken =
        await _localDBRepository.get(HiveKey.refreshToken);
    final bool isConnected = await _connection.checkConnection();

    if (refreshToken == null || refreshToken.isEmpty) {
      emit(AuthUnauthenticated());
      return;
    }

    if (!isConnected) {
      emit(AuthAuthenticated());
      return;
    }

    final result = await _authRepository.refreshToken();

    result.fold(
      (err) {
        emit(AuthUnauthenticated());
      },
      (data) {
        final (newToken, newRefreshToken) = data;
        _localDBRepository.store(HiveKey.accessToken, newToken);
        _localDBRepository.store(HiveKey.refreshToken, newRefreshToken);
        emit(AuthAuthenticated());
      },
    );
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
