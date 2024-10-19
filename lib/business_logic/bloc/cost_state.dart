part of 'cost_bloc.dart';

class CostState extends Equatable {
  const CostState();

  @override
  List<Object> get props => [];
}

class CostInitial extends CostState {}

class CostListLoadingProgress extends CostState {}

class CostListLoadedSuccess extends CostState {
  const CostListLoadedSuccess();
}

class CostLoadedFailed extends CostState {
  final String errortext;

  const CostLoadedFailed(this.errortext);
}
