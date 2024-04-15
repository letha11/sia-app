import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/attendance.dart';
import 'package:sia_app/data/repository/attendance_repository.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository _attendanceRepository;

  AttendanceBloc({required AttendanceRepository attendanceRepository})
      : _attendanceRepository = attendanceRepository,
        super(AttendanceInitial()) {
    on<FetchAttendance>(_onFetchAttendance);
  }

  _onFetchAttendance(
      FetchAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());

    final response = await _attendanceRepository.getAttendance();

    response.fold((err) {
      if (err is TimeoutFailure) {
        // caching ?
      } else if (err is Unauthorized) {
        emit(AttendanceFailed(errorMessage: err.defaultMessage));
      } else {
        emit(AttendanceFailed(
          error: err,
          errorMessage:
              "Terjadi kesalahan:\n${(err as UnhandledFailure).exception ?? ''}",
        ));
      }
    }, (data) {
      emit(
        AttendanceSuccess(data),
      );
    });
  }
}
