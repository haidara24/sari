import 'package:custome_mobile/data/models/package_model.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String _syrianExchangeValue = "8585";
  String get syrianExchangeValue => _syrianExchangeValue;
  String _syrianTotalValue = "0";
  String get syrianTotalValue => _syrianTotalValue;
  String _totalValueWithEnsurance = "0";
  String get totalValueWithEnsurance => _totalValueWithEnsurance;

  Package? _selectedPackage;
  Package? get selectedPackage => _selectedPackage;
  Origin? _selectedOrigin;
  Origin? get selectedOrigin => _selectedOrigin;

  String _wieghtUnit = "";
  String get wieghtUnit => _wieghtUnit;
  String _wieghtLabel = "الوزن";
  String get wieghtLabel => _wieghtLabel;

  int _weight = 0;
  int get weight => _weight;

  double _basePrice = 0;
  double get basePrice => _basePrice;
  double _extraPrice = 0;
  double get extraPrice => _extraPrice;

  bool _valueEnabled = true;
  bool get valueEnabled => _valueEnabled;
  bool _allowexport = false;
  bool get allowexport => _allowexport;
  bool _fillorigin = false;
  bool get fillorigin => _fillorigin;
  bool _originerror = false;
  bool get originerror => _originerror;
  bool _feeerror = false;
  bool get feeerror => _feeerror;
  bool _isfeeequal001 = false;
  bool get isfeeequal001 => _isfeeequal001;
  bool _isBrand = false;
  bool get isBrand => _isBrand;
  bool _brandValue = false;
  bool get brandValue => _brandValue;
  bool _rawMaterialValue = false;
  bool get rawMaterialValue => _rawMaterialValue;
  bool _industrialValue = false;
  bool get industrialValue => _industrialValue;
  bool _isTubes = false;
  bool get isTubes => _isTubes;
  bool _tubesValue = false;
  bool get tubesValue => _tubesValue;
  bool _isLycra = false;
  bool get isLycra => _isLycra;
  bool _lycraValue = false;
  bool get lycraValue => _lycraValue;
  bool _isColored = false;
  bool get isColored => _isColored;
  bool _colorValue = false;
  bool get colorValue => _colorValue;
  bool _showunit = false;
  bool get showunit => _showunit;
  bool _isdropdwonVisible = false;
  bool get isdropdwonVisible => _isdropdwonVisible;
  String _placeholder = "";
  String get placeholder => _placeholder;
  String _patternString = "";
  String get patternString => _patternString;
  List<Extras> _items = [];
  List<Extras> get items => _items;
  Extras? _selectedValue;
  Extras? get selectedValue => _selectedValue;

  initProvider() {
    _syrianExchangeValue = "8585";
    _syrianTotalValue = "0";
    _totalValueWithEnsurance = "0";
    _selectedPackage;
    _selectedOrigin;
    _wieghtUnit = "";
    _wieghtLabel = "الوزن";
    _valueEnabled = true;
    _allowexport = false;
    _fillorigin = false;
    _originerror = false;
    _feeerror = false;
    _isfeeequal001 = false;
    _isBrand = false;
    _brandValue = false;
    _rawMaterialValue = false;
    _industrialValue = false;
    _isTubes = false;
    _tubesValue = false;
    _isLycra = false;
    _lycraValue = false;
    _isColored = false;
    _colorValue = false;
    _showunit = false;
    _isdropdwonVisible = false;
    _placeholder = "";
    _patternString = "";
    _items = [];
    _selectedValue = null;
    notifyListeners();
  }

  setselectedPackage(Package value) {
    _selectedPackage = value;
    notifyListeners();
  }

  setFeeError(bool value) {
    _feeerror = value;
    notifyListeners();
  }

  setPatternString(String value) {
    _patternString = value;
    notifyListeners();
  }

  setBasePrice(double value) {
    _basePrice = value;
    notifyListeners();
  }

  setValueEnable(bool value) {
    _valueEnabled = value;
    notifyListeners();
  }

  setSelectedValue(Extras value) {
    _selectedValue = value;
    notifyListeners();
  }

  setOriginError(bool value) {
    _originerror = value;
    notifyListeners();
  }

  setWeightValue(int value) {
    _weight = value;
    notifyListeners();
  }

  setRawMaterial(bool value) {
    _rawMaterialValue = value;
    notifyListeners();
  }

  setIndustrail(bool value) {
    _industrialValue = value;
    notifyListeners();
  }

  setBrand(bool value) {
    _brandValue = value;
    notifyListeners();
  }

  setLycra(bool value) {
    _lycraValue = value;
    notifyListeners();
  }

  setColor(bool value) {
    _colorValue = value;
    notifyListeners();
  }

  setTubes(bool value) {
    _tubesValue = value;
    notifyListeners();
  }

  selectSuggestion(Package suggestion) {
    _selectedPackage = suggestion;
    _feeerror = false;
    if (suggestion.price! > 0) {
      _basePrice = suggestion.price!;
      _valueEnabled = false;
    } else {
      _basePrice = 0.0;
      _valueEnabled = true;
      _syrianExchangeValue = "8585";
    }
    if (suggestion.extras!.isNotEmpty) {
      if (suggestion.extras![0].brand!) {
        _isBrand = true;
        _brandValue = false;
      } else {
        _isBrand = false;
        _brandValue = false;
      }

      if (suggestion.extras![0].tubes!) {
        _isTubes = true;
        _tubesValue = false;
      } else {
        _isTubes = false;
        _tubesValue = false;
      }

      if (suggestion.extras![0].lycra!) {
        _isLycra = true;
        _lycraValue = false;
      } else {
        _isLycra = false;
        _lycraValue = false;
      }

      if (suggestion.extras![0].coloredThread!) {
        _isColored = true;
        _colorValue = false;
      } else {
        _isColored = false;
        _colorValue = false;
      }
    }

    if (suggestion.unit!.isNotEmpty) {
      switch (suggestion.unit) {
        case "كغ":
          _wieghtLabel = " الوزن";

          break;
        case "طن":
          _wieghtLabel = " الوزن";

          break;
        case "قيراط":
          _wieghtLabel = " الوزن";

          break;
        case "كيلو واط بالساعة 1000":
          _wieghtLabel = "الاستطاعة";

          break;
        case "الاستطاعة بالطن":
          _wieghtLabel = "الاستطاعة";

          break;
        case "واط":
          _wieghtLabel = "الاستطاعة";

          break;
        case "عدد الأزواج":
          _wieghtLabel = "العدد";

          break;
        case "عدد":
          _wieghtLabel = "العدد";

          break;
        case "طرد":
          _wieghtLabel = "العدد";

          break;
        case "قدم":
          _wieghtLabel = "العدد";

          break;
        case "متر":
          _wieghtLabel = "الحجم";

          break;
        case "متر مربع":
          _wieghtLabel = "الحجم";

          break;
        case "متر مكعب":
          _wieghtLabel = "الحجم";

          break;
        case "لتر":
          _wieghtLabel = "السعة";

          break;
        default:
          _wieghtLabel = "الوزن";
      }
      _wieghtUnit = suggestion.unit!;
      _showunit = true;
    } else {
      _wieghtUnit = "";
      _showunit = false;
    }

    if (suggestion.placeholder != "") {
      _placeholder = suggestion.placeholder!;
      _isdropdwonVisible = false;
      _items = suggestion.extras!;
      _isdropdwonVisible = true;
    } else {
      _isdropdwonVisible = false;
      _placeholder = "";
      _items = [];
    }

    if (suggestion.fee! == 0.01) {
      _isfeeequal001 = true;
    } else {
      _isfeeequal001 = false;
    }

    switch (suggestion.export1) {
      case "0":
        _allowexport = true;

        break;
      case "1":
        _allowexport = false;

        break;
      default:
    }
    notifyListeners();
  }

  void selectOrigin(Origin origin) {
    _selectedOrigin = origin;
    _originerror = false;

    if (selectedPackage!.extras!.isNotEmpty) {
      outerLoop:
      for (var element in selectedPackage!.extras!) {
        for (var element1 in origin.countryGroups!) {
          if (element.countryGroup!.contains(element1)) {
            if (element.price! > 0) {
              _basePrice = element.price!;

              _valueEnabled = false;

              break outerLoop;
            }
          } else {
            _valueEnabled = true;
            _syrianExchangeValue = "8585";
            _basePrice = 0.0;
          }
        }
      }
      if (origin.countryGroups!.isEmpty) {
        _basePrice = 0.0;
        _valueEnabled = true;
        _syrianExchangeValue = "8585";
      }
    }
    notifyListeners();
    evaluatePrice();
  }

  void evaluatePrice() {
    if (valueEnabled) {
      calculateTotalValue();
    } else {
      calculateTotalValueWithPrice();
    }
    notifyListeners();
  }

  void calculateTotalValueWithPrice() {
    var syrianExch = _weight * _basePrice;
    var syrianTotal = syrianExch * 8585;
    var totalEnsurance = (syrianTotal * 0.0012);
    _syrianExchangeValue = syrianExch.round().toString();
    _syrianTotalValue = syrianTotal.round().toString();
    _totalValueWithEnsurance = totalEnsurance.round().toString();
    notifyListeners();
  }

  void calculateTotalValue() {
    var syrianTotal = _weight * 8585;
    var totalEnsurance = (syrianTotal * 0.0012);
    _syrianTotalValue = syrianTotal.round().toString();
    _totalValueWithEnsurance = totalEnsurance.round().toString();
    notifyListeners();
  }

  void calculateExtrasPrice(double percentage, bool add) {
    _extraPrice = 0.0;
    if (add) {
      _extraPrice = _basePrice + (_basePrice * percentage);
    } else {
      _extraPrice = _basePrice - (_basePrice * percentage);
    }
  }
}
