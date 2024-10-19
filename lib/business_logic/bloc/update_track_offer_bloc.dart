import 'package:bloc/bloc.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:equatable/equatable.dart';

part 'update_track_offer_event.dart';
part 'update_track_offer_state.dart';

class UpdateTrackOfferBloc
    extends Bloc<UpdateTrackOfferEvent, UpdateTrackOfferState> {
  late StateAgencyRepository stateAgencyRepository;
  UpdateTrackOfferBloc({required this.stateAgencyRepository})
      : super(UpdateTrackOfferInitial()) {
    on<UpdateValuesEvent>((event, emit) async {
      emit(UpdateTrackOfferLoadingProgress());
      try {
        var data = await stateAgencyRepository.updateTracking(
            event.trackOffer, event.message);
        if (data != null) {
          emit(UpdateTrackOfferLoadedSuccess(data));
        } else {
          emit(UpdateTrackOfferLoadedFailed("خطأ"));
        }
      } catch (e) {
        emit(UpdateTrackOfferLoadedFailed(e.toString()));
      }
    });
  }
}
