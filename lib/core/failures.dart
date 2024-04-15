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
  final defaultMessage = "Silahkan login ulang untuk mengakses halaman ini";

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return "Unauthorized";
  }
}

class NoDataFailure extends Failure {
  final defaultMessage = "Kamu sedang offline, periksa koneksi kamu lalu coba lagi";
  
  @override
  String toString() {
    return "No Data";
  }
}

class TimeoutFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return "Timeout";
  }
}
