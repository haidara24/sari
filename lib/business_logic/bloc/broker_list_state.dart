part of 'broker_list_bloc.dart';

class BrokerListState extends Equatable {
  const BrokerListState();

  @override
  List<Object> get props => [];
}

class BrokerListInitial extends BrokerListState {}

class BrokerListLoadingProgress extends BrokerListState {}

class BrokerListSucess extends BrokerListState {
  final List<CostumBroker> brokers;

  const BrokerListSucess(this.brokers);
}
