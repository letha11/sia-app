import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/connection.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/attendance.dart';
import 'package:sia_app/data/repository/attendance_repository.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/utils/constants.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository _attendanceRepository;
  final LocalDBRepository _localDBRepository;
  final Connection _connection;

  AttendanceBloc({
    required AttendanceRepository attendanceRepository,
    required LocalDBRepository localDBRepository,
    required Connection connection,
  })  : _attendanceRepository = attendanceRepository,
        _localDBRepository = localDBRepository,
        _connection = connection,
        super(AttendanceInitial()) {
    on<FetchAttendance>(_onFetchAttendance);
  }

  _onFetchAttendance(
      FetchAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());

    bool isConnected = await _connection.checkConnection();
    final result = await _getAttendanceData(isConnected);

    await result.fold((err) async {
      if (err is NoDataFailure) {
        emit(AttendanceFailed(errorMessage: err.defaultMessage));
      } else if (err is Unauthorized) {
        emit(AttendanceFailed(errorMessage: err.defaultMessage));
      } else if (err is TimeoutFailure) {
        try {
          final attendance = await _fetchAttendanceFromLocal();

          if (attendance != null) {
            emit(AttendanceSuccess(attendance));
          } else {
            emit(const AttendanceFailed(
                errorMessage:
                    "Website host sedang tidak aktif, mohon coba lagi beberapa saat"));
          }
        } catch (e, stackTrace) {
          emit(AttendanceFailed(
            error: err,
            errorMessage:
                "Terjadi kesalahan:\n$stackTrace",
          ));
        }
      } else {
        emit(AttendanceFailed(
          error: err,
          errorMessage:
              "Terjadi kesalahan:\n${(err as UnhandledFailure).exception ?? ''}",
        ));
      }
    }, (data) {
      _localDBRepository.store(HiveKey.attendanceJson, data.toJson());
      emit(
        AttendanceSuccess(data),
      );
    });
  }

  Future<Attendance?> _fetchAttendanceFromLocal() async {
    final storedAttendanceJson =
        await _localDBRepository.get(HiveKey.attendanceJson);

    return storedAttendanceJson != null
        ? Attendance.fromJson(storedAttendanceJson)
        : null;
  }

  Future<Either<Failure, Attendance>> _getAttendanceData(
      bool isConnected) async {
    if (isConnected) {
      return _attendanceRepository.getAttendance();
    } else {
      try {
        final localAttendance = await _fetchAttendanceFromLocal();
        return localAttendance != null
            ? Right(localAttendance)
            : Left(NoDataFailure());
      } catch (e) {
        return Left(UnhandledFailure(e));
      }
    }
  }
}
