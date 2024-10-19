import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'trader_log_event.dart';
part 'trader_log_state.dart';

class TraderLogBloc extends Bloc<TraderLogEvent, TraderLogState> {
  late StateAgencyRepository stateAgencyRepository;
  TraderLogBloc({required this.stateAgencyRepository})
      : super(TraderLogInitial()) {
    on<TraderLogLoadEvent>((event, emit) async {
      emit(TraderLogLoadingProgress());
      try {
        var result =
            await stateAgencyRepository.getTraderLogOffers(event.state);
        emit(TraderLogLoadedSuccess(result));
      } catch (e) {
        emit(TraderLogLoadedFailed(e.toString()));
      }
    });
  }
}
