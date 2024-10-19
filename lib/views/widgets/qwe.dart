// import 'dart:async';

// import 'package:custome_mobile/Localization/app_localizations.dart';
// import 'package:custome_mobile/business_logic/bloc/calculate_multi_result_dart_bloc.dart';
// import 'package:custome_mobile/business_logic/bloc/calculate_result_bloc.dart';
// import 'package:custome_mobile/business_logic/bloc/calculator_panel_bloc.dart';
// import 'package:custome_mobile/business_logic/bloc/fee_select_bloc.dart';
// import 'package:custome_mobile/business_logic/bloc/flags_bloc.dart';
// import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
// import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
// import 'package:custome_mobile/business_logic/cubit/stop_scroll_cubit.dart';
// import 'package:custome_mobile/data/models/package_model.dart';
// import 'package:custome_mobile/helpers/color_constants.dart';
// import 'package:custome_mobile/helpers/formatter.dart';
// import 'package:custome_mobile/views/screens/trader/trader_calculator_result_screen.dart';
// // import 'package:custome_mobile/views/widgets/calculator_dart';
// import 'package:custome_mobile/views/widgets/custom_botton.dart';
// import 'package:custome_mobile/views/widgets/highlight_text.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:intl/intl.dart' as intel;

// class TraderCalculatorMultiScreen extends StatefulWidget {
//   TraderCalculatorMultiScreen({Key? key}) : super(key: key);

//   @override
//   State<TraderCalculatorMultiScreen> createState() =>
//       _TraderCalculatorMultiScreenState();
// }

// class _TraderCalculatorMultiScreenState
//     extends State<TraderCalculatorMultiScreen> {
//   final GlobalKey<FormState> _calformkey = GlobalKey<FormState>();

//   bool publicOriginError = false;
//   bool publicPackageError = false;
//   List<Package?> packages = [];

//   List<Origin?> origins = [];

//   List<TextEditingController> packageControllers = [];

//   List<TextEditingController> originControllers = [];

//   List<TextEditingController> weightControllers = [];

//   List<TextEditingController> valueControllers = [];

//   List<bool> allowexports = [];
//   List<bool> feeerrors = [];
//   List<bool> isdropdownVisibles = [];
//   List<String> placeholders = [];
//   List<List<Extras>> extraslist = [];
//   List<Extras?> extraselectedValues = [];
//   List<bool> isfeeequal001 = [];
//   List<bool> rawMaterialValues = [];
//   List<bool> industrialValues = [];
//   List<bool> isBrands = [];
//   List<bool> brandValus = [];
//   List<bool> isTubes = [];
//   List<bool> tubeValus = [];
//   List<bool> isColored = [];
//   List<bool> colorValus = [];
//   List<bool> isLycra = [];
//   List<bool> lycraValus = [];
//   List<double> extraPrices = [];
//   List<bool> originerrors = [];
//   List<bool> showunits = [];
//   List<String> weightUnits = [];
//   List<int> weightValues = [];
//   List<double> basePriceValues = [];
//   List<bool> valueEnabled = [];
//   List<String> syrianExchangeValue = [];
//   List<String> syrianTotalValue = [];
//   List<String> totalValueWithEnsurance = [];
//   List<String> weightLabels = [];

//   List<CalculateObject> objects = [];
//   List<Widget> _children = [];

//   int _count = 0;
//   int _countselected = 0;
//   var f = intel.NumberFormat("#,###", "en_US");

//   late final KeyboardVisibilityController _keyboardVisibilityController;
//   late StreamSubscription<bool> keyboardSubscription;

//   @override
//   void initState() {
//     super.initState();

//     TextEditingController package_controller = TextEditingController();
//     TextEditingController weight_controller = TextEditingController();
//     TextEditingController value_controller = TextEditingController();
//     TextEditingController origin_controller = TextEditingController();

