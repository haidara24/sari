part of 'cost_bloc.dart';

class CostEvent extends Equatable {
  const CostEvent();

  @override
  List<Object> get props => [];
}

class CostSubmitEvent extends CostEvent {
  final List<Cost> costs;

  const CostSubmitEvent(this.costs);
}
