class NotificationModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? dateCreated;
  String? noteficationType;
  bool? isread;
  int? user;
  int? offer;

  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.dateCreated,
    this.noteficationType,
    this.isread,
    this.user,
    this.offer,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'] ?? "";
    dateCreated = json['date_created'];
    noteficationType = json['notefication_type'];
    isread = json['isread'];
    user = json['user'];
    offer = json['offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['date_created'] = dateCreated;
    data['notefication_type'] = noteficationType;
    data['isread'] = isread;
    data['user'] = user;
    return data;
  }
}
