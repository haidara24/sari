import 'package:bloc/bloc.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';

part 'assign_broker_event.dart';
part 'assign_broker_state.dart';

class AssignBrokerBloc extends Bloc<AssignBrokerEvent, AssignBrokerState> {
  late StateAgencyRepository stateAgencyRepository;
  AssignBrokerBloc({required this.stateAgencyRepository})
      : super(AssignBrokerInitial()) {
    on<AssignBrokerToOfferEvent>((event, emit) async {
      emit(AssignBrokerLoadingProgress());
      try {
        var result = await stateAgencyRepository.assignBrokerToOffer(
            event.offerId, event.brokerId);
        if (result) {
          emit(AssignBrokerSuccess());
        } else {
          emit(AssignBrokerFailed("error"));
        }
      } catch (e) {
        emit(AssignBrokerFailed(e.toString()));
      }
    });
  }
}
