part of 'offer_details_bloc.dart';

class OfferDetailsEvent extends Equatable {
  const OfferDetailsEvent();

  @override
  List<Object> get props => [];
}

class OfferDetailsLoadEvent extends OfferDetailsEvent {
  final int id;

  OfferDetailsLoadEvent(this.id);
}
