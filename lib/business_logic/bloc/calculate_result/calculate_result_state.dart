part of 'calculate_result_bloc.dart';

class CalculateResultState extends Equatable {
  const CalculateResultState();

  @override
  List<Object> get props => [];
}

class CalculateResultInitial extends CalculateResultState {}

class CalculateResultLoading extends CalculateResultState {}

class CalculateResultSuccessed extends CalculateResultState {
  final CalculatorResult result;

  const CalculateResultSuccessed(this.result);
}

class CalculateResultFailed extends CalculateResultState {
  final String error;

  const CalculateResultFailed(this.error);
}
