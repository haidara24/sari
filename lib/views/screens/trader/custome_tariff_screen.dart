import 'dart:convert';

import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculator_panel_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/chapter_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_item_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_trade_description_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/note_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/section_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/sub_chapter_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/constants/enums.dart';
import 'package:custome_mobile/data/models/accurdion_model.dart';
import 'package:custome_mobile/data/repositories/accurdion_repository.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/widgets/highlight_text.dart';
import 'package:custome_mobile/views/widgets/tariff_info_icon.dart';
import 'package:custome_mobile/views/widgets/tariff_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';
import 'package:shimmer/shimmer.dart';

import '../../../business_logic/bloc/search_section_bloc.dart';

class CustomeTariffScreen extends StatefulWidget {
  const CustomeTariffScreen({Key? key}) : super(key: key);

  @override
  State<CustomeTariffScreen> createState() => _CustomeTariffScreenState();
}

class _CustomeTariffScreenState extends State<CustomeTariffScreen> {
  // final _headerStyle = const TextStyle(
  //     color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final ScrollController _scrollController = ScrollController();

  List<Widget> buildFeesTradeDescription() {
    List<Widget> list = [];
    list.add(BlocBuilder<FeeTradeDescriptionBloc, FeeTradeDescriptionState>(
      builder: (context, state) {
        if (state is FeeTradeDescriptionLoadedSuccess) {
          return state.tradeDescription.commercialDescriptions!.isEmpty
              ? Center(
                  child: Text(AppLocalizations.of(context)!
                      .translate('no_trade_description')),
                )
              : Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          state.tradeDescription.commercialDescriptions!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index4) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          // decoration: BoxDecoration(
                          //   color: Colors.white,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          child: Text(state
                              .tradeDescription
                              .commercialDescriptions![index4]
                              .secondDescription!),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    // SizedBox(
                    //   height: 50,
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount:
                    //         state.tradeDescription.imageDescriptions!.length,
                    //     // physics: const NeverScrollableScrollPhysics(),
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index4) {
                    //       return Container(
                    //         margin: const EdgeInsets.symmetric(horizontal: 4),
                    //         // decoration: BoxDecoration(
                    //         //   color: Colors.white,
                    //         //   borderRadius: BorderRadius.circular(10),
                    //         // ),
                    //         child: Image.network(
                    //           state.tradeDescription.imageDescriptions![index4]
                    //               .image!,
                    //           height: 70.h,
                    //           width: 70.w,
                    //           loadingBuilder:
                    //               (context, child, loadingProgress) {
                    //             if (loadingProgress == null) {
                    //               return child;
                    //             }

                    //             return Container(
                    //               height: 70.h,
                    //               width: 70.w,
                    //               color: Colors.grey[200],
                    //               child: Center(
                    //                   child: CircularProgressIndicator(
                    //                 value: loadingProgress.expectedTotalBytes !=
                    //                         null
                    //                     ? loadingProgress
                    //                             .cumulativeBytesLoaded /
                    //                         loadingProgress.expectedTotalBytes!
                    //                     : null,
                    //               )),
                    //             );
                    //           },
                    //           errorBuilder: (context, error, stackTrace) {
                    //             return Container(
                    //               height: 70.h,
                    //               width: 70.w,
                    //               color: Colors.grey[300],
                    //               child: const Center(child: Text("error")),
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 7,
                    // )
                  ],
                );
        } else {
          return Shimmer.fromColors(
            baseColor: (Colors.grey[300])!,
            highlightColor: (Colors.grey[100])!,
            enabled: true,
            child: SizedBox(
              // width: MediaQuery.of(context).size.width * .7,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, __) => Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 60.h,
                  ),
                ),
                itemCount: 3,
              ),
            ),
          );
        }
      },
    ));
    return list;
  }

  List<Widget> buildimportfees(FeeSet fee) {
    List<Widget> list = [];
    list.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/icons/export_restrection.png"),
                SizedBox(
                  width: 5.w,
                ),
                Text(AppLocalizations.of(context)!
                    .translate('import_conditions')),
                const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                Text(AppLocalizations.of(context)!.translate('import_allowed')),
              ],
            ),
          ],
        ),
      ),
    );
    for (var element in fee.importFees!) {
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(element.restriction_import!),
                ],
              ),
            ],
          ),
        ),
      );
    }
    if (fee.stoneFarming!.isNotEmpty) {
      for (var element in fee.stoneFarming!) {
        list.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/icons/stone_farming.png"),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(AppLocalizations.of(context)!
                        .translate('import_farming_stone')),
                    Text(element.stonImport!),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
    return list;
  }

  List<Widget> buildfeesChildren(FeeSet fe) {
    List<Widget> list = [];
    list.add(Container(
      color: Colors.white,
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Visibility(
                visible: localeState.value.languageCode == 'ar',
                child: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: AppColor.goldenYellow,
                    ),
                    ExpansionTile(
                      title: Directionality(
                        textDirection: localeState.value.languageCode == 'en'
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        child: Row(
                          children: [
                            Container(
                              height: 25.h,
                              width: 25.h,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                    "assets/icons/description.svg"),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('trade_description'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onExpansionChanged: (value) {
                        if (value) {
                          BlocProvider.of<FeeTradeDescriptionBloc>(context)
                              .add(FeeTradeDescriptionLoadEvent(fe.id!));
                        } else {}
                      },
                      children: buildFeesTradeDescription(),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: AppColor.goldenYellow,
              ),
              ExpansionTile(
                title: Directionality(
                  textDirection: localeState.value.languageCode == 'en'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Row(
                    children: [
                      Container(
                        height: 25.h,
                        width: 25.h,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: SvgPicture.asset("assets/icons/import.svg"),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('import_conditions'),
                        ),
                      ),
                    ],
                  ),
                ),
                children: fe.importFees!.isEmpty
                    ? [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 25.h,
                                      width: 25.h,
                                      child: SvgPicture.asset(
                                          "assets/icons/conditions.svg")),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(AppLocalizations.of(context)!
                                      .translate('import_conditions')),
                                  const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('import_not_allowed'),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                    : buildimportfees(fe),
              ),
              Divider(
                height: 1,
                color: AppColor.goldenYellow,
              ),
              ExpansionTile(
                title: Directionality(
                  textDirection: localeState.value.languageCode == 'en'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Row(
                    children: [
                      Container(
                        height: 25.h,
                        width: 25.h,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: SvgPicture.asset("assets/icons/Export.svg"),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('export_conditions'),
                        ),
                      ),
                    ],
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 25.h,
                                width: 25.h,
                                child: SvgPicture.asset(
                                    "assets/icons/conditions.svg")),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(AppLocalizations.of(context)!
                                .translate('export_conditions')),
                            fe.export![0].export! ==
                                    AppLocalizations.of(context)!
                                        .translate('export_allowed')
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                            Text(fe.export![0] != null
                                ? fe.export![0].export!
                                : ""),
                          ],
                        ),
                        Text(
                          fe.restrictionExport!,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
                color: AppColor.goldenYellow,
              ),
              ExpansionTile(
                title: Directionality(
                  textDirection: localeState.value.languageCode == 'en'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Row(
                    children: [
                      Container(
                        height: 25.h,
                        width: 25.h,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                              "assets/icons/Fee_calculation.svg"),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('fee_calculate'),
                        ),
                      ),
                    ],
                  ),
                ),
                onExpansionChanged: (value) {
                  BlocProvider.of<CalculatorPanelBloc>(context)
                      .add(CalculatorPanelOpenEvent());
                  BlocProvider.of<FeeItemBloc>(context)
                      .add(FeeItemLoadEvent(fe.id!));
                },
                trailing: const SizedBox.shrink(),
              ),
              // Divider(
              //   height: 1,
              //   color: AppColor.goldenYellow,
              // ),
              // ExpansionTile(
              //   title: Directionality(
              //     textDirection: localeState.value.languageCode == 'en'
              //         ? TextDirection.ltr
              //         : TextDirection.rtl,
              //     child: Row(
              //       children: [
              //         Container(
              //           height: 25.h,
              //           width: 25.h,
              //           margin: const EdgeInsets.symmetric(horizontal: 10),
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: Center(
              //             child: SvgPicture.asset("assets/icons/share.svg"),
              //           ),
              //         ),
              //         Container(
              //           padding: const EdgeInsets.symmetric(horizontal: 5),
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: Text(
              //             AppLocalizations.of(context)!.translate('share'),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   trailing: const SizedBox.shrink(),
              // ),
            ],
          );
        },
      ),
    ));
    return list;
  }

  buildFeesTiles(int index3) {
    List<Widget> list = [];
    list.add(BlocConsumer<FeeBloc, FeeState>(
      listener: (context, state) {
        if (state is FeeLoadedSuccess) {
          Future.delayed(const Duration(milliseconds: 400))
              .then((value) => Scrollable.ensureVisible(
                    chapterKeys[subchapterselected!].currentContext!,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                  ));
        }
      },
      builder: (context, state) {
        if (state is FeeLoadedSuccess) {
          return Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(3.0),
            child: ListView.builder(
              key: Key('feebuilder ${feeselected.toString()}'),
              shrinkWrap: true,
              itemCount: state.fees.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index4) {
                return Column(
                  children: [
                    Card(
                      // margin: const EdgeInsets.symmetric(horizontal: 4),
                      margin: const EdgeInsets.all(2),
                      // decoration: BoxDecoration(
                      //   color: feeselected == index4 ? Colors.white : null,
                      //   borderRadius: BorderRadius.circular(5),
                      //   border: feeselected == index4
                      //       ? Border.all(color: AppColor.goldenYellow, width: 2)
                      //       : null,
                      // ),
                      elevation: feeselected == index4 ? 1 : 0,
                      color: feeselected == index4
                          ? Colors.white
                          : Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: feeselected == index4
                                ? AppColor.goldenYellow
                                : Colors.grey[200]!,
                            width: 2),
                      ),
                      child: ExpansionTile(
                        key: Key(index4.toString()),
                        tilePadding: EdgeInsets.zero,
                        initiallyExpanded: index4 == feeselected,
                        // controlAffinity: ListTileControlAffinity.leading,
                        // leading: const SizedBox.shrink(),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 13.w,
                            ),
                            Flexible(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.fees[index4].id!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Flexible(
                                    child: Text(
                                      state.fees[index4].label!,
                                      style: const TextStyle(
                                        height: 1.3,
                                        fontSize: 17,
                                      ),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onExpansionChanged: (value) {
                          if (value) {
                            setState(() {
                              feeselected = index4;
                            });
                          } else {
                            setState(() {
                              feeselected = -1;

                              shownote = false;
                              noteType = NoteType.None;
                            });
                          }
                        },
                        children: buildfeesChildren(state.fees[index4]),
                      ),
                    ),
                    index4 == (state.fees.length - 1)
                        ? const SizedBox.shrink()
                        : Divider(
                            height: 1,
                            color: AppColor.goldenYellow,
                          ),
                  ],
                );
              },
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Shimmer.fromColors(
                baseColor: (Colors.grey[300])!,
                highlightColor: (Colors.grey[100])!,
                enabled: true,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, __) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 3),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 40.h,
                      ),
                    ),
                    itemCount: 4,
                  ),
                ),
              ),
            ],
          );
        }
      },
    ));
    return list;
  }

  buildSubChapterTiles(int index2) {
    List<Widget> list = [];
    list.add(BlocConsumer<SubChapterBloc, SubChapterState>(
      listener: (context, state) {
        if (state is SubChapterLoadedSuccess) {
          Future.delayed(const Duration(milliseconds: 400))
              .then((value) => Scrollable.ensureVisible(
                    chapterKeys[chapterselected!].currentContext!,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                  ));
        }
      },
      builder: (context, state) {
        if (state is SubChapterLoadedSuccess) {
          subchapterKeys = [];
          for (var element in state.subchapters) {
            subchapterKeys.add(GlobalKey());
          }
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 0.0),
            child: ListView.builder(
              key: Key('subchapterbuilder ${subchapterselected.toString()}'),
              shrinkWrap: true,
              itemCount: state.subchapters.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index3) {
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(2),
                      clipBehavior: Clip.antiAlias,
                      // decoration: BoxDecoration(
                      //   color: subchapterselected == index3
                      //       ? Colors.white
                      //       : null,
                      //   border: subchapterselected == index3
                      //       ? feeselected == -1
                      //           ? Border.all(
                      //               color: AppColor.goldenYellow, width: 2)
                      //           : null
                      //       : null,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      elevation: subchapterselected == index3 ? 1 : 0,
                      color: subchapterselected == index3
                          ? Colors.white
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: subchapterselected == index3
                                ? feeselected == -1
                                    ? AppColor.goldenYellow
                                    : Colors.white
                                : Colors.white,
                            width: 2),
                      ),
                      child: ExpansionTile(
                        key: Key(index3.toString()), //attention
                        initiallyExpanded: index3 == subchapterselected,
                        tilePadding: EdgeInsets.zero,

                        // controlAffinity: ListTileControlAffinity.leading,
                        childrenPadding: EdgeInsets.zero,
                        // leading: Container(
                        //   margin: EdgeInsets.symmetric(horizontal: 7),
                        //   child: subchapterselected == index3
                        //       ? const Icon(Icons.remove)
                        //       : const Icon(Icons.add),
                        // ),
                        // leading: const SizedBox.shrink(),
                        title: Row(
                          key: subchapterKeys[index3],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15.w,
                            ),
                            Flexible(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.subchapters[index3].id!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Flexible(
                                    child: Text(
                                      state.subchapters[index3].label!,
                                      style: const TextStyle(
                                        height: 1.3,
                                        fontSize: 17,
                                      ),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onExpansionChanged: (value) {
                          if (value) {
                            BlocProvider.of<FeeBloc>(context).add(
                                FeeLoadEvent(state.subchapters[index3].id!));
                            setState(() {
                              subchapterselected = index3;
                              feeselected = -1;
                            });
                          } else {
                            setState(() {
                              subchapterselected = -1;
                              shownote = false;
                              noteType = NoteType.None;
                            });
                          }
                        },
                        children: buildFeesTiles(index3),
                      ),
                    ),
                    state.subchapters.length - 1 == index3
                        ? const SizedBox.shrink()
                        : Divider(
                            height: 1,
                            color: AppColor.goldenYellow,
                          ),
                  ],
                );
              },
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Shimmer.fromColors(
                baseColor: (Colors.grey[300])!,
                highlightColor: (Colors.grey[100])!,
                enabled: true,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, __) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 3),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 40.h,
                      ),
                    ),
                    itemCount: 4,
                  ),
                ),
              ),
            ],
          );
        }
      },
    ));

    return list;
  }

  buildChapterTiles() {
    // _CustomeTariffScreenState? stateobject =
    //     context.findAncestorStateOfType<_CustomeTariffScreenState>();
    List<Widget> list = [];
    list.add(BlocConsumer<ChapterBloc, ChapterState>(
      listener: (context, state) {
        if (state is ChapterLoadedSuccess) {
          Future.delayed(const Duration(milliseconds: 400))
              .then((value) => Scrollable.ensureVisible(
                    sectionKeys[selected!].currentContext!,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                  ));
        }
      },
      builder: (context, state) {
        if (state is ChapterLoadedSuccess) {
          chapterKeys = [];
          for (var element in state.chapters) {
            chapterKeys.add(GlobalKey());
          }
          return Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.only(top: 3.0),
            child: ListView.builder(
              key: Key('chapterbuilder ${chapterselected.toString()}'),
              shrinkWrap: true,
              itemCount: state.chapters.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index2) {
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(2),
                      clipBehavior: Clip.antiAlias,
                      // decoration: BoxDecoration(
                      //   color: chapterselected == index2
                      //       ? subchapterselected == -1
                      //           ? Colors.white
                      //           : null
                      //       : null,
                      //   border: chapterselected == index2
                      //       ? subchapterselected == -1
                      //           ? Border.all(
                      //               color: AppColor.goldenYellow, width: 2)
                      //           : null
                      //       : null,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      elevation: chapterselected == index2 ? 1 : 0,
                      color: chapterselected == index2
                          ? Colors.grey[200]
                          : Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: chapterselected == index2
                                ? subchapterselected == -1
                                    ? AppColor.goldenYellow
                                    : Colors.grey[200]!
                                : Colors.grey[200]!,
                            width: 2),
                      ),

                      child: ListTileTheme(
                        contentPadding: const EdgeInsets.all(0),
                        dense: true,
                        horizontalTitleGap: 0.0,
                        minLeadingWidth: 0,
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          childrenPadding: EdgeInsets.zero,
                          leading: const SizedBox.shrink(),
                          // leading: Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 7),
                          //   child: chapterselected == index2
                          //       ? const Icon(Icons.remove)
                          //       : const Icon(Icons.add),
                          // ),
                          title: Row(
                            key: chapterKeys[index2],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 17.w,
                              ),
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.chapters[index2].id!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Flexible(
                                      child: Text(
                                        state.chapters[index2].label!,
                                        style: const TextStyle(
                                          height: 1.3,
                                          fontSize: 17,
                                        ),
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Builder(builder: (iconcontext) {
                                return GestureDetector(
                                  onTap: () {
                                    showPopover(
                                      context: iconcontext,
                                      bodyBuilder: (iconcontext) =>
                                          StatefulBuilder(
                                              builder: (context, setState) {
                                        BlocProvider.of<NoteBloc>(context).add(
                                            NoteLoadEvent(
                                                state.chapters[index2]!.id!
                                                    .toString(),
                                                NoteType.Chapter));
                                        return BlocBuilder<NoteBloc, NoteState>(
                                          builder: (context, state) {
                                            if (state is NoteLoadedSuccess) {
                                              return ListItems(
                                                noteType: NoteType.Section,
                                                sectionnotes: state.notes,
                                                loading: false,
                                                contxt: context,
                                              );
                                            } else {
                                              return ListItems(
                                                noteType: NoteType.Section,
                                                sectionnotes: [],
                                                loading: true,
                                                contxt: context,
                                              );
                                            }
                                          },
                                        );
                                      }),
                                      onPop: () => print('Popover was popped!'),
                                      direction: PopoverDirection.bottom,
                                      width: MediaQuery.of(context).size.width -
                                          28.w,
                                      height: 280.h,
                                      arrowHeight: 15,
                                      arrowWidth: 0,
                                      barrierLabel:
                                          AppLocalizations.of(context)!
                                              .translate('notes'),
                                      radius: 15,
                                    );
                                  },
                                  child: const TariffInfoIcon(),
                                );
                              }),
                            ],
                          ),
                          key: Key(index2.toString()), //attention
                          initiallyExpanded: index2 == chapterselected,

                          onExpansionChanged: (value) {
                            if (value) {
                              BlocProvider.of<SubChapterBloc>(context).add(
                                  SubChapterLoadEvent(
                                      state.chapters[index2].id!));
                              setState(() {
                                chapterselected = index2;

                                subchapterselected = -1;
                                feeselected = -1;
                              });
                            } else {
                              setState(() {
                                chapterselected = -1;
                                shownote = false;
                                noteType = NoteType.None;
                              });
                            }
                          },
                          children: buildSubChapterTiles(index2),
                        ),
                      ),
                    ),
                    state.chapters.length - 1 == index2
                        ? const SizedBox.shrink()
                        : Divider(
                            height: 1,
                            color: AppColor.goldenYellow,
                          ),
                  ],
                );
              },
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: (Colors.grey[300])!,
                highlightColor: (Colors.grey[100])!,
                enabled: true,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, __) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 3),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 40.h,
                      ),
                    ),
                    itemCount: 4,
                  ),
                ),
              ),
            ],
          );
        }
      },
    ));

    return list;
  }

  buildSearchChapterTiles(List<ChapterSet?> chapters) {
    // _CustomeTariffScreenState? stateobject =
    //     context.findAncestorStateOfType<_CustomeTariffScreenState>();
    List<Widget> list = [];
    list.add(Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.only(top: 3.0),
      child: ListView.builder(
        key: Key('chapterbuilder ${chapterselected.toString()}'),
        shrinkWrap: true,
        itemCount: chapters.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index2) {
          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(2),
                clipBehavior: Clip.antiAlias,
                elevation: 1,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: Colors.grey[200]!,
                      // color: chapterselected == index2
                      //     ? subchapterselected == -1
                      //         ? AppColor.goldenYellow
                      //         : Colors.grey[200]!
                      //     : Colors.grey[200]!,
                      width: 2),
                ),
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.all(0),
                  dense: true,
                  horizontalTitleGap: 0.0,
                  minLeadingWidth: 0,
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    childrenPadding: EdgeInsets.zero,
                    leading: const SizedBox.shrink(),

                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 17.w,
                        ),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chapters[index2]!.id!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Flexible(
                                child: HighlightText(
                                  highlightStyle: TextStyle(
                                    height: 1.3,
                                    fontSize: 17,
                                    color: AppColor.goldenYellow,
                                  ),
                                  style: const TextStyle(
                                    height: 1.3,
                                    fontSize: 17,
                                  ),
                                  text: chapters[index2]!.label!,
                                  highlight: _searchController.text,
                                  ignoreCase: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Builder(builder: (iconcontext) {
                          return GestureDetector(
                            onTap: () {
                              showPopover(
                                context: iconcontext,
                                bodyBuilder: (iconcontext) => StatefulBuilder(
                                    builder: (context, setState) {
                                  BlocProvider.of<NoteBloc>(context).add(
                                      NoteLoadEvent(
                                          chapters[index2]!.id!.toString(),
                                          NoteType.Chapter));
                                  return BlocBuilder<NoteBloc, NoteState>(
                                    builder: (context, state) {
                                      if (state is NoteLoadedSuccess) {
                                        return ListItems(
                                          noteType: NoteType.Section,
                                          sectionnotes: state.notes,
                                          loading: false,
                                          contxt: context,
                                        );
                                      } else {
                                        return ListItems(
                                          noteType: NoteType.Section,
                                          sectionnotes: [],
                                          loading: true,
                                          contxt: context,
                                        );
                                      }
                                    },
                                  );
                                }),
                                onPop: () => print('Popover was popped!'),
                                direction: PopoverDirection.bottom,
                                width: MediaQuery.of(context).size.width - 28.w,
                                height: 280.h,
                                arrowHeight: 15,
                                arrowWidth: 0,
                                barrierLabel: AppLocalizations.of(context)!
                                    .translate('notes'),
                                radius: 15,
                              );
                            },
                            child: const TariffInfoIcon(),
                          );
                        }),
                        SizedBox(
                          width: 4.w,
                        )
                      ],
                    ),
                    key: Key(index2.toString()), //attention
                    initiallyExpanded: true,
                    children: buildSearchSubChapterTiles(
                        chapters[index2]!.subChapterSet!),
                  ),
                ),
              ),
              chapters.length - 1 == index2
                  ? const SizedBox.shrink()
                  : Divider(
                      height: 1,
                      color: AppColor.goldenYellow,
                    ),
            ],
          );
        },
      ),
    ));

    return list;
  }

  buildSearchSubChapterTiles(List<SubChapterSet?> subchapters) {
    List<Widget> list = [];
    list.add(Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 0.0),
      child: ListView.builder(
        key: Key('subchapterbuilder ${subchapterselected.toString()}'),
        shrinkWrap: true,
        itemCount: subchapters.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index3) {
          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(2),
                clipBehavior: Clip.antiAlias,
                elevation: subchapterselected == index3 ? 1 : 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: subchapterselected == index3
                          ? feeselected == -1
                              ? AppColor.goldenYellow
                              : Colors.white
                          : Colors.white,
                      width: 2),
                ),
                child: ExpansionTile(
                  key: Key(index3.toString()), //attention
                  initiallyExpanded: true,
                  tilePadding: EdgeInsets.zero,

                  // controlAffinity: ListTileControlAffinity.leading,
                  childrenPadding: EdgeInsets.zero,
                  // leading: Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 7),
                  //   child: subchapterselected == index3
                  //       ? const Icon(Icons.remove)
                  //       : const Icon(Icons.add),
                  // ),
                  // leading: const SizedBox.shrink(),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subchapters[index3]!.id!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Flexible(
                              child: HighlightText(
                                highlightStyle: TextStyle(
                                  height: 1.3,
                                  fontSize: 17,
                                  color: AppColor.goldenYellow,
                                ),
                                style: const TextStyle(
                                  height: 1.3,
                                  fontSize: 17,
                                ),
                                text: subchapters[index3]!.label!,
                                highlight: _searchController.text,
                                ignoreCase: false,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                          ],
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: const TariffInfoIcon(),
                      // ),
                    ],
                  ),

                  children: subchapters[index3]!.feeSet == null
                      ? []
                      : buildSearchFeesTiles(subchapters[index3]!.feeSet!),
                ),
              ),
              subchapters.length - 1 == index3
                  ? const SizedBox.shrink()
                  : Divider(
                      height: 1,
                      color: AppColor.goldenYellow,
                    ),
            ],
          );
        },
      ),
    ));

    return list;
  }

  buildSearchFeesTiles(List<FeeSet?> feeslist) {
    List<Widget> list = [];
    List<FeeSet?> fees = [];
    for (var element in feeslist) {
      if (fees.singleWhere((it) => it!.id == element!.id, orElse: () => null) ==
          null) {
        fees.add(element);
      }
    }
    list.add(Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(3.0),
      child: ListView.builder(
        key: Key('feebuilder ${feeselected.toString()}'),
        shrinkWrap: true,
        itemCount: fees.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index4) {
          return Column(
            children: [
              Card(
                // margin: const EdgeInsets.symmetric(horizontal: 4),
                margin: const EdgeInsets.all(2),

                elevation: feeselected == index4 ? 1 : 0,
                color: feeselected == index4 ? Colors.white : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: feeselected == index4
                          ? AppColor.goldenYellow
                          : Colors.grey[200]!,
                      width: 2),
                ),
                child: ExpansionTile(
                  key: Key(index4.toString()),
                  tilePadding: EdgeInsets.zero,
                  // initiallyExpanded: true,
                  // controlAffinity: ListTileControlAffinity.leading,
                  // leading: const SizedBox.shrink(),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 13.w,
                      ),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fees[index4]!.id!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Flexible(
                              child: HighlightText(
                                highlightStyle: TextStyle(
                                  height: 1.3,
                                  fontSize: 17,
                                  color: AppColor.goldenYellow,
                                ),
                                style: const TextStyle(
                                  height: 1.3,
                                  fontSize: 17,
                                ),
                                text: fees[index4]!.label!,
                                highlight: _searchController.text,
                                ignoreCase: false,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                          ],
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: const TariffInfoIcon(),
                      // ),
                    ],
                  ),
                  children: buildfeesChildren(fees[index4]!),
                ),
              ),
              index4 == (fees.length - 1)
                  ? const SizedBox.shrink()
                  : Divider(
                      height: 1,
                      color: AppColor.goldenYellow,
                    ),
            ],
          );
        },
      ),
    ));

    return list;
  }

  final ScrollController scroll = ScrollController();

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  List<GlobalKey> sectionKeys = [];
  List<GlobalKey> chapterKeys = [];
  List<GlobalKey> subchapterKeys = [];
  List<GlobalKey> feeKeys = [];

  int? selected;
  int? chapterselected;
  int? subchapterselected;
  int? feeselected;
  bool shownote = false;
  NoteType noteType = NoteType.None;
  final TextEditingController _searchController = TextEditingController();
  bool isSearch = false;
  final FocusNode _statenode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: BlocProvider(
            create: (context) => NoteBloc(
              accordionRepository:
                  RepositoryProvider.of<AccordionRepository>(context),
            ),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                backgroundColor: Colors.grey[100],
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Focus(
                          focusNode: _statenode,
                          onFocusChange: (bool focus) {
                            if (!focus) {
                              BlocProvider.of<BottomNavBarCubit>(context)
                                  .emitShow();
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          child: BlocListener<SearchSectionBloc,
                              SearchSectionState>(
                            listener: (context, state) {
                              if (state is SearchSectionLoadedSuccess) {
                                // print(jsonEncode(state.sections));
                              }
                              if (state is SearchSectionLoadedFailed) {}
                            },
                            child: TextFormField(
                              controller: _searchController,
                              onTap: () {
                                BlocProvider.of<BottomNavBarCubit>(context)
                                    .emitHide();
                                _searchController.selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset:
                                        _searchController.value.text.length);
                              },
                              style: TextStyle(fontSize: 18.sp),
                              scrollPadding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          50),
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .translate('search'),
                                hintText: AppLocalizations.of(context)!
                                    .translate('search'),
                                hintStyle: TextStyle(fontSize: 18.sp),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    BlocProvider.of<BottomNavBarCubit>(context)
                                        .emitShow();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    if (_searchController.text.isNotEmpty) {
                                      BlocProvider.of<SearchSectionBloc>(
                                              context)
                                          .add(SearchSectionLoadEvent(
                                              _searchController.text));
                                      setState(() {
                                        isSearch = true;
                                      });
                                    }
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    isSearch = false;
                                  });
                                }
                              },
                              onFieldSubmitted: (value) {
                                BlocProvider.of<BottomNavBarCubit>(context)
                                    .emitShow();
                                _searchController.text = value;
                                if (value.isNotEmpty) {
                                  BlocProvider.of<SearchSectionBloc>(context)
                                      .add(SearchSectionLoadEvent(value));
                                  setState(() {
                                    isSearch = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      isSearch
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: BlocBuilder<SearchSectionBloc,
                                  SearchSectionState>(
                                builder: (context, state) {
                                  if (state is SearchSectionLoadedSuccess) {
                                    return state.sections.isEmpty
                                        ? Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                          'no_result_found'),
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const Icon(
                                                  Icons.warning_rounded,
                                                  color: Colors.grey,
                                                )
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            key: Key(
                                                'builder ${selected.toString()}'),
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state.sections.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 6.h,
                                                ),
                                                clipBehavior: Clip.none,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  side: BorderSide(
                                                      color:
                                                          AppColor.goldenYellow,
                                                      width: 2),
                                                ),
                                                color: Colors.white,
                                                // decoration: BoxDecoration(
                                                //   borderRadius: BorderRadius.circular(10),
                                                //   border: selected == index
                                                //       ? Border.all(
                                                //           color: Colors.yellow[600]!, width: 2)
                                                //       : null,
                                                // ),
                                                child: Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                          dividerColor: Colors
                                                              .transparent),
                                                  child: ExpansionTile(
                                                    key: Key(index
                                                        .toString()), //attention
                                                    initiallyExpanded: true,
                                                    tilePadding:
                                                        const EdgeInsets.all(5),
                                                    // controlAffinity:
                                                    //     ListTileControlAffinity.leading,
                                                    trailing: Builder(
                                                        builder: (iconcontext) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          showPopover(
                                                            context:
                                                                iconcontext,
                                                            bodyBuilder: (iconcontext) =>
                                                                StatefulBuilder(
                                                                    builder:
                                                                        (context,
                                                                            setState) {
                                                              BlocProvider.of<
                                                                          NoteBloc>(
                                                                      context)
                                                                  .add(NoteLoadEvent(
                                                                      state
                                                                          .sections[
                                                                              index]!
                                                                          .id!
                                                                          .toString(),
                                                                      NoteType
                                                                          .Section));
                                                              return BlocBuilder<
                                                                  NoteBloc,
                                                                  NoteState>(
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  if (state
                                                                      is NoteLoadedSuccess) {
                                                                    return ListItems(
                                                                      noteType:
                                                                          NoteType
                                                                              .Section,
                                                                      sectionnotes:
                                                                          state
                                                                              .notes,
                                                                      loading:
                                                                          false,
                                                                      contxt:
                                                                          context,
                                                                    );
                                                                  } else {
                                                                    return ListItems(
                                                                      noteType:
                                                                          NoteType
                                                                              .Section,
                                                                      sectionnotes: [],
                                                                      loading:
                                                                          true,
                                                                      contxt:
                                                                          context,
                                                                    );
                                                                  }
                                                                },
                                                              );
                                                            }),
                                                            onPop: () => print(
                                                                'Popover was popped!'),
                                                            direction:
                                                                PopoverDirection
                                                                    .bottom,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                28.w,
                                                            height: 280.h,
                                                            arrowHeight: 15,
                                                            arrowWidth: 0,
                                                            barrierLabel:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .translate(
                                                                        'notes'),
                                                            radius: 15,
                                                          );
                                                        },
                                                        child:
                                                            const TariffInfoIcon(),
                                                      );
                                                    }),

                                                    title: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 65.w,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width: 36.w,
                                                                height: 36.h,
                                                                child: SvgPicture
                                                                    .network(
                                                                  "https://across-mena.com${state.sections[index]!.image!}",
                                                                  placeholderBuilder:
                                                                      (context) =>
                                                                          Container(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    width: 36.w,
                                                                    height:
                                                                        36.h,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                "(${state.sections[index]!.end!}__${state.sections[index]!.start!})",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.w,
                                                        ),
                                                        Flexible(
                                                          child: HighlightText(
                                                            highlightStyle:
                                                                TextStyle(
                                                              height: 1.3,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColor
                                                                  .goldenYellow,
                                                            ),
                                                            style:
                                                                const TextStyle(
                                                              height: 1.3,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            text: state
                                                                .sections[
                                                                    index]!
                                                                .label!,
                                                            highlight:
                                                                _searchController
                                                                    .text,
                                                            ignoreCase: false,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    children:
                                                        buildSearchChapterTiles(
                                                            state
                                                                .sections[
                                                                    index]!
                                                                .chapterSet!),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                  } else if (state is SearchSectionLoading) {
                                    return Shimmer.fromColors(
                                      baseColor: (Colors.grey[300])!,
                                      highlightColor: (Colors.grey[100])!,
                                      enabled: true,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (_, __) => Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 3),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: SizedBox(
                                            height: 90.h,
                                          ),
                                        ),
                                        itemCount: 10,
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          // BlocProvider.of<SectionBloc>(context)
                                          //     .add(SectionLoadEvent());
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
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: BlocConsumer<SectionBloc, SectionState>(
                                listener: (context, state) {
                                  // if(state is)
                                },
                                builder: (context, state) {
                                  if (state is SectionLoadedSuccess) {
                                    sectionKeys = [];
                                    for (var element in state.sections) {
                                      sectionKeys.add(GlobalKey());
                                    }
                                    return ListView.builder(
                                      key:
                                          Key('builder ${selected.toString()}'),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.sections.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          // key: sectionKeys[index],
                                          margin: EdgeInsets.symmetric(
                                            vertical: 6.h,
                                          ),
                                          clipBehavior: Clip.none,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            side: BorderSide(
                                                color: selected == index
                                                    ? AppColor.goldenYellow
                                                    : Colors.white,
                                                width: 2),
                                          ),
                                          color: Colors.white,
                                          // decoration: BoxDecoration(
                                          //   borderRadius: BorderRadius.circular(10),
                                          //   border: selected == index
                                          //       ? Border.all(
                                          //           color: Colors.yellow[600]!, width: 2)
                                          //       : null,
                                          // ),
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent),
                                            child: ExpansionTile(
                                              key: Key(
                                                  "section$index"), //attention
                                              initiallyExpanded:
                                                  index == selected,
                                              tilePadding:
                                                  const EdgeInsets.all(5),
                                              // controlAffinity:
                                              //     ListTileControlAffinity.leading,
                                              trailing: Builder(
                                                  builder: (iconcontext) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    showPopover(
                                                      context: iconcontext,
                                                      bodyBuilder: (iconcontext) =>
                                                          StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                        BlocProvider.of<
                                                                    NoteBloc>(
                                                                context)
                                                            .add(NoteLoadEvent(
                                                                state
                                                                    .sections[
                                                                        index]!
                                                                    .id!
                                                                    .toString(),
                                                                NoteType
                                                                    .Section));
                                                        return BlocBuilder<
                                                            NoteBloc,
                                                            NoteState>(
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is NoteLoadedSuccess) {
                                                              return ListItems(
                                                                noteType:
                                                                    NoteType
                                                                        .Section,
                                                                sectionnotes:
                                                                    state.notes,
                                                                loading: false,
                                                                contxt: context,
                                                              );
                                                            } else {
                                                              return ListItems(
                                                                noteType:
                                                                    NoteType
                                                                        .Section,
                                                                sectionnotes: [],
                                                                loading: true,
                                                                contxt: context,
                                                              );
                                                            }
                                                          },
                                                        );
                                                      }),
                                                      onPop: () => print(
                                                          'Popover was popped!'),
                                                      direction:
                                                          PopoverDirection
                                                              .bottom,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              28.w,
                                                      height: 280.h,
                                                      arrowHeight: 15,
                                                      arrowWidth: 0,
                                                      barrierLabel:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'notes'),
                                                      radius: 15,
                                                    );
                                                    // BlocProvider.of<NoteBloc>(context)
                                                    //     .add(NoteLoadEvent(
                                                    //         state.sections[index]!.id!
                                                    //             .toString(),
                                                    //         NoteType.Section));
                                                    // if (!shownote) {
                                                    //   setState(() {
                                                    //     selected = index;
                                                    //     chapterselected = -1;
                                                    //     subchapterselected = -1;
                                                    //     shownote = true;
                                                    //     noteType = NoteType.Section;
                                                    //   });

                                                    //   scroll.animateTo(
                                                    //       index +
                                                    //           MediaQuery.of(context)
                                                    //                   .size
                                                    //                   .width /
                                                    //               2,
                                                    //       duration: const Duration(
                                                    //           seconds: 1),
                                                    //       curve: Curves.easeIn);
                                                    // } else {
                                                    //   setState(() {
                                                    //     selected = -1;
                                                    //     shownote = false;
                                                    //     noteType = NoteType.None;
                                                    //   });
                                                    // }
                                                  },
                                                  child: const TariffInfoIcon(),
                                                );
                                              }),

                                              title: Row(
                                                key: sectionKeys[index],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 65.w,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 36.w,
                                                          height: 36.h,
                                                          child: Img(
                                                            state
                                                                .sections[
                                                                    index]!
                                                                .image!,
                                                            placeholder:
                                                                Container(
                                                              color: Colors
                                                                  .grey[200],
                                                              width: 36.w,
                                                              height: 36.h,
                                                            ),
                                                            errorWidget:
                                                                Container(
                                                              color: Colors
                                                                  .grey[200],
                                                              width: 36.w,
                                                              height: 36.h,
                                                              child: const Center(
                                                                  child: Text(
                                                                      "error")),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "(${state.sections[index]!.end!}__${state.sections[index]!.start!})",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.w,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      state.sections[index]!
                                                          .label!,
                                                      style: const TextStyle(
                                                        height: 1.3,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 10,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              onExpansionChanged: (value) {
                                                if (value) {
                                                  BlocProvider.of<ChapterBloc>(
                                                          context)
                                                      .add(
                                                    ChapterLoadEvent(state
                                                        .sections[index]!.id!),
                                                  );
                                                  setState(() {
                                                    selected = index;
                                                    chapterselected = -1;
                                                    subchapterselected = -1;
                                                    feeselected = -1;
                                                  });
                                                } else {
                                                  setState(() {
                                                    selected = -1;
                                                    shownote = false;
                                                    noteType = NoteType.None;
                                                  });
                                                }
                                              },
                                              children: buildChapterTiles(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else if (state is SectionLoadingProgress) {
                                    return Shimmer.fromColors(
                                      baseColor: (Colors.grey[300])!,
                                      highlightColor: (Colors.grey[100])!,
                                      enabled: true,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (_, __) => Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 3),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: SizedBox(
                                            height: 90.h,
                                          ),
                                        ),
                                        itemCount: 10,
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<SectionBloc>(context)
                                              .add(SectionLoadEvent());
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "حدث خطأأثناء تحميل القائمة...  ",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            Icon(
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
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
