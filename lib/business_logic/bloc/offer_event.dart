part of 'offer_bloc.dart';

class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class OfferInit extends OfferEvent {}

class OfferLoadEvent extends OfferEvent {}

class OfferStatusUpdateEvent extends OfferEvent {
  final int offerId;
  final String state;

  const OfferStatusUpdateEvent(this.offerId, this.state);
}

// class AddAdditionalAttachmentEvent extends OfferEvent {
//   final List<int> additionalList;
//   final List<int> attachments;
//   final int offerId;

//   AddAdditionalAttachmentEvent(
//       this.attachments, this.additionalList, this.offerId);
// }

class AddOfferEvent extends OfferEvent {
  final String offerType;
  final int broker;
  final int packageNum;
  final int tabalehNum;
  final List<int> weight;
  final List<String> price;
  final List<String> taxes;
  final int totalweight;
  final String totalprice;
  final String totaltaxes;
  final List<bool> rawmaterial;
  final List<bool> industrial;
  final List<bool> brands;
  final List<bool> tubes;
  final List<bool> colored;
  final List<bool> lycra;
  final int costumeAgency;
  final int costumeState;
  final int packageType;
  final String expectedDate;
  final String notes;
  final package.Origin source;
  final List<int> origin;
  final List<String> products;
  final List<int> attachments;

  AddOfferEvent(
      this.offerType,
      this.broker,
      this.packageNum,
      this.tabalehNum,
      this.weight,
      this.price,
      this.taxes,
      this.totalweight,
      this.totalprice,
      this.totaltaxes,
      this.rawmaterial,
      this.industrial,
      this.brands,
      this.tubes,
      this.colored,
      this.lycra,
      this.costumeAgency,
      this.costumeState,
      this.packageType,
      this.expectedDate,
      this.notes,
      this.source,
      this.origin,
      this.products,
      this.attachments);
}
