import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculate_result_event.dart';
part 'calculate_result_state.dart';

class CalculateResultBloc
    extends Bloc<CalculateResultEvent, CalculateResultState> {
  late StateAgencyRepository stateAgencyRepository;
  CalculateResultBloc({required this.stateAgencyRepository})
      : super(CalculateResultInitial()) {
    on<CalculateTheResultEvent>((event, emit) async {
      emit(CalculateResultLoading());
      try {
        var result =
            await stateAgencyRepository.getCalculatorResult(event.object);
        emit(CalculateResultSuccessed(result));
      } catch (e) {
        emit(CalculateResultFailed(e.toString()));
      }
    });
  }
}
