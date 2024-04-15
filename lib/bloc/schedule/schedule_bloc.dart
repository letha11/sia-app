import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/connection.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/schedule.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/data/repository/schedule_repository.dart';
import 'package:sia_app/utils/constants.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _scheduleRepository;
  final Connection _connection;
  final LocalDBRepository _localDBRepository;

  ScheduleBloc({
    required ScheduleRepository scheduleRepository,
    required Connection connection,
    required LocalDBRepository localDBRepository,
  })  : _scheduleRepository = scheduleRepository,
        _connection = connection,
        _localDBRepository = localDBRepository,
        super(ScheduleInitial()) {
    on<FetchSchedule>(_onFetchSchedule);
  }

  _onFetchSchedule(FetchSchedule event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());

    final isConnected = await _connection.checkConnection();
    final result = await _getScheduleData(isConnected, event.periode);

    await result.fold(
      (err) async {
        if (err is Unauthorized) {
          emit(
            ScheduleFailed(
              error: err,
              errorMessage: err.defaultMessage,
            ),
          );
        } else if (err is NoDataFailure) {
          emit(
            ScheduleFailed(error: err, errorMessage: err.defaultMessage),
          );
        } else if (err is TimeoutFailure) {
          try {
            final schedule = await _getScheduleLocal();

            if (schedule != null) {
              emit(ScheduleSuccess(schedule: schedule));
            } else {
              emit(
                ScheduleFailed(
                  error: err,
                  errorMessage: "Periksa kembali koneksi anda dan coba lagi",
                ),
              );
            }
          } catch (e, stackTrace) {
            emit(
              ScheduleFailed(
                error: err,
                errorMessage: "Terjadi kesalahan:\n$stackTrace",
              ),
            );
          }
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
        _localDBRepository.store(HiveKey.scheduleJson, data.toJson());
        emit(
          ScheduleSuccess(
            schedule: data,
          ),
        );
      },
    );
  }

  Future<Schedule?> _getScheduleLocal() async {
    final storedSchedule = await _localDBRepository.get(HiveKey.scheduleJson);

    return storedSchedule != null ? Schedule.fromJson(storedSchedule) : null;
  }

  Future<Either<Failure, Schedule>> _getScheduleData(
      bool isConnected, String? periode) async {
    if (isConnected) {
      return _scheduleRepository.getSchedule(periode: periode);
    } else {
      try {
        final localSchedule = await _getScheduleLocal();
        return localSchedule != null
            ? Right(localSchedule)
            : Left(NoDataFailure());
      } catch (e) {
        return Left(UnhandledFailure(e));
      }
    }
  }
}