//     packageControllers.add(package_controller);
//     weightControllers.add(weight_controller);
//     valueControllers.add(value_controller);
//     originControllers.add(origin_controller);
//     packages.add(null);
//     origins.add(null);
//     allowexports.add(false);
//     feeerrors.add(false);
//     isdropdownVisibles.add(false);
//     placeholders.add("");
//     extraslist.add([]);
//     extraselectedValues.add(null);
//     isfeeequal001.add(false);
//     rawMaterialValues.add(false);
//     industrialValues.add(false);
//     isBrands.add(false);
//     brandValus.add(false);
//     isTubes.add(false);
//     tubeValus.add(false);
//     isColored.add(false);
//     colorValus.add(false);
//     isLycra.add(false);
//     lycraValus.add(false);
//     extraPrices.add(0.0);
//     originerrors.add(false);
//     showunits.add(false);
//     weightUnits.add("kg");
//     weightLabels.add("kg");
//     weightValues.add(0);
//     basePriceValues.add(0);
//     valueEnabled.add(false);
//     syrianExchangeValue.add("8585");
//     syrianTotalValue.add("0.0");
//     totalValueWithEnsurance.add("0.0");

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _children = List.from(_children)
//         ..add(
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Focus(
//                       // focusNode: _ordernode,
//                       child: Text(
//                           AppLocalizations.of(context)!
//                               .translate('goods_details'),
//                           style: TextStyle(
//                             fontSize: 19,
//                             fontWeight: FontWeight.bold,
//                             color: AppColor.deepBlue,
//                           )),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   _count.toString(),
//                   style: TextStyle(
//                     fontSize: 19,
//                     fontWeight: FontWeight.bold,
//                     color: AppColor.deepBlue,
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         BlocProvider.of<CalculatorPanelBloc>(context)
//                             .add(TariffPanelOpenEvent());

//                         FocusManager.instance.primaryFocus?.unfocus();
//                         BlocProvider.of<BottomNavBarCubit>(context).emitShow();
//                         _countselected = 0;
//                         print(_countselected);
//                         print(_count);
//                       },
//                       child: SizedBox(
//                         height: 40.h,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             SizedBox(
//                               width: 25.w,
//                               height: 25.h,
//                               child: SvgPicture.asset(
//                                 "assets/icons/tarrif_btn.svg",
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 3,
//                             ),
//                             Text(
//                               AppLocalizations.of(context)!
//                                   .translate('tariff_browser'),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: AppColor.lightBlue,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         BlocProvider.of<CalculatorPanelBloc>(context)
//                             .add(TariffPanelOpenEvent());
//                         FocusManager.instance.primaryFocus?.unfocus();
//                         BlocProvider.of<BottomNavBarCubit>(context).emitShow();
//                         _countselected = 0;
//                         print(_countselected);
//                         print(_count);
//                       },
//                       child: TypeAheadField(
//                         textFieldConfiguration: TextFieldConfiguration(
//                           // autofocus: true,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: null,
//                           enabled: false,
//                           controller: packageControllers[0],
//                           scrollPadding: EdgeInsets.only(
//                               bottom: MediaQuery.of(context).viewInsets.bottom +
//                                   150),
//                           style: const TextStyle(fontSize: 18),
//                           decoration: InputDecoration(
//                             labelText: AppLocalizations.of(context)!
//                                 .translate('goods_name'),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 9.0,
//                               vertical: 11.0,
//                             ),
//                           ),
//                           onSubmitted: (value) {
//                             BlocProvider.of<StopScrollCubit>(context)
//                                 .emitEnable();
//                             FocusManager.instance.primaryFocus?.unfocus();
//                             BlocProvider.of<BottomNavBarCubit>(context)
//                                 .emitShow();
//                           },
//                         ),
//                         loadingBuilder: (context) {
//                           return Container(
//                             color: Colors.white,
//                             child: const Center(
//                               child: LoadingIndicator(),
//                             ),
//                           );
//                         },
//                         errorBuilder: (context, error) {
//                           return Container(
//                             color: Colors.white,
//                           );
//                         },
//                         noItemsFoundBuilder: (value) {
//                           var localizedMessage = AppLocalizations.of(context)!
//                               .translate('no_result_found');
//                           return Container(
//                             width: double.infinity,
//                             color: Colors.white,
//                             child: Center(
//                               child: Text(
//                                 localizedMessage,
//                                 style: TextStyle(fontSize: 18.sp),
//                               ),
//                             ),
//                           );
//                         },
//                         suggestionsCallback: (pattern) async {
//                           return [];
//                         },
//                         itemBuilder: (context, suggestion) {
//                           return Container();
//                         },
//                         onSuggestionSelected: (suggestion) {},
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 14,
//                 ),
//                 Visibility(
//                   visible: allowexports[0],
//                   child: Text(
//                     AppLocalizations.of(context)!
//                         .translate('fee_import_banned'),
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: allowexports[0],
//                   child: const SizedBox(
//                     height: 14,
//                   ),
//                 ),
//                 Visibility(
//                   visible: feeerrors[0],
//                   child: Text(
//                     AppLocalizations.of(context)!.translate('select_fee_error'),
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: feeerrors[0],
//                   child: const SizedBox(
//                     height: 14,
//                   ),
//                 ),
//                 Visibility(
//                   visible: isdropdownVisibles[0],
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton2<Extras>(
//                       isExpanded: true,
//                       barrierLabel: placeholders[0],
//                       hint: Text(
//                         placeholders[0],
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Theme.of(context).hintColor,
//                         ),
//                       ),
//                       items: extraslist[0]
//                           .map((Extras item) => DropdownMenuItem<Extras>(
//                                 value: item,
//                                 child: Text(
//                                   item.label!,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ))
//                           .toList(),
//                       value: extraselectedValues[0],
//                       onChanged: (Extras? value) {
//                         if (value!.countryGroup!.isEmpty) {
//                           if (value.price! > 0) {
//                             basePriceValues[0] = value.price!;
//                             valueEnabled[0] = false;
//                             setState(() {
//                               valueControllers[0].text =
//                                   basePriceValues[0].toString();
//                             });
//                           } else {
//                             basePriceValues[0] = 0.0;
//                             valueEnabled[0] = true;
//                             setState(() {
//                               valueControllers[0].text = "0.0";
//                             });
//                           }
//                           evaluatePrice(0);
//                         } else {
//                           if (value.price! > 0) {
//                             basePriceValues[0] = value.price!;
//                             valueEnabled[0] = false;

//                             setState(() {
//                               valueControllers[0].text =
//                                   value.price!.toString();
//                             });
//                           } else {
//                             basePriceValues[0] = value.price!;
//                             valueEnabled[0] = true;
//                             setState(() {
//                               valueControllers[0].text = "0.0";
//                             });
//                           }
//                           evaluatePrice(0);
//                         }
//                         extraselectedValues[0] = value;
//                       },
//                       buttonStyleData: ButtonStyleData(
//                         height: 50,
//                         width: double.infinity,

//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 9.0,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: Colors.black26,
//                           ),
//                           color: Colors.white,
//                         ),
//                         // elevation: 2,
//                       ),
//                       iconStyleData: const IconStyleData(
//                         icon: Icon(
//                           Icons.keyboard_arrow_down_sharp,
//                         ),
//                         iconSize: 20,
//                         iconEnabledColor: AppColor.AccentBlue,
//                         iconDisabledColor: Colors.grey,
//                       ),
//                       dropdownStyleData: DropdownStyleData(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(14),
//                           color: Colors.white,
//                         ),
//                         scrollbarTheme: ScrollbarThemeData(
//                           radius: const Radius.circular(40),
//                           thickness: MaterialStateProperty.all(6),
//                           thumbVisibility: MaterialStateProperty.all(true),
//                         ),
//                       ),
//                       menuItemStyleData: MenuItemStyleData(
//                         height: 50.h,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: isdropdownVisibles[0],
//                   child: const SizedBox(
//                     height: 24,
//                   ),
//                 ),
//                 Wrap(
//                   children: [
//                     Visibility(
//                       visible: isfeeequal001[0],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: rawMaterialValues[0],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('raw_material')),
//                             onChanged: (value) {
//                               setState(() {
//                                 rawMaterialValues[0] = value!;
//                               });
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isfeeequal001[0],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: industrialValues[0],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('industrial')),
//                             onChanged: (value) {
//                               industrialValues[0] = value!;
//                               evaluatePrice(0);
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isBrands[0],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: brandValus[0],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('isBrand')),
//                             onChanged: (value) {
//                               calculateExtrasPrice(1.5, value!, 0);
//                               valueControllers[0].text =
//                                   extraPrices[0].toString();
//                               brandValus[0] = value!;
//                               evaluatePrice(0);
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isTubes[0],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: tubeValus[0],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('isTubeValue')),
//                             onChanged: (value) {
//                               calculateExtrasPrice(.1, value!, 0);
//                               valueControllers[0].text =
//                                   extraPrices[0].toString();
//                               tubeValus[0] = value!;
//                               evaluatePrice(0);
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isColored[0],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: colorValus[0],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('isColored')),
//                             onChanged: (value) {
//                               calculateExtrasPrice(.1, value!, 0);
//                               valueControllers[0].text =
//                                   extraPrices[0].toString();
//                               colorValus[0] = value!;
//                               evaluatePrice(0);
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isLycra[0],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: lycraValus[0],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('isLycra')),
//                             onChanged: (value) {
//                               calculateExtrasPrice(.05, value!, 0);
//                               valueControllers[0].text =
//                                   extraPrices[0].toString();
//                               lycraValus[0] = value!;

//                               evaluatePrice(0);
//                             }),
//                       ),
//                     ),
//                   ],
//                 ),
//                 BlocBuilder<FlagsBloc, FlagsState>(
//                   builder: (context, flagstate) {
//                     if (flagstate is FlagsLoadedSuccess) {
//                       return StatefulBuilder(builder: (context, setState2) {
//                         return DropdownButtonHideUnderline(
//                           child: DropdownButton2<Origin>(
//                             isExpanded: true,
//                             hint: Text(
//                               AppLocalizations.of(context)!
//                                   .translate('select_origin'),
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: Theme.of(context).hintColor,
//                               ),
//                             ),
//                             items: flagstate.origins
//                                 .map((Origin item) => DropdownMenuItem<Origin>(
//                                       value: item,
//                                       child: SizedBox(
//                                         // width: 200,
//                                         child: Row(
//                                           children: [
//                                             SizedBox(
//                                               height: 35,
//                                               width: 55,
//                                               child: SvgPicture.network(
//                                                 item.imageURL!,
//                                                 height: 35,
//                                                 width: 55,
//                                                 // semanticsLabel: 'A shark?!',
//                                                 placeholderBuilder:
//                                                     (BuildContext context) =>
//                                                         Container(
//                                                   height: 35.h,
//                                                   width: 45.w,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.grey[200],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(width: 7),
//                                             Container(
//                                               constraints: BoxConstraints(
//                                                 maxWidth: 280.w,
//                                               ),
//                                               child: Text(
//                                                 item.label!,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 // maxLines: 2,
//                                               ),
//                                             ),
//                                           ],
//                                           // subtitle: Text('\$${suggestion['price']}'),
//                                         ),
//                                       ),
//                                     ))
//                                 .toList(),
//                             value: origins[0],
//                             onChanged: (Origin? value) {
//                               setState2(() {
//                                 origins[0] = value;
//                               });
//                             },
//                             barrierColor: Colors.black45,
//                             dropdownSearchData: DropdownSearchData(
//                               searchController: originControllers[0],
//                               searchInnerWidgetHeight: 60,
//                               searchInnerWidget: Container(
//                                 height: 60,
//                                 padding: const EdgeInsets.only(
//                                   top: 8,
//                                   bottom: 4,
//                                   right: 8,
//                                   left: 8,
//                                 ),
//                                 child: TextFormField(
//                                   expands: true,
//                                   maxLines: null,
//                                   controller: originControllers[0],
//                                   onTap: () {
//                                     originControllers[0].selection =
//                                         TextSelection(
//                                       baseOffset: 0,
//                                       extentOffset: originControllers[0]
//                                           .value
//                                           .text
//                                           .length,
//                                     );
//                                   },
//                                   decoration: InputDecoration(
//                                     isDense: true,
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 10,
//                                       vertical: 8,
//                                     ),
//                                     labelText: AppLocalizations.of(context)!
//                                         .translate('select_origin'),
//                                     hintStyle: const TextStyle(fontSize: 12),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   onTapOutside: (event) {
//                                     FocusManager.instance.primaryFocus
//                                         ?.unfocus();
//                                     BlocProvider.of<BottomNavBarCubit>(context)
//                                         .emitShow();
//                                   },
//                                   onFieldSubmitted: (value) {
//                                     FocusManager.instance.primaryFocus
//                                         ?.unfocus();
//                                     BlocProvider.of<BottomNavBarCubit>(context)
//                                         .emitShow();
//                                   },
//                                 ),
//                               ),
//                               searchMatchFn: (item, searchValue) {
//                                 return item.value!.label!.contains(searchValue);
//                               },
//                             ),
//                             onMenuStateChange: (isOpen) {
//                               if (isOpen) {
//                                 setState2(() {
//                                   originControllers[0].clear();
//                                 });
//                               }
//                             },
//                             buttonStyleData: ButtonStyleData(
//                               height: 50,
//                               width: double.infinity,
//                               padding:
//                                   const EdgeInsets.only(left: 14, right: 14),

