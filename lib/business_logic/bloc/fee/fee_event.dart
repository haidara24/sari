part of 'fee_bloc.dart';

abstract class FeeEvent extends Equatable {
  const FeeEvent();

  @override
  List<Object> get props => [];
}

class FeeLoadEvent extends FeeEvent {
  final String subchapterId;

  const FeeLoadEvent(this.subchapterId);
}
