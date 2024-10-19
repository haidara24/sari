part of 'flag_select_bloc.dart';

class FlagSelectEvent extends Equatable {
  const FlagSelectEvent();

  @override
  List<Object> get props => [];
}

class FlagSelectLoadEvent extends FlagSelectEvent {
  final Origin origin;

  const FlagSelectLoadEvent({required this.origin});
}
