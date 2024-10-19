part of 'fee_add_loading_bloc.dart';

class FeeAddLoadingEvent extends Equatable {
  const FeeAddLoadingEvent();

  @override
  List<Object> get props => [];
}

class FeeLoadingProgressEvent extends FeeAddLoadingEvent {}

class FeeIdleProgressEvent extends FeeAddLoadingEvent {}
