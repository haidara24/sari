part of 'offer_bloc.dart';

class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object> get props => [];
}

class OfferInitial extends OfferState {}

class OfferListLoadingProgress extends OfferState {}

class OfferListLoadedSuccess extends OfferState {
  final List<Offer> offers;

  const OfferListLoadedSuccess(this.offers);
}

class OfferLoadingProgress extends OfferState {}

class OfferLoadedSuccess extends OfferState {
  final Offer offer;

  const OfferLoadedSuccess(this.offer);
}

class OfferLoadedFailed extends OfferState {
  final String errortext;

  const OfferLoadedFailed(this.errortext);
}
