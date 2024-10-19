import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/offer_details_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/trader_log_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/screens/trader/log_screens/offer_details_screen.dart';
import 'package:custome_mobile/views/screens/trader/log_screens/order_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({Key? key}) : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  String getOfferType(String offer) {
    switch (offer) {
      case "I":
        return "استيراد";
      case "E":
        return "تصدير";
      default:
        return "تصدير";
    }
  }

  String getEnOfferType(String offer) {
    switch (offer) {
      case "I":
        return "Import";
      case "E":
        return "Export";
      default:
        return "Export";
    }
  }

  String getOfferStatus(String offer) {
    switch (offer) {
      case "P":
        return "معلقة";
      case "R":
        return "جارية";
      case "C":
        return "مكتملة";
      case "F":
        return "مرفوضة";
      default:
        return "خطأ";
    }
  }

  String diffText(Duration diff) {
    if (diff.inSeconds < 60) {
      return "منذ ${diff.inSeconds.toString()} ثانية";
    } else if (diff.inMinutes < 60) {
      return "منذ ${diff.inMinutes.toString()} دقيقة";
    } else if (diff.inHours < 24) {
      return "منذ ${diff.inHours.toString()} ساعة";
    } else {
      return "منذ ${diff.inDays.toString()} يوم";
    }
  }

  String diffEnText(Duration diff) {
    if (diff.inSeconds < 60) {
      return "since ${diff.inSeconds.toString()} seconds";
    } else if (diff.inMinutes < 60) {
      return "since ${diff.inMinutes.toString()} minutes";
    } else if (diff.inHours < 24) {
      return "since ${diff.inHours.toString()} hours";
    } else {
      return "since ${diff.inDays.toString()} days";
    }
  }

  double showPercentage(TrackOffer track) {
    int percentage = 0;
    if (track.attachmentRecivment!) {
      percentage++;
    }
    if (track.unloadDistenation!) {
      percentage++;
    }
    if (track.deliveryPermit!) {
      percentage++;
    }
    if (track.customeDeclration!) {
      percentage++;
    }
    if (track.previewGoods!) {
      percentage++;
    }
    if (track.payFeesTaxes!) {
      percentage++;
    }
    if (track.issuingExitPermit!) {
      percentage++;
    }
    if (track.loadDistenation!) {
      percentage++;
    }
    return (percentage / 8);
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
            backgroundColor: Colors.grey[100],
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    )),
                    // margin: EdgeInsets.symmetric(horizontal: 7.w),
                    elevation: 1,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: TabBar(
                        controller: _tabController,
                        // give the indicator a decoration (color and border radius)

                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),

                          // color: AppColor.activeGreen,
                        ),

                        labelColor: AppColor.deepBlue,
                        unselectedLabelColor: Colors.black,
                        splashBorderRadius: BorderRadius.circular(25),
                        onTap: (value) {
                          switch (value) {
                            case 0:
                              BlocProvider.of<TraderLogBloc>(context)
                                  .add(const TraderLogLoadEvent("R"));
                              break;
                            case 1:
                              BlocProvider.of<TraderLogBloc>(context)
                                  .add(const TraderLogLoadEvent("P"));
                              break;
                            default:
                          }
                          setState(() {
                            tabIndex = value;
                          });
                        },
                        tabs: [
                          // first tab [you can add an icon using the icon property]
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: tabIndex == 0
                                      ? AppColor.goldenYellow
                                      : null,
                                  borderRadius: BorderRadius.circular(
                                    25.0,
                                  ),
                                  border: tabIndex != 0
                                      ? Border.all(
                                          color: AppColor.goldenYellow,
                                          width: 2,
                                        )
                                      : null
                                  // color: AppColor.activeGreen,
                                  ),
                              child: Center(
                                  child: Text(AppLocalizations.of(context)!
                                      .translate('running_operations'))),
                            ),
                          ),

                          // second tab [you can add an icon using the icon property]
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: tabIndex == 1
                                      ? AppColor.goldenYellow
                                      : null,
                                  borderRadius: BorderRadius.circular(
                                    25.0,
                                  ),
                                  border: tabIndex != 1
                                      ? Border.all(
                                          color: AppColor.goldenYellow,
                                          width: 2,
                                        )
                                      : null
                                  // color: AppColor.activeGreen,
                                  ),
                              child: Center(
                                  child: Text(AppLocalizations.of(context)!
                                      .translate('pending_operations'))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<TraderLogBloc, TraderLogState>(
                      builder: (context, state) {
                        if (state is TraderLogLoadedSuccess) {
                          return state.offers.isEmpty
                              ? Center(
                                  child: Text(AppLocalizations.of(context)!
                                      .translate('no_offers')),
                                )
                              : ListView.builder(
                                  itemCount: state.offers.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    // DateTime now = DateTime.now();
                                    // Duration diff = now
                                    //     .difference(state.offers[index].createdDate!);
                                    return GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<OfferDetailsBloc>(
                                                context)
                                            .add(OfferDetailsLoadEvent(
                                                state.offers[index].id!));
                                        print(tabIndex);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OfferDetailsScreen(
                                                type: "trader",
                                                operationtype: tabIndex,
                                              ),
                                            ));
                                      },
                                      child: Card(
                                        elevation: 1,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 35.h,
                                                          width: 35.w,
                                                          child: Center(
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/icons/naval_shipping.svg",
                                                              height: 55.h,
                                                              width: 55.w,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 7.h,
                                                        ),
                                                        Text(
                                                          'SA-${state.offers[index].id!}',
                                                          style: TextStyle(
                                                              // color: AppColor.lightBlue,
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        // const Icon(
                                                        //   Icons
                                                        //       .notifications_none_outlined,
                                                        // ),
                                                        SizedBox(
                                                          width: 7.h,
                                                        ),
                                                        Icon(
                                                          localeState.value
                                                                      .languageCode ==
                                                                  'en'
                                                              ? Icons
                                                                  .arrow_forward_ios
                                                              : Icons
                                                                  .arrow_back_ios_new,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text.rich(
                                                    TextSpan(
                                                        text: state
                                                            .offers[index]
                                                            .source!
                                                            .label!,
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .lightBlue,
                                                          fontSize: 17.sp,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text: "  --->  ",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17.sp,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "${state.offers[index].costumestate!.name}",
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .lightBlue,
                                                              fontSize: 17.sp,
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FittedBox(
                                                  // fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "${AppLocalizations.of(context)!.translate('directorate')}: ${localeState.value.languageCode == 'en' ? state.offers[index].costumeagency!.name! : state.offers[index].costumeagency!.nameAr!}",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: AppColor.deepBlue,
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .85,
                                                      child: Text(
                                                        localeState.value
                                                                    .languageCode ==
                                                                'en'
                                                            ? state
                                                                .offers[index]
                                                                .products![0]
                                                                .labelen!
                                                            : state
                                                                .offers[index]
                                                                .products![0]
                                                                .label!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color:
                                                              AppColor.deepBlue,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  // GestureDetector(
                                                  //   onTap: () {
                                                  //     BlocProvider.of<
                                                  //                 OfferDetailsBloc>(
                                                  //             context)
                                                  //         .add(
                                                  //             OfferDetailsLoadEvent(
                                                  //                 state
                                                  //                     .offers[
                                                  //                         index]
                                                  //                     .id!));
                                                  //     Navigator.push(
                                                  //         context,
                                                  //         MaterialPageRoute(
                                                  //           builder: (context) =>
                                                  //               OrderTrackingScreen(
                                                  //                   type:
                                                  //                       "trader",
                                                  //                   offer: state
                                                  //                           .offers[
                                                  //                       index]),
                                                  //         ));
                                                  //   },
                                                  //   child: Padding(
                                                  //     padding: const EdgeInsets
                                                  //         .symmetric(
                                                  //         horizontal: 3.0),
                                                  //     child: Column(
                                                  //       mainAxisSize:
                                                  //           MainAxisSize.min,
                                                  //       mainAxisAlignment:
                                                  //           MainAxisAlignment
                                                  //               .end,
                                                  //       children: [
                                                  //         Text(
                                                  //           AppLocalizations.of(
                                                  //                   context)!
                                                  //               .translate(
                                                  //                   'operation_tracking'),
                                                  //           style: TextStyle(
                                                  //             color: AppColor
                                                  //                 .lightBlue,
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .bold,
                                                  //             fontSize: 17.sp,
                                                  //           ),
                                                  //         )
                                                  //       ],
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  tabIndex == 0
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child:
                                                              LinearPercentIndicator(
                                                            // width: MediaQuery.of(context)
                                                            //         .size
                                                            //         .width -
                                                            //     50,
                                                            animation: true,
                                                            lineHeight: 20.0,
                                                            animationDuration:
                                                                2000,
                                                            percent: showPercentage(
                                                                state
                                                                    .offers[
                                                                        index]
                                                                    .track_offer!),
                                                            center: Text(
                                                              "${(showPercentage(state.offers[index].track_offer!) * 100).toString()}%",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            linearStrokeCap:
                                                                LinearStrokeCap
                                                                    .roundAll,
                                                            progressColor:
                                                                AppColor
                                                                    .deepYellow,
                                                            barRadius:
                                                                const Radius
                                                                    .circular(
                                                                    15),
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                        } else {
                          return Shimmer.fromColors(
                            baseColor: (Colors.grey[300])!,
                            highlightColor: (Colors.grey[100])!,
                            enabled: true,
                            direction: ShimmerDirection.ttb,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (_, __) => Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30.h,
                                      width: 100.w,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 30.h,
                                      width: 150.w,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 30.h,
                                      width: 150.w,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              itemCount: 6,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