//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                   color: Colors.black26,
//                                 ),
//                                 color: Colors.white,
//                               ),
//                               // elevation: 2,
//                             ),
//                             iconStyleData: const IconStyleData(
//                               icon: Icon(
//                                 Icons.keyboard_arrow_down_sharp,
//                               ),
//                               iconSize: 20,
//                               iconEnabledColor: AppColor.AccentBlue,
//                               iconDisabledColor: Colors.grey,
//                             ),
//                             dropdownStyleData: DropdownStyleData(
//                               maxHeight: MediaQuery.of(context).size.height,
//                               padding: const EdgeInsets.all(8.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(14),
//                                 color: Colors.white,
//                               ),
//                               scrollbarTheme: ScrollbarThemeData(
//                                 radius: const Radius.circular(40),
//                                 thickness: MaterialStateProperty.all(6),
//                                 thumbVisibility:
//                                     MaterialStateProperty.all(true),
//                               ),
//                             ),
//                             menuItemStyleData: const MenuItemStyleData(
//                               height: 40,
//                             ),
//                           ),
//                         );
//                       });
//                     } else if (flagstate is FlagsLoadingProgressState) {
//                       return const Center(
//                         child: LinearProgressIndicator(),
//                       );
//                     } else {
//                       return Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             BlocProvider.of<FlagsBloc>(context)
//                                 .add(FlagsLoadEvent());
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 AppLocalizations.of(context)!
//                                     .translate('list_error'),
//                                 style: const TextStyle(color: Colors.red),
//                               ),
//                               const Icon(
//                                 Icons.refresh,
//                                 color: Colors.grey,
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//                 const SizedBox(
//                   height: 14,
//                 ),

//                 Visibility(
//                   visible: originerrors[0],
//                   child: Text(
//                     AppLocalizations.of(context)!
//                         .translate('select_origin_error'),
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ),
//                 Visibility(
//                   visible: originerrors[0],
//                   child: const SizedBox(
//                     height: 24,
//                   ),
//                 ),
//                 TextFormField(
//                   controller: weightControllers[0],
//                   // focusNode: _nodeWeight,
//                   onTap: () {
//                     BlocProvider.of<BottomNavBarCubit>(context).emitHide();
//                     weightControllers[0].selection = TextSelection(
//                         baseOffset: 0,
//                         extentOffset: weightControllers[0].value.text.length);
//                   },
//                   // enabled: !valueEnabled,
//                   scrollPadding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom + 50),
//                   textInputAction: TextInputAction.done,
//                   keyboardType: const TextInputType.numberWithOptions(
//                       decimal: true, signed: true),
//                   inputFormatters: [
//                     DecimalFormatter(),
//                   ],
//                   style: const TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     labelText:
//                         AppLocalizations.of(context)!.translate('weight'),
//                     suffixText: showunits[0] ? weightLabels[0] : "",
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 9.0,
//                       vertical: 11.0,
//                     ),
//                   ),
//                   onChanged: (value) {
//                     if (origins[0] != null) {
//                       setState(() {
//                         originerrors[0] = false;
//                       });
//                       if (value.isNotEmpty) {
//                         calculateTotalValueWithPrice(0);
//                         weightValues[0] = int.parse(value);
//                       } else {
//                         weightValues[0] = 0;
//                       }
//                       evaluatePrice(0);
//                     } else {
//                       originerrors[0] = true;
//                     }
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return AppLocalizations.of(context)!
//                           .translate('insert_value_validate');
//                     }
//                     return null;
//                   },
//                   onFieldSubmitted: (value) {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                     BlocProvider.of<BottomNavBarCubit>(context).emitShow();
//                   },
//                 ),

