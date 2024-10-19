part of 'trader_log_bloc.dart';

class TraderLogState extends Equatable {
  const TraderLogState();

  @override
  List<Object> get props => [];
}

class TraderLogInitial extends TraderLogState {}

class TraderLogLoadingProgress extends TraderLogState {}

class TraderLogLoadedSuccess extends TraderLogState {
  final List<Offer> offers;

  const TraderLogLoadedSuccess(this.offers);
}

class TraderLogLoadedFailed extends TraderLogState {
  final String error;

  const TraderLogLoadedFailed(this.error);
}
