part of 'fee_select_bloc.dart';

class FeeSelectState extends Equatable {
  const FeeSelectState();

  @override
  List<Object> get props => [];
}

class FeeSelectInitial extends FeeSelectState {}

class FeeSelectLoadingProgress extends FeeSelectState {}

class FeeSelectSuccess extends FeeSelectState {
  final Package package;

  const FeeSelectSuccess({required this.package});
}

class FeeSelectFailed extends FeeSelectState {
  final String error;

  const FeeSelectFailed({required this.error});
}
