part of 'agency_bloc.dart';

class AgencyEvent extends Equatable {
  const AgencyEvent();

  @override
  List<Object> get props => [];
}

class AgenciesLoadEvent extends AgencyEvent {
  final int stateId;

  const AgenciesLoadEvent(this.stateId);
}
