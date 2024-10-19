import 'package:bloc/bloc.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';

part 'calculate_multi_result_dart_event.dart';
part 'calculate_multi_result_dart_state.dart';

class CalculateMultiResultBloc
    extends Bloc<CalculateMultiResultEvent, CalculateMultiResultState> {
  late StateAgencyRepository stateAgencyRepository;
  CalculateMultiResultBloc({required this.stateAgencyRepository})
      : super(CalculateMultiResultInitial()) {
    on<CalculateMultiTheResultEvent>((event, emit) async {
      emit(CalculateMultiResultLoading());
      try {
        var result =
            await stateAgencyRepository.getCalculatorMultiResult(event.object);
        emit(CalculateMultiResultSuccessed(result));
      } catch (e) {
        emit(CalculateMultiResultFailed(e.toString()));
      }
    });
  }
}
