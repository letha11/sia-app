part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final UserDetail userDetail;

  HomeSuccess({required this.userDetail});

  @override
  List<Object?> get props => [userDetail];
}

final class HomeFailed extends HomeState {
  final String errorMessage;
  final Failure? error;

  HomeFailed({required this.errorMessage, this.error});

  @override
  List<Object?> get props => [];
}
