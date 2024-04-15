import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/schedule.dart';
import 'package:sia_app/data/repository/schedule_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _scheduleRepository;

  ScheduleBloc({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository,
        super(ScheduleInitial()) {
    on<FetchSchedule>(_onFetchSchedule);
  }

  _onFetchSchedule(FetchSchedule event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());

    final result =
        await _scheduleRepository.getSchedule(periode: event.periode);

    result.fold(
      (err) {
        if (err is Unauthorized) {
          emit(
            ScheduleFailed(
              error: err,
              errorMessage: err.defaultMessage,
            ),
          );
        } else if (err is TimeoutFailure) {
          emit(
            ScheduleFailed(
              error: err,
              errorMessage: "Periksa kembali koneksi anda dan coba lagi",
            ),
          );
        } else {
          emit(
            ScheduleFailed(
              error: err,
              errorMessage:
                  "Terjadi kesalahan:\n${(err as UnhandledFailure).exception ?? ''}",
            ),
          );
        }
      },
      (data) {
        emit(
          ScheduleSuccess(
            schedule: data,
          ),
        );
      },
    );
  }
}
