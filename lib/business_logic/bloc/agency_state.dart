part of 'agency_bloc.dart';

class AgencyState extends Equatable {
  const AgencyState();

  @override
  List<Object> get props => [];
}

class AgencyInitial extends AgencyState {}

class AgencyLoadingProgress extends AgencyState {}

class AgencyLoadedSuccess extends AgencyState {
  final List<CustomeAgency> agencies;

  const AgencyLoadedSuccess(this.agencies);
}

class AgencyLoadedFailed extends AgencyState {
  final String errortext;

  const AgencyLoadedFailed(this.errortext);
}
