import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state_custome_event.dart';
part 'state_custome_state.dart';

class StateCustomeBloc extends Bloc<StateCustomeEvent, StateCustomeState> {
  late StateAgencyRepository stateAgencyRepository;
  StateCustomeBloc({required this.stateAgencyRepository})
      : super(StateCustomeInitial()) {
    on<StateCustomeLoadEvent>((event, emit) async {
      emit(StateCustomeLoadingProgress());
      try {
        var states = await stateAgencyRepository.getstates();
        emit(StateCustomeLoadedSuccess(states));
        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