//                 const SizedBox(
//                   height: 12,
//                 ),
//                 TextFormField(
//                   controller: valueControllers[0],
//                   // focusNode: _nodeValue,
//                   onTap: () {
//                     BlocProvider.of<BottomNavBarCubit>(context).emitHide();
//                     valueControllers[0].selection = TextSelection(
//                         baseOffset: 0,
//                         extentOffset: valueControllers[0].value.text.length);
//                   },
//                   // enabled: valueEnabled,
//                   textInputAction: TextInputAction.done,
//                   keyboardType: const TextInputType.numberWithOptions(
//                       decimal: true, signed: true),
//                   inputFormatters: [
//                     DecimalFormatter(),
//                   ],
//                   scrollPadding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom + 50),
//                   style: const TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     suffixText: "\$",
//                     labelText: valueEnabled[0]
//                         ? AppLocalizations.of(context)!
//                             .translate('total_value_in_dollar')
//                         : AppLocalizations.of(context)!
//                             .translate('price_for_custome'),
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 9.0,
//                       vertical: 11.0,
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return AppLocalizations.of(context)!
//                           .translate('insert_value_validate');
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     if (origins[0] != null) {
//                       originerrors[0] = false;
//                       if (value.isNotEmpty) {
//                         basePriceValues[0] = double.parse(value);
//                         calculateTotalValue(0);
//                       } else {
//                         basePriceValues[0] = 0.0;
//                         calculateTotalValue(0);
//                       }
//                       evaluatePrice(0);
//                     } else {
//                       originerrors[0] = true;
//                     }
//                   },
//                   onFieldSubmitted: (value) {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                     BlocProvider.of<BottomNavBarCubit>(context).emitShow();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),

//                 // Visibility(
//                 //   visible: isfeeequal001,
//                 //   child: const SizedBox(
//                 //     height: 12,
//                 //   ),
//                 // ),
//                 // const Text(
//                 //   "ملاحظة: الحد الأدنى للسعر الاسترشادي هو 100\$",
//                 //   style: TextStyle(color: Colors.grey),
//                 // ),
//                 // const SizedBox(
//                 //   height: 12,
//                 // ),
//               ],
//             ),
//           ),
//         );
//       setState(() => ++_count);
//     });

//     _keyboardVisibilityController = KeyboardVisibilityController();
//     keyboardSubscription =
//         _keyboardVisibilityController.onChange.listen((isVisible) {
//       if (!isVisible) {
//         FocusManager.instance.primaryFocus?.unfocus();
//         BlocProvider.of<BottomNavBarCubit>(context).emitShow();
//       }
//     });
//     // FocusScope.of(context).unfocus();
//   }

//   void _add() {
//     TextEditingController package_controller = TextEditingController();
//     TextEditingController weight_controller = TextEditingController();
//     TextEditingController value_controller = TextEditingController();
//     TextEditingController origin_controller = TextEditingController();

//     packageControllers.add(package_controller);
//     weightControllers.add(weight_controller);
//     valueControllers.add(value_controller);
//     originControllers.add(origin_controller);
//     packages.add(null);
//     origins.add(null);
//     allowexports.add(false);
//     feeerrors.add(false);
//     isdropdownVisibles.add(false);
//     placeholders.add("");
//     extraslist.add([]);
//     extraselectedValues.add(null);
//     isfeeequal001.add(false);
//     rawMaterialValues.add(false);
//     industrialValues.add(false);
//     isBrands.add(false);
//     brandValus.add(false);
//     isTubes.add(false);
//     tubeValus.add(false);
//     isColored.add(false);
//     colorValus.add(false);
//     isLycra.add(false);
//     lycraValus.add(false);
//     extraPrices.add(0.0);
//     originerrors.add(false);
//     showunits.add(false);
//     weightUnits.add("kg");
//     weightLabels.add("kg");
//     weightValues.add(0);
//     basePriceValues.add(0);
//     valueEnabled.add(false);
//     syrianExchangeValue.add("8585");
//     syrianTotalValue.add("0.0");
//     totalValueWithEnsurance.add("0.0");

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _children = List.from(_children)
//         ..add(
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Focus(
//                       // focusNode: _ordernode,
//                       child: Text(
//                         AppLocalizations.of(context)!
//                             .translate('goods_details'),
//                         style: TextStyle(
//                           fontSize: 19,
//                           fontWeight: FontWeight.bold,
//                           color: AppColor.deepBlue,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   _count.toString(),
//                   style: TextStyle(
//                     fontSize: 19,
//                     fontWeight: FontWeight.bold,
//                     color: AppColor.deepBlue,
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         BlocProvider.of<CalculatorPanelBloc>(context)
//                             .add(TariffPanelOpenEvent());

//                         FocusManager.instance.primaryFocus?.unfocus();
//                         BlocProvider.of<BottomNavBarCubit>(context).emitShow();
//                         _countselected = _count - 1;
//                         print(_countselected);
//                         print(_count);
//                       },
//                       child: SizedBox(
//                         height: 40.h,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             SizedBox(
//                               width: 25.w,
//                               height: 25.h,
//                               child: SvgPicture.asset(
//                                 "assets/icons/tarrif_btn.svg",
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 3,
//                             ),
//                             Text(
//                               AppLocalizations.of(context)!
//                                   .translate('tariff_browser'),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: AppColor.lightBlue,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         BlocProvider.of<CalculatorPanelBloc>(context)
//                             .add(TariffPanelOpenEvent());
//                         FocusManager.instance.primaryFocus?.unfocus();
//                         BlocProvider.of<BottomNavBarCubit>(context).emitShow();
//                         _countselected = _count - 1;
//                         print(_countselected);
//                         print(_count);
//                       },
//                       child: TypeAheadField(
//                         textFieldConfiguration: TextFieldConfiguration(
//                           // autofocus: true,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: null,
//                           enabled: false,
//                           controller: packageControllers[_count],
//                           scrollPadding: EdgeInsets.only(
//                               bottom: MediaQuery.of(context).viewInsets.bottom +
//                                   150),
//                           style: const TextStyle(fontSize: 18),
//                           decoration: InputDecoration(
//                             labelText: AppLocalizations.of(context)!
//                                 .translate('goods_name'),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 9.0,
//                               vertical: 11.0,
//                             ),
//                           ),
//                           onSubmitted: (value) {
//                             BlocProvider.of<StopScrollCubit>(context)
//                                 .emitEnable();
//                             FocusManager.instance.primaryFocus?.unfocus();
//                             BlocProvider.of<BottomNavBarCubit>(context)
//                                 .emitShow();
//                           },
//                         ),
//                         loadingBuilder: (context) {
//                           return Container(
//                             color: Colors.white,
//                             child: const Center(
//                               child: LoadingIndicator(),
//                             ),
//                           );
//                         },
//                         errorBuilder: (context, error) {
//                           return Container(
//                             color: Colors.white,
//                           );
//                         },
//                         noItemsFoundBuilder: (value) {
//                           var localizedMessage = AppLocalizations.of(context)!
//                               .translate('no_result_found');
//                           return Container(
//                             width: double.infinity,
//                             color: Colors.white,
//                             child: Center(
//                               child: Text(
//                                 localizedMessage,
//                                 style: TextStyle(fontSize: 18.sp),
//                               ),
//                             ),
//                           );
//                         },
//                         suggestionsCallback: (pattern) async {
//                           return [];
//                         },
//                         itemBuilder: (context, suggestion) {
//                           return Container();
//                         },
//                         onSuggestionSelected: (suggestion) {},
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 14,
//                 ),
//                 Visibility(
//                   visible: allowexports[_count],
//                   child: Text(
//                     AppLocalizations.of(context)!
//                         .translate('fee_import_banned'),
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: allowexports[_count],
//                   child: const SizedBox(
//                     height: 14,
//                   ),
//                 ),
//                 Visibility(
//                   visible: feeerrors[_count],
//                   child: Text(
//                     AppLocalizations.of(context)!.translate('select_fee_error'),
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: feeerrors[_count],
//                   child: const SizedBox(
//                     height: 14,
//                   ),
//                 ),
//                 Visibility(
//                   visible: isdropdownVisibles[_count],
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton2<Extras>(
//                       isExpanded: true,
//                       barrierLabel: placeholders[_count],
//                       hint: Text(
//                         placeholders[_count],
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Theme.of(context).hintColor,
//                         ),
//                       ),
//                       items: extraslist[_count]
//                           .map((Extras item) => DropdownMenuItem<Extras>(
//                                 value: item,
//                                 child: Text(
//                                   item.label!,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ))
//                           .toList(),
//                       value: extraselectedValues[_count],
//                       onChanged: (Extras? value) {
//                         if (value!.countryGroup!.isEmpty) {
//                           if (value.price! > 0) {
//                             basePriceValues[_count] = value.price!;
//                             valueEnabled[_count] = false;
//                             setState(() {
//                               valueControllers[_count].text =
//                                   basePriceValues[_count].toString();
//                             });
//                           } else {
//                             basePriceValues[_count] = 0.0;
//                             valueEnabled[_count] = true;
//                             setState(() {
//                               valueControllers[_count].text = "0.0";
//                             });
//                           }
//                           evaluatePrice(_count);
//                         } else {
//                           if (value.price! > 0) {
//                             basePriceValues[_count] = value.price!;
//                             valueEnabled[_count] = false;

//                             setState(() {
//                               valueControllers[_count].text =
//                                   value.price!.toString();
//                             });
//                           } else {
//                             basePriceValues[_count] = value.price!;
//                             valueEnabled[_count] = true;
//                             setState(() {
//                               valueControllers[_count].text = "0.0";
//                             });
//                           }
//                           evaluatePrice(_count);
//                         }
//                         extraselectedValues[_count] = value;
//                       },
//                       buttonStyleData: ButtonStyleData(
//                         height: 50,
//                         width: double.infinity,

//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 9.0,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: Colors.black26,
//                           ),
//                           color: Colors.white,
//                         ),
//                         // elevation: 2,
//                       ),
//                       iconStyleData: const IconStyleData(
//                         icon: Icon(
//                           Icons.keyboard_arrow_down_sharp,
//                         ),
//                         iconSize: 20,
//                         iconEnabledColor: AppColor.AccentBlue,
//                         iconDisabledColor: Colors.grey,
//                       ),
//                       dropdownStyleData: DropdownStyleData(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(14),
//                           color: Colors.white,
//                         ),
//                         scrollbarTheme: ScrollbarThemeData(
//                           radius: const Radius.circular(40),
//                           thickness: MaterialStateProperty.all(6),
//                           thumbVisibility: MaterialStateProperty.all(true),
//                         ),
//                       ),
//                       menuItemStyleData: MenuItemStyleData(
//                         height: 50.h,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: isdropdownVisibles[_count],
//                   child: const SizedBox(
//                     height: 24,
//                   ),
//                 ),
//                 Wrap(
//                   children: [
//                     Visibility(
//                       visible: isfeeequal001[_count],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: rawMaterialValues[_count],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('raw_material')),
//                             onChanged: (value) {
//                               setState(() {
//                                 rawMaterialValues[_count] = value!;
//                               });
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isfeeequal001[_count],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: industrialValues[_count],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('industrial')),
//                             onChanged: (value) {
//                               industrialValues[_count] = value!;
//                               evaluatePrice(_count);
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isBrands[_count],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: brandValus[_count],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('isBrand')),
//                             onChanged: (value) {
//                               calculateExtrasPrice(1.5, value!, _count);
//                               valueControllers[_count].text =
//                                   extraPrices[_count].toString();
//                               brandValus[_count] = value!;
//                               evaluatePrice(_count);
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isTubes[_count],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: tubeValus[_count],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('isTubeValue')),
//                             onChanged: (value) {
//                               calculateExtrasPrice(.1, value!, _count);
//                               valueControllers[_count].text =
//                                   extraPrices[_count].toString();
//                               tubeValus[_count] = value!;
//                               evaluatePrice(_count);
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isColored[_count],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: colorValus[_count],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('isColored')),
//                             onChanged: (value) {
//                               calculateExtrasPrice(.1, value!, _count);
//                               valueControllers[_count].text =
//                                   extraPrices[_count].toString();
//                               colorValus[_count] = value!;
//                               evaluatePrice(_count);
//                             }),
//                       ),
//                     ),
//                     Visibility(
//                       visible: isLycra[_count],
//                       child: SizedBox(
//                         width: MediaQuery.of(context).size.width * .4,
//                         child: CheckboxListTile(
//                             value: lycraValus[_count],
//                             contentPadding: EdgeInsets.zero,
//                             controlAffinity: ListTileControlAffinity.leading,
//                             title: Text(AppLocalizations.of(context)!
//                                 .translate('isLycra')),
//                             onChanged: (value) {
//                               calculateExtrasPrice(.05, value!, _count);
//                               valueControllers[_count].text =
//                                   extraPrices[_count].toString();
//                               lycraValus[_count] = value!;

