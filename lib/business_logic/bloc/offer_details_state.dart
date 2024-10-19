part of 'offer_details_bloc.dart';

class OfferDetailsState extends Equatable {
  const OfferDetailsState();

  @override
  List<Object> get props => [];
}

class OfferDetailsInitial extends OfferDetailsState {}

class OfferDetailsLoadingProgress extends OfferDetailsState {}

class OfferDetailsLoadedSuccess extends OfferDetailsState {
  final Offer offer;

  OfferDetailsLoadedSuccess(this.offer);
}

class OfferDetailsLoadedFailed extends OfferDetailsState {
  final String error;

  OfferDetailsLoadedFailed(this.error);
}
