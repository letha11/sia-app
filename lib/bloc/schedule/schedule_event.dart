part of 'schedule_bloc.dart';

sealed class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

final class FetchSchedule extends ScheduleEvent {
  final String? periode;

  const FetchSchedule({this.periode});

  @override
  List<Object?> get props => [periode];
}
