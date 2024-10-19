import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:flutter/material.dart';

class BrokerOfferProvider extends ChangeNotifier {
  int? _id;
  int? get id => _id;

  String? _orderStatus;
  String? get orderStatus => _orderStatus;

  String? _offerType;
  String? get offerType => _offerType;

  int? _trader;
  int? get trader => _trader;

  int? _costumeBroker;
  int? get costumeBroker => _costumeBroker;

  CustomeAgency? _costumeagency;
  CustomeAgency? get costumeagency => _costumeagency;

  Costumestate? _costumestate;
  Costumestate? get costumestate => _costumestate;

  List<Product>? _products;
  List<Product>? get products => _products;

  List<Origin>? _origin;
  List<Origin>? get origin => _origin;

  Origin? _source;
  Origin? get source => _source;

  int? _packageType;
  int? get packageType => _packageType;

  int? _packagesNum;
  int? get packagesNum => _packagesNum;

  int? _tabalehNum;
  int? get tabalehNum => _tabalehNum;

  List<bool>? _raw_material;
  List<bool>? get raw_material => _raw_material;

  List<bool>? _industrial;
  List<bool>? get industrial => _industrial;

  List<bool>? _brand;
  List<bool>? get brand => _brand;

  List<bool>? _tubes;
  List<bool>? get tubes => _tubes;

  List<bool>? _colored;
  List<bool>? get colored => _colored;

  List<bool>? _lycra;
  List<bool>? get lycra => _lycra;

  List<int>? _weight;
  List<int>? get weight => _weight;

  List<int>? _price;
  List<int>? get price => _price;

  List<int>? _taxes;
  List<int>? get taxes => _taxes;

  double? _totalweight;
  double? get totalweight => _totalweight;

  double? _totalprice;
  double? get totalprice => _totalprice;

  double? _totaltaxes;
  double? get totaltaxes => _totaltaxes;

  DateTime? _expectedArrivalDate;
  DateTime? get expectedArrivalDate => _expectedArrivalDate;

  List<Attachment>? _attachments;
  List<Attachment>? get attachments => _attachments;

  String? _notes;
  String? get notes => _notes;

  DateTime? _createdDate;
  DateTime? get createdDate => _createdDate;

  List<Costs>? _costs;
  List<Costs>? get costs => _costs;

  List<AttachmentType>? _additional_attachments;
  List<AttachmentType>? get additional_attachments => _additional_attachments;

  TrackOffer? _track_offer;
  TrackOffer? get track_offer => _track_offer;

  initOffer(Offer value) {
    _id = value.id;
    _orderStatus = value.orderStatus;
    _offerType = value.offerType;
    _trader = value.trader;
    _costumeBroker = value.costumeBroker;
    _costumeagency = value.costumeagency;
    _costumestate = value.costumestate;
    _products = value.products;
    _source = value.source;
    _origin = value.origin;
    _packageType = value.packageType;
    _packagesNum = value.packagesNum;
    _tabalehNum = value.tabalehNum;
    _raw_material = value.rawMaterial;
    _industrial = value.industrial;
    _brand = value.brand;
    _tubes = value.tubes;
    _colored = value.colored;
    _lycra = value.lycra;
    _weight = value.weight;
    _price = value.price;
    _taxes = value.taxes;
    _totalweight = value.totalweight!.toDouble();
    _totalprice = value.totalprice!.toDouble();
    _totaltaxes = value.totaltaxes!.toDouble();
    _expectedArrivalDate = value.expectedArrivalDate;
    _attachments = value.attachments;
    _notes = value.notes;
    _createdDate = value.createdDate;
    _costs = value.costs;
    _additional_attachments = value.additional_attachments;
    _track_offer = value.track_offer;
    notifyListeners();
  }

  updateTracking(TrackOffer value) {
    _track_offer = value;
    notifyListeners();
  }
}
