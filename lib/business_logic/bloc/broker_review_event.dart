part of 'broker_review_bloc.dart';

class BrokerReviewEvent extends Equatable {
  const BrokerReviewEvent();

  @override
  List<Object> get props => [];
}

class BrokerReviewLoadEvent extends BrokerReviewEvent {
  final int brokerId;

  BrokerReviewLoadEvent(this.brokerId);
}
