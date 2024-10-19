import 'package:custome_mobile/data/models/state_custome_agency_model.dart';

class UserProfile {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? image;
  String? phone;
  String? bio;
  int? trader;
  int? costumebroker;

  UserProfile({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.image,
    this.phone,
    this.bio,
    this.trader,
    this.costumebroker,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    image = json['image'] ?? "";
    phone = json['phone'] ?? "";
    bio = json['bio'] ?? "";
    trader = json['trader'] ?? 0;
    costumebroker = json['costumebroker'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['trader'] = this.trader;
    data['costumebroker'] = this.costumebroker;
    return data;
  }
}

class CostumBroker {
  int? id;
  UserProfile? user;
  List<CustomeAgency>? agencies;
  int? rating;

  CostumBroker({this.id, this.user, this.agencies, this.rating});

  CostumBroker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new UserProfile.fromJson(json['user']) : null;
    if (json['agencies'] != null) {
      agencies = <CustomeAgency>[];
      json['agencies'].forEach((v) {
        agencies!.add(new CustomeAgency.fromJson(v));
      });
    }
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.agencies != null) {
      data['agencies'] = this.agencies!.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    return data;
  }
}

class Review {
  int? id;
  Trader? trader;
  Broker? broker;
  int? rate;
  String? review;
  String? dateCreated;

  Review(
      {this.id,
      this.trader,
      this.broker,
      this.rate,
      this.review,
      this.dateCreated});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trader =
        json['trader'] != null ? new Trader.fromJson(json['trader']) : null;
    broker =
        json['broker'] != null ? new Broker.fromJson(json['broker']) : null;
    rate = json['rate'];
    review = json['review'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.trader != null) {
      data['trader'] = this.trader!.toJson();
    }
    if (this.broker != null) {
      data['broker'] = this.broker!.toJson();
    }
    data['rate'] = this.rate;
    data['review'] = this.review;
    data['date_created'] = this.dateCreated;
    return data;
  }
}

class Trader {
  int? id;
  User? user;

  Trader({this.id, this.user});

  Trader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;

  User({
    this.id,
    this.firstName,
    this.lastName,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Broker {
  int? id;
  User? user;

  Broker({
    this.id,
    this.user,
  });

  Broker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
