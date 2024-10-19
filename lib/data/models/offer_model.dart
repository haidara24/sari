// ignore_for_file: non_constant_identifier_names

import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'dart:convert';

class Offer {
  int? id;
  String? orderStatus;
  String? offerType;
  int? trader;
  int? costumeBroker;
  CustomeAgency? costumeagency;
  Costumestate? costumestate;
  List<Product>? products;
  List<Origin>? origin;
  Origin? source;
  int? packageType;
  int? packagesNum;
  int? tabalehNum;
  List<bool>? rawMaterial;
  List<bool>? industrial;
  List<bool>? brand;
  List<bool>? tubes;
  List<bool>? colored;
  List<bool>? lycra;
  List<int>? weight;
  List<int>? price;
  List<int>? taxes;
  double? totalweight;
  double? totalprice;
  double? totaltaxes;
  DateTime? expectedArrivalDate;
  List<Attachment>? attachments;
  String? notes;
  DateTime? createdDate;
  List<Costs>? costs;
  List<AttachmentType>? additional_attachments;
  TrackOffer? track_offer;

  Offer({
    this.id,
    this.orderStatus,
    this.offerType,
    this.trader,
    this.costumeBroker,
    this.costumeagency,
    this.costumestate,
    this.products,
    this.source,
    this.origin,
    this.packageType,
    this.packagesNum,
    this.tabalehNum,
    this.rawMaterial,
    this.industrial,
    this.brand,
    this.tubes,
    this.colored,
    this.lycra,
    this.weight,
    this.price,
    this.taxes,
    this.totalweight,
    this.totalprice,
    this.totaltaxes,
    this.expectedArrivalDate,
    this.attachments,
    this.notes,
    this.createdDate,
    this.costs,
    this.additional_attachments,
    this.track_offer,
  });

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderStatus = json['order_status'];
    offerType = json['offer_type'];
    trader = json['trader'];
    source = json['source'] != null ? Origin.fromJson(json['source']) : null;
    costumeBroker = json['costume_broker'] ?? 0;
    costumeagency = json['costumeagency'] != null
        ? CustomeAgency.fromJson(json['costumeagency'])
        : null;
    costumestate = json['costumestate'] != null
        ? Costumestate.fromJson(json['costumestate'])
        : null;
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    } else {
      json['products'] = [];
    }
    if (json['origin'] != null) {
      origin = <Origin>[];
      json['origin'].forEach((v) {
        origin!.add(Origin.fromJson(v));
      });
    } else {
      json['origin'] = [];
    }

    track_offer = json['track_offer'] != null
        ? TrackOffer.fromJson(json['track_offer'])
        : null;
    packageType = json['package_type'];
    packagesNum = json['packages_num'];
    tabalehNum = json['tabaleh_num'] ?? 0;
    rawMaterial = jsonDecode(json['raw_material']).cast<bool>();
    industrial = jsonDecode(json['industrial']).cast<bool>();
    brand = jsonDecode(json['brand']).cast<bool>();
    tubes = jsonDecode(json['tubes']).cast<bool>();
    colored = jsonDecode(json['colored']).cast<bool>();
    lycra = jsonDecode(json['lycra']).cast<bool>();
    weight = jsonDecode(json['weight']).cast<int>();
    price = jsonDecode(json['price']).cast<int>();
    taxes = jsonDecode(json['taxes']).cast<int>();
    totalweight = json['totalweight'];
    totalprice = json['totalprice'];
    totaltaxes = json['totaltaxes'];
    expectedArrivalDate = DateTime.parse(json['expected_arrival_date']);
    if (json['attachments'] != null) {
      attachments = <Attachment>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachment.fromJson(v));
      });
    } else {
      json['attachments'] = [];
    }

    notes = json['notes'];
    createdDate = DateTime.parse(json['created_date']);
    if (json['costs'] != null) {
      costs = <Costs>[];
      json['costs'].forEach((v) {
        costs!.add(Costs.fromJson(v));
      });
    } else {
      json['costs'] = [];
    }

    if (json['aditional_attachments'] != null) {
      additional_attachments = <AttachmentType>[];
      json['aditional_attachments'].forEach((v) {
        additional_attachments!.add(AttachmentType.fromJson(v));
      });
    } else {
      json['aditional_attachments'] = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_status'] = orderStatus;
    data['offer_type'] = offerType;
    data['trader'] = trader;
    data['costume_broker'] = costumeBroker;
    if (costumeagency != null) {
      data['costumeagency'] = costumeagency!.toJson();
    }
    if (costumestate != null) {
      data['costumestate'] = costumestate!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (this.origin != null) {
      data['origin'] = this.origin!.map((v) => v.toJson()).toList();
    }
    data['package_type'] = packageType;
    data['packages_num'] = packagesNum;
    data['tabaleh_num'] = tabalehNum;
    data['weight'] = weight;
    data['price'] = price;
    data['taxes'] = taxes;
    data['expected_arrival_date'] = expectedArrivalDate;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['notes'] = notes;
    data['created_date'] = createdDate;
    if (costs != null) {
      data['costs'] = costs!.map((v) => v.toJson()).toList();
    }
    if (additional_attachments != null) {
      data['aditional_attachments'] =
          additional_attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Costumeagency {
  int? id;
  String? name;
  int? statecustome;

  Costumeagency({this.id, this.name, this.statecustome});

  Costumeagency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    statecustome = json['statecustome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['statecustome'] = statecustome;
    return data;
  }
}

class Costumestate {
  int? id;
  String? name;

  Costumestate({this.id, this.name});

  Costumestate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Product {
  String? id;
  TotalTaxes? totalTaxes;
  Dolar? dolar;
  List<Extras>? extras;
  String? label;
  String? labelen;
  String? export1;
  double? fee;
  double? spendingFee;
  double? supportFee;
  double? protectionFee;
  double? naturalFee;
  double? taxFee;
  double? localFee;
  double? gold;
  double? paper;
  double? brid;
  double? price;
  String? unit;
  double? importFee;
  String? placeholder;
  String? decision;
  // List<Null>? feesGroup;

  Product({
    this.id,
    this.label,
    this.labelen,
    this.export1,
    this.fee,
    this.spendingFee,
    this.supportFee,
    this.protectionFee,
    this.naturalFee,
    this.taxFee,
    this.localFee,
    this.gold,
    this.paper,
    this.brid,
    this.price,
    this.unit,
    this.importFee,
    this.placeholder,
    this.decision,
    this.dolar,
    this.totalTaxes,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    labelen = json['label_en'];
    export1 = json['export1'];
    fee = json['fee'];
    spendingFee = json['spending_fee'];
    supportFee = json['support_fee'];
    protectionFee = json['protection_fee'];
    naturalFee = json['natural_fee'];
    taxFee = json['tax_fee'];
    localFee = json['local_fee'];
    gold = json['gold'];
    paper = json['paper'];
    brid = json['brid'];
    price = json['price'];
    unit = json['unit'];
    importFee = json['Import_fee'];
    placeholder = json['placeholder'];
    decision = json['decision'];
    totalTaxes = json['total_taxes'] != null
        ? TotalTaxes.fromJson(json['total_taxes'])
        : null;
    dolar = json['dolar'] != null ? Dolar.fromJson(json['dolar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['label_en'] = this.labelen;
    data['export1'] = this.export1;
    data['fee'] = this.fee;
    data['spending_fee'] = this.spendingFee;
    data['support_fee'] = this.supportFee;
    data['protection_fee'] = this.protectionFee;
    data['natural_fee'] = this.naturalFee;
    data['tax_fee'] = this.taxFee;
    data['local_fee'] = this.localFee;
    data['gold'] = this.gold;
    data['paper'] = this.paper;
    data['brid'] = this.brid;
    data['price'] = this.price;
    data['unit'] = this.unit;
    data['Import_fee'] = this.importFee;
    data['placeholder'] = this.placeholder;
    data['decision'] = this.decision;
    if (this.totalTaxes != null) {
      data['total_taxes'] = this.totalTaxes!.toJson();
    }
    if (this.dolar != null) {
      data['dolar'] = this.dolar!.toJson();
    }
    return data;
  }
}

class Extras {
  int? id;
  String? label;
  double? price;
  bool? lycra;
  bool? coloredThread;
  bool? brand;
  bool? tubes;
  String? fees;
  List<Origin>? origin;
  // List<Null>? countryGroups;

  Extras({
    this.id,
    this.label,
    this.price,
    this.lycra,
    this.coloredThread,
    this.brand,
    this.tubes,
    this.fees,
    this.origin,
  });

  Extras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    price = json['price'];
    lycra = json['lycra'];
    coloredThread = json['colored_thread'];
    brand = json['Brand'];
    tubes = json['tubes'];
    fees = json['fees'];
    if (json['origin'] != null) {
      origin = <Origin>[];
      json['origin'].forEach((v) {
        origin!.add(Origin.fromJson(v));
      });
    }
    // if (json['countryGroups'] != null) {
    //   countryGroups = <Null>[];
    //   json['countryGroups'].forEach((v) {
    //     countryGroups!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['price'] = this.price;
    data['lycra'] = this.lycra;
    data['colored_thread'] = this.coloredThread;
    data['Brand'] = this.brand;
    data['tubes'] = this.tubes;
    data['fees'] = this.fees;
    if (this.origin != null) {
      data['origin'] = this.origin!.map((v) => v.toJson()).toList();
    }
    // if (this.countryGroups != null) {
    //   data['countryGroups'] =
    //       this.countryGroups!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class TotalTaxes {
  double? totalTax;
  double? partialTax;
  double? arabicStamp;

  TotalTaxes({this.totalTax, this.partialTax, this.arabicStamp});

  TotalTaxes.fromJson(Map<String, dynamic> json) {
    totalTax = json['total_tax'];
    partialTax = json['partial_tax'];
    arabicStamp = json['arabic_stamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_tax'] = this.totalTax;
    data['partial_tax'] = this.partialTax;
    data['arabic_stamp'] = this.arabicStamp;
    return data;
  }
}

class Dolar {
  double? price;

  Dolar({this.price});

  Dolar.fromJson(Map<String, dynamic> json) {
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['price'] = this.price;
    return data;
  }
}

class Origin {
  int? id;
  String? label;

  Origin({this.id, this.label});

  Origin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    return data;
  }
}

class Costs {
  int? id;
  String? description;
  double? amount;

  Costs({this.id, this.description, this.amount});

  Costs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['amount'] = amount;
    return data;
  }
}

class OfferResult {
  int? id;
  String? orderStatus;
  String? offerType;
  int? trader;
  int? costumeBroker;
  int? costumeagency;
  int? costumestate;
  String? product;
  int? origin;
  int? packageType;
  int? packagesNum;
  int? tabalehNum;
  int? rawMaterial;
  int? industrial;
  int? weight;
  int? price;
  int? taxes;
  String? expectedArrivalDate;
  List<int>? attachments;
  String? notes;
  String? createdDate;

  OfferResult(
      {this.id,
      this.orderStatus,
      this.offerType,
      this.trader,
      this.costumeBroker,
      this.costumeagency,
      this.costumestate,
      this.product,
      this.origin,
      this.packageType,
      this.packagesNum,
      this.tabalehNum,
      this.rawMaterial,
      this.industrial,
      this.weight,
      this.price,
      this.taxes,
      this.expectedArrivalDate,
      this.attachments,
      this.notes,
      this.createdDate});

  OfferResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderStatus = json['order_status'];
    offerType = json['offer_type'];
    trader = json['trader'];
    costumeBroker = json['costume_broker'];
    costumeagency = json['costumeagency'];
    costumestate = json['costumestate'];
    product = json['product'];
    origin = json['origin'];
    packageType = json['package_type'];
    packagesNum = json['packages_num'];
    tabalehNum = json['tabaleh_num'];
    rawMaterial = json['raw_material'];
    industrial = json['industrial'];
    weight = json['weight'];
    price = json['price'];
    taxes = json['taxes'];
    expectedArrivalDate = json['expected_arrival_date'];
    if (json['attachments'] != null) {
      attachments = <int>[];
      json['attachments'].forEach((v) {
        attachments!.add(v);
      });
    }
    notes = json['notes'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_status'] = orderStatus;
    data['offer_type'] = offerType;
    data['trader'] = trader;
    data['costume_broker'] = costumeBroker;
    data['costumeagency'] = costumeagency;
    data['costumestate'] = costumestate;
    data['product'] = product;
    data['origin'] = origin;
    data['package_type'] = packageType;
    data['packages_num'] = packagesNum;
    data['tabaleh_num'] = tabalehNum;
    data['raw_material'] = rawMaterial;
    data['industrial'] = industrial;
    data['weight'] = weight;
    data['price'] = price;
    data['taxes'] = taxes;
    data['expected_arrival_date'] = expectedArrivalDate;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v).toList();
    }
    data['notes'] = notes;
    data['created_date'] = createdDate;
    return data;
  }
}

class TrackOffer {
  int? id;
  bool? attachmentRecivment;
  bool? unloadDistenation;
  bool? deliveryPermit;
  bool? customeDeclration;
  bool? previewGoods;
  bool? payFeesTaxes;
  bool? issuingExitPermit;
  bool? loadDistenation;
  String? message;

  TrackOffer({
    this.id,
    this.attachmentRecivment,
    this.unloadDistenation,
    this.deliveryPermit,
    this.customeDeclration,
    this.previewGoods,
    this.payFeesTaxes,
    this.issuingExitPermit,
    this.loadDistenation,
    this.message,
  });

  TrackOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attachmentRecivment = json['attachment_recivment'];
    unloadDistenation = json['unload_distenation'];
    deliveryPermit = json['delivery_permit'];
    customeDeclration = json['custome_declration'];
    previewGoods = json['preview_goods'];
    payFeesTaxes = json['pay_fees_taxes'];
    issuingExitPermit = json['Issuing_exit_permit'];
    loadDistenation = json['load_distenation'];
    message = json['message'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['attachment_recivment'] = this.attachmentRecivment;
    data['unload_distenation'] = this.unloadDistenation;
    data['delivery_permit'] = this.deliveryPermit;
    data['custome_declration'] = this.customeDeclration;
    data['preview_goods'] = this.previewGoods;
    data['pay_fees_taxes'] = this.payFeesTaxes;
    data['Issuing_exit_permit'] = this.issuingExitPermit;
    data['load_distenation'] = this.loadDistenation;
    return data;
  }
}
