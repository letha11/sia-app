part of 'transcript_bloc.dart';

sealed class TranscriptState extends Equatable {
  const TranscriptState();

  @override
  List<Object> get props => [];
}

final class TranscriptInitial extends TranscriptState {}

final class TranscriptLoading extends TranscriptState {}

final class TranscriptSuccess extends TranscriptState {
  final Transcript data;

  const TranscriptSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class TranscriptFailed extends TranscriptState {
  final String errorMessage;
  final Object? error;

  const TranscriptFailed({required this.errorMessage, this.error});
}
