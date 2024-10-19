import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:flutter/material.dart';

class OrderBrokerProvider extends ChangeNotifier {
  String _selectedRadioTile = "";
  String get selectedRadioTile => _selectedRadioTile;
  bool _selectedRadioTileError = false;
  bool get selectedRadioTileError => _selectedRadioTileError;

  bool _isProfile = false;
  bool get isProfile => _isProfile;

  StateCustome? _selectedStateCustome;
  StateCustome? get selectedStateCustome => _selectedStateCustome;
  CustomeAgency? _selectedCustomeAgency;
  CustomeAgency? get selectedCustomeAgency => _selectedCustomeAgency;
  Origin? _source;
  Origin? get source => _source;
  bool _selectedStateError = false;
  bool get selectedStateError => _selectedStateError;

  DateTime? _productExpireDate;
  DateTime? get productExpireDate => _productExpireDate;
  bool _dateError = false;
  bool get dateError => _dateError;

  int _packageTypeId = 0;
  int get packageTypeId => _packageTypeId;
  int _packageNum = 0;
  int get packageNum => _packageNum;
  int _tabalehNum = 1;
  int get tabalehNum => _tabalehNum;
  bool _packageError = false;
  bool get packageError => _packageError;
  bool _haveTabaleh = false;
  bool get haveTabaleh => _haveTabaleh;
  String _note = "";
  String get note => _note;

  List<Attachment> _attachments = [];
  List<Attachment> get attachments => _attachments;
  List<int> _attachmentsId = [];
  List<int> get attachmentsId => _attachmentsId;

  List<AttachmentType> _attachmentTypes = [];
  List<AttachmentType> get attachmentTypes => _attachmentTypes;

  initAttachmentType(List<AttachmentType> types) {
    _attachmentTypes = [];
    _attachmentTypes = types;
    notifyListeners();
  }

  addAttachment(Attachment attachment) {
    _attachments.add(attachment);
    notifyListeners();
  }

  removeAttachment(Attachment attachment) {
    _attachments.remove(attachment);
    notifyListeners();
  }

  initProvider() {
    _selectedRadioTile = "";
    _selectedRadioTileError = false;
    _selectedStateCustome = null;
    _selectedCustomeAgency = null;
    _source = null;
    _selectedStateError = false;
    _productExpireDate = null;
    _dateError = false;
    _packageTypeId = 0;
    _packageNum = 0;
    _tabalehNum = 1;
    _haveTabaleh = false;
    _note = "";
    _packageError = false;
    _attachments = [];
    _attachmentsId = [];
    _attachmentTypes = [];
    notifyListeners();
  }

  setSelectedRadioTile(String val) {
    _selectedRadioTile = val;
    _selectedRadioTileError = false;
    notifyListeners();
  }

  setSelectedRadioError(bool val) {
    _selectedRadioTileError = val;
    notifyListeners();
  }

  setSelectedStateCustome(StateCustome? value) {
    _selectedStateCustome = value;
    notifyListeners();
  }

  setSource(Origin? value) {
    _source = value;
    notifyListeners();
  }

  setIsProfile(bool value) {
    _isProfile = value;
    notifyListeners();
  }

  setSelectedCustomeAgency(CustomeAgency? value) {
    _selectedCustomeAgency = value;
    notifyListeners();
  }

  setselectedStateError(bool value) {
    _selectedStateError = value;
    notifyListeners();
  }

  setProductDate(DateTime? value) {
    _productExpireDate = value;
    notifyListeners();
  }

  setDateError(bool value) {
    _dateError = value;
    notifyListeners();
  }

  setpackageTypeId(int value) {
    _packageTypeId = value;
    notifyListeners();
  }

  setpackageNum(int value) {
    _packageNum = value;
    notifyListeners();
  }

  settabalehNum(int value) {
    _tabalehNum = value;
    notifyListeners();
  }

  increasetabalehNum() {
    _tabalehNum++;
    notifyListeners();
  }

  decreasetabalehNum() {
    if (_tabalehNum > 1) {
      _tabalehNum--;
    }
    notifyListeners();
  }

  setPackageError(bool value) {
    _packageError = value;
    notifyListeners();
  }

  setHaveTabaleh(bool value) {
    _haveTabaleh = value;
    notifyListeners();
  }

  setNote(String value) {
    _note = value;
    notifyListeners();
  }

  addAttachmentId(int value) {
    _attachmentsId.add(value);
    notifyListeners();
  }
}
