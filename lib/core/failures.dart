import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class UnhandledFailure extends Failure {
  final Object? exception;

  UnhandledFailure(this.exception);

  @override
  List<Object?> get props => [exception];
}

class InvalidCredentials extends Failure {
  @override
  List<Object?> get props => [];
}

class InvalidInput extends Failure {
  @override
  List<Object?> get props => [];
}
