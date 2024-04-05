part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {}

final class AuthUnauthenticated extends AuthState {}

final class AuthSuccess extends AuthState {
  final bool isInitialApp;

  AuthSuccess({this.isInitialApp = false});
}

final class AuthFailed extends AuthState {
  final String errorMessage;
  final Failure? error;

  AuthFailed({required this.errorMessage, this.error});

  @override
  List<Object?> get props => [];
}
