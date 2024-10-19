part of 'fee_item_bloc.dart';

class FeeItemState extends Equatable {
  const FeeItemState();

  @override
  List<Object> get props => [];
}

class FeeItemInitial extends FeeItemState {}

class FeeItemLoadingProgress extends FeeItemState {}

class FeeItemLoadedSuccess extends FeeItemState {
  final Package fee;

  const FeeItemLoadedSuccess(this.fee);
}

class FeeItemLoadedFailed extends FeeItemState {
  final String errortext;

  const FeeItemLoadedFailed(this.errortext);
}