//                               evaluatePrice(_count);
//                             }),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // BlocBuilder<FlagsBloc, FlagsState>(
//                 //   builder: (context, flagstate) {
//                 //     if (flagstate is FlagsLoadedSuccess) {
//                 //       return StatefulBuilder(builder: (context, setState2) {
//                 //         return DropdownButtonHideUnderline(
//                 //           child: DropdownButton2<Origin>(
//                 //             isExpanded: true,
//                 //             hint: Text(
//                 //               AppLocalizations.of(context)!
//                 //                   .translate('select_origin'),
//                 //               style: TextStyle(
//                 //                 fontSize: 15,
//                 //                 color: Theme.of(context).hintColor,
//                 //               ),
//                 //             ),
//                 //             items: flagstate.origins
//                 //                 .map((Origin item) => DropdownMenuItem<Origin>(
//                 //                       value: item,
//                 //                       child: SizedBox(
//                 //                         // width: 200,
//                 //                         child: Row(
//                 //                           children: [
//                 //                             SizedBox(
//                 //                               height: 35,
//                 //                               width: 55,
//                 //                               child: SvgPicture.network(
//                 //                                 item.imageURL!,
//                 //                                 height: 35,
//                 //                                 width: 55,
//                 //                                 // semanticsLabel: 'A shark?!',
//                 //                                 placeholderBuilder:
//                 //                                     (BuildContext context) =>
//                 //                                         Container(
//                 //                                   height: 35.h,
//                 //                                   width: 45.w,
//                 //                                   decoration: BoxDecoration(
//                 //                                     color: Colors.grey[200],
//                 //                                     borderRadius:
//                 //                                         BorderRadius.circular(
//                 //                                             5),
//                 //                                   ),
//                 //                                 ),
//                 //                               ),
//                 //                             ),
//                 //                             const SizedBox(width: 7),
//                 //                             Container(
//                 //                               constraints: BoxConstraints(
//                 //                                 maxWidth: 280.w,
//                 //                               ),
//                 //                               child: Text(
//                 //                                 item.label!,
//                 //                                 overflow: TextOverflow.ellipsis,
//                 //                                 // maxLines: 2,
//                 //                               ),
//                 //                             ),
//                 //                           ],
//                 //                           // subtitle: Text('\$${suggestion['price']}'),
//                 //                         ),
//                 //                       ),
//                 //                     ))
//                 //                 .toList(),
//                 //             value: origins[_count],
//                 //             onChanged: (Origin? value) {
//                 //               setState2(() {
//                 //                 origins[_count] = value;
//                 //               });
//                 //             },
//                 //             barrierColor: Colors.black45,
//                 //             dropdownSearchData: DropdownSearchData(
//                 //               searchController: originControllers[_count],
//                 //               searchInnerWidgetHeight: 60,
//                 //               searchInnerWidget: Container(
//                 //                 height: 60,
//                 //                 padding: const EdgeInsets.only(
//                 //                   top: 8,
//                 //                   bottom: 4,
//                 //                   right: 8,
//                 //                   left: 8,
//                 //                 ),
//                 //                 child: TextFormField(
//                 //                   expands: true,
//                 //                   maxLines: null,
//                 //                   controller: originControllers[_count],
//                 //                   onTap: () {
//                 //                     originControllers[_count].selection =
//                 //                         TextSelection(
//                 //                       baseOffset: 0,
//                 //                       extentOffset: originControllers[_count]
//                 //                           .value
//                 //                           .text
//                 //                           .length,
//                 //                     );
//                 //                   },
//                 //                   decoration: InputDecoration(
//                 //                     isDense: true,
//                 //                     contentPadding: const EdgeInsets.symmetric(
//                 //                       horizontal: 10,
//                 //                       vertical: 8,
//                 //                     ),
//                 //                     labelText: AppLocalizations.of(context)!
//                 //                         .translate('select_origin'),
//                 //                     hintStyle: const TextStyle(fontSize: 12),
//                 //                     border: OutlineInputBorder(
//                 //                       borderRadius: BorderRadius.circular(8),
//                 //                     ),
//                 //                   ),
//                 //                   onTapOutside: (event) {
//                 //                     FocusManager.instance.primaryFocus
//                 //                         ?.unfocus();
//                 //                     BlocProvider.of<BottomNavBarCubit>(context)
//                 //                         .emitShow();
//                 //                   },
//                 //                   onFieldSubmitted: (value) {
//                 //                     FocusManager.instance.primaryFocus
//                 //                         ?.unfocus();
//                 //                     BlocProvider.of<BottomNavBarCubit>(context)
//                 //                         .emitShow();
//                 //                   },
//                 //                 ),
//                 //               ),
//                 //               searchMatchFn: (item, searchValue) {
//                 //                 return item.value!.label!.contains(searchValue);
//                 //               },
//                 //             ),
//                 //             onMenuStateChange: (isOpen) {
//                 //               if (isOpen) {
//                 //                 setState2(() {
//                 //                   originControllers[_count].clear();
//                 //                 });
//                 //               }
//                 //             },
//                 //             buttonStyleData: ButtonStyleData(
//                 //               height: 50,
//                 //               width: double.infinity,
//                 //               padding:
//                 //                   const EdgeInsets.only(left: 14, right: 14),

