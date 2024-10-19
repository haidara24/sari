part of 'flag_select_bloc.dart';

class FlagSelectState extends Equatable {
  const FlagSelectState();

  @override
  List<Object> get props => [];
}

class FlagSelectInitial extends FlagSelectState {}

class FlagSelectLoadingProgress extends FlagSelectState {}

class FlagSelectSuccess extends FlagSelectState {
  final Origin origin;

  const FlagSelectSuccess({required this.origin});
}

class FlagSelectFailed extends FlagSelectState {
  final String error;

  const FlagSelectFailed({required this.error});
}
