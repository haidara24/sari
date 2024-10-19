import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'step_order_event.dart';
part 'step_order_state.dart';

class StepOrderBloc extends Bloc<StepOrderEvent, StepOrderState> {
  StepOrderBloc() : super(StepOrderInitial()) {
    on<LoadSecondStep>((event, emit) {
      emit(StepOrderLoadingProgress());
      emit(SecondStepOrderState(
          event.customAgency,
          event.customeState,
          event.offerType,
          event.packagesNum,
          event.tabalehNum,
          event.weight,
          event.price,
          event.taxes,
          event.product,
          event.origin,
          event.packageType,
          event.rawMaterial,
          event.industrial));
    });
  }
}
