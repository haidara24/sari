class Cost {
  int? id;
  String? description;
  double? amount;
  int? offerId;

  Cost({this.id, this.description, this.amount, this.offerId});

  Cost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    amount = json['amount'];
    offerId = json['offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['amount'] = amount;
    data['offer'] = offerId;
    return data;
  }
}

class CustomeAgency {
  int? id;
  String? name;
  String? nameAr;
  StateCustome? statecustome;
  String? shippingType;
  CustomeAgency(
      {this.id, this.name, this.nameAr, this.statecustome, this.shippingType});

  CustomeAgency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    shippingType = json['shipping_type'];
    statecustome = json['statecustome'] != null
        ? new StateCustome.fromJson(json['statecustome'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['shipping_type'] = shippingType;
    if (this.statecustome != null) {
      data['statecustome'] = this.statecustome!.toJson();
    }
    return data;
  }
}

class StateCustome {
  int? id;
  String? name;
  String? nameAr;

  StateCustome({this.id, this.name, this.nameAr});

  StateCustome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_ar'] = nameAr;
    return data;
  }
}

class PackageType {
  int? id;
  String? name;
  String? nameAr;
  String? image;
  String? activeImage;

  PackageType({this.id, this.name, this.nameAr, this.image, this.activeImage});

  PackageType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    image = json['image'];
    activeImage = json['active_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['image'] = image;
    data['active_image'] = activeImage;
    return data;
  }
}
