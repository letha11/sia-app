part of 'attendance_bloc.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceSuccess extends AttendanceState {
  final Attendance attendance;

  const AttendanceSuccess(this.attendance);

  @override
  List<Object> get props => [attendance];
}

final class AttendanceFailed extends AttendanceState {
  final String errorMessage;
  final Failure? error;

  const AttendanceFailed({required this.errorMessage, this.error});
}
