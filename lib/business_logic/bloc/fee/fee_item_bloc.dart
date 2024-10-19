import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/services/calculator_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fee_item_event.dart';
part 'fee_item_state.dart';

class FeeItemBloc extends Bloc<FeeItemEvent, FeeItemState> {
  FeeItemBloc() : super(FeeItemInitial()) {
    on<FeeItemLoadEvent>((event, emit) async {
      emit(FeeItemLoadingProgress());
      try {
        var fees = await CalculatorService.getpackages(event.feeId);
        emit(FeeItemLoadedSuccess(fees[0]));
        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
