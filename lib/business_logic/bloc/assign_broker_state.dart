part of 'assign_broker_bloc.dart';

class AssignBrokerState extends Equatable {
  const AssignBrokerState();

  @override
  List<Object> get props => [];
}

class AssignBrokerInitial extends AssignBrokerState {}

class AssignBrokerLoadingProgress extends AssignBrokerState {}

class AssignBrokerSuccess extends AssignBrokerState {}

class AssignBrokerFailed extends AssignBrokerState {
  final String error;

  AssignBrokerFailed(this.error);
}
