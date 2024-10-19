import 'dart:async';

import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_multi_result_dart_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculator_panel_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_add_loading_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_select_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/flag_select_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/flags_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/stop_scroll_cubit.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/providers/fee_add_provider.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/helpers/formatter.dart';
import 'package:custome_mobile/views/screens/trader/trader_calculator_result_screen.dart';
// import 'package:custome_mobile/views/widgets/calculator_dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart' as intel;
import 'package:provider/provider.dart';

class TraderCalculatorMultiScreen extends StatefulWidget {
  TraderCalculatorMultiScreen({Key? key}) : super(key: key);

  @override
  State<TraderCalculatorMultiScreen> createState() =>
      _TraderCalculatorMultiScreenState();
}

class _TraderCalculatorMultiScreenState
    extends State<TraderCalculatorMultiScreen> {
  final GlobalKey<FormState> _calformkey = GlobalKey<FormState>();

  bool publicOriginError = false;
  bool publicPackageError = false;
  List<Package?> packages = [];
  Origin? source;
  List<Origin?> origins = [];

  List<TextEditingController> packageControllers = [];

  List<TextEditingController> originControllers = [];

  List<TextEditingController> weightControllers = [];

  List<TextEditingController> valueControllers = [];

  List<bool> allowexports = [];
  List<bool> feeerrors = [];
  List<bool> isdropdownVisibles = [];
  List<String> placeholders = [];
  List<List<Extras>> extraslist = [];
  List<Extras?> extraselectedValues = [];
  List<bool> isfeeequal001 = [];
  List<bool> rawMaterialValues = [];
  List<bool> industrialValues = [];
  List<bool> isBrands = [];
  List<bool> brandValus = [];
  List<bool> isTubes = [];
  List<bool> tubeValus = [];
  List<bool> isColored = [];
  List<bool> colorValus = [];
  List<bool> isLycra = [];
  List<bool> lycraValus = [];
  List<double> extraPrices = [];
  List<bool> originerrors = [];
  List<bool> doubleoriginerrors = [];
  List<bool> showunits = [];
  List<String> weightUnits = [];
  List<int> weightValues = [];
  List<double> basePriceValues = [];
  List<bool> valueEnabled = [];
  List<String> syrianExchangeValue = [];
  List<String> syrianTotalValue = [];
  List<String> totalValueWithEnsurance = [];
  String totalsyrianExchangeValue = "8585";
  String totalsyrianTotalValue = "0.0";
  String totalTotalValueWithEnsurance = "0.0";
  List<String> weightLabels = [];

  List<CalculateObject> objects = [];
  List<Widget> _children = [];
  List<int> _childrencount = [];

  bool commodity_panel_loading = false;
  int _count = 0;
  int _countselected = 0;
  bool sourceselect = false;
  var f = intel.NumberFormat("#,###", "en_US");

  int agencyId = 0;
  int selectedPanel = -1;
  bool showtypeError = false;
  bool calculatorError = false;
  bool packageError = false;
  String statePlaceholder = "اختر مديرية";
  String agencyPlaceholder = "اختر أمانة";
  String originPlaceholder = "اختر المنشأ";

  String patternString = "";
  late final KeyboardVisibilityController _keyboardVisibilityController;
  late StreamSubscription<bool> keyboardSubscription;
  TextEditingController sourceControllers = TextEditingController();

  FeeAddProvider? feeAddProvider;

  final FocusNode _nodeWeight = FocusNode();
  final FocusNode _nodeValue = FocusNode();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FeeAddLoadingBloc>(context).add(FeeLoadingProgressEvent());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TextEditingController package_controller = TextEditingController();
      TextEditingController weight_controller = TextEditingController();
      TextEditingController value_controller = TextEditingController();
      TextEditingController origin_controller = TextEditingController();
      package_controller.text = "";
      packageControllers.add(package_controller);
      weightControllers.add(weight_controller);
      valueControllers.add(value_controller);
      originControllers.add(origin_controller);
      packages.add(null);
      origins.add(null);
      allowexports.add(false);
      feeerrors.add(false);
      isdropdownVisibles.add(false);
      placeholders.add("");
      extraslist.add([]);
      extraselectedValues.add(null);
      isfeeequal001.add(false);
      rawMaterialValues.add(false);
      industrialValues.add(false);
      isBrands.add(false);
      brandValus.add(false);
      isTubes.add(false);
      tubeValus.add(false);
      isColored.add(false);
      colorValus.add(false);
      isLycra.add(false);
      lycraValus.add(false);
      extraPrices.add(0.0);
      originerrors.add(false);
      doubleoriginerrors.add(false);
      showunits.add(false);
      weightUnits.add("kg");
      weightLabels.add("kg");
      weightValues.add(0);
      basePriceValues.add(0);
      valueEnabled.add(false);
      syrianExchangeValue.add("8585");
      syrianTotalValue.add("0.0");
      totalValueWithEnsurance.add("0.0");

      setState(() {
        _count++;
      });
    });

    BlocProvider.of<FeeAddLoadingBloc>(context).add(FeeIdleProgressEvent());
    // FocusScope.of(context).unfocus();
  }

  void _add() {
    TextEditingController package_controller = TextEditingController();
    TextEditingController weight_controller = TextEditingController();
    TextEditingController value_controller = TextEditingController();
    TextEditingController origin_controller = TextEditingController();
    package_controller.text = "";
    packageControllers.add(package_controller);
    weightControllers.add(weight_controller);
    valueControllers.add(value_controller);
    originControllers.add(origin_controller);
    packages.add(null);
    origins.add(null);
    allowexports.add(false);
    feeerrors.add(false);
    isdropdownVisibles.add(false);
    placeholders.add("");
    extraslist.add([]);
    extraselectedValues.add(null);
    isfeeequal001.add(false);
    rawMaterialValues.add(false);
    industrialValues.add(false);
    isBrands.add(false);
    brandValus.add(false);
    isTubes.add(false);
    tubeValus.add(false);
    isColored.add(false);
    colorValus.add(false);
    isLycra.add(false);
    lycraValus.add(false);
    extraPrices.add(0.0);
    originerrors.add(false);
    doubleoriginerrors.add(false);
    showunits.add(false);
    weightUnits.add("kg");
    weightLabels.add("kg");
    weightValues.add(0);
    basePriceValues.add(0);
    valueEnabled.add(false);
    syrianExchangeValue.add("8585");
    syrianTotalValue.add("0.0");
    totalValueWithEnsurance.add("0.0");

    setState(() {
      _count++;
    });
  }

  void remove(int index) {
    BlocProvider.of<FeeAddLoadingBloc>(context).add(FeeLoadingProgressEvent());

    packageControllers.removeAt(index);
    weightControllers.removeAt(index);
    valueControllers.removeAt(index);
    originControllers.removeAt(index);
    packages.removeAt(index);
    origins.removeAt(index);
    allowexports.removeAt(index);
    feeerrors.removeAt(index);
    isdropdownVisibles.removeAt(index);
    placeholders.removeAt(index);
    extraslist.removeAt(index);
    extraselectedValues.removeAt(index);
    isfeeequal001.removeAt(index);
    rawMaterialValues.removeAt(index);
    industrialValues.removeAt(index);
    isBrands.removeAt(index);
    brandValus.removeAt(index);
    isTubes.removeAt(index);
    tubeValus.removeAt(index);
    isColored.removeAt(index);
    colorValus.removeAt(index);
    isLycra.removeAt(index);
    lycraValus.removeAt(index);
    extraPrices.removeAt(index);
    originerrors.removeAt(index);
    doubleoriginerrors.removeAt(index);
    showunits.removeAt(index);
    weightUnits.removeAt(index);
    weightLabels.removeAt(index);
    weightValues.removeAt(index);
    basePriceValues.removeAt(index);
    valueEnabled.removeAt(index);
    syrianExchangeValue.removeAt(index);
    syrianTotalValue.removeAt(index);
    totalValueWithEnsurance.removeAt(index);

    setState(() {
      _count--;
    });
    BlocProvider.of<FeeAddLoadingBloc>(context).add(FeeIdleProgressEvent());
  }

  void calculateTotalValueWithPrice(int index) {
    print(weightValues[index]);
    print(basePriceValues[index]);
    var syrianExch = weightValues[index] * basePriceValues[index];
    var syrianTotal = syrianExch * 8585;
    var totalEnsurance = syrianTotal + (syrianTotal * 0.0012);

    var totalsyrian = 0;
    var totalinsurance = 0;

    syrianExchangeValue[index] = syrianExch.round().toString();
    syrianTotalValue[index] = syrianTotal.round().toString();
    totalValueWithEnsurance[index] = totalEnsurance.round().toString();
    print(totalValueWithEnsurance[index]);

    for (var i = 0; i < totalValueWithEnsurance.length; i++) {
      totalsyrian += int.parse(syrianTotalValue[i]);
      totalinsurance += int.parse(totalValueWithEnsurance[i]);
    }
    setState(() {
      totalsyrianTotalValue = totalsyrian.toString();
      totalTotalValueWithEnsurance = totalinsurance.toString();
    });
    print(totalsyrianTotalValue);
  }

  void calculateTotalValue(int index) {
    var syrianTotal =
        double.parse(valueControllers[index].text.replaceAll(",", "")) * 8585;
    print(syrianTotal);
    var totalEnsurance = syrianTotal + (syrianTotal * 0.0012);
    var totalsyrian = 0;
    var totalinsurance = 0;
    syrianTotalValue[index] = syrianTotal.round().toString();
    totalValueWithEnsurance[index] = totalEnsurance.round().toString();
    for (var i = 0; i < totalValueWithEnsurance.length; i++) {
      totalsyrian += int.parse(syrianTotalValue[i]);
      totalinsurance += int.parse(totalValueWithEnsurance[i]);
    }

    totalsyrianTotalValue = totalsyrian.toString();
    totalTotalValueWithEnsurance = totalinsurance.toString();
    setState(() {});
  }

  String showLabel(String unit, String lang) {
    switch (unit) {
      case "كغ":
        return lang == 'en' ? "Weight" : "الوزن";

      case "طن":
        return lang == 'en' ? "Weight" : "الوزن";

      case "قيراط":
        return lang == 'en' ? "Weight" : "الوزن";

      case "  كيلو واط بالساعة 1000":
        return lang == 'en' ? "Power" : "الاستطاعة";

      case "  الاستطاعة بالطن":
        return lang == 'en' ? "Power" : "الاستطاعة";

      case "واط":
        return lang == 'en' ? "Power" : "الاستطاعة";

      case "عدد الأزواج":
        return lang == 'en' ? "Quantity" : "العدد";

      case "عدد":
        return lang == 'en' ? "Quantity" : "العدد";

      case "طرد":
        return lang == 'en' ? "Quantity" : "العدد";

      case "قدم":
        return lang == 'en' ? "Length" : "الطول";

      case "متر":
        return lang == 'en' ? "Length" : "الطول";

      case "متر مربع":
        return lang == 'en' ? "Area" : "المساحة";

      case "متر مكعب":
        return lang == 'en' ? "Volume" : "الحجم";

      case "لتر":
        return lang == 'en' ? "Capacity" : "السعة";

      default:
        return lang == 'en' ? "Weight" : "الوزن";
    }
  }

  String showUnit(String unit, String lang) {
    switch (unit) {
      case "كغ":
        return lang == 'en' ? "kg" : "كغ";

      case "طن":
        return lang == 'en' ? "ton" : "طن";

      case "قيراط":
        return lang == 'en' ? "oz" : "قيراط";

      case "  كيلو واط بالساعة 1000":
        return lang == 'en' ? "k watts" : "واط";

      case "  الاستطاعة بالطن":
        return lang == 'en' ? "power" : "الاستطاعة";

      case "واط":
        return lang == 'en' ? "watts" : "واط";

      case "عدد الأزواج":
        return lang == 'en' ? "num" : "عدد الأزواج";

      case "عدد":
        return lang == 'en' ? "num" : "عدد";

      case "طرد":
        return lang == 'en' ? "package" : "طرد";

      case "قدم":
        return lang == 'en' ? "feet" : "قدم";

      case "متر":
        return lang == 'en' ? "metre" : "متر";

      case "متر مربع":
        return lang == 'en' ? "metre square" : "م2";

      case "متر مكعب":
        return lang == 'en' ? "metre cube" : "م3";

      case "لتر":
        return lang == 'en' ? "litre" : "لتر";

      default:
        return lang == 'en' ? "kg" : "كغ";
    }
  }

  void selectSuggestion(Package suggestion, String lang, int index) {
    packages[index] = suggestion;
    feeerrors[index] = false;
    if (suggestion.price! > 0) {
      basePriceValues[index] = suggestion.price!;
      valueEnabled[index] = true;
    } else {
      basePriceValues[index] = 0.0;
      valueEnabled[index] = false;
      syrianExchangeValue[index] = "8585";
    }

    if (suggestion.extras!.isNotEmpty) {
      if (suggestion.extras![0].brand!) {
        isBrands[index] = true;
        brandValus[index] = false;
      } else {
        isBrands[index] = false;
        brandValus[index] = false;
      }

      if (suggestion.extras![0].tubes!) {
        isTubes[index] = true;
        tubeValus[index] = false;
      } else {
        isTubes[index] = false;
        tubeValus[index] = false;
      }

      if (suggestion.extras![0].lycra!) {
        isLycra[index] = true;
        lycraValus[index] = false;
      } else {
        isLycra[index] = false;
        lycraValus[index] = false;
      }

      if (suggestion.extras![0].coloredThread!) {
        isColored[index] = true;
        colorValus[index] = false;
      } else {
        isColored[index] = false;
        colorValus[index] = false;
      }
    }

    if (suggestion.unit!.isNotEmpty) {
      switch (suggestion.unit) {
        case "كغ":
          weightLabels[index] = lang == 'en' ? "weight" : "الوزن";

          break;
        case "طن":
          weightLabels[index] = lang == 'en' ? "weight" : "الوزن";

          break;
        case "قيراط":
          weightLabels[index] = lang == 'en' ? "weight" : "الوزن";

          break;
        case "  كيلو واط بالساعة 1000":
          weightLabels[index] = lang == 'en' ? "power" : "الاستطاعة";

          break;
        case "  الاستطاعة بالطن":
          weightLabels[index] = lang == 'en' ? "power" : "الاستطاعة";

          break;
        case "واط":
          weightLabels[index] = lang == 'en' ? "power" : "الاستطاعة";

          break;
        case "عدد الأزواج":
          weightLabels[index] = lang == 'en' ? "number" : "العدد";

          break;
        case "عدد":
          weightLabels[index] = lang == 'en' ? "number" : "العدد";

          break;
        case "طرد":
          weightLabels[index] = lang == 'en' ? "number" : "العدد";

          break;
        case "قدم":
          weightLabels[index] = lang == 'en' ? "number" : "العدد";

          break;
        case "متر":
          weightLabels[index] = lang == 'en' ? "volume" : "الحجم";

          break;
        case "متر مربع":
          weightLabels[index] = lang == 'en' ? "volume" : "الحجم";

          break;
        case "متر مكعب":
          weightLabels[index] = lang == 'en' ? "volume" : "الحجم";

          break;
        case "لتر":
          weightLabels[index] = lang == 'en' ? "capacity" : "السعة";

          break;
        default:
          weightLabels[index] = lang == 'en' ? "weight" : "الوزن";
      }
      weightUnits[index] = suggestion.unit!;
      showunits[index] = true;
    } else {
      weightUnits[index] = "";
      showunits[index] = false;
    }

    if (suggestion.placeholder != "") {
      placeholders[index] = suggestion.placeholder!;
      isdropdownVisibles[index] = false;
      extraslist[index] = suggestion.extras!;
      isdropdownVisibles[index] = true;
    } else {
      isdropdownVisibles[index] = false;
      placeholders[index] = "";
      extraslist[index] = [];
    }

    if (suggestion.fee! == 0.01) {
      isfeeequal001[index] = true;
    } else {
      isfeeequal001[index] = false;
    }

    switch (suggestion.export1) {
      case "0":
        allowexports[index] = true;

        break;
      case "1":
        allowexports[index] = false;

        break;
      default:
    }
    evaluatePrice(index);
    setState(() {});
  }

  void selectOrigin(Origin origin, int index) {
    origins[index] = origin;
    originerrors[index] = false;

    if (packages[index]!.extras!.isNotEmpty) {
      outerLoop:
      for (var element in packages[index]!.extras!) {
        for (var element1 in origin.countryGroups!) {
          if (element.countryGroup!.contains(element1)) {
            if (element.price! > 0) {
              basePriceValues[index] = element.price!;
              valueEnabled[index] = false;

              break outerLoop;
            }
          } else {
            valueEnabled[index] = true;
            syrianExchangeValue[index] = "8585";
            basePriceValues[index] = 0.0;
          }
        }
      }
      if (origin.countryGroups!.isEmpty) {
        basePriceValues[index] = 0.0;
        valueEnabled[index] = true;
        syrianExchangeValue[index] = "8585";
      }
    }
    evaluatePrice(index);
    setState(() {});
  }

  void calculateExtrasPrice(double percentage, bool add, int index) {
    extraPrices[index] = 0.0;
    if (add) {
      extraPrices[index] = double.parse(valueControllers[index].text) +
          (basePriceValues[index] * percentage);
    } else {
      extraPrices[index] = double.parse(valueControllers[index].text) -
          (basePriceValues[index] * percentage);
    }
    valueControllers[index].text = extraPrices[index].toString();
    setState(() {});
  }

  void evaluatePrice(int index) {
    if (origins[index] != null &&
        packages[index] != null &&
        (valueControllers[index].text.isNotEmpty &&
            valueControllers[index].text != "0.0") &&
        (weightControllers[index].text.isNotEmpty &&
            weightControllers[index].text != "0.0")) {
      print("asd");
      if (!valueEnabled[index]) {
        calculateTotalValue(index);
      } else {
        calculateTotalValueWithPrice(index);
      }
      // calculateTheFees(index);
    }
  }

  void calculateTheFees(int index) {
    _calformkey.currentState?.save();
    if (_calformkey.currentState!.validate()) {
      setState(() {
        packageError = false;
      });
      for (var i = 0; i < origins.length; i++) {
        if (origins[i] != null) {
          publicOriginError = false;
          originerrors[i] = false;
        } else {
          originerrors[i] = true;
          publicOriginError = true;
        }
      }
      // List<CalculateObject> objects = [];
      objects = [];
      if (!publicOriginError && !publicPackageError) {
        print("asd4");
        for (var i = 0; i < packages.length; i++) {
          objects.add(CalculateObject());
          objects[i].insurance = int.parse(totalValueWithEnsurance[i]);
          objects[i].fee = packages[i]!.fee;
          objects[i].rawMaterial = rawMaterialValues[i] ? 1 : 0;
          objects[i].industrial = industrialValues[i] ? 1 : 0;
          objects[i].totalTax = packages[i]!.totalTaxes!.totalTax;
          objects[i].partialTax = packages[i]!.totalTaxes!.partialTax;
          objects[i].origin = origins[i]!.label;
          objects[i].source = sourceControllers.text;
          objects[i].spendingFee = packages[i]!.spendingFee;
          objects[i].supportFee = packages[i]!.supportFee;
          objects[i].localFee = packages[i]!.localFee;
          objects[i].protectionFee = packages[i]!.protectionFee;
          objects[i].naturalFee = packages[i]!.naturalFee;
          objects[i].taxFee = packages[i]!.taxFee;
          objects[i].weight = weightValues[i];
          objects[i].price = basePriceValues[i].toInt();
          objects[i].cnsulate = 1;
          objects[i].dolar = 8585;
          objects[i].arabic_stamp =
              packages[i]!.totalTaxes!.arabicStamp!.toInt();
          objects[i].import_fee = packages[i]!.importFee!;
        }
        BlocProvider.of<CalculateMultiResultBloc>(context)
            .add(CalculateMultiTheResultEvent(objects));
        // FocusManager.instance.primaryFocus?.unfocus();
        // BlocProvider.of<BottomNavBarCubit>(context).emitShow();
      }
    }
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  Future<void> _showAlertDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Delete commodity'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to delete this commodity?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                remove(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[100],
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: BlocBuilder<StopScrollCubit, StopScrollState>(
                      builder: (context, state) {
                        return SingleChildScrollView(
                          physics: (state is ScrollEnabled)
                              ? const ClampingScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          child: GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              BlocProvider.of<BottomNavBarCubit>(context)
                                  .emitShow();
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  BlocListener<FeeSelectBloc, FeeSelectState>(
                                    listener: (context, state) {
                                      if (state is FeeSelectSuccess) {
                                        setState(() {
                                          weightControllers[_countselected]
                                              .text = "0.0";
                                          valueControllers[_countselected]
                                              .text = "0.0";

                                          // calculatorProvider.initProvider();
                                        });
                                        selectSuggestion(
                                            state.package,
                                            localeState.value.languageCode,
                                            _countselected);
                                        setState(() {
                                          packageControllers[_countselected]
                                                  .text =
                                              packages[_countselected]!.label!;
                                          valueControllers[_countselected]
                                                  .text =
                                              basePriceValues[_countselected]
                                                  .toString();
                                        });
                                      }
                                    },
                                    child: BlocListener<FlagSelectBloc,
                                        FlagSelectState>(
                                      listener: (context, flagselectstate) {
                                        if (flagselectstate
                                            is FlagSelectSuccess) {
                                          print(
                                              "flagselectstate.origin.label!");
                                          print(flagselectstate.origin.label!);
                                          if (sourceselect) {
                                            setState(
                                              () {
                                                source = flagselectstate.origin;
                                                sourceControllers.text =
                                                    flagselectstate
                                                        .origin.label!;
                                              },
                                            );
                                          } else {
                                            setState(
                                              () {
                                                origins[_countselected] =
                                                    flagselectstate.origin;
                                                originControllers[
                                                            _countselected]
                                                        .text =
                                                    flagselectstate
                                                        .origin.label!;
                                              },
                                            );
                                            selectOrigin(flagselectstate.origin,
                                                _countselected);
                                            var originCount = 0;
                                            for (var i = 0;
                                                i < origins.length;
                                                i++) {
                                              if (origins[i] ==
                                                      flagselectstate.origin &&
                                                  packageControllers[i].text ==
                                                      packageControllers[
                                                              _countselected]
                                                          .text) {
                                                originCount++;
                                              }
                                            }

                                            if (originCount > 1) {
                                              setState(
                                                () {
                                                  doubleoriginerrors[
                                                      _countselected] = true;
                                                },
                                              );
                                            } else {
                                              setState(
                                                () {
                                                  doubleoriginerrors[
                                                      _countselected] = false;
                                                },
                                              );
                                            }
                                          }
                                        }
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          BlocProvider.of<BottomNavBarCubit>(
                                                  context)
                                              .emitShow();
                                        },
                                        child: Form(
                                          key: _calformkey,
                                          child: Column(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: _count,
                                                itemBuilder: (context, index) {
                                                  return Stack(
                                                    children: [
                                                      Card(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                          vertical: 5,
                                                          // horizontal: 5,
                                                        ),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                side:
                                                                    BorderSide(
                                                                  color: doubleoriginerrors[
                                                                          index]
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .white,
                                                                  width: 1,
                                                                )),
                                                        elevation: 1,
                                                        color: Colors.white,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 8.0,
                                                                horizontal:
                                                                    16.0,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            35,
                                                                      ),
                                                                      Focus(
                                                                        // focusNode: _ordernode,
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .translate('goods_details'),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                19,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                AppColor.deepBlue,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      // GestureDetector(
                                                                      //   onTap: () {
                                                                      //     BlocProvider.of<
                                                                      //                 CalculatorPanelBloc>(
                                                                      //             context)
                                                                      //         .add(
                                                                      //             TariffPanelOpenEvent());

                                                                      //     FocusManager.instance
                                                                      //         .primaryFocus
                                                                      //         ?.unfocus();
                                                                      //     BlocProvider.of<
                                                                      //                 BottomNavBarCubit>(
                                                                      //             context)
                                                                      //         .emitShow();
                                                                      //     _countselected =
                                                                      //         index;
                                                                      //   },
                                                                      //   child: SizedBox(
                                                                      //     height: 40.h,
                                                                      //     child: Row(
                                                                      //       mainAxisAlignment:
                                                                      //           MainAxisAlignment
                                                                      //               .end,
                                                                      //       children: [
                                                                      //         SizedBox(
                                                                      //           width: 25.w,
                                                                      //           height: 25.h,
                                                                      //           child:
                                                                      //               SvgPicture
                                                                      //                   .asset(
                                                                      //             "assets/icons/tarrif_btn.svg",
                                                                      //           ),
                                                                      //         ),
                                                                      //         const SizedBox(
                                                                      //           width: 3,
                                                                      //         ),
                                                                      //         Text(
                                                                      //           AppLocalizations.of(
                                                                      //                   context)!
                                                                      //               .translate(
                                                                      //                   'tariff_browser'),
                                                                      //           textAlign:
                                                                      //               TextAlign
                                                                      //                   .center,
                                                                      //           style:
                                                                      //               TextStyle(
                                                                      //             color: AppColor
                                                                      //                 .lightBlue,
                                                                      //             fontSize:
                                                                      //                 15.sp,
                                                                      //             fontWeight:
                                                                      //                 FontWeight
                                                                      //                     .bold,
                                                                      //           ),
                                                                      //         ),
                                                                      //       ],
                                                                      //     ),
                                                                      //   ),
                                                                      // ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          BlocProvider.of<CalculatorPanelBloc>(context)
                                                                              .add(TariffPanelOpenEvent());
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                          BlocProvider.of<BottomNavBarCubit>(context)
                                                                              .emitShow();
                                                                          _countselected =
                                                                              index;
                                                                        },
                                                                        child:
                                                                            TypeAheadField(
                                                                          textFieldConfiguration:
                                                                              TextFieldConfiguration(
                                                                            // autofocus: true,
                                                                            keyboardType:
                                                                                TextInputType.multiline,
                                                                            maxLines:
                                                                                null,
                                                                            enabled:
                                                                                false,
                                                                            controller:
                                                                                packageControllers[index],

                                                                            scrollPadding:
                                                                                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 150),
                                                                            style:
                                                                                TextStyle(fontSize: 18, color: originControllers[index].text.isNotEmpty ? AppColor.deepBlue : Colors.grey[600]!),
                                                                            onTap:
                                                                                () {},
                                                                            decoration:
                                                                                InputDecoration(
                                                                              // labelText:
                                                                              //     AppLocalizations.of(context)!.translate('goods_name'),
                                                                              // hintText:
                                                                              //     AppLocalizations.of(context)!.translate('goods_name'),
                                                                              contentPadding: const EdgeInsets.symmetric(
                                                                                horizontal: 9.0,
                                                                                vertical: 11.0,
                                                                              ),
                                                                              prefixIcon: packageControllers[index].text == ""
                                                                                  ? SizedBox(
                                                                                      width: 130.w,
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: 21.w,
                                                                                            height: 21.h,
                                                                                            child: SvgPicture.asset(
                                                                                              "assets/icons/tarrif_btn.svg",
                                                                                            ),
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            width: 3,
                                                                                          ),
                                                                                          FittedBox(
                                                                                            fit: BoxFit.scaleDown,
                                                                                            child: Text(
                                                                                              AppLocalizations.of(context)!.translate('tariff_browser'),
                                                                                              textAlign: TextAlign.center,
                                                                                              style: TextStyle(
                                                                                                color: AppColor.lightBlue,
                                                                                                fontSize: 15.sp,
                                                                                                fontWeight: FontWeight.bold,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            width: 3,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  : const SizedBox.shrink(),
                                                                            ),
                                                                            onSubmitted:
                                                                                (value) {
                                                                              BlocProvider.of<StopScrollCubit>(context).emitEnable();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                              BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                                                                            },
                                                                          ),
                                                                          loadingBuilder:
                                                                              (context) {
                                                                            return Container(
                                                                              color: Colors.white,
                                                                              child: const Center(
                                                                                child: LoadingIndicator(),
                                                                              ),
                                                                            );
                                                                          },
                                                                          errorBuilder:
                                                                              (context, error) {
                                                                            return Container(
                                                                              color: Colors.white,
                                                                            );
                                                                          },
                                                                          noItemsFoundBuilder:
                                                                              (value) {
                                                                            var localizedMessage =
                                                                                AppLocalizations.of(context)!.translate('no_result_found');
                                                                            return Container(
                                                                              width: double.infinity,
                                                                              color: Colors.white,
                                                                              child: Center(
                                                                                child: Text(
                                                                                  localizedMessage,
                                                                                  style: TextStyle(fontSize: 18.sp),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          suggestionsCallback:
                                                                              (pattern) async {
                                                                            return [];
                                                                          },
                                                                          itemBuilder:
                                                                              (context, suggestion) {
                                                                            return Container();
                                                                          },
                                                                          onSuggestionSelected:
                                                                              (suggestion) {},
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 14,
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        allowexports[
                                                                            index],
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .translate(
                                                                              'fee_import_banned'),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            13,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        allowexports[
                                                                            index],
                                                                    child:
                                                                        const SizedBox(
                                                                      height:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        feeerrors[
                                                                            index],
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .translate(
                                                                              'select_fee_error'),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            13,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        feeerrors[
                                                                            index],
                                                                    child:
                                                                        const SizedBox(
                                                                      height:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        isdropdownVisibles[
                                                                            index],
                                                                    child:
                                                                        DropdownButtonHideUnderline(
                                                                      child: DropdownButton2<
                                                                          Extras>(
                                                                        isExpanded:
                                                                            true,
                                                                        barrierLabel:
                                                                            placeholders[index],
                                                                        hint:
                                                                            Text(
                                                                          placeholders[
                                                                              index],
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Theme.of(context).hintColor,
                                                                          ),
                                                                        ),
                                                                        items: extraslist[
                                                                                index]
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
                                                                        value: extraselectedValues[
                                                                            index],
                                                                        onChanged:
                                                                            (Extras?
                                                                                value) {
                                                                          if (value!
                                                                              .countryGroup!
                                                                              .isEmpty) {
                                                                            if (value.price! >
                                                                                0) {
                                                                              basePriceValues[index] = value.price!;
                                                                              valueEnabled[index] = false;
                                                                              setState(() {
                                                                                valueControllers[index].text = basePriceValues[index].toString();
                                                                              });
                                                                            } else {
                                                                              basePriceValues[index] = 0.0;
                                                                              valueControllers[index].text = "0.0";
                                                                              valueEnabled[0] = true;
                                                                              setState(
                                                                                () {
                                                                                  valueControllers[index].text = "0.0";
                                                                                },
                                                                              );
                                                                            }
                                                                            evaluatePrice(index);
                                                                          } else {
                                                                            if (value.price! >
                                                                                0) {
                                                                              basePriceValues[index] = value.price!;
                                                                              valueEnabled[index] = false;

                                                                              setState(
                                                                                () {
                                                                                  valueControllers[index].text = value.price!.toString();
                                                                                },
                                                                              );
                                                                            } else {
                                                                              basePriceValues[index] = 0.0;
                                                                              valueEnabled[index] = true;
                                                                              setState(
                                                                                () {
                                                                                  valueControllers[index].text = "0.0";
                                                                                },
                                                                              );
                                                                            }
                                                                            evaluatePrice(index);
                                                                          }
                                                                          extraselectedValues[index] =
                                                                              value;
                                                                        },
                                                                        buttonStyleData:
                                                                            ButtonStyleData(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              double.infinity,

                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                9.0,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(12),
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.black26,
                                                                            ),
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          // elevation: 2,
                                                                        ),
                                                                        iconStyleData:
                                                                            const IconStyleData(
                                                                          icon:
                                                                              Icon(
                                                                            Icons.keyboard_arrow_down_sharp,
                                                                          ),
                                                                          iconSize:
                                                                              20,
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
                                                                                BorderRadius.circular(14),
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          scrollbarTheme:
                                                                              ScrollbarThemeData(
                                                                            radius:
                                                                                const Radius.circular(40),
                                                                            thickness:
                                                                                MaterialStateProperty.all(6),
                                                                            thumbVisibility:
                                                                                MaterialStateProperty.all(true),
                                                                          ),
                                                                        ),
                                                                        menuItemStyleData:
                                                                            MenuItemStyleData(
                                                                          height:
                                                                              50.h,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        isdropdownVisibles[
                                                                            index],
                                                                    child:
                                                                        const SizedBox(
                                                                      height:
                                                                          24,
                                                                    ),
                                                                  ),
                                                                  Wrap(
                                                                    children: [
                                                                      Visibility(
                                                                        visible:
                                                                            isfeeequal001[index],
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .4,
                                                                          child: CheckboxListTile(
                                                                              value: rawMaterialValues[index],
                                                                              contentPadding: EdgeInsets.zero,
                                                                              controlAffinity: ListTileControlAffinity.leading,
                                                                              title: FittedBox(
                                                                                fit: BoxFit.scaleDown,
                                                                                child: Text(AppLocalizations.of(context)!.translate('raw_material')),
                                                                              ),
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  rawMaterialValues[index] = value!;
                                                                                });
                                                                                evaluatePrice(index);
                                                                              }),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            isfeeequal001[index],
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .4,
                                                                          child: CheckboxListTile(
                                                                              value: industrialValues[index],
                                                                              contentPadding: EdgeInsets.zero,
                                                                              controlAffinity: ListTileControlAffinity.leading,
                                                                              title: FittedBox(
                                                                                fit: BoxFit.scaleDown,
                                                                                child: Text(AppLocalizations.of(context)!.translate('industrial')),
                                                                              ),
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  industrialValues[index] = value!;
                                                                                });
                                                                                evaluatePrice(index);
                                                                              }),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            isBrands[index],
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .4,
                                                                          child: CheckboxListTile(
                                                                              value: brandValus[index],
                                                                              contentPadding: EdgeInsets.zero,
                                                                              controlAffinity: ListTileControlAffinity.leading,
                                                                              title: FittedBox(
                                                                                fit: BoxFit.scaleDown,
                                                                                child: Text(AppLocalizations.of(context)!.translate('isBrand')),
                                                                              ),
                                                                              onChanged: (value) {
                                                                                calculateExtrasPrice(1.5, value!, index);
                                                                                valueControllers[index].text = extraPrices[index].toString();
                                                                                brandValus[index] = value!;
                                                                                evaluatePrice(index);
                                                                              }),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            isTubes[index],
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .4,
                                                                          child: CheckboxListTile(
                                                                              value: tubeValus[index],
                                                                              contentPadding: EdgeInsets.zero,
                                                                              controlAffinity: ListTileControlAffinity.leading,
                                                                              title: FittedBox(
                                                                                fit: BoxFit.scaleDown,
                                                                                child: Text(AppLocalizations.of(context)!.translate('isTubeValue')),
                                                                              ),
                                                                              onChanged: (value) {
                                                                                calculateExtrasPrice(.1, value!, index);
                                                                                valueControllers[index].text = extraPrices[index].toString();
                                                                                tubeValus[index] = value!;
                                                                                evaluatePrice(index);
                                                                              }),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            isColored[index],
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .4,
                                                                          child:
                                                                              CheckboxListTile(
                                                                            value:
                                                                                colorValus[index],
                                                                            contentPadding:
                                                                                EdgeInsets.zero,
                                                                            controlAffinity:
                                                                                ListTileControlAffinity.leading,
                                                                            title:
                                                                                FittedBox(
                                                                              fit: BoxFit.scaleDown,
                                                                              child: Text(AppLocalizations.of(context)!.translate('isColored')),
                                                                            ),
                                                                            onChanged:
                                                                                (value) {
                                                                              calculateExtrasPrice(.1, value!, index);
                                                                              valueControllers[index].text = extraPrices[index].toString();
                                                                              colorValus[index] = value!;
                                                                              evaluatePrice(index);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            isLycra[index],
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .4,
                                                                          child:
                                                                              CheckboxListTile(
                                                                            value:
                                                                                lycraValus[index],
                                                                            contentPadding:
                                                                                EdgeInsets.zero,
                                                                            controlAffinity:
                                                                                ListTileControlAffinity.leading,
                                                                            title:
                                                                                FittedBox(
                                                                              fit: BoxFit.scaleDown,
                                                                              child: Text(AppLocalizations.of(context)!.translate('isLycra')),
                                                                            ),
                                                                            onChanged:
                                                                                (value) {
                                                                              calculateExtrasPrice(.05, value!, index);
                                                                              valueControllers[index].text = extraPrices[index].toString();
                                                                              lycraValus[index] = value!;

                                                                              evaluatePrice(index);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        index ==
                                                                            0,
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        BlocProvider.of<CalculatorPanelBloc>(context)
                                                                            .add(FlagsPanelOpenEvent());
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                        BlocProvider.of<BottomNavBarCubit>(context)
                                                                            .emitShow();
                                                                        sourceselect =
                                                                            true;
                                                                      },
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            sourceControllers,
                                                                        enabled:
                                                                            false,
                                                                        style: TextStyle(
                                                                            color: sourceControllers.text.isNotEmpty
                                                                                ? AppColor.deepBlue
                                                                                : Colors.grey[600]!),
                                                                        onTap:
                                                                            () {
                                                                          BlocProvider.of<CalculatorPanelBloc>(context)
                                                                              .add(FlagsPanelOpenEvent());
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                          BlocProvider.of<BottomNavBarCubit>(context)
                                                                              .emitShow();
                                                                          sourceselect =
                                                                              true;
                                                                        },
                                                                        decoration: InputDecoration(
                                                                            labelText: AppLocalizations.of(context)!.translate('select_source'),
                                                                            hintText: AppLocalizations.of(context)!.translate('select_source'),
                                                                            contentPadding: const EdgeInsets.symmetric(
                                                                              horizontal: 9.0,
                                                                              vertical: 11.0,
                                                                            ),
                                                                            prefixIcon: sourceControllers.text.isNotEmpty
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                    child: SizedBox(
                                                                                      height: 25,
                                                                                      width: 45,
                                                                                      child: SvgPicture.network(
                                                                                        source!.imageURL!,
                                                                                        height: 25,
                                                                                        width: 45,
                                                                                        // semanticsLabel: 'A shark?!',
                                                                                        placeholderBuilder: (BuildContext context) => Container(
                                                                                          height: 25.h,
                                                                                          width: 45.w,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Colors.grey[200],
                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : null),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        index ==
                                                                            0,
                                                                    child:
                                                                        const SizedBox(
                                                                      height:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      BlocProvider.of<CalculatorPanelBloc>(
                                                                              context)
                                                                          .add(
                                                                              FlagsPanelOpenEvent());
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                      BlocProvider.of<BottomNavBarCubit>(
                                                                              context)
                                                                          .emitShow();
                                                                      _countselected =
                                                                          index;
                                                                      sourceselect =
                                                                          false;
                                                                    },
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          originControllers[
                                                                              index],
                                                                      enabled:
                                                                          false,
                                                                      style: TextStyle(
                                                                          color: originControllers[index].text.isNotEmpty
                                                                              ? AppColor.deepBlue
                                                                              : Colors.grey[600]!),
                                                                      onTap:
                                                                          () {
                                                                        BlocProvider.of<CalculatorPanelBloc>(context)
                                                                            .add(FlagsPanelOpenEvent());
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                        BlocProvider.of<BottomNavBarCubit>(context)
                                                                            .emitShow();
                                                                        _countselected =
                                                                            index;
                                                                        sourceselect =
                                                                            false;
                                                                      },
                                                                      decoration: InputDecoration(
                                                                          labelText: AppLocalizations.of(context)!.translate('select_origin'),
                                                                          hintText: AppLocalizations.of(context)!.translate('select_origin'),
                                                                          contentPadding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                9.0,
                                                                            vertical:
                                                                                11.0,
                                                                          ),
                                                                          prefixIcon: originControllers[index].text.isNotEmpty
                                                                              ? Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: SizedBox(
                                                                                    height: 25,
                                                                                    width: 45,
                                                                                    child: SvgPicture.network(
                                                                                      origins[index]!.imageURL!,
                                                                                      height: 25,
                                                                                      width: 45,
                                                                                      // semanticsLabel: 'A shark?!',
                                                                                      placeholderBuilder: (BuildContext context) => Container(
                                                                                        height: 25.h,
                                                                                        width: 45.w,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.grey[200],
                                                                                          borderRadius: BorderRadius.circular(5),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : null),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 14,
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        originerrors[
                                                                            index],
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .translate(
                                                                              'select_origin_error'),
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        originerrors[
                                                                            index],
                                                                    child:
                                                                        const SizedBox(
                                                                      height:
                                                                          24,
                                                                    ),
                                                                  ),
                                                                  Focus(
                                                                    focusNode:
                                                                        _nodeWeight,
                                                                    onFocusChange:
                                                                        (bool
                                                                            focus) {
                                                                      if (!focus) {
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                        BlocProvider.of<BottomNavBarCubit>(context)
                                                                            .emitShow();
                                                                        evaluatePrice(
                                                                            index);
                                                                      }
                                                                    },
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          weightControllers[
                                                                              index],
                                                                      // focusNode: _nodeWeight,
                                                                      onTap:
                                                                          () {
                                                                        BlocProvider.of<BottomNavBarCubit>(context)
                                                                            .emitHide();
                                                                        weightControllers[index].selection =
                                                                            TextSelection(
                                                                          baseOffset:
                                                                              0,
                                                                          extentOffset: weightControllers[index]
                                                                              .value
                                                                              .text
                                                                              .length,
                                                                        );
                                                                      },
                                                                      // enabled: !valueEnabled,
                                                                      scrollPadding:
                                                                          EdgeInsets.only(
                                                                              bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .done,
                                                                      keyboardType: const TextInputType
                                                                          .numberWithOptions(
                                                                          decimal:
                                                                              true,
                                                                          signed:
                                                                              true),
                                                                      inputFormatters: [
                                                                        DecimalFormatter(),
                                                                      ],
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText: showunits[index]
                                                                            ? showLabel(packages[index]!.unit!,
                                                                                localeState.value.languageCode)
                                                                            : AppLocalizations.of(context)!.translate('weight'),
                                                                        suffixText: showunits[index]
                                                                            ? showUnit(packages[index]!.unit!,
                                                                                localeState.value.languageCode)
                                                                            : "",
                                                                        contentPadding:
                                                                            const EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              9.0,
                                                                          vertical:
                                                                              11.0,
                                                                        ),
                                                                      ),
                                                                      onChanged:
                                                                          (value) {
                                                                        if (origins[index] !=
                                                                            null) {
                                                                          setState(
                                                                            () {
                                                                              originerrors[index] = false;
                                                                            },
                                                                          );
                                                                          if (value
                                                                              .isNotEmpty) {
                                                                            calculateTotalValueWithPrice(index);
                                                                            weightValues[index] =
                                                                                int.parse(value);
                                                                          } else {
                                                                            weightValues[index] =
                                                                                0;
                                                                          }
                                                                          evaluatePrice(
                                                                              index);
                                                                        } else {
                                                                          originerrors[index] =
                                                                              true;
                                                                        }
                                                                      },
                                                                      autovalidateMode:
                                                                          AutovalidateMode
                                                                              .onUserInteraction,
                                                                      validator:
                                                                          (value) {
                                                                        if (value!.isEmpty ||
                                                                            value ==
                                                                                "0.0") {
                                                                          return AppLocalizations.of(context)!
                                                                              .translate('insert_value_validate');
                                                                        }
                                                                        return null;
                                                                      },
                                                                      onSaved:
                                                                          (newValue) {
                                                                        weightControllers[index].text =
                                                                            newValue!;
                                                                      },
                                                                      onFieldSubmitted:
                                                                          (value) {
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                        BlocProvider.of<BottomNavBarCubit>(context)
                                                                            .emitShow();
                                                                      },
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 12,
                                                                  ),
                                                                  Focus(
                                                                    focusNode:
                                                                        _nodeValue,
                                                                    onFocusChange:
                                                                        (bool
                                                                            focus) {
                                                                      if (!focus) {
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                        BlocProvider.of<BottomNavBarCubit>(context)
                                                                            .emitShow();
                                                                        evaluatePrice(
                                                                            index);
                                                                      }
                                                                    },
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          valueControllers[
                                                                              index],
                                                                      // focusNode: _nodeValue,
                                                                      onTap:
                                                                          () {
                                                                        BlocProvider.of<BottomNavBarCubit>(context)
                                                                            .emitHide();

                                                                        valueControllers[index].selection =
                                                                            TextSelection(
                                                                          baseOffset:
                                                                              0,
                                                                          extentOffset: valueControllers[index]
                                                                              .value
                                                                              .text
                                                                              .length,
                                                                        );
                                                                      },
                                                                      // enabled: valueEnabled,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .done,
                                                                      keyboardType: const TextInputType
                                                                          .numberWithOptions(
                                                                          decimal:
                                                                              true,
                                                                          signed:
                                                                              true),
                                                                      inputFormatters: [
                                                                        DecimalFormatter(),
                                                                      ],
                                                                      scrollPadding:
                                                                          EdgeInsets.only(
                                                                              bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        suffixText:
                                                                            "\$",
                                                                        labelText: valueEnabled[index]
                                                                            ? AppLocalizations.of(context)!.translate('price_for_custome')
                                                                            : AppLocalizations.of(context)!.translate('total_value_in_dollar'),
                                                                        contentPadding:
                                                                            const EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              9.0,
                                                                          vertical:
                                                                              11.0,
                                                                        ),
                                                                      ),
                                                                      validator:
                                                                          (value) {
                                                                        if (value!.isEmpty ||
                                                                            value ==
                                                                                "0.0") {
                                                                          return AppLocalizations.of(context)!
                                                                              .translate('insert_value_validate');
                                                                        } else if (valueEnabled[index] &&
                                                                            double.parse(value) <
                                                                                basePriceValues[index]) {
                                                                          return "entered price should be grater than ${basePriceValues[index]}";
                                                                        }
                                                                        return null;
                                                                      },
                                                                      onEditingComplete:
                                                                          () {
                                                                        evaluatePrice(
                                                                            index);
                                                                      },
                                                                      onChanged:
                                                                          (value) {
                                                                        if (origins[index] !=
                                                                            null) {
                                                                          originerrors[index] =
                                                                              false;
                                                                          if (valueEnabled[index] &&
                                                                              double.parse(value) > basePriceValues[index]) {
                                                                            if (value.isNotEmpty) {
                                                                              basePriceValues[index] = double.parse(value);
                                                                              calculateTotalValue(index);
                                                                            } else {
                                                                              basePriceValues[index] = 0.0;
                                                                              calculateTotalValue(index);
                                                                            }
                                                                            evaluatePrice(index);
                                                                          }
                                                                        } else {
                                                                          originerrors[index] =
                                                                              true;
                                                                        }
                                                                      },
                                                                      autovalidateMode:
                                                                          AutovalidateMode
                                                                              .onUserInteraction,
                                                                      onSaved:
                                                                          (newValue) {
                                                                        valueControllers[index].text =
                                                                            newValue!;
                                                                      },
                                                                      onFieldSubmitted:
                                                                          (value) {
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                        BlocProvider.of<BottomNavBarCubit>(context)
                                                                            .emitShow();
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                        valueEnabled[
                                                                            index],
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .translate('price_for_custome'),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            index ==
                                                                    (_count - 1)
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        AppLocalizations.of(context)!
                                                                            .translate('add_commodity'),
                                                                        style:
                                                                            TextStyle(
                                                                          // fontSize: 16,
                                                                          // fontWeight:
                                                                          //     FontWeight
                                                                          //         .bold,
                                                                          color:
                                                                              AppColor.deepYellow,
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          // feeAddProvider!
                                                                          //     .setLoading(true);
                                                                          _add();
                                                                          // feeAddProvider!
                                                                          //     .setLoading(false);
                                                                        },
                                                                        child:
                                                                            AbsorbPointer(
                                                                          absorbing:
                                                                              true,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Icon(
                                                                              Icons.add_circle_outline_outlined,
                                                                              color: AppColor.goldenYellow,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : const SizedBox
                                                                    .shrink(),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 0,
                                                        top: 5,
                                                        child: Container(
                                                          height: 30,
                                                          width: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor
                                                                .deepYellow,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              (index + 1)
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      (_count > 1) &&
                                                              (index != 0)
                                                          ? Positioned(
                                                              right: 0,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  _showAlertDialog(
                                                                      index);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            45),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  );
                                                },
                                              ),
                                              // ListView(
                                              //   shrinkWrap: true,
                                              //   children: _children,
                                              // ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [],
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: localeState.value
                                                                .languageCode ==
                                                            'en'
                                                        ? [
                                                            AppColor
                                                                .lighterAppBarBlue,
                                                            AppColor
                                                                .lightAppBarBlue,
                                                            AppColor
                                                                .lightAppBarBlue,
                                                            AppColor
                                                                .deepAppBarBlue,
                                                            AppColor
                                                                .deepAppBarBlue,
                                                          ]
                                                        : [
                                                            AppColor
                                                                .deepAppBarBlue,
                                                            AppColor
                                                                .deepAppBarBlue,
                                                            AppColor
                                                                .lightAppBarBlue,
                                                            AppColor
                                                                .lightAppBarBlue,
                                                            AppColor
                                                                .lighterAppBarBlue,
                                                          ],
                                                    begin:
                                                        Alignment.centerRight,
                                                    end: Alignment.centerLeft,
                                                  ),
                                                  border: Border.all(
                                                      color: Colors.black26,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context)!.translate('convert_to_dollar_value')}: ${f.format(double.parse(totalsyrianExchangeValue).toInt())} USD",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17.sp),
                                                    ),
                                                    Text(
                                                      "${AppLocalizations.of(context)!.translate('total_value_in_eygptian_pound')}: ${f.format(double.parse(totalsyrianTotalValue).toInt())} EGP",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17.sp),
                                                    ),
                                                    Text(
                                                      "${AppLocalizations.of(context)!.translate('total_value_with_insurance')}: ${f.format(double.parse(totalTotalValueWithEnsurance).toInt())} EGP",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  BlocConsumer<
                                                      CalculateMultiResultBloc,
                                                      CalculateMultiResultState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is CalculateMultiResultSuccessed) {}
                                                    },
                                                    builder: (context, state) {
                                                      if (state
                                                          is CalculateMultiResultLoading) {
                                                        return CustomButton(
                                                          onTap: () {},
                                                          title: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .91,
                                                            child: const Center(
                                                              child:
                                                                  LoadingIndicator(),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      if (state
                                                          is CalculateMultiResultFailed) {
                                                        return Text(
                                                            state.error);
                                                      } else {
                                                        return CustomButton(
                                                          onTap: () {
                                                            _calformkey
                                                                .currentState
                                                                ?.save();
                                                            if (_calformkey
                                                                .currentState!
                                                                .validate()) {
                                                              for (var i = 0;
                                                                  i <
                                                                      origins
                                                                          .length;
                                                                  i++) {
                                                                if (origins[
                                                                        i] !=
                                                                    null) {
                                                                  publicOriginError =
                                                                      false;
                                                                  originerrors[
                                                                          i] =
                                                                      false;
                                                                } else {
                                                                  originerrors[
                                                                      i] = true;
                                                                  publicOriginError =
                                                                      true;
                                                                }
                                                              }
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                              BlocProvider.of<
                                                                          BottomNavBarCubit>(
                                                                      context)
                                                                  .emitShow();
                                                              // List<CalculateObject> objects = [];
                                                              objects = [];

                                                              if (!publicOriginError &&
                                                                  !publicPackageError) {
                                                                print("asd4");
                                                                for (var i = 0;
                                                                    i <
                                                                        packages
                                                                            .length;
                                                                    i++) {
                                                                  objects.add(
                                                                      CalculateObject());
                                                                  objects[i]
                                                                          .insurance =
                                                                      int.parse(
                                                                          totalValueWithEnsurance[
                                                                              i]);
                                                                  objects[i]
                                                                          .fee =
                                                                      packages[
                                                                              i]!
                                                                          .fee;
                                                                  objects[i]
                                                                          .rawMaterial =
                                                                      rawMaterialValues[
                                                                              i]
                                                                          ? 1
                                                                          : 0;
                                                                  objects[i]
                                                                          .industrial =
                                                                      industrialValues[
                                                                              i]
                                                                          ? 1
                                                                          : 0;
                                                                  objects[i]
                                                                      .totalTax = packages[
                                                                          i]!
                                                                      .totalTaxes!
                                                                      .totalTax;
                                                                  objects[i]
                                                                      .partialTax = packages[
                                                                          i]!
                                                                      .totalTaxes!
                                                                      .partialTax;
                                                                  objects[i]
                                                                          .origin =
                                                                      origins[i]!
                                                                          .label;
                                                                  objects[i]
                                                                          .spendingFee =
                                                                      packages[
                                                                              i]!
                                                                          .spendingFee;
                                                                  objects[i]
                                                                          .supportFee =
                                                                      packages[
                                                                              i]!
                                                                          .supportFee;
                                                                  objects[i]
                                                                          .localFee =
                                                                      packages[
                                                                              i]!
                                                                          .localFee;
                                                                  objects[i]
                                                                          .protectionFee =
                                                                      packages[
                                                                              i]!
                                                                          .protectionFee;
                                                                  objects[i]
                                                                          .naturalFee =
                                                                      packages[
                                                                              i]!
                                                                          .naturalFee;
                                                                  objects[i]
                                                                          .taxFee =
                                                                      packages[
                                                                              i]!
                                                                          .taxFee;
                                                                  objects[i]
                                                                          .weight =
                                                                      weightValues[
                                                                          i];
                                                                  objects[i]
                                                                          .price =
                                                                      basePriceValues[
                                                                              i]
                                                                          .toInt();
                                                                  objects[i]
                                                                      .cnsulate = 1;
                                                                  objects[i]
                                                                          .dolar =
                                                                      8585;
                                                                  objects[i]
                                                                      .arabic_stamp = packages[
                                                                          i]!
                                                                      .totalTaxes!
                                                                      .arabicStamp!
                                                                      .toInt();
                                                                  objects[i]
                                                                          .import_fee =
                                                                      packages[
                                                                              i]!
                                                                          .importFee!;
                                                                }
                                                                BlocProvider.of<
                                                                            CalculateMultiResultBloc>(
                                                                        context)
                                                                    .add(CalculateMultiTheResultEvent(
                                                                        objects));
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                                BlocProvider.of<
                                                                            BottomNavBarCubit>(
                                                                        context)
                                                                    .emitShow();

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              TraderCalculatorResultScreen(),
                                                                    ));
                                                              }
                                                            }
                                                          },
                                                          title: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .91,
                                                            child: Center(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .translate(
                                                                        'calculate_costume_fee'),
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ]),
                          ),
                        );
                      },
                    ),
                  ),
                  Consumer<FeeAddProvider>(
                    builder: (context, value, child) {
                      return value.loading
                          ? Container(
                              color: Colors.white54,
                              child: const Center(child: LoadingIndicator()),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  BlocBuilder<FeeSelectBloc, FeeSelectState>(
                    builder: (context, state) {
                      if (state is FeeSelectLoadingProgress) {
                        return Container(
                          color: Colors.white54,
                          child: const Center(child: LoadingIndicator()),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
