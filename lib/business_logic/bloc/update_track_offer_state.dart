part of 'update_track_offer_bloc.dart';

class UpdateTrackOfferState extends Equatable {
  const UpdateTrackOfferState();

  @override
  List<Object> get props => [];
}

class UpdateTrackOfferInitial extends UpdateTrackOfferState {}

class UpdateTrackOfferLoadingProgress extends UpdateTrackOfferState {}

class UpdateTrackOfferLoadedSuccess extends UpdateTrackOfferState {
  final TrackOffer trackOffer;

  UpdateTrackOfferLoadedSuccess(this.trackOffer);
}

class UpdateTrackOfferLoadedFailed extends UpdateTrackOfferState {
  final String error;

  UpdateTrackOfferLoadedFailed(this.error);
}
