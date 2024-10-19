part of 'assign_broker_bloc.dart';

class AssignBrokerEvent extends Equatable {
  const AssignBrokerEvent();

  @override
  List<Object> get props => [];
}

class AssignBrokerToOfferEvent extends AssignBrokerEvent {
  final int offerId;
  final int brokerId;

  AssignBrokerToOfferEvent(this.offerId, this.brokerId);
}
