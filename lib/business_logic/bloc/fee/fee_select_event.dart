part of 'fee_select_bloc.dart';

class FeeSelectEvent extends Equatable {
  const FeeSelectEvent();

  @override
  List<Object> get props => [];
}

class FeeSelectLoadEvent extends FeeSelectEvent {
  final String id;

  const FeeSelectLoadEvent({required this.id});
}
