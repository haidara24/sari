part of 'fee_item_bloc.dart';

class FeeItemEvent extends Equatable {
  const FeeItemEvent();

  @override
  List<Object> get props => [];
}

class FeeItemLoadEvent extends FeeItemEvent {
  final String feeId;

  const FeeItemLoadEvent(this.feeId);
}
