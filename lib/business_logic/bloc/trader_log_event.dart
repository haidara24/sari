part of 'trader_log_bloc.dart';

class TraderLogEvent extends Equatable {
  const TraderLogEvent();

  @override
  List<Object> get props => [];
}

class TraderLogLoadEvent extends TraderLogEvent {
  final String state;

  const TraderLogLoadEvent(this.state);
}