//                 //               decoration: BoxDecoration(
//                 //                 borderRadius: BorderRadius.circular(12),
//                 //                 border: Border.all(
//                 //                   color: Colors.black26,
//                 //                 ),
//                 //                 color: Colors.white,
//                 //               ),
//                 //               // elevation: 2,
//                 //             ),
//                 //             iconStyleData: const IconStyleData(
//                 //               icon: Icon(
//                 //                 Icons.keyboard_arrow_down_sharp,
//                 //               ),
//                 //               iconSize: 20,
//                 //               iconEnabledColor: AppColor.AccentBlue,
//                 //               iconDisabledColor: Colors.grey,
//                 //             ),
//                 //             dropdownStyleData: DropdownStyleData(
//                 //               maxHeight: MediaQuery.of(context).size.height,
//                 //               padding: const EdgeInsets.all(8.0),
//                 //               decoration: BoxDecoration(
//                 //                 borderRadius: BorderRadius.circular(14),
//                 //                 color: Colors.white,
//                 //               ),
//                 //               scrollbarTheme: ScrollbarThemeData(
//                 //                 radius: const Radius.circular(40),
//                 //                 thickness: MaterialStateProperty.all(6),
//                 //                 thumbVisibility:
//                 //                     MaterialStateProperty.all(true),
//                 //               ),
//                 //             ),
//                 //             menuItemStyleData: const MenuItemStyleData(
//                 //               height: 40,
//                 //             ),
//                 //           ),
//                 //         );
//                 //       });
//                 //     } else if (flagstate is FlagsLoadingProgressState) {
//                 //       return const Center(
//                 //         child: LinearProgressIndicator(),
//                 //       );
//                 //     } else {
//                 //       return Center(
//                 //         child: GestureDetector(
//                 //           onTap: () {
//                 //             BlocProvider.of<FlagsBloc>(context)
//                 //                 .add(FlagsLoadEvent());
//                 //           },
//                 //           child: Row(
//                 //             mainAxisAlignment: MainAxisAlignment.center,
//                 //             children: [
//                 //               Text(
//                 //                 AppLocalizations.of(context)!
//                 //                     .translate('list_error'),
//                 //                 style: const TextStyle(color: Colors.red),
//                 //               ),
//                 //               const Icon(
//                 //                 Icons.refresh,
//                 //                 color: Colors.grey,
//                 //               )
//                 //             ],
//                 //           ),
//                 //         ),
//                 //       );
//                 //     }
//                 //   },
//                 // ),
//                 const SizedBox(
//                   height: 14,
//                 ),

//                 Visibility(
//                   visible: originerrors[_count],
//                   child: Text(
//                     AppLocalizations.of(context)!
//                         .translate('select_origin_error'),
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ),
//                 Visibility(
//                   visible: originerrors[_count],
//                   child: const SizedBox(
//                     height: 24,
//                   ),
//                 ),
//                 TextFormField(
//                   controller: weightControllers[_count],
//                   // focusNode: _nodeWeight,
//                   onTap: () {
//                     BlocProvider.of<BottomNavBarCubit>(context).emitHide();
//                     weightControllers[_count].selection = TextSelection(
//                         baseOffset: 0,
//                         extentOffset:
//                             weightControllers[_count].value.text.length);
//                   },
//                   // enabled: !valueEnabled,
//                   scrollPadding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom + 50),
//                   textInputAction: TextInputAction.done,
//                   keyboardType: const TextInputType.numberWithOptions(
//                       decimal: true, signed: true),
//                   inputFormatters: [
//                     DecimalFormatter(),
//                   ],
//                   style: const TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     labelText:
//                         AppLocalizations.of(context)!.translate('weight'),
//                     suffixText: showunits[_count] ? weightLabels[_count] : "",
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 9.0,
//                       vertical: 11.0,
//                     ),
//                   ),
//                   onChanged: (value) {
//                     if (origins[_count] != null) {
//                       setState(() {
//                         originerrors[_count] = false;
//                       });
//                       if (value.isNotEmpty) {
//                         calculateTotalValueWithPrice(_count);
//                         weightValues[_count] = int.parse(value);
//                       } else {
//                         weightValues[_count] = 0;
//                       }
//                       evaluatePrice(_count);
//                     } else {
//                       originerrors[_count] = true;
//                     }
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return AppLocalizations.of(context)!
//                           .translate('insert_value_validate');
//                     }
//                     return null;
//                   },
//                   onFieldSubmitted: (value) {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                     BlocProvider.of<BottomNavBarCubit>(context).emitShow();
//                   },
//                 ),

//                 const SizedBox(
//                   height: 12,
//                 ),
//                 TextFormField(
//                   controller: valueControllers[_count],
//                   // focusNode: _nodeValue,
//                   onTap: () {
//                     BlocProvider.of<BottomNavBarCubit>(context).emitHide();
//                     valueControllers[_count].selection = TextSelection(
//                         baseOffset: 0,
//                         extentOffset:
//                             valueControllers[_count].value.text.length);
//                   },
//                   // enabled: valueEnabled,
//                   textInputAction: TextInputAction.done,
//                   keyboardType: const TextInputType.numberWithOptions(
//                       decimal: true, signed: true),
//                   inputFormatters: [
//                     DecimalFormatter(),
//                   ],
//                   scrollPadding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom + 50),
//                   style: const TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     suffixText: "\$",
//                     labelText: valueEnabled[_count]
//                         ? AppLocalizations.of(context)!
//                             .translate('total_value_in_dollar')
//                         : AppLocalizations.of(context)!
//                             .translate('price_for_custome'),
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 9.0,
//                       vertical: 11.0,
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return AppLocalizations.of(context)!
//                           .translate('insert_value_validate');
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     if (origins[_count] != null) {
//                       originerrors[_count] = false;
//                       if (value.isNotEmpty) {
//                         basePriceValues[_count] = double.parse(value);
//                         calculateTotalValue(_count);
//                       } else {
//                         basePriceValues[_count] = 0.0;
//                         calculateTotalValue(_count);
//                       }
//                       evaluatePrice(_count);
//                     } else {
//                       originerrors[_count] = true;
//                     }
//                   },
//                   onFieldSubmitted: (value) {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                     BlocProvider.of<BottomNavBarCubit>(context).emitShow();
//                   },
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),

//                 // Visibility(
//                 //   visible: isfeeequal001,
//                 //   child: const SizedBox(
//                 //     height: 12,
//                 //   ),
//                 // ),
//                 // const Text(
//                 //   "ملاحظة: الحد الأدنى للسعر الاسترشادي هو 100\$",
//                 //   style: TextStyle(color: Colors.grey),
//                 // ),
//                 // const SizedBox(
//                 //   height: 12,
//                 // ),
//               ],
//             ),
//           ),
//         );
//       setState(() => ++_count);
//     });
//   }

//   @override
//   void dispose() {
//     keyboardSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LocaleCubit, LocaleState>(
//       builder: (context, localeState) {
//         return Directionality(
//           textDirection: localeState.value.languageCode == 'en'
//               ? TextDirection.ltr
//               : TextDirection.rtl,
//           child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             backgroundColor: Colors.grey[200],
//             body: SafeArea(
//               child: Stack(
//                 children: [
//                   BlocBuilder<StopScrollCubit, StopScrollState>(
//                     builder: (context, state) {
//                       return SingleChildScrollView(
//                         physics: (state is ScrollEnabled)
//                             ? const ClampingScrollPhysics()
//                             : const NeverScrollableScrollPhysics(),
//                         child: GestureDetector(
//                           onTap: () {
//                             FocusManager.instance.primaryFocus?.unfocus();
//                             BlocProvider.of<BottomNavBarCubit>(context)
//                                 .emitShow();
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: 12.h,
//                                   ),
//                                   Card(
//                                     clipBehavior: Clip.antiAlias,
//                                     shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.all(
//                                       Radius.circular(15),
//                                     )),
//                                     margin:
//                                         EdgeInsets.symmetric(horizontal: 10.w),
//                                     elevation: 1,
//                                     color: Colors.white,
//                                     child: Container(
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 7),
//                                       width: double.infinity,
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: BlocListener<FeeSelectBloc,
//                                           FeeSelectState>(
//                                         listener: (context, state) {
//                                           if (state is FeeSelectSuccess) {
//                                             setState(() {
//                                               weightControllers[_countselected]
//                                                   .text = "0.0";
//                                               valueControllers[_countselected]
//                                                   .text = "0.0";

