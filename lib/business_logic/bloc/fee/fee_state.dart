part of 'fee_bloc.dart';

abstract class FeeState extends Equatable {
  const FeeState();

  @override
  List<Object> get props => [];
}

class FeeInitial extends FeeState {}

class FeeLoadingProgress extends FeeState {}

class FeeLoadedSuccess extends FeeState {
  final List<FeeSet> fees;

  const FeeLoadedSuccess(this.fees);
}

class FeeLoadedFailed extends FeeState {
  final String errortext;

  const FeeLoadedFailed(this.errortext);
}
