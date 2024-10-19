part of 'fee_trade_description_bloc.dart';

class FeeTradeDescriptionState extends Equatable {
  const FeeTradeDescriptionState();

  @override
  List<Object> get props => [];
}

class FeeTradeDescriptionInitial extends FeeTradeDescriptionState {}

class FeeTradeDescriptionLoadingProgress extends FeeTradeDescriptionState {}

class FeeTradeDescriptionLoadedSuccess extends FeeTradeDescriptionState {
  final TradeDescription tradeDescription;

  const FeeTradeDescriptionLoadedSuccess(this.tradeDescription);
}

class FeeTradeDescriptionLoadedFailed extends FeeTradeDescriptionState {
  final String error;

  const FeeTradeDescriptionLoadedFailed(this.error);
}