//                                               // calculatorProvider.initProvider();
//                                             });
//                                             selectSuggestion(
//                                                 state.package, _countselected);
//                                             setState(() {
//                                               print(packages[_countselected]!
//                                                   .label!);
//                                               print(_countselected);
//                                               packageControllers[_countselected]
//                                                       .text =
//                                                   packages[_countselected]!
//                                                       .label!;
//                                               valueControllers[_countselected]
//                                                   .text = basePriceValues[
//                                                       _countselected]
//                                                   .toString();
//                                             });
//                                           }
//                                         },
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             FocusManager.instance.primaryFocus
//                                                 ?.unfocus();
//                                             BlocProvider.of<BottomNavBarCubit>(
//                                                     context)
//                                                 .emitShow();
//                                           },
//                                           child: Form(
//                                             key: _calformkey,
//                                             child: Column(
//                                               children: [
//                                                 ListView(
//                                                   physics:
//                                                       NeverScrollableScrollPhysics(),
//                                                   shrinkWrap: true,
//                                                   children: _children,
//                                                 ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   children: [
//                                                     GestureDetector(
//                                                       onTap: _add,
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Icon(
//                                                             Icons
//                                                                 .add_circle_outline,
//                                                             size: 35,
//                                                             color: AppColor
//                                                                 .deepYellow,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Container(
//                                                   width: double.infinity,
//                                                   decoration: BoxDecoration(
//                                                     color: AppColor.lightGreen,
//                                                     border: Border.all(
//                                                         color: Colors.black26,
//                                                         width: 2),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             12),
//                                                   ),
//                                                   padding: const EdgeInsets.all(
//                                                       15.0),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         "${AppLocalizations.of(context)!.translate('convert_to_dollar_value')}: ${f.format(double.parse(syrianExchangeValue[0]).toInt())}\$",
//                                                         style: TextStyle(
//                                                             fontSize: 17.sp),
//                                                       ),
//                                                       Text(
//                                                         "${AppLocalizations.of(context)!.translate('total_value_in_eygptian_pound')}: ${f.format(double.parse(syrianTotalValue[0]).toInt())} E.P",
//                                                         style: TextStyle(
//                                                             fontSize: 17.sp),
//                                                       ),
//                                                       Text(
//                                                         "${AppLocalizations.of(context)!.translate('total_value_with_insurance')}: ${f.format(double.parse(totalValueWithEnsurance[0]).toInt())} E.P",
//                                                         style: TextStyle(
//                                                             fontSize: 17.sp),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10.h,
//                                                 ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     BlocConsumer<
//                                                         CalculateMultiResultBloc,
//                                                         CalculateMultiResultState>(
//                                                       listener:
//                                                           (context, state) {
//                                                         if (state
//                                                             is CalculateMultiResultSuccessed) {
//                                                           print(state.result
//                                                               .totalAddedTaxes);
//                                                           print(state.result
//                                                               .totalCategoryPrice);
//                                                           print(state.result
//                                                               .totalFinalFee);
//                                                           print(state.result
//                                                               .totalFinalTotal);
//                                                           print(state.result
//                                                               .totalInsuranceFee);
//                                                           print(state.result
//                                                               .totalReconstructionFee);
//                                                         }
//                                                       },
//                                                       builder:
//                                                           (context, state) {
//                                                         if (state
//                                                             is CalculateMultiResultLoading) {
//                                                           return CustomButton(
//                                                               onTap: () {},
//                                                               title: SizedBox(
//                                                                   width: 250.w,
//                                                                   child: const Center(
//                                                                       child:
//                                                                           LoadingIndicator())));
//                                                         }
//                                                         if (state
//                                                             is CalculateMultiResultFailed) {
//                                                           return Text(
//                                                               state.error);
//                                                         } else {
//                                                           return CustomButton(
//                                                             onTap: () {
//                                                               print("asd");
//                                                               _calformkey
//                                                                   .currentState
//                                                                   ?.save();
//                                                               if (_calformkey
//                                                                   .currentState!
//                                                                   .validate()) {
//                                                                 print("asd");
//                                                                 for (var i = 0;
//                                                                     i <
//                                                                         origins
//                                                                             .length;
//                                                                     i++) {
//                                                                   if (origins[
//                                                                           i] !=
//                                                                       null) {
//                                                                     publicOriginError =
//                                                                         false;
//                                                                     originerrors[
//                                                                             i] =
//                                                                         false;
//                                                                   } else {
//                                                                     originerrors[
//                                                                             i] =
//                                                                         true;
//                                                                     publicOriginError =
//                                                                         true;
//                                                                   }
//                                                                 }
//                                                                 print("asd12");

//                                                                 // for (var i = 0; i < packages.length; i++) {
//                                                                 //   if (packages[i] != null) {
//                                                                 //     feeerrors[i] = false;
//                                                                 //     publicPackageError = false;
//                                                                 //   } else {
//                                                                 //     publicPackageError = true;
//                                                                 //   }
//                                                                 // }
//                                                                 print("asd123");
//                                                                 FocusManager
//                                                                     .instance
//                                                                     .primaryFocus
//                                                                     ?.unfocus();
//                                                                 BlocProvider.of<
//                                                                             BottomNavBarCubit>(
//                                                                         context)
//                                                                     .emitShow();
//                                                                 // List<CalculateObject> objects = [];
//                                                                 objects = [];

//                                                                 if (!publicOriginError &&
//                                                                     !publicPackageError) {
//                                                                   print("asd4");
//                                                                   for (var i =
//                                                                           0;
//                                                                       i <
//                                                                           packages
//                                                                               .length;
//                                                                       i++) {
//                                                                     objects.add(
//                                                                         CalculateObject());
//                                                                     objects[i]
//                                                                             .insurance =
//                                                                         int.parse(
//                                                                             totalValueWithEnsurance[i]);
//                                                                     objects[i]
//                                                                             .fee =
//                                                                         packages[i]!
//                                                                             .fee;
//                                                                     objects[i]
//                                                                             .rawMaterial =
//                                                                         rawMaterialValues[i]
//                                                                             ? 1
//                                                                             : 0;
//                                                                     objects[i]
//                                                                             .industrial =
//                                                                         industrialValues[i]
//                                                                             ? 1
//                                                                             : 0;
//                                                                     objects[i]
//                                                                         .totalTax = packages[
//                                                                             i]!
//                                                                         .totalTaxes!
//                                                                         .totalTax;
//                                                                     objects[i]
//                                                                         .partialTax = packages[
//                                                                             i]!
//                                                                         .totalTaxes!
//                                                                         .partialTax;
//                                                                     objects[i]
//                                                                         .origin = origins[
//                                                                             i]!
//                                                                         .label;
//                                                                     objects[i]
//                                                                         .spendingFee = packages[
//                                                                             i]!
//                                                                         .spendingFee;
//                                                                     objects[i]
//                                                                         .supportFee = packages[
//                                                                             i]!
//                                                                         .supportFee;
//                                                                     objects[i]
//                                                                         .localFee = packages[
//                                                                             i]!
//                                                                         .localFee;
//                                                                     objects[i]
//                                                                         .protectionFee = packages[
//                                                                             i]!
//                                                                         .protectionFee;
//                                                                     objects[i]
//                                                                         .naturalFee = packages[
//                                                                             i]!
//                                                                         .naturalFee;
//                                                                     objects[i]
//                                                                         .taxFee = packages[
//                                                                             i]!
//                                                                         .taxFee;
//                                                                     objects[i]
//                                                                             .weight =
//                                                                         weightValues[
//                                                                             i];
//                                                                     objects[i]
//                                                                         .price = basePriceValues[
//                                                                             i]
//                                                                         .toInt();
//                                                                     objects[i]
//                                                                         .cnsulate = 1;
//                                                                     objects[i]
//                                                                             .dolar =
//                                                                         8585;
//                                                                     objects[i]
//                                                                         .arabic_stamp = packages[
//                                                                             i]!
//                                                                         .totalTaxes!
//                                                                         .arabicStamp!
//                                                                         .toInt();
//                                                                     objects[i]
//                                                                         .import_fee = packages[
//                                                                             i]!
//                                                                         .importFee!;
//                                                                   }
//                                                                   BlocProvider.of<
//                                                                               CalculateMultiResultBloc>(
//                                                                           context)
//                                                                       .add(CalculateMultiTheResultEvent(
//                                                                           objects));
//                                                                   FocusManager
//                                                                       .instance
//                                                                       .primaryFocus
//                                                                       ?.unfocus();
//                                                                   BlocProvider.of<
//                                                                               BottomNavBarCubit>(
//                                                                           context)
//                                                                       .emitShow();

//                                                                   Navigator.push(
//                                                                       context,
//                                                                       MaterialPageRoute(
//                                                                         builder:
//                                                                             (context) =>
//                                                                                 TraderCalculatorResultScreen(),
//                                                                       ));
//                                                                 }
//                                                               }
//                                                             },
//                                                             title: SizedBox(
//                                                               width: 250.w,
//                                                               child: Center(
//                                                                 child: Text(
//                                                                   AppLocalizations.of(
//                                                                           context)!
//                                                                       .translate(
//                                                                           'calculate_costume_fee'),
//                                                                   style:
//                                                                       const TextStyle(
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           );
//                                                         }
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10.h,
//                                   )
//                                 ]),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   BlocBuilder<FeeSelectBloc, FeeSelectState>(
//                     builder: (context, state) {
//                       if (state is FeeSelectLoadingProgress) {
//                         return Container(
//                           color: Colors.white54,
//                           child:
//                               const Center(child: LoadingIndicator()),
//                         );
//                       } else {
//                         return const SizedBox.shrink();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   selectSuggestion(Package suggestion, int index) {
//     packages[index] = suggestion;
//     feeerrors[index] = false;
//     if (suggestion.price! > 0) {
//       basePriceValues[index] = suggestion.price!;
//       valueEnabled[index] = false;
//     } else {
//       basePriceValues[index] = 0.0;
//       valueEnabled[index] = true;
//       syrianExchangeValue[index] = "8585";
//     }
//     if (suggestion.extras!.isNotEmpty) {
//       if (suggestion.extras![0].brand!) {
//         isBrands[index] = true;
//         brandValus[index] = false;
//       } else {
//         isBrands[index] = false;
//         brandValus[index] = false;
//       }

