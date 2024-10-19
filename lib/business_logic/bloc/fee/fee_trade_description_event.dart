part of 'fee_trade_description_bloc.dart';

class FeeTradeDescriptionEvent extends Equatable {
  const FeeTradeDescriptionEvent();

  @override
  List<Object> get props => [];
}

class FeeTradeDescriptionLoadEvent extends FeeTradeDescriptionEvent {
  final String feeId;

  const FeeTradeDescriptionLoadEvent(this.feeId);
}
