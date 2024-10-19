class AttachmentType {
  int? id;
  String? name;
  int? number;
  String? image;

  AttachmentType({this.id, this.name, this.number, this.image});

  AttachmentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['image'] = image;
    return data;
  }
}

class Attachment {
  int? id;
  List<AttachmentFile>? file;
  List<AttachmentImage>? image;
  AttachmentType? attachmentType;
  String? otherAttachmentName;
  int? user;

  Attachment(
      {this.id,
      this.file,
      this.image,
      this.attachmentType,
      this.otherAttachmentName,
      this.user});

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['files'] != null) {
      file = <AttachmentFile>[];
      json['files'].forEach((v) {
        file!.add(AttachmentFile.fromJson(v));
      });
    } else {
      file = <AttachmentFile>[];
    }
    if (json['images'] != null) {
      image = <AttachmentImage>[];
      json['images'].forEach((v) {
        image!.add(AttachmentImage.fromJson(v));
      });
    } else {
      image = <AttachmentImage>[];
    }
    attachmentType = json['attachment_type'] != null
        ? (json['attachment_type'] is int)
            ? AttachmentType(id: json['attachment_type'])
            : AttachmentType.fromJson(json['attachment_type'])
        : null;
    otherAttachmentName = json['other_attachment_name'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file'] = file;
    data['image'] = image;
    data['attachment_type'] = attachmentType;
    data['user'] = user;
    return data;
  }
}

class CreateAttachment {
  int? id;
  List<AttachmentFile>? file;
  List<AttachmentImage>? image;
  int? attachmentType;
  String? otherAttachmentName;
  int? user;

  CreateAttachment(
      {this.id,
      this.file,
      this.image,
      this.attachmentType,
      this.otherAttachmentName,
      this.user});

  CreateAttachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['files'] != null) {
      file = <AttachmentFile>[];
      json['files'].forEach((v) {
        file!.add(AttachmentFile.fromJson(v));
      });
    } else {
      file = <AttachmentFile>[];
    }
    if (json['images'] != null) {
      image = <AttachmentImage>[];
      json['images'].forEach((v) {
        image!.add(AttachmentImage.fromJson(v));
      });
    } else {
      image = <AttachmentImage>[];
    }
    attachmentType = json['attachment_type'];
    otherAttachmentName = json['other_attachment_name'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file'] = file;
    data['image'] = image;
    data['attachment_type'] = attachmentType;
    data['user'] = user;
    return data;
  }
}

class AttachmentImage {
  int? id;
  String? image;
  int? attachment;

  AttachmentImage({
    this.id,
    this.image,
    this.attachment,
  });

  AttachmentImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    attachment = json['attachment'];
  }
}

class AttachmentFile {
  int? id;
  String? file;
  int? attachment;

  AttachmentFile({
    this.id,
    this.file,
    this.attachment,
  });

  AttachmentFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    attachment = json['attachment'];
  }
}
