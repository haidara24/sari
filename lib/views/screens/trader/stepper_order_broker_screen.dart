import 'dart:convert';

import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/agency_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_result_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculator_panel_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_select_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/flags_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/state_custome_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:custome_mobile/data/providers/order_broker_provider.dart';
import 'package:custome_mobile/data/services/calculator_service.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/helpers/formatter.dart';
import 'package:custome_mobile/views/screens/trader/trader_attachement_screen.dart';
import 'package:custome_mobile/views/screens/trader/trader_calculator_result_screen.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/highlight_text.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ensure_visible_when_focused/ensure_visible_when_focused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StepperOrderBrokerScreen extends StatefulWidget {
  const StepperOrderBrokerScreen({Key? key}) : super(key: key);

  @override
  State<StepperOrderBrokerScreen> createState() =>
      _StepperOrderBrokerScreenState();
}

class _StepperOrderBrokerScreenState extends State<StepperOrderBrokerScreen> {
  final GlobalKey<FormState> _ordercalformkey = GlobalKey<FormState>();
  final FocusNode _ordernode = FocusNode();
  final FocusNode _orderTypenode = FocusNode();
  final FocusNode _stateCustomenode = FocusNode();
  final GlobalKey<FormState> _packagesformkey = GlobalKey<FormState>();

  var key1 = GlobalKey();
  var key2 = GlobalKey();
  var key3 = GlobalKey();

  final TextEditingController _typeAheadController = TextEditingController();

  final TextEditingController _wieghtController = TextEditingController();

  final TextEditingController _originController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  String syrianExchangeValue = "8585";

  String syrianTotalValue = "0.0";

  String totalValueWithEnsurance = "0.0";
  String totalFees = "0.0";
  bool totalFeesloading = false;
  bool totalFeesdone = false;

  bool haveTabaleh = false;

  Package? selectedPackage;
  Origin? selectedOrigin;

  String wieghtUnit = "";
  String wieghtLabel = "الوزن";

  double usTosp = 8585;
  double basePrice = 0.0;
  double wieghtValue = 0.0;

  bool valueEnabled = true;
  bool allowexport = false;
  bool fillorigin = false;
  bool originerror = false;
  bool feeerror = false;
  bool isfeeequal001 = false;
  bool isBrand = false;
  bool brandValue = false;
  bool isTubes = false;
  bool tubesValue = false;
  bool rawMaterialValue = false;
  bool industrialValue = false;
  bool isLycra = false;
  bool lycraValue = false;
  bool isColored = false;
  bool colorValue = false;
  bool showunit = false;
  bool isdropdwonVisible = false;
  String _placeholder = "";

  CalculateObject result = CalculateObject();

  int agencyId = 0;
  int selectedPanel = -1;
  bool showtypeError = false;
  bool calculatorError = false;
  bool packageError = false;
  String statePlaceholder = "اختر مديرية";
  String agencyPlaceholder = "اختر أمانة";
  String originPlaceholder = "اختر المنشأ";
  var f = NumberFormat("#,###", "en_US");

  String patternString = "";

