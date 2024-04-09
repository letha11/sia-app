part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

final class ScheduleInitial extends ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleSuccess extends ScheduleState {
  final Schedule schedule;

  const ScheduleSuccess({required this.schedule});

  @override
  List<Object> get props => [schedule];
}

final class ScheduleFailed extends ScheduleState {
  final String errorMessage;
  final Failure? error;

  const ScheduleFailed({required this.errorMessage, this.error});

  @override
  List<Object?> get props => [];
}
