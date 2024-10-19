part of 'update_track_offer_bloc.dart';

class UpdateTrackOfferEvent extends Equatable {
  const UpdateTrackOfferEvent();

  @override
  List<Object> get props => [];
}

class UpdateValuesEvent extends UpdateTrackOfferEvent {
  final TrackOffer trackOffer;
  final String message;

  UpdateValuesEvent(this.trackOffer, this.message);
}
