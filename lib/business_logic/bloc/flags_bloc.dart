import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/services/calculator_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'flags_event.dart';
part 'flags_state.dart';

class FlagsBloc extends Bloc<FlagsEvent, FlagsState> {
  FlagsBloc() : super(FlagsInitial()) {
    on<FlagsLoadEvent>((event, emit) async {
      emit(FlagsLoadingProgressState());
      try {
        var origins = await CalculatorService.getAllorigins();
        if (origins.isNotEmpty) {
          emit(FlagsLoadedSuccess(origins));
        } else {
          emit(const FlagsLoadedFailed('حدث خطأ ما حاول مرة أخرى'));
        }
      } catch (e) {
        emit(FlagsLoadedFailed(e.toString()));
      }
    });
  }
}
