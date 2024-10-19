import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:flutter/material.dart';

class TraderOfferProvider extends ChangeNotifier {
  List<Attachment> _attachments = [];
  List<Attachment> get attachments => _attachments;

  List<AttachmentType> _additionalAttachments = [];
  List<AttachmentType> get additionalAttachments => _additionalAttachments;

  initAttachment(List<Attachment> value) {
    _attachments = [];
    _attachments = value;
    notifyListeners();
  }

  addAttachment(Attachment value) {
    _attachments.add(value);
    notifyListeners();
  }

  initAdditionalAttachment(List<AttachmentType> value) {
    _additionalAttachments = [];
    _additionalAttachments = value;
    notifyListeners();
  }

  removeAdditionalAttachment(AttachmentType value) {
    _additionalAttachments.remove(value);
    notifyListeners();
  }
}
