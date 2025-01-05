part of 'transcript_bloc.dart';

sealed class TranscriptEvent extends Equatable {
  const TranscriptEvent();

  @override
  List<Object> get props => [];
}

final class FetchTranscript extends TranscriptEvent {}
