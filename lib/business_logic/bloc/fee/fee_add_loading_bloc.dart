import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fee_add_loading_event.dart';
part 'fee_add_loading_state.dart';

class FeeAddLoadingBloc extends Bloc<FeeAddLoadingEvent, FeeAddLoadingState> {
  FeeAddLoadingBloc() : super(FeeAddLoadingInitial()) {
    on<FeeLoadingProgressEvent>((event, emit) {
      emit(FeeAddLoadingProgressState());
    });

    on<FeeIdleProgressEvent>((event, emit) {
      emit(FeeAddLoadingInitial());
    });
  }
}
