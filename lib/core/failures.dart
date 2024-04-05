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

  @override
  String toString() {
    return "UnhandledFailure";
  }
}

class InvalidCredentials extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return "Invalid Credentials";
  }
}

class InvalidInput extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return "Invalid Input";
  }
}

class Unauthorized extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return "Unauthorized";
  }
}
