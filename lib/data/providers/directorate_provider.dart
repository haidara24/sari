import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:flutter/material.dart';

class DirectorateProvider extends ChangeNotifier {
  StateCustome? _selectedStateCustome;
  StateCustome? get selectedStateCustome => _selectedStateCustome;

  List<StateCustome>? _stateCustomes;
  List<StateCustome>? get stateCustomes => _stateCustomes;

  CustomeAgency? _selectedCustomeAgency;
  CustomeAgency? get selectedCustomeAgency => _selectedCustomeAgency;

  List<CustomeAgency>? _customeAgencies;
  List<CustomeAgency>? get customeAgencies => _customeAgencies;

  setstateCustome(List<StateCustome>? value) {
    _stateCustomes = value;
    notifyListeners();
  }

  init() {
    _selectedStateCustome = null;

    _stateCustomes = [];

    _selectedCustomeAgency = null;

    _customeAgencies = [];
  }

  setcustomeAgency(List<CustomeAgency>? value) {
    _customeAgencies = value;
    notifyListeners();
  }

  setSelectedStateCustome(StateCustome? value) {
    _selectedStateCustome = value;
    notifyListeners();
  }

  setSelectedCustomeAgency(CustomeAgency? value) {
    _selectedCustomeAgency = value;
    notifyListeners();
  }
}
