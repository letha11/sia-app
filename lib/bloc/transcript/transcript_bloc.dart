import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sia_app/core/connection.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/transcript.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/data/repository/transcript_repository.dart';
import 'package:sia_app/utils/constants.dart';

part 'transcript_event.dart';
part 'transcript_state.dart';

class TranscriptBloc extends Bloc<TranscriptEvent, TranscriptState> {
  final TranscriptRepository _transcriptRepository;
  final LocalDBRepository _localDBRepository;
  final Connection _connection;

  TranscriptBloc({
    required TranscriptRepository transcriptRepository,
    required LocalDBRepository localDBRepository,
    required Connection connection,
  })  : _transcriptRepository = transcriptRepository,
        _localDBRepository = localDBRepository,
        _connection = connection,
        super(TranscriptInitial()) {
    on<FetchTranscript>(_onFetchTranscript);
  }

  _onFetchTranscript(
      FetchTranscript event, Emitter<TranscriptState> emit) async {
    emit(TranscriptLoading());

    bool isConnected = await _connection.checkConnection();
    final result = await _getTranscriptData(isConnected);

    await result.fold(
      (err) async {
        if (err is ReloginFailure) {
          emit(
            TranscriptFailed(
              error: err,
              errorMessage: "Silahkan masukkan captcha untuk login ulang",
            ),
          );
        } else if (err is NoDataFailure) {
          emit(TranscriptFailed(errorMessage: err.defaultMessage));
        } else if (err is Unauthorized) {
          emit(TranscriptFailed(errorMessage: err.defaultMessage));
        } else if (err is TimeoutFailure) {
          try {
            final attendance = await _fetchTranscriptFromLocal();

            if (attendance != null) {
              emit(TranscriptSuccess(attendance));
            } else {
              emit(const TranscriptFailed(
                  errorMessage:
                      "Website host sedang tidak aktif, mohon coba lagi beberapa saat"));
            }
          } catch (e, stackTrace) {
            emit(TranscriptFailed(
              error: err,
              errorMessage: "Terjadi kesalahan:\n$stackTrace",
            ));
          }
        } else {
          emit(
            TranscriptFailed(
              error: err,
              errorMessage:
                  "Terjadi kesalahan:\n${(err as UnhandledFailure).exception ?? ''}",
            ),
          );
        }
      },
      (data) {
        _localDBRepository.store(HiveKey.transcriptJson, data.toJson());
        emit(
          TranscriptSuccess(data),
        );
      },
    );
  }

  Future<Transcript?> _fetchTranscriptFromLocal() async {
    final localTranscript =
        await _localDBRepository.get(HiveKey.transcriptJson);

    return localTranscript != null
        ? Transcript.fromJson(localTranscript)
        : null;
  }

  Future<Either<Failure, Transcript>> _getTranscriptData(
      bool isConnected) async {
    if (isConnected) {
      final result = await _transcriptRepository.getTranscript();

      return result;
    } else {
      try {
        final localTranscript = await _fetchTranscriptFromLocal();

        return localTranscript != null
            ? Right(localTranscript)
            : Left(NoDataFailure());
      } catch (e) {
        return Left(UnhandledFailure(e));
      }
    }
  }
}
