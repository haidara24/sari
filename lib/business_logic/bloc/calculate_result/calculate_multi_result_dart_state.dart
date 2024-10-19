part of 'calculate_multi_result_dart_bloc.dart';

class CalculateMultiResultState extends Equatable {
  const CalculateMultiResultState();

  @override
  List<Object> get props => [];
}

class CalculateMultiResultInitial extends CalculateMultiResultState {}

class CalculateMultiResultLoading extends CalculateMultiResultState {}

class CalculateMultiResultSuccessed extends CalculateMultiResultState {
  final CalculateMultiResult result;

  const CalculateMultiResultSuccessed(this.result);
}

class CalculateMultiResultFailed extends CalculateMultiResultState {
  final String error;

  const CalculateMultiResultFailed(this.error);
}
