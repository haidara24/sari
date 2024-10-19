import 'package:bloc/bloc.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/services/calculator_service.dart';
import 'package:equatable/equatable.dart';

part 'fee_select_event.dart';
part 'fee_select_state.dart';

class FeeSelectBloc extends Bloc<FeeSelectEvent, FeeSelectState> {
  FeeSelectBloc() : super(FeeSelectInitial()) {
    on<FeeSelectLoadEvent>((event, emit) async {
      emit(FeeSelectLoadingProgress());

      try {
        var package = await CalculatorService.getProductInfo(event.id);
        emit(FeeSelectSuccess(package: package));
      } catch (e) {
        emit(FeeSelectFailed(error: e.toString()));
      }
    });
  }
}