  final FocusNode _statenode = FocusNode();
  // final FocusNode _agencynode = FocusNode();
  // Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    // FocusScope.of(context).unfocus();
  }

  void calculateTotalValueWithPrice() {
    var syrianExch = double.parse(_wieghtController.text.replaceAll(",", "")) *
        double.parse(_valueController.text.replaceAll(",", ""));
    print(syrianExch);
    var syrianTotal = syrianExch * 8585;
    var totalEnsurance = (syrianTotal * 0.0012);
    setState(() {
      syrianExchangeValue = syrianExch.round().toString();
      syrianTotalValue = syrianTotal.round().toString();
      totalValueWithEnsurance = totalEnsurance.round().toString();
    });
  }

  void calculateTotalValue() {
    var syrianTotal =
        double.parse(_valueController.text.replaceAll(",", "")) * 8585;
    print(syrianTotal);
    var totalEnsurance = (syrianTotal * 0.0012);
    setState(() {
      syrianTotalValue = syrianTotal.round().toString();
      totalValueWithEnsurance = totalEnsurance.round().toString();
    });
  }

  void selectSuggestion(Package suggestion, String lang) {
    _typeAheadController.text = suggestion.label!;
    selectedPackage = suggestion;
    setState(() {
      feeerror = false;
    });
    if (suggestion.price! > 0) {
      basePrice = suggestion.price!;

      _valueController.text = suggestion.price!.toString();
      setState(() {
        valueEnabled = false;
      });
    } else {
      setState(() {
        basePrice = 0.0;

        if (_valueController.text.isEmpty) {
          _valueController.text = "0.0";
        }
        valueEnabled = true;
        syrianExchangeValue = "8585";
      });
    }

    if (suggestion.extras!.isNotEmpty) {
      if (suggestion.extras![0].brand!) {
        setState(() {
          isBrand = true;
          brandValue = false;
        });
      } else {
        setState(() {
          isBrand = false;
          brandValue = false;
        });
      }

      if (suggestion.extras![0].tubes!) {
        setState(() {
          isTubes = true;
          tubesValue = false;
        });
      } else {
        setState(() {
          isTubes = false;
          tubesValue = false;
        });
      }

      if (suggestion.extras![0].lycra!) {
        setState(() {
          isLycra = true;
          lycraValue = false;
        });
      } else {
        setState(() {
          isLycra = false;
          lycraValue = false;
        });
      }

      if (suggestion.extras![0].coloredThread!) {
        setState(() {
          isColored = true;
          colorValue = false;
        });
      } else {
        setState(() {
          isColored = false;
          colorValue = false;
        });
      }
    }

    if (suggestion.unit!.isNotEmpty) {
      switch (suggestion.unit) {
        case "كغ":
          setState(() {
            wieghtLabel = lang == 'en' ? "weight" : "الوزن";
          });
          break;
        case "طن":
          setState(() {
            wieghtLabel = lang == 'en' ? "weight" : "الوزن";
          });
          break;
        case "قيراط":
          setState(() {
            wieghtLabel = lang == 'en' ? "weight" : "الوزن";
          });
          break;
        case "  كيلو واط بالساعة 1000":
          setState(() {
            wieghtLabel = lang == 'en' ? "power" : "الاستطاعة";
          });
          break;
        case "  الاستطاعة بالطن":
          setState(() {
            wieghtLabel = lang == 'en' ? "power" : "الاستطاعة";
          });
          break;
        case "واط":
          setState(() {
            wieghtLabel = lang == 'en' ? "power" : "الاستطاعة";
          });
          break;
        case "عدد الأزواج":
          setState(() {
            wieghtLabel = lang == 'en' ? "number" : "العدد";
          });
          break;
        case "عدد":
          setState(() {
            wieghtLabel = lang == 'en' ? "number" : "العدد";
          });
          break;
        case "طرد":
          setState(() {
            wieghtLabel = lang == 'en' ? "number" : "العدد";
          });
          break;
        case "قدم":
          setState(() {
            wieghtLabel = lang == 'en' ? "number" : "العدد";
          });
          break;
        case "متر":
          setState(() {
            wieghtLabel = lang == 'en' ? "volume" : "الحجم";
          });
          break;
        case "متر مربع":
          setState(() {
            wieghtLabel = lang == 'en' ? "volume" : "الحجم";
          });
          break;
        case "متر مكعب":
          setState(() {
            wieghtLabel = lang == 'en' ? "volume" : "الحجم";
          });
          break;
        case "لتر":
          setState(() {
            wieghtLabel = lang == 'en' ? "capacity" : "السعة";
          });
          break;
        default:
          setState(() {
            wieghtLabel = lang == 'en' ? "weight" : "الوزن";
          });
      }
      setState(() {
        wieghtUnit = suggestion.unit!;
        showunit = true;
      });
    } else {
      setState(() {
        wieghtUnit = "";
        showunit = false;
      });
    }

    if (suggestion.placeholder != "") {
      setState(() {
        _placeholder = suggestion.placeholder!;
        isdropdwonVisible = false;
        items = suggestion.extras!;
        isdropdwonVisible = true;
      });
    } else {
      setState(() {
        isdropdwonVisible = false;
        _placeholder = "";
        items = [];
      });
    }

    if (suggestion.fee! == 0.01) {
      setState(() {
        isfeeequal001 = true;
      });
    } else {
      setState(() {
        isfeeequal001 = false;
      });
    }

    switch (suggestion.export1) {
      case "0":
        setState(() {
          allowexport = true;
        });
        break;
      case "1":
        setState(() {
          allowexport = false;
        });
        break;
      default:
    }
  }

  void selectOrigin(Origin origin) {
    _originController.text = " ${origin.label!}";
    setState(() {
      selectedOrigin = origin;
      originerror = false;
    });

    if (selectedPackage!.extras!.isNotEmpty) {
      outerLoop:
      for (var element in selectedPackage!.extras!) {
        for (var element1 in origin.countryGroups!) {
          if (element.countryGroup!.contains(element1)) {
            if (element.price! > 0) {
              _valueController.text = element.price!.toString();
              basePrice = element.price!;

              setState(() {
                valueEnabled = false;
              });
              break outerLoop;
            }
          } else {
            setState(() {
              basePrice = 0.0;
              _valueController.text = "0.0";
              valueEnabled = true;
              syrianExchangeValue = "8585";
            });
          }
        }
      }
      if (origin.countryGroups!.isEmpty) {
        setState(() {
          basePrice = 0.0;

          _valueController.text = "0.0";
          valueEnabled = true;
          syrianExchangeValue = "8585";
        });
      }
    }
    evaluatePrice();
  }

  void calculateExtrasPrice(double percentage, bool add) {
    var price = 0.0;
    if (add) {
      price = double.parse(_valueController.text) + (basePrice * percentage);

      setState(() {
        _valueController.text = price.toString();
      });
    } else {
      price = double.parse(_valueController.text) - (basePrice * percentage);

      setState(() {
        _valueController.text = price.toString();
      });
    }
  }

  void evaluatePrice() {
    if (selectedOrigin != null &&
        selectedPackage != null &&
        (_valueController.text.isNotEmpty && _valueController.text != "0.0") &&
        (_wieghtController.text.isNotEmpty &&
            _wieghtController.text != "0.0")) {
      if (valueEnabled) {
        calculateTotalValue();
      } else {
        calculateTotalValueWithPrice();
      }
      calculateTheFees();
    }
  }

  void calculateTheFees() {
    _ordercalformkey.currentState?.save();
    if (_ordercalformkey.currentState!.validate()) {
      setState(() {
        packageError = false;
      });
      // print(
      //     '$totalValueWithEnsurance\n${selectedPackage!.fee!}\n$rawMaterialValue\n$industrialValue\n${selectedPackage!.totalTaxes!.totalTax!}\n${selectedPackage!.totalTaxes!.partialTax!}\n${selectedOrigin!.label!}\n${selectedPackage!.spendingFee!}\n${selectedPackage!.supportFee!}\n${selectedPackage!.localFee!}\n${selectedPackage!.protectionFee!}\n${selectedPackage!.naturalFee!}${selectedPackage!.taxFee!}\n');
      result.insurance = int.parse(totalValueWithEnsurance);
      result.fee = selectedPackage!.fee!;
      result.rawMaterial = rawMaterialValue ? 1 : 0;
      result.industrial = industrialValue ? 1 : 0;
      result.totalTax = selectedPackage!.totalTaxes!.totalTax!;
      result.partialTax = selectedPackage!.totalTaxes!.partialTax!;
      result.origin = selectedOrigin!.label!;
      result.spendingFee = selectedPackage!.spendingFee!;
      result.supportFee = selectedPackage!.supportFee!;
      result.localFee = selectedPackage!.localFee!;
      result.protectionFee = selectedPackage!.protectionFee!;
      result.naturalFee = selectedPackage!.naturalFee!;
      result.taxFee = selectedPackage!.taxFee!;
      result.weight = wieghtValue.toInt();
      result.price = basePrice.toInt();
      result.cnsulate = 1;
      result.dolar = 8585;
      result.arabic_stamp = selectedPackage!.totalTaxes!.arabicStamp!.toInt();
      result.import_fee = selectedPackage!.importFee;
      print(jsonEncode(result.toJson()));
      BlocProvider.of<CalculateResultBloc>(context)
          .add(CalculateTheResultEvent(result));
    }
  }

  setSelectedPanel(int val) {
    if (selectedPanel != val) {
      setState(() {
        selectedPanel = val;
      });
    }
  }

  List<Extras> items = [];
  Extras? selectedValue;

  final FocusNode _nodeWeight = FocusNode();
  final FocusNode _nodeValue = FocusNode();
  bool disableScrolling = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: disableScrolling
          ? const NeverScrollableScrollPhysics()
          : const ClampingScrollPhysics(),
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return BlocListener<FeeSelectBloc, FeeSelectState>(
            listener: (context, state) {
              if (state is FeeSelectSuccess) {
                setState(() {
                  _wieghtController.text = "0.0";
                  _valueController.text = "0.0";
                  syrianExchangeValue = "8585";
                  syrianTotalValue = "0.0";
                  totalValueWithEnsurance = "0.0";
                });
                selectSuggestion(state.package, localeState.value.languageCode);
              } else {
                // print("ghjhgjgh");
              }
            },
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                BlocProvider.of<BottomNavBarCubit>(context).emitShow();
              },
              child: Consumer<OrderBrokerProvider>(
                  builder: (context, orderBrokerProvider, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    EnsureVisibleWhenFocused(
                      focusNode: _orderTypenode,
                      child: Card(
                        key: key1,
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: selectedPanel == 0
                                ? orderBrokerProvider.selectedRadioTileError
                                    ? LinearGradient(
                                        colors: [
                                            Colors.red[300]!,
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                          ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)
                                    : LinearGradient(
                                        colors: [
                                            AppColor.goldenYellow,
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                          ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)
                                : null,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate('select_operation_type'),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.deepBlue,
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .38,
                                  child: RadioListTile(
                                    value: "I",
                                    groupValue:
                                        orderBrokerProvider.selectedRadioTile,
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .translate('import'),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    // subtitle: Text("Radio 1 Subtitle"),
                                    onChanged: (val) {
                                      // print("Radio Tile pressed $val");
                                      setSelectedPanel(0);
                                      orderBrokerProvider
                                          .setSelectedRadioTile(val!);
                                    },
                                    activeColor: AppColor.goldenYellow,
                                    selected:
                                        orderBrokerProvider.selectedRadioTile ==
                                            "I",
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .38,
                                  child: RadioListTile(
                                    value: "E",
                                    groupValue:
                                        orderBrokerProvider.selectedRadioTile,
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .translate('export'),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    // subtitle: Text("Radio 2 Subtitle"),
                                    onChanged: (val) {
                                      // print("Radio Tile pressed $val");
                                      setSelectedPanel(0);
                                      orderBrokerProvider
                                          .setSelectedRadioTile(val!);
                                    },
                                    activeColor: AppColor.goldenYellow,

                                    selected:
                                        orderBrokerProvider.selectedRadioTile ==
                                            "E",
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                                visible: showtypeError,
                                child: Text(
                                    AppLocalizations.of(context)!.translate(
                                        'select_operation_type_error'),
                                    style: const TextStyle(color: Colors.red)))
                          ]),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: orderBrokerProvider.selectedRadioTileError,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, bottom: 8.0, right: 25.0, left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .translate('select_operation_type_error'),
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    EnsureVisibleWhenFocused(
                      focusNode: _stateCustomenode,
                      child: Card(
                        key: key2,
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: selectedPanel == 1
                                ? orderBrokerProvider.selectedStateError
                                    ? LinearGradient(
                                        colors: [
                                            Colors.red[300]!,
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                          ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)
                                    : LinearGradient(
                                        colors: [
                                            AppColor.goldenYellow,
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                            Colors.white,
                                          ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)
                                : null,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate('costume_agency'),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.deepBlue,
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                BlocBuilder<StateCustomeBloc,
                                    StateCustomeState>(
                                  builder: (context, state) {
                                    if (state is StateCustomeLoadedSuccess) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DropdownButtonHideUnderline(
                                            child: Focus(
                                              focusNode: _statenode,
                                              onFocusChange: (bool focus) {
                                                if (focus) {
                                                  setSelectedPanel(1);
                                                }
                                              },
                                              child:
                                                  DropdownButton2<StateCustome>(
                                                isExpanded: true,
                                                barrierLabel: AppLocalizations
                                                        .of(context)!
                                                    .translate('select_state'),
                                                hint: Text(
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                          'select_state'),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                                items: state.states
                                                    .map((StateCustome item) =>
                                                        DropdownMenuItem<
                                                            StateCustome>(
                                                          value: item,
                                                          child: Text(
                                                            item.name!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: orderBrokerProvider
                                                    .selectedStateCustome,
                                                onChanged:
                                                    (StateCustome? value) {
                                                  BlocProvider.of<AgencyBloc>(
                                                          context)
                                                      .add(AgenciesLoadEvent(
                                                          value!.id!));
                                                  orderBrokerProvider
                                                      .setSelectedStateCustome(
                                                          value);
                                                  orderBrokerProvider
                                                      .setSelectedCustomeAgency(
                                                          null);
                                                },
                                                buttonStyleData:
                                                    ButtonStyleData(
                                                  height: 50,
                                                  width: double.infinity,

                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 9.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.black26,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  // elevation: 2,
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                  ),
                                                  iconSize: 20,
                                                  iconEnabledColor:
                                                      AppColor.AccentBlue,
                                                  iconDisabledColor:
                                                      Colors.grey,
                                                ),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: Colors.white,
                                                  ),
                                                  scrollbarTheme:
                                                      ScrollbarThemeData(
                                                    radius:
                                                        const Radius.circular(
                                                            40),
                                                    thickness:
                                                        MaterialStateProperty
                                                            .all(6),
                                                    thumbVisibility:
                                                        MaterialStateProperty
                                                            .all(true),
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                    MenuItemStyleData(
                                                  height: 40.h,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          BlocBuilder<AgencyBloc, AgencyState>(
                                            builder: (context, state2) {
                                              if (state2
                                                  is AgencyLoadedSuccess) {
                                                return DropdownButtonHideUnderline(
                                                  child: Focus(
                                                    focusNode: _statenode,
                                                    onFocusChange:
                                                        (bool focus) {
                                                      if (focus) {
                                                        setSelectedPanel(1);
                                                      }
                                                    },
                                                    child: DropdownButton2<
                                                        CustomeAgency>(
                                                      isExpanded: true,
                                                      hint: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'select_agency'),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .hintColor,
                                                        ),
                                                      ),
                                                      items: state2.agencies
                                                          .map((CustomeAgency
                                                                  item) =>
                                                              DropdownMenuItem<
                                                                  CustomeAgency>(
                                                                value: item,
                                                                child: SizedBox(
                                                                  width: 200,
                                                                  child: Text(
                                                                    item.name!,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ))
                                                          .toList(),
                                                      value: orderBrokerProvider
                                                          .selectedCustomeAgency,
                                                      onChanged: (CustomeAgency?
                                                          value) {
                                                        orderBrokerProvider
                                                            .setSelectedCustomeAgency(
                                                                value);
                                                        orderBrokerProvider
                                                            .setselectedStateError(
                                                                false);
                                                      },
                                                      buttonStyleData:
                                                          ButtonStyleData(
                                                        height: 50,
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 9.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          border: Border.all(
                                                            color:
                                                                Colors.black26,
                                                          ),
                                                          color: Colors.white,
                                                        ),
                                                        // elevation: 2,
                                                      ),
                                                      iconStyleData:
                                                          const IconStyleData(
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_sharp,
                                                        ),
                                                        iconSize: 20,
                                                        iconEnabledColor:
                                                            AppColor.AccentBlue,
                                                        iconDisabledColor:
                                                            Colors.grey,
                                                      ),
                                                      dropdownStyleData:
                                                          DropdownStyleData(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(14),
                                                          color: Colors.white,
                                                        ),
                                                        scrollbarTheme:
                                                            ScrollbarThemeData(
                                                          radius: const Radius
                                                              .circular(40),
                                                          thickness:
                                                              MaterialStateProperty
                                                                  .all(6),
                                                          thumbVisibility:
                                                              MaterialStateProperty
                                                                  .all(true),
                                                        ),
                                                      ),
                                                      menuItemStyleData:
                                                          const MenuItemStyleData(
                                                        height: 40,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else if (state2
                                                  is AgencyLoadingProgress) {
                                                return const Center(
                                                  child:
                                                      LinearProgressIndicator(),
                                                );
                                              } else if (state
                                                  is AgencyLoadedFailed) {
                                                return Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  AgencyBloc>(
                                                              context)
                                                          .add(AgenciesLoadEvent(
                                                              orderBrokerProvider
                                                                  .selectedStateCustome!
                                                                  .id!));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'list_error'),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                        const Icon(
                                                          Icons.refresh,
                                                          color: Colors.grey,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    } else if (state
                                        is StateCustomeLoadedFailed) {
                                      return Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<StateCustomeBloc>(
                                                    context)
                                                .add(StateCustomeLoadEvent());
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .translate('list_error'),
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              ),
                                              const Icon(
                                                Icons.refresh,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: LinearProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                              ]),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: orderBrokerProvider.selectedStateError,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, bottom: 8.0, right: 25.0, left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .translate('select_agency_error'),
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      key: key3,
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        // margin: const EdgeInsets.symmetric(vertical: 7),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: selectedPanel == 2
                              ? calculatorError
                                  ? LinearGradient(
                                      colors: [
                                          Colors.red[300]!,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                        ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)
                                  : LinearGradient(
                                      colors: [
                                          AppColor.goldenYellow,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                          Colors.white,
                                        ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _ordercalformkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Focus(
                                      focusNode: _ordernode,
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .translate('goods_details'),
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.deepBlue,
                                          )),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<CalculatorPanelBloc>(
                                                context)
                                            .add(TariffPanelOpenEvent());
                                        // BlocProvider.of<SectionBloc>(context)
                                        //     .add(SectionLoadEvent());
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        BlocProvider.of<BottomNavBarCubit>(
                                                context)
                                            .emitShow();
                                      },
                                      child: SizedBox(
                                        height: 40.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 25.w,
                                              height: 25.h,
                                              child: SvgPicture.asset(
                                                "assets/icons/tarrif_btn.svg",
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .translate('tariff_browser'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: AppColor.lightBlue,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Focus(
                                      focusNode: _statenode,
                                      onFocusChange: (bool focus) {
                                        if (!focus) {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          BlocProvider.of<BottomNavBarCubit>(
                                                  context)
                                              .emitShow();
                                          setState(() {
                                            disableScrolling = false;
                                          });
                                        }
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<CalculatorPanelBloc>(
                                                  context)
                                              .add(TariffPanelOpenEvent());
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          BlocProvider.of<BottomNavBarCubit>(
                                                  context)
                                              .emitShow();
                                        },
                                        child: TypeAheadField(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            // autofocus: true,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            enabled: false,
                                            controller: _typeAheadController,
                                            scrollPadding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom +
                                                    150),
                                            onTap: () {
                                              setSelectedPanel(2);
                                              BlocProvider.of<
                                                          BottomNavBarCubit>(
                                                      context)
                                                  .emitHide();
                                              _typeAheadController.selection =
                                                  TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset:
                                                          _typeAheadController
                                                              .value
                                                              .text
                                                              .length);
                                            },
                                            style:
                                                const TextStyle(fontSize: 18),
                                            decoration: InputDecoration(
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .translate('goods_name'),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 11.0,
                                                      horizontal: 9.0),
                                            ),
                                            onSubmitted: (value) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              BlocProvider.of<
                                                          BottomNavBarCubit>(
                                                      context)
                                                  .emitShow();
                                              setState(() {
                                                disableScrolling = false;
                                              });
                                            },
                                          ),
                                          loadingBuilder: (context) {
                                            return Container(
                                              color: Colors.white,
                                              child: const Center(
                                                child: LoadingIndicator(),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error) {
                                            return Container(
                                              color: Colors.white,
                                            );
                                          },
                                          noItemsFoundBuilder: (value) {
                                            var localizedMessage =
                                                AppLocalizations.of(context)!
                                                    .translate(
                                                        'no_result_found');
                                            return Container(
                                              width: double.infinity,
                                              color: Colors.white,
                                              child: Center(
                                                child: Text(
                                                  localizedMessage,
                                                  style: TextStyle(
                                                      fontSize: 18.sp),
                                                ),
                                              ),
                                            );
                                          },
                                          suggestionsCallback: (pattern) async {
                                            // _debouncer.run(() {

                                            // });

                                            setState(() {
                                              patternString = pattern;
                                            });
                                            if (pattern.isNotEmpty) {
                                              setState(() {
                                                disableScrolling = true;
                                              });
                                            }
                                            return pattern.isEmpty ||
                                                    pattern.length == 1
                                                ? []
                                                : await CalculatorService
                                                    .getpackages(pattern);
                                          },
                                          itemBuilder: (context, suggestion) {
                                            return Container(
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    // leading: Icon(Icons.shopping_cart),
                                                    tileColor: Colors.white,
                                                    title: HighlightText(
                                                      text: suggestion.label!,
                                                      highlight: patternString,
                                                      ignoreCase: false,
                                                      style: TextStyle(
                                                          fontSize: 17.sp),
                                                      highlightStyle: TextStyle(
                                                        fontSize: 17.sp,
                                                        backgroundColor:
                                                            AppColor
                                                                .goldenYellow,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    // subtitle: Text('\$${suggestion['price']}'),
                                                  ),
                                                  Divider(
                                                    color: Colors.grey[300],
                                                    height: 3,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          onSuggestionSelected: (suggestion) {
                                            setState(() {
                                              _wieghtController.text = "";
                                              _valueController.text = "";
                                              syrianExchangeValue = "8585";
                                              syrianTotalValue = "0.0";
                                              totalValueWithEnsurance = "0.0";
                                            });
                                            selectSuggestion(suggestion,
                                                localeState.value.languageCode);
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            BlocProvider.of<BottomNavBarCubit>(
                                                    context)
                                                .emitShow();
                                            setState(() {
                                              disableScrolling = false;
                                            });
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //   builder: (context) => ProductPage(product: suggestion)
                                            // ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: allowexport,
                                  child: const SizedBox(
                                    height: 7,
                                  ),
                                ),
                                Visibility(
                                  visible: allowexport,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate('fee_import_banned'),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                Visibility(
                                  visible: feeerror,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate('select_fee_error'),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: feeerror,
                                  child: const SizedBox(
                                    height: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Visibility(
                                  visible: isdropdwonVisible,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Extras>(
                                      isExpanded: true,
                                      barrierLabel: _placeholder,
                                      hint: Text(
                                        _placeholder,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: items
                                          .map((Extras item) =>
                                              DropdownMenuItem<Extras>(
                                                value: item,
                                                child: Text(
                                                  item.label!,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: selectedValue,
                                      onChanged: (Extras? value) {
                                        if (value!.countryGroup!.isEmpty) {
                                          if (value.price! > 0) {
                                            basePrice = value.price!;

                                            _valueController.text =
                                                value.price!.toString();
                                            setState(() {
                                              valueEnabled = false;
                                            });
                                          } else {
                                            setState(() {
                                              basePrice = 0.0;
                                              _valueController.text = "0.0";
                                              valueEnabled = true;
                                              syrianExchangeValue = "8585";
                                            });
                                          }
                                          evaluatePrice();
                                        } else {
                                          if (value.price! > 0) {
                                            basePrice = value.price!;

                                            _valueController.text =
                                                value.price!.toString();
                                            setState(() {
                                              valueEnabled = false;
                                            });
                                          } else {
                                            setState(() {
                                              basePrice = 0.0;

                                              _valueController.text = "0.0";
                                              valueEnabled = true;
                                              syrianExchangeValue = "8585";
                                            });
                                          }
                                          evaluatePrice();
                                        }
                                        setState(() {
                                          selectedValue = value;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: double.infinity,

                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 9.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Colors.white,
                                        ),
                                        // elevation: 2,
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                        ),
                                        iconSize: 20,
                                        iconEnabledColor: AppColor.AccentBlue,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all(6),
                                          thumbVisibility:
                                              MaterialStateProperty.all(true),
                                        ),
                                      ),
                                      menuItemStyleData: MenuItemStyleData(
                                        height: 40.h,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isdropdwonVisible,
                                  child: const SizedBox(
                                    height: 24,
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    Visibility(
                                      visible: isfeeequal001,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: CheckboxListTile(
                                            value: rawMaterialValue,
                                            contentPadding: EdgeInsets.zero,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('raw_material')),
                                            onChanged: (value) {
                                              setState(() {
                                                rawMaterialValue = value!;
                                              });
                                              evaluatePrice();
                                            }),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isfeeequal001,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: CheckboxListTile(
                                            value: industrialValue,
                                            contentPadding: EdgeInsets.zero,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('industrial')),
                                            onChanged: (value) {
                                              setState(() {
                                                industrialValue = value!;
                                              });
                                              evaluatePrice();
                                            }),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isBrand,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: CheckboxListTile(
                                            value: brandValue,
                                            contentPadding: EdgeInsets.zero,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('isBrand')),
                                            onChanged: (value) {
                                              calculateExtrasPrice(1.5, value!);
                                              setState(() {
                                                brandValue = value;
                                              });
                                              evaluatePrice();
                                            }),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isTubes,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: CheckboxListTile(
                                            value: tubesValue,
                                            contentPadding: EdgeInsets.zero,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('isTubeValue')),
                                            onChanged: (value) {
                                              calculateExtrasPrice(.1, value!);
                                              setState(() {
                                                tubesValue = value;
                                              });
                                              evaluatePrice();
                                            }),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isColored,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: CheckboxListTile(
                                            value: colorValue,
                                            contentPadding: EdgeInsets.zero,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('isColored')),
                                            onChanged: (value) {
                                              calculateExtrasPrice(.1, value!);
                                              setState(() {
                                                colorValue = value;
                                              });
                                              evaluatePrice();
                                            }),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isLycra,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: CheckboxListTile(
                                            value: lycraValue,
                                            contentPadding: EdgeInsets.zero,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('isLycra')),
                                            onChanged: (value) {
                                              calculateExtrasPrice(.05, value!);
                                              setState(() {
                                                lycraValue = value;
                                              });
                                              evaluatePrice();
                                            }),
                                      ),
                                    ),
                                  ],
                                ),

                                BlocBuilder<FlagsBloc, FlagsState>(
                                  builder: (context, flagstate) {
                                    if (flagstate is FlagsLoadedSuccess) {
                                      return DropdownButtonHideUnderline(
                                        child: Focus(
                                          focusNode: _statenode,
                                          onFocusChange: (bool focus) {
                                            if (focus) {
                                              setSelectedPanel(2);
                                            }
                                          },
                                          child: DropdownButton2<Origin>(
                                            isExpanded: true,
                                            hint: Text(
                                              AppLocalizations.of(context)!
                                                  .translate('select_origin'),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: flagstate.origins
                                                .map((Origin item) =>
                                                    DropdownMenuItem<Origin>(
                                                      value: item,
                                                      child: SizedBox(
                                                        // width: 200,
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.network(
                                                              item.imageURL!,
                                                              height: 35.h,
                                                              width: 45.w,
                                                              placeholderBuilder:
                                                                  (context) =>
                                                                      Container(
                                                                height: 35.h,
                                                                width: 45.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 7),
                                                            Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                maxWidth: 280.w,
                                                              ),
                                                              child: Text(
                                                                item.label!,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                // maxLines: 2,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                          // subtitle: Text('\$${suggestion['price']}'),
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: selectedOrigin,
                                            onChanged: (Origin? value) {
                                              // setState(() {
                                              //   selectedOrigin = value;
                                              // });
                                              selectOrigin(value!);
                                            },
                                            dropdownSearchData:
                                                DropdownSearchData(
                                              searchController:
                                                  _originController,
                                              searchInnerWidgetHeight: 60,
                                              searchInnerWidget: Container(
                                                height: 60,
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 4,
                                                  right: 8,
                                                  left: 8,
                                                ),
                                                child: TextFormField(
                                                  expands: true,
                                                  maxLines: null,
                                                  controller: _originController,
                                                  onTap: () {
                                                    setSelectedPanel(2);

                                                    _originController
                                                            .selection =
                                                        TextSelection(
                                                            baseOffset: 0,
                                                            extentOffset:
                                                                _originController
                                                                    .value
                                                                    .text
                                                                    .length);
                                                  },
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText: AppLocalizations
                                                            .of(context)!
                                                        .translate(
                                                            'select_origin'),
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  onFieldSubmitted: (value) {
                                                    BlocProvider.of<
                                                                BottomNavBarCubit>(
                                                            context)
                                                        .emitShow();
                                                  },
                                                ),
                                              ),
                                              searchMatchFn:
                                                  (item, searchValue) {
                                                return item.value!.label!
                                                    .contains(searchValue);
                                              },
                                            ),
                                            onMenuStateChange: (isOpen) {
                                              if (isOpen) {
                                                setState(() {
                                                  _originController.clear();
                                                });
                                              }
                                            },
                                            barrierColor: Colors.black45,
                                            buttonStyleData: ButtonStyleData(
                                              height: 50,
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 9.0,
                                              ),

                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                                color: Colors.white,
                                              ),
                                              // elevation: 2,
                                            ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down_sharp,
                                              ),
                                              iconSize: 20,
                                              iconEnabledColor:
                                                  AppColor.AccentBlue,
                                              iconDisabledColor: Colors.grey,
                                            ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: Colors.white,
                                              ),
                                              scrollbarTheme:
                                                  ScrollbarThemeData(
                                                radius:
                                                    const Radius.circular(40),
                                                thickness:
                                                    MaterialStateProperty.all(
                                                        6),
                                                thumbVisibility:
                                                    MaterialStateProperty.all(
                                                        true),
                                              ),
                                            ),
                                            menuItemStyleData:
                                                const MenuItemStyleData(
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (flagstate
                                        is FlagsLoadingProgressState) {
                                      return const Center(
                                        child: LinearProgressIndicator(),
                                      );
                                    } else {
                                      return Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<FlagsBloc>(context)
                                                .add(FlagsLoadEvent());
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .translate('list_error'),
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              ),
                                              const Icon(
                                                Icons.refresh,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Visibility(
                                  visible: originerror,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate('select_origin_error'),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                Visibility(
                                  visible: originerror,
                                  child: const SizedBox(
                                    height: 24,
                                  ),
                                ),
                                Focus(
                                  focusNode: _nodeWeight,
                                  onFocusChange: (bool focus) {
                                    if (!focus) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<BottomNavBarCubit>(
                                              context)
                                          .emitShow();
                                      evaluatePrice();
                                    }
                                  },
                                  child: TextFormField(
                                    controller: _wieghtController,
                                    onTap: () {
                                      setSelectedPanel(2);

                                      BlocProvider.of<BottomNavBarCubit>(
                                              context)
                                          .emitHide();
                                      _wieghtController.selection =
                                          TextSelection(
                                              baseOffset: 0,
                                              extentOffset: _wieghtController
                                                  .value.text.length);
                                    },
                                    // focusNode: _nodeWeight,
                                    // enabled: !valueEnabled,
                                    scrollPadding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom +
                                            50),
                                    textInputAction: TextInputAction.done,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true, signed: true),
                                    inputFormatters: [
                                      DecimalFormatter(),
                                    ],
                                    style: const TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!
                                          .translate('weight'),
                                      suffixText: showunit ? wieghtUnit : "",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 11.0, horizontal: 9.0),
                                    ),
                                    onTapOutside: (event) {},
                                    onEditingComplete: () {
                                      evaluatePrice();
                                    },
                                    onChanged: (value) {
                                      if (_originController.text.isNotEmpty) {
                                        setState(() {
                                          originerror = false;
                                        });
                                        if (value.isNotEmpty) {
                                          // calculateTotalValueWithPrice(value);
                                          wieghtValue = double.parse(value);
                                        } else {
                                          wieghtValue = 0.0;
                                        }
                                        evaluatePrice();
                                      } else {
                                        setState(() {
                                          originerror = true;
                                        });
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .translate('insert_value_validate');
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      _wieghtController.text = newValue!;
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<BottomNavBarCubit>(
                                              context)
                                          .emitShow();
                                    },
                                  ),
                                ),

                                const SizedBox(
                                  height: 24,
                                ),
                                Focus(
                                  focusNode: _nodeValue,
                                  onFocusChange: (bool focus) {
                                    if (!focus) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<BottomNavBarCubit>(
                                              context)
                                          .emitShow();
                                      evaluatePrice();
                                    }
                                  },
                                  child: TextFormField(
                                    controller: _valueController,
                                    onTap: () {
                                      BlocProvider.of<BottomNavBarCubit>(
                                              context)
                                          .emitHide();
                                      _valueController.selection =
                                          TextSelection(
                                              baseOffset: 0,
                                              extentOffset: _valueController
                                                  .value.text.length);
                                    },
                                    // enabled: valueEnabled,
                                    textInputAction: TextInputAction.done,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true, signed: true),
                                    scrollPadding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom +
                                            50),
                                    inputFormatters: [
                                      DecimalFormatter(),
                                    ],
                                    style: const TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      labelText: valueEnabled
                                          ? AppLocalizations.of(context)!
                                              .translate(
                                                  'total_value_in_dollar')
                                          : AppLocalizations.of(context)!
                                              .translate('price_for_custome'),
                                      suffixText: "\$",
                                    ),
                                    onEditingComplete: () {
                                      evaluatePrice();
                                    },
                                    onChanged: (value) {
                                      if (_originController.text.isNotEmpty) {
                                        setState(() {
                                          originerror = false;
                                        });
                                        if (value.isNotEmpty) {
                                          basePrice = double.parse(value);
                                          // calculateTotalValue();
                                        } else {
                                          basePrice = 0.0;
                                          // calculateTotalValue();
                                        }
                                      } else {
                                        setState(() {
                                          originerror = true;
                                        });
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .translate('insert_value_validate');
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      _valueController.text = newValue!;
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<BottomNavBarCubit>(
                                              context)
                                          .emitShow();
                                    },
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 12,
                                // ),
                                // const Text(
                                //   "ملاحظة: الحد الأدنى للسعر الاسترشادي هو 100\$",
                                //   style: TextStyle(color: Colors.grey),
                                // ),
                                const SizedBox(
                                  height: 12,
                                ),

                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColor.lightGreen,
                                    border: Border.all(
                                        color: Colors.black26, width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.translate('convert_to_dollar_value')}: ${f.format(double.parse(syrianExchangeValue).toInt())}\$",
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                      Text(
                                        "${AppLocalizations.of(context)!.translate('total_value_in_eygptian_pound')}: ${f.format(double.parse(syrianTotalValue).toInt())} E.P",
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                      Text(
                                        "${AppLocalizations.of(context)!.translate('total_value_with_insurance')}: ${f.format(double.parse(totalValueWithEnsurance).toInt())} E.P",
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                      Divider(color: AppColor.deepYellow),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${AppLocalizations.of(context)!.translate('fees')} :  ",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.deepBlue,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200.w,
                                                child: BlocBuilder<
                                                    CalculateResultBloc,
                                                    CalculateResultState>(
                                                  builder: (context, state) {
                                                    if (state
                                                            is CalculateResultSuccessed &&
                                                        totalValueWithEnsurance !=
                                                            "0.0") {
                                                      return Text(
                                                        f.format(state
                                                            .result.finalTotal!
                                                            .toInt()),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      );
                                                    } else if (state
                                                        is CalculateResultLoading) {
                                                      return const LinearProgressIndicator();
                                                    } else {
                                                      return const Text(
                                                        " _ _ _ _ _  ",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          BlocBuilder<CalculateResultBloc,
                                              CalculateResultState>(
                                            builder: (context, state) {
                                              if (state
                                                      is CalculateResultSuccessed &&
                                                  totalValueWithEnsurance !=
                                                      "0.0") {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TraderCalculatorResultScreen(),
                                                      ),
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'fees_details'),
                                                          style: TextStyle(
                                                            color: AppColor
                                                                .lightBlue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                Visibility(
                                  visible:
                                      orderBrokerProvider.selectedStateError ||
                                          orderBrokerProvider
                                              .selectedRadioTileError ||
                                          calculatorError
                                  // packageError,
                                  ,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0,
                                        bottom: 8.0,
                                        right: 25.0,
                                        left: 25.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .translate(
                                                  'complete_blank_textfield'),
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // CustomButton(
                                    //   onTap: () {},
                                    //   color: AppColor.deepYellow,
                                    //   title: const SizedBox(
                                    //       width: 100, child: Center(child: Text("إلغاء"))),
                                    // ),
                                    BlocConsumer<CalculateResultBloc,
                                        CalculateResultState>(
                                      listener: (context, state) {
                                        if (state
                                            is CalculateResultSuccessed) {}
                                      },
                                      builder: (context, state) {
                                        if (state is CalculateResultLoading) {
                                          return CustomButton(
                                              title: SizedBox(
                                                  width: 250.w,
                                                  child: const Center(
                                                      child:
                                                          LoadingIndicator())),
                                              // color: AppColor.deepYellow,
                                              onTap: () {});
                                        }
                                        if (state is CalculateResultFailed) {
                                          return Text(state.error);
                                        } else {
                                          return CustomButton(
                                            title: SizedBox(
                                              width: 250.w,
                                              child: Center(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .translate('next'),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // color: AppColor.deepYellow,
                                            onTap: () {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              if (orderBrokerProvider
                                                  .selectedRadioTile
                                                  .isNotEmpty) {
                                                if (orderBrokerProvider
                                                            .selectedStateCustome !=
                                                        null &&
                                                    orderBrokerProvider
                                                            .selectedCustomeAgency !=
                                                        null) {
                                                  _ordercalformkey.currentState
                                                      ?.save();
                                                  if (_ordercalformkey
                                                      .currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      calculatorError = false;
                                                    });
                                                    if (selectedOrigin !=
                                                        null) {
                                                      if (selectedPackage !=
                                                          null) {
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         TraderAttachementScreen(
                                                        //       origin:
                                                        //           selectedOrigin!
                                                        //               .id!,
                                                        //       weight:
                                                        //           wieghtValue
                                                        //               .toInt(),
                                                        //       product:
                                                        //           selectedPackage!
                                                        //               .id,
                                                        //       price: int.parse(
                                                        //           syrianTotalValue),
                                                        //       taxes: int.parse(
                                                        //           totalValueWithEnsurance),
                                                        //       rawMaterial: result
                                                        //           .rawMaterial,
                                                        //       industrial: result
                                                        //           .industrial,
                                                        //     ),
                                                        //   ),
                                                        // );
                                                      } else {
                                                        setState(() {
                                                          feeerror = true;
                                                          calculatorError =
                                                              true;
                                                        });
                                                        setSelectedPanel(2);
                                                        Scrollable
                                                            .ensureVisible(
                                                          key3.currentContext!,
                                                          duration:
                                                              const Duration(
                                                            milliseconds: 500,
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      setState(() {
                                                        originerror = true;
                                                        calculatorError = true;
                                                      });
                                                      setSelectedPanel(2);
                                                      Scrollable.ensureVisible(
                                                        key3.currentContext!,
                                                        duration:
                                                            const Duration(
                                                          milliseconds: 500,
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    setSelectedPanel(2);

                                                    setState(() {
                                                      calculatorError = true;
                                                    });
                                                    Scrollable.ensureVisible(
                                                      key3.currentContext!,
                                                      duration: const Duration(
                                                        milliseconds: 500,
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  setSelectedPanel(1);

                                                  orderBrokerProvider
                                                      .setselectedStateError(
                                                          true);
                                                  Scrollable.ensureVisible(
                                                    key2.currentContext!,
                                                    duration: const Duration(
                                                      milliseconds: 500,
                                                    ),
                                                  );
                                                }
                                              } else {
                                                setSelectedPanel(0);
                                                orderBrokerProvider
                                                    .setSelectedRadioError(
                                                        true);
                                                Scrollable.ensureVisible(
                                                  key1.currentContext!,
                                                  duration: const Duration(
                                                    milliseconds: 500,
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                  ]),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
