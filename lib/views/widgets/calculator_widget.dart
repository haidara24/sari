import 'dart:async';
import 'dart:convert';

import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_result_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculator_panel_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_select_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/flags_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/stop_scroll_cubit.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/providers/calculator_provider.dart';
import 'package:custome_mobile/data/services/calculator_service.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/helpers/formatter.dart';
import 'package:custome_mobile/views/screens/trader/trader_calculator_result_screen.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/highlight_text.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CalculatorWidget extends StatefulWidget {
  GlobalKey<FormState> calformkey;

  TextEditingController? typeAheadController;

  TextEditingController? wieghtController;

  TextEditingController? originController;

  TextEditingController? valueController;
  bool? tariffButton;
  final Function()? unfocus;

  CalculatorWidget({
    Key? key,
    required this.calformkey,
    required this.typeAheadController,
    required this.wieghtController,
    required this.originController,
    required this.valueController,
    required this.tariffButton,
    this.unfocus,
  }) : super(key: key);

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  var f = NumberFormat("#,###", "en_US");

  CalculateObject result = CalculateObject();
  final FocusNode _statenode = FocusNode();
  late final KeyboardVisibilityController _keyboardVisibilityController;
  late StreamSubscription<bool> keyboardSubscription;

  final FocusNode _nodeWeight = FocusNode();
  final FocusNode _nodeValue = FocusNode();
  @override
  void initState() {
    super.initState();
    _keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        _keyboardVisibilityController.onChange.listen((isVisible) {
      if (!isVisible) {
        FocusManager.instance.primaryFocus?.unfocus();
        BlocProvider.of<BottomNavBarCubit>(context).emitShow();
      }
    });
    // FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeWeight,
          toolbarButtons: [
            //button 2
            (node) {
              return GestureDetector(
                onTap: () {
                  node.unfocus();
                  BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "DONE",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              );
            }
          ],
        ),
        KeyboardActionsItem(
          focusNode: _nodeValue,
          toolbarButtons: [
            //button 2
            (node) {
              return GestureDetector(
                onTap: () {
                  node.unfocus();
                  BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "DONE",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              );
            }
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
      return BlocListener<FeeSelectBloc, FeeSelectState>(
        listener: (context, state) {
          if (state is FeeSelectSuccess) {
            setState(() {
              widget.wieghtController!.text = "0.0";
              widget.valueController!.text = "0.0";

              calculatorProvider.initProvider();
            });
            calculatorProvider.selectSuggestion(state.package);
            setState(() {
              widget.typeAheadController!.text =
                  calculatorProvider.selectedPackage!.label!;
              widget.valueController!.text =
                  calculatorProvider.basePrice.toString();
            });
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            BlocProvider.of<BottomNavBarCubit>(context).emitShow();
          },
          child: Form(
            key: widget.calformkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Focus(
                      // focusNode: _ordernode,
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
                    widget.tariffButton!
                        ? GestureDetector(
                            onTap: () {
                              BlocProvider.of<CalculatorPanelBloc>(context)
                                  .add(TariffPanelOpenEvent());

                              FocusManager.instance.primaryFocus?.unfocus();
                              BlocProvider.of<BottomNavBarCubit>(context)
                                  .emitShow();
                            },
                            child: SizedBox(
                              height: 40.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
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
                          )
                        : const SizedBox.shrink(),
                    Focus(
                      focusNode: _statenode,
                      onFocusChange: (bool focus) {
                        if (!focus) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          BlocProvider.of<BottomNavBarCubit>(context)
                              .emitShow();
                          BlocProvider.of<StopScrollCubit>(context)
                              .emitEnable();
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<CalculatorPanelBloc>(context)
                              .add(TariffPanelOpenEvent());
                          // BlocProvider.of<SectionBloc>(context)
                          //     .add(SectionLoadEvent());
                          FocusManager.instance.primaryFocus?.unfocus();
                          BlocProvider.of<BottomNavBarCubit>(context)
                              .emitShow();
                        },
                        child: TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            // autofocus: true,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            enabled: false,
                            controller: widget.typeAheadController,
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        150),
                            onTap: () {
                              // setSelectedPanel(2);
                              BlocProvider.of<BottomNavBarCubit>(context)
                                  .emitHide();
                              widget.typeAheadController!.selection =
                                  TextSelection(
                                      baseOffset: 0,
                                      extentOffset: widget.typeAheadController!
                                          .value.text.length);
                            },

                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!
                                  .translate('goods_name'),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 9.0,
                                vertical: 11.0,
                              ),
                            ),
                            onSubmitted: (value) {
                              BlocProvider.of<StopScrollCubit>(context)
                                  .emitEnable();
                              FocusManager.instance.primaryFocus?.unfocus();
                              BlocProvider.of<BottomNavBarCubit>(context)
                                  .emitShow();
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
                            var localizedMessage = AppLocalizations.of(context)!
                                .translate('no_result_found');
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
                          suggestionsCallback: (pattern) async {
                            calculatorProvider.setPatternString(pattern);
                            if (pattern.isNotEmpty) {
                              BlocProvider.of<StopScrollCubit>(context)
                                  .emitDisable();
                            }
                            return pattern.isEmpty || pattern.length == 1
                                ? []
                                : await CalculatorService.getpackages(pattern);
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
                                      highlight:
                                          calculatorProvider.patternString,
                                      ignoreCase: false,
                                      style: TextStyle(fontSize: 17.sp),
                                      highlightStyle: TextStyle(
                                        fontSize: 17.sp,
                                        backgroundColor: AppColor.goldenYellow,
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
                            BlocProvider.of<StopScrollCubit>(context)
                                .emitEnable();
                            calculatorProvider.selectSuggestion(suggestion);
                            setState(() {
                              widget.typeAheadController!.text =
                                  calculatorProvider.selectedPackage!.label!;
                              widget.valueController!.text =
                                  calculatorProvider.basePrice.toString();
                            });
                            FocusManager.instance.primaryFocus?.unfocus();
                            BlocProvider.of<BottomNavBarCubit>(context)
                                .emitShow();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Visibility(
                  visible: calculatorProvider.allowexport,
                  child: Text(
                    AppLocalizations.of(context)!
                        .translate('fee_import_banned'),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                    ),
                  ),
                ),
                Visibility(
                  visible: calculatorProvider.allowexport,
                  child: const SizedBox(
                    height: 14,
                  ),
                ),
                Visibility(
                  visible: calculatorProvider.feeerror,
                  child: Text(
                    AppLocalizations.of(context)!.translate('select_fee_error'),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                    ),
                  ),
                ),
                Visibility(
                  visible: calculatorProvider.feeerror,
                  child: const SizedBox(
                    height: 14,
                  ),
                ),
                Visibility(
                  visible: calculatorProvider.isdropdwonVisible,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<Extras>(
                      isExpanded: true,
                      barrierLabel: calculatorProvider.placeholder,
                      hint: Text(
                        calculatorProvider.placeholder,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: calculatorProvider.items
                          .map((Extras item) => DropdownMenuItem<Extras>(
                                value: item,
                                child: Text(
                                  item.label!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: calculatorProvider.selectedValue,
                      onChanged: (Extras? value) {
                        if (value!.countryGroup!.isEmpty) {
                          if (value.price! > 0) {
                            calculatorProvider.setBasePrice(value.price!);
                            calculatorProvider.setValueEnable(false);
                            setState(() {
                              widget.valueController!.text =
                                  calculatorProvider.basePrice.toString();
                            });
                          } else {
                            calculatorProvider.setBasePrice(0.0);
                            calculatorProvider.setValueEnable(true);
                            setState(() {
                              widget.valueController!.text = "0.0";
                            });
                          }
                          calculatorProvider.evaluatePrice();
                        } else {
                          if (value.price! > 0) {
                            calculatorProvider.setBasePrice(value.price!);
                            calculatorProvider.setValueEnable(false);

                            setState(() {
                              widget.valueController!.text =
                                  value.price!.toString();
                            });
                          } else {
                            calculatorProvider.setBasePrice(value.price!);
                            calculatorProvider.setValueEnable(false);
                            setState(() {
                              widget.valueController!.text = "0.0";
                            });
                          }
                          calculatorProvider.evaluatePrice();
                        }
                        calculatorProvider.setSelectedValue(value);
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: double.infinity,

                        padding: const EdgeInsets.symmetric(
                          horizontal: 9.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
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
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 50.h,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: calculatorProvider.isdropdwonVisible,
                  child: const SizedBox(
                    height: 24,
                  ),
                ),
                Wrap(
                  children: [
                    Visibility(
                      visible: calculatorProvider.isfeeequal001,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: CheckboxListTile(
                            value: calculatorProvider.rawMaterialValue,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(AppLocalizations.of(context)!
                                .translate('raw_material')),
                            onChanged: (value) {
                              calculatorProvider.setRawMaterial(value!);
                            }),
                      ),
                    ),
                    Visibility(
                      visible: calculatorProvider.isfeeequal001,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: CheckboxListTile(
                            value: calculatorProvider.industrialValue,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(AppLocalizations.of(context)!
                                .translate('industrial')),
                            onChanged: (value) {
                              calculatorProvider.setIndustrail(value!);
                              calculatorProvider.evaluatePrice();
                            }),
                      ),
                    ),
                    Visibility(
                      visible: calculatorProvider.isBrand,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: CheckboxListTile(
                            value: calculatorProvider.brandValue,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(AppLocalizations.of(context)!
                                .translate('isBrand')),
                            onChanged: (value) {
                              calculatorProvider.calculateExtrasPrice(
                                  1.5, value!);
                              widget.valueController!.text =
                                  calculatorProvider.extraPrice.toString();
                              calculatorProvider.setBrand(value);
                              calculatorProvider.evaluatePrice();
                            }),
                      ),
                    ),
                    Visibility(
                      visible: calculatorProvider.isTubes,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: CheckboxListTile(
                            value: calculatorProvider.tubesValue,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(AppLocalizations.of(context)!
                                .translate('isTubeValue')),
                            onChanged: (value) {
                              calculatorProvider.calculateExtrasPrice(
                                  .1, value!);
                              widget.valueController!.text =
                                  calculatorProvider.extraPrice.toString();
                              calculatorProvider.setTubes(value);
                              calculatorProvider.evaluatePrice();
                            }),
                      ),
                    ),
                    Visibility(
                      visible: calculatorProvider.isColored,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: CheckboxListTile(
                            value: calculatorProvider.colorValue,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(AppLocalizations.of(context)!
                                .translate('isColored')),
                            onChanged: (value) {
                              calculatorProvider.calculateExtrasPrice(
                                  .1, value!);
                              widget.valueController!.text =
                                  calculatorProvider.extraPrice.toString();
                              calculatorProvider.setColor(value);
                              calculatorProvider.evaluatePrice();
                            }),
                      ),
                    ),
                    Visibility(
                      visible: calculatorProvider.isLycra,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: CheckboxListTile(
                            value: calculatorProvider.lycraValue,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(AppLocalizations.of(context)!
                                .translate('isLycra')),
                            onChanged: (value) {
                              calculatorProvider.calculateExtrasPrice(
                                  .05, value!);
                              widget.valueController!.text =
                                  calculatorProvider.extraPrice.toString();
                              calculatorProvider.setLycra(value);

                              calculatorProvider.evaluatePrice();
                            }),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<FlagsBloc, FlagsState>(
                  builder: (context, flagstate) {
                    if (flagstate is FlagsLoadedSuccess) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2<Origin>(
                          isExpanded: true,
                          hint: Text(
                            AppLocalizations.of(context)!
                                .translate('select_origin'),
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: flagstate.origins
                              .map((Origin item) => DropdownMenuItem<Origin>(
                                    value: item,
                                    child: SizedBox(
                                      // width: 200,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            width: 55,
                                            child: SvgPicture.network(
                                              item.imageURL!,
                                              height: 35,
                                              width: 55,
                                              // semanticsLabel: 'A shark?!',
                                              placeholderBuilder:
                                                  (BuildContext context) =>
                                                      Container(
                                                height: 35.h,
                                                width: 45.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 7),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 280.w,
                                            ),
                                            child: Text(
                                              item.label!,
                                              overflow: TextOverflow.ellipsis,
                                              // maxLines: 2,
                                            ),
                                          ),
                                        ],
                                        // subtitle: Text('\$${suggestion['price']}'),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: calculatorProvider.selectedOrigin,
                          onChanged: (Origin? value) {
                            // setState(() {
                            //   selectedOrigin = value;
                            // });
                            calculatorProvider.selectOrigin(value!);
                          },
                          barrierColor: Colors.black45,
                          dropdownSearchData: DropdownSearchData(
                            searchController: widget.originController,
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
                                controller: widget.originController,
                                onTap: () {
                                  widget.originController!.selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: widget.originController!
                                              .value.text.length);
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .translate('select_origin'),
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onTapOutside: (event) {
                                  widget.unfocus;
                                  BlocProvider.of<BottomNavBarCubit>(context)
                                      .emitShow();
                                },
                                onFieldSubmitted: (value) {
                                  widget.unfocus;
                                  BlocProvider.of<BottomNavBarCubit>(context)
                                      .emitShow();
                                },
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value!.label!.contains(searchValue);
                            },
                          ),
                          onMenuStateChange: (isOpen) {
                            if (isOpen) {
                              setState(() {
                                widget.originController!.clear();
                              });
                            }
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 14, right: 14),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
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
                            maxHeight: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      );
                    } else if (flagstate is FlagsLoadingProgressState) {
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('list_error'),
                                style: const TextStyle(color: Colors.red),
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
                  height: 14,
                ),

                Visibility(
                  visible: calculatorProvider.originerror,
                  child: Text(
                    AppLocalizations.of(context)!
                        .translate('select_origin_error'),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                Visibility(
                  visible: calculatorProvider.originerror,
                  child: const SizedBox(
                    height: 24,
                  ),
                ),
                TextFormField(
                  controller: widget.wieghtController!,
                  // focusNode: _nodeWeight,
                  onTap: () {
                    BlocProvider.of<BottomNavBarCubit>(context).emitHide();
                    widget.wieghtController!.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset:
                            widget.wieghtController!.value.text.length);
                  },
                  // enabled: !valueEnabled,
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                  textInputAction: TextInputAction.done,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                  inputFormatters: [
                    DecimalFormatter(),
                  ],
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.translate('weight'),
                    suffixText: calculatorProvider.showunit
                        ? calculatorProvider.wieghtUnit
                        : "",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 9.0,
                      vertical: 11.0,
                    ),
                  ),
                  onChanged: (value) {
                    if (calculatorProvider.selectedOrigin != null) {
                      calculatorProvider.setOriginError(false);
                      if (value.isNotEmpty) {
                        // calculateTotalValueWithPrice(value);
                        calculatorProvider.setWeightValue(int.parse(value));
                      } else {
                        calculatorProvider.setWeightValue(0);
                      }
                      calculatorProvider.evaluatePrice();
                    } else {
                      calculatorProvider.setOriginError(true);
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!
                          .translate('insert_value_validate');
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                  },
                ),

                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: widget.valueController!,
                  // focusNode: _nodeValue,
                  onTap: () {
                    BlocProvider.of<BottomNavBarCubit>(context).emitHide();
                    widget.valueController!.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset:
                            widget.valueController!.value.text.length);
                  },
                  // enabled: valueEnabled,
                  textInputAction: TextInputAction.done,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                  inputFormatters: [
                    DecimalFormatter(),
                  ],
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    suffixText: "\$",
                    labelText: calculatorProvider.valueEnabled
                        ? AppLocalizations.of(context)!
                            .translate('total_value_in_dollar')
                        : AppLocalizations.of(context)!
                            .translate('price_for_custome'),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 9.0,
                      vertical: 11.0,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!
                          .translate('insert_value_validate');
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (calculatorProvider.selectedOrigin != null) {
                      calculatorProvider.setOriginError(false);
                      if (value.isNotEmpty) {
                        calculatorProvider.setBasePrice(double.parse(value));
                        // calculateTotalValue();
                      } else {
                        calculatorProvider.setBasePrice(0.0);
                        // calculateTotalValue();
                      }
                      calculatorProvider.evaluatePrice();
                    } else {
                      calculatorProvider.setOriginError(true);
                    }
                  },
                  onFieldSubmitted: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                  },
                ),
                const SizedBox(
                  height: 12,
                ),

                // Visibility(
                //   visible: isfeeequal001,
                //   child: const SizedBox(
                //     height: 12,
                //   ),
                // ),
                // const Text(
                //   "ملاحظة: الحد الأدنى للسعر الاسترشادي هو 100\$",
                //   style: TextStyle(color: Colors.grey),
                // ),
                // const SizedBox(
                //   height: 12,
                // ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.lightGreen,
                    border: Border.all(color: Colors.black26, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "قيمة التحويل بالجنيه المصري : 8585 E.P",
                      //   style: TextStyle(fontSize: 17.sp),
                      // ),
                      Text(
                        "${AppLocalizations.of(context)!.translate('convert_to_dollar_value')}: ${f.format(double.parse(calculatorProvider.syrianExchangeValue).toInt())}\$",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.translate('total_value_in_eygptian_pound')}: ${f.format(double.parse(calculatorProvider.syrianTotalValue).toInt())} E.P",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.translate('total_value_with_insurance')}: ${f.format(double.parse(calculatorProvider.totalValueWithEnsurance).toInt())} E.P",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<CalculateResultBloc, CalculateResultState>(
                      listener: (context, state) {
                        if (state is CalculateResultSuccessed) {}
                      },
                      builder: (context, state) {
                        if (state is CalculateResultLoading) {
                          return CustomButton(
                              onTap: () {},
                              title: SizedBox(
                                  width: 250.w,
                                  child:
                                      const Center(child: LoadingIndicator())));
                        }
                        if (state is CalculateResultFailed) {
                          return Text(state.error);
                        } else {
                          return CustomButton(
                            onTap: () {
                              widget.calformkey.currentState?.save();
                              if (widget.calformkey.currentState!.validate()) {
                                if (calculatorProvider.selectedOrigin != null) {
                                  if (calculatorProvider.selectedPackage !=
                                      null) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    BlocProvider.of<BottomNavBarCubit>(context)
                                        .emitShow();
                                    result.insurance = int.parse(
                                        calculatorProvider
                                            .totalValueWithEnsurance);
                                    result.fee = calculatorProvider
                                        .selectedPackage!.fee!;
                                    result.rawMaterial =
                                        calculatorProvider.rawMaterialValue
                                            ? 1
                                            : 0;
                                    result.industrial =
                                        calculatorProvider.industrialValue
                                            ? 1
                                            : 0;
                                    result.totalTax = calculatorProvider
                                        .selectedPackage!.totalTaxes!.totalTax!;
                                    result.partialTax = calculatorProvider
                                        .selectedPackage!
                                        .totalTaxes!
                                        .partialTax!;
                                    result.origin = calculatorProvider
                                        .selectedOrigin!.label!;
                                    result.spendingFee = calculatorProvider
                                        .selectedPackage!.spendingFee!;
                                    result.supportFee = calculatorProvider
                                        .selectedPackage!.supportFee!;
                                    result.localFee = calculatorProvider
                                        .selectedPackage!.localFee!;
                                    result.protectionFee = calculatorProvider
                                        .selectedPackage!.protectionFee!;
                                    result.naturalFee = calculatorProvider
                                        .selectedPackage!.naturalFee!;
                                    result.taxFee = calculatorProvider
                                        .selectedPackage!.taxFee!;
                                    result.weight = calculatorProvider.weight;
                                    result.price =
                                        calculatorProvider.basePrice.toInt();
                                    result.cnsulate = 1;
                                    result.dolar = 8585;
                                    result.arabic_stamp = calculatorProvider
                                        .selectedPackage!
                                        .totalTaxes!
                                        .arabicStamp!
                                        .toInt();
                                    result.import_fee = calculatorProvider
                                        .selectedPackage!.importFee;
                                    BlocProvider.of<CalculateResultBloc>(
                                            context)
                                        .add(CalculateTheResultEvent(result));
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    BlocProvider.of<BottomNavBarCubit>(context)
                                        .emitShow();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TraderCalculatorResultScreen(),
                                        ));
                                  } else {
                                    calculatorProvider.setFeeError(true);
                                  }
                                } else {
                                  calculatorProvider.setOriginError(true);
                                }
                              }
                            },
                            title: SizedBox(
                              width: 250.w,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('calculate_costume_fee'),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
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
      );
    });
  }
}