//       if (suggestion.extras![0].tubes!) {
//         isTubes[index] = true;
//         tubeValus[index] = false;
//       } else {
//         isTubes[index] = false;
//         tubeValus[index] = false;
//       }

//       if (suggestion.extras![0].lycra!) {
//         isLycra[index] = true;
//         lycraValus[index] = false;
//       } else {
//         isLycra[index] = false;
//         lycraValus[index] = false;
//       }

//       if (suggestion.extras![0].coloredThread!) {
//         isColored[index] = true;
//         colorValus[index] = false;
//       } else {
//         isColored[index] = false;
//         colorValus[index] = false;
//       }
//     }

//     if (suggestion.unit!.isNotEmpty) {
//       switch (suggestion.unit) {
//         case "كغ":
//           weightLabels[index] = " الوزن";

//           break;
//         case "طن":
//           weightLabels[index] = " الوزن";

//           break;
//         case "قيراط":
//           weightLabels[index] = " الوزن";

//           break;
//         case "كيلو واط بالساعة 1000":
//           weightLabels[index] = "الاستطاعة";

//           break;
//         case "الاستطاعة بالطن":
//           weightLabels[index] = "الاستطاعة";

//           break;
//         case "واط":
//           weightLabels[index] = "الاستطاعة";

//           break;
//         case "عدد الأزواج":
//           weightLabels[index] = "العدد";

//           break;
//         case "عدد":
//           weightLabels[index] = "العدد";

//           break;
//         case "طرد":
//           weightLabels[index] = "العدد";

//           break;
//         case "قدم":
//           weightLabels[index] = "العدد";

//           break;
//         case "متر":
//           weightLabels[index] = "الحجم";

//           break;
//         case "متر مربع":
//           weightLabels[index] = "الحجم";

//           break;
//         case "متر مكعب":
//           weightLabels[index] = "الحجم";

//           break;
//         case "لتر":
//           weightLabels[index] = "السعة";

//           break;
//         default:
//           weightLabels[index] = "الوزن";
//       }
//       weightUnits[index] = suggestion.unit!;
//       showunits[index] = true;
//     } else {
//       weightUnits[index] = "";
//       showunits[index] = false;
//     }

//     if (suggestion.placeholder != "") {
//       placeholders[index] = suggestion.placeholder!;
//       isdropdownVisibles[index] = false;
//       extraslist[index] = suggestion.extras!;
//       isdropdownVisibles[index] = true;
//     } else {
//       isdropdownVisibles[index] = false;
//       placeholders[index] = "";
//       extraslist[index] = [];
//     }

//     if (suggestion.fee! == 0.01) {
//       isfeeequal001[index] = true;
//     } else {
//       isfeeequal001[index] = false;
//     }

//     switch (suggestion.export1) {
//       case "0":
//         allowexports[index] = true;

//         break;
//       case "1":
//         allowexports[index] = false;

//         break;
//       default:
//     }
//   }

//   void selectOrigin(Origin origin, int index) {
//     origins[index] = origin;
//     originerrors[index] = false;

//     if (packages[index]!.extras!.isNotEmpty) {
//       outerLoop:
//       for (var element in packages[index]!.extras!) {
//         for (var element1 in origin.countryGroups!) {
//           if (element.countryGroup!.contains(element1)) {
//             if (element.price! > 0) {
//               basePriceValues[index] = element.price!;
//               valueEnabled[index] = false;

//               break outerLoop;
//             }
//           } else {
//             valueEnabled[index] = true;
//             syrianExchangeValue[index] = "8585";
//             basePriceValues[index] = 0.0;
//           }
//         }
//       }
//       if (origin.countryGroups!.isEmpty) {
//         basePriceValues[index] = 0.0;
//         valueEnabled[index] = true;
//         syrianExchangeValue[index] = "8585";
//       }
//     }
//     evaluatePrice(index);
//   }

//   void evaluatePrice(int index) {
//     if (valueEnabled[index]) {
//       calculateTotalValue(index);
//     } else {
//       calculateTotalValueWithPrice(index);
//     }
//   }

//   void calculateTotalValueWithPrice(int index) {
//     var syrianExch = weightValues[index] * basePriceValues[index];
//     var syrianTotal = syrianExch * 8585;
//     var totalEnsurance = syrianTotal + (syrianTotal * 0.0012);
//     syrianExchangeValue[index] = syrianExch.round().toString();
//     syrianTotalValue[index] = syrianTotal.round().toString();
//     totalValueWithEnsurance[index] = totalEnsurance.round().toString();
//   }

//   void calculateTotalValue(int index) {
//     var syrianTotal = weightValues[index] * 8585;
//     var totalEnsurance = (syrianTotal * 0.0012);
//     syrianTotalValue[index] = syrianTotal.round().toString();
//     totalValueWithEnsurance[index] = totalEnsurance.round().toString();
//   }

//   void calculateExtrasPrice(double percentage, bool add, int index) {
//     extraPrices[index] = 0.0;
//     if (add) {
//       extraPrices[index] =
//           basePriceValues[index] + (basePriceValues[index] * percentage);
//     } else {
//       extraPrices[index] =
//           basePriceValues[index] - (basePriceValues[index] * percentage);
//     }
//   }
// }
