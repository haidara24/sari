import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'agency_event.dart';
part 'agency_state.dart';

class AgencyBloc extends Bloc<AgencyEvent, AgencyState> {
  late StateAgencyRepository stateAgencyRepository;
  AgencyBloc({required this.stateAgencyRepository}) : super(AgencyInitial()) {
    on<AgenciesLoadEvent>((event, emit) async {
      emit(AgencyLoadingProgress());
      try {
        var agencies = await stateAgencyRepository.getagencies(event.stateId);
        emit(AgencyLoadedSuccess(agencies));
        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
