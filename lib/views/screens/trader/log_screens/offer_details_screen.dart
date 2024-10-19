import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_multi_result_dart_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/offer_details_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/models/offer_model.dart' as offer;
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/providers/broker_offer_provider.dart';
import 'package:custome_mobile/data/providers/trader_offer_provider.dart';
import 'package:custome_mobile/data/services/calculator_service.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/screens/trader/log_screens/broker_attachments_screen.dart';
import 'package:custome_mobile/views/screens/trader/log_screens/broker_costs_screen.dart';
import 'package:custome_mobile/views/screens/trader/log_screens/order_tracking_screen.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:custome_mobile/views/widgets/custome_timeline.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intel;
import 'package:provider/provider.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OfferDetailsScreen extends StatefulWidget {
  // final Offer offer;
  final String type;
  final int operationtype;
  OfferDetailsScreen(
      {Key? key, required this.type, required this.operationtype})
      : super(key: key);

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen>
    with TickerProviderStateMixin {
  late FlutterGifController controller1;
  CalculateObject result = CalculateObject();
  List<CalculateObject> objects = [];
  var f = intel.NumberFormat("#,###", "en_US");
  double finaltotalcost = 0.0;

  TraderOfferProvider? trader_offerProvider;
  BrokerOfferProvider? broker_offerProvider;
  String userType = "Trader";
  late SharedPreferences prefs;

  String finaltotalCost(List<Costs>? costs, double finaltotal) {
    double total = 0.0;
    for (var element in costs!) {
      total += element.amount!;
    }
    return f.format((total + finaltotal).toInt());
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

  Package? product;

  void getProductInfo(String id) async {
    product = await CalculatorService.getProductInfo(id);
  }

  getUserType() async {
    prefs = await SharedPreferences.getInstance();
    userType = prefs.getString("userType") ?? "Trader";
  }

  void calculateCosts() {
    objects = [];
    print(broker_offerProvider!.products == null);
    print(broker_offerProvider!.products!.length);
    for (var i = 0; i < broker_offerProvider!.products!.length; i++) {
      objects.add(CalculateObject());
      objects[i].insurance = broker_offerProvider!.taxes![i];
      objects[i].fee = broker_offerProvider!.products![i].fee;
      objects[i].rawMaterial = broker_offerProvider!.raw_material![i] ? 1 : 0;
      objects[i].industrial = broker_offerProvider!.industrial![i] ? 1 : 0;
      objects[i].totalTax =
          broker_offerProvider!.products![i]!.totalTaxes!.totalTax!.toDouble();
      objects[i].partialTax = broker_offerProvider!
          .products![i]!.totalTaxes!.partialTax!
          .toDouble();
      objects[i].origin = broker_offerProvider!.origin![i].label;
      objects[i].spendingFee = broker_offerProvider!.products![i]!.spendingFee;
      objects[i].supportFee = broker_offerProvider!.products![i]!.supportFee;
      objects[i].localFee =
          broker_offerProvider!.products![i]!.localFee!.toDouble();
      objects[i].protectionFee =
          broker_offerProvider!.products![i]!.protectionFee;
      objects[i].naturalFee = broker_offerProvider!.products![i]!.naturalFee;
      objects[i].taxFee = broker_offerProvider!.products![i]!.taxFee;
      objects[i].weight = broker_offerProvider!.weight![i];
      objects[i].price = broker_offerProvider!.price![i];
      objects[i].cnsulate = 1;
      objects[i].dolar = 8585;
      objects[i].arabic_stamp =
          broker_offerProvider!.products![i]!.totalTaxes!.arabicStamp!.toInt();
      objects[i].import_fee = broker_offerProvider!.products![i]!.importFee!;
    }
    BlocProvider.of<CalculateMultiResultBloc>(context)
        .add(CalculateMultiTheResultEvent(objects));
  }

  @override
  void initState() {
    controller1 = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller1.repeat(
        min: 0,
        max: 53,
        period: const Duration(milliseconds: 200),
      );
      trader_offerProvider =
          Provider.of<TraderOfferProvider>(context, listen: false);
      broker_offerProvider =
          Provider.of<BrokerOfferProvider>(context, listen: false);
      getUserType();
    });
    super.initState();
  }

  List<Widget> buildProductTiles(String agency, offer.Origin origin,
      int packageType, int packageNum, int weight, int price) {
    List<Widget> list = [];
    list.add(Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: Text.rich(
                TextSpan(
                    text:
                        "${AppLocalizations.of(context)!.translate('goods_origin')}: ",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: origin!.label!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 45.h,
              child: VerticalDivider(
                color: Colors.grey[300],
              ),
            ),
            Text.rich(
              TextSpan(
                  text:
                      "${AppLocalizations.of(context)!.translate('destination')}: ",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: agency,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
        Divider(
          color: Colors.grey[300]!,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: Text.rich(
                TextSpan(
                    text:
                        "${AppLocalizations.of(context)!.translate('package_type')}: ",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: packageType!.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 45.h,
              child: VerticalDivider(
                color: Colors.grey[300],
              ),
            ),
            Text.rich(
              TextSpan(
                  text:
                      "${AppLocalizations.of(context)!.translate('packages_number')}: ",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: packageNum!.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
        Divider(
          color: Colors.grey[300]!,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: Text.rich(
                TextSpan(
                    text:
                        "${AppLocalizations.of(context)!.translate('weight')}: ",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: weight.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 45.h,
              child: VerticalDivider(
                color: Colors.grey[300],
              ),
            ),
            Text.rich(
              TextSpan(
                  text: "${AppLocalizations.of(context)!.translate('value')}: ",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: price.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ],
    ));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // Duration diff = now.difference(offer.createdDate!);
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                  title: AppLocalizations.of(context)!
                      .translate('operation_details')),
              backgroundColor: Colors.grey[100],
              body: BlocConsumer<OfferDetailsBloc, OfferDetailsState>(
                listener: (context, offersstate) {
                  if (offersstate is OfferDetailsLoadedSuccess) {
                    trader_offerProvider!
                        .initAttachment(offersstate.offer.attachments!);
                    trader_offerProvider!.initAdditionalAttachment(
                        offersstate.offer.additional_attachments!);
                    broker_offerProvider!.initOffer(offersstate.offer);
                    calculateCosts();
                  }
                },
                builder: (context, offerstate) {
                  if (offerstate is OfferDetailsLoadedSuccess) {
                    getProductInfo(offerstate.offer.products![0].id!);

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              // margin: EdgeInsets.symmetric(horizontal: 10.w),
                              elevation: 1,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 7.5.h),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('operation_number')}: SA-${broker_offerProvider!.id!}',
                                        style: TextStyle(
                                          color: AppColor.lightBlue,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: SizedBox(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text.rich(
                                              TextSpan(
                                                  text: broker_offerProvider!
                                                      .source!.label!,
                                                  style: TextStyle(
                                                    color: AppColor.lightBlue,
                                                    fontSize: 17.sp,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: "  --->  ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17.sp,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${broker_offerProvider!.costumestate!.name}",
                                                      style: TextStyle(
                                                        color:
                                                            AppColor.lightBlue,
                                                        fontSize: 17.sp,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text.rich(
                                          TextSpan(
                                              text:
                                                  "${AppLocalizations.of(context)!.translate('operation_type')}: ",
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: localeState.value
                                                              .languageCode ==
                                                          'en'
                                                      ? getEnOfferType(
                                                          broker_offerProvider!
                                                              .offerType!)
                                                      : getOfferType(
                                                          broker_offerProvider!
                                                              .offerType!),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text.rich(
                                          TextSpan(
                                              text:
                                                  "${AppLocalizations.of(context)!.translate('costume_agency')}: ",
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: localeState.value
                                                              .languageCode ==
                                                          'en'
                                                      ? offerstate.offer
                                                          .costumeagency!.name
                                                      : offerstate
                                                          .offer
                                                          .costumeagency!
                                                          .nameAr,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          text:
                                              "${AppLocalizations.of(context)!.translate('expected_arrival_date')}: ",
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${broker_offerProvider!.expectedArrivalDate!.day}-${broker_offerProvider!.expectedArrivalDate!.month}-${broker_offerProvider!.expectedArrivalDate!.year}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            ListView.builder(
                              itemCount: broker_offerProvider!.products!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Theme(
                                              data: Theme.of(context).copyWith(
                                                  dividerColor:
                                                      Colors.transparent),
                                              child: ExpansionTile(
                                                initiallyExpanded: false,
                                                tilePadding: EdgeInsets.zero,

                                                // controlAffinity: ListTileControlAffinity.leading,
                                                childrenPadding:
                                                    EdgeInsets.zero,
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .75,
                                                      child: Text(
                                                        '${AppLocalizations.of(context)!.translate('goods_name')}: ${localeState.value.languageCode == 'en' ? broker_offerProvider!.products![index].labelen! : broker_offerProvider!.products![index].label!}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 10,
                                                        style: TextStyle(
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onExpansionChanged: (value) {},
                                                children: buildProductTiles(
                                                    localeState.value
                                                                .languageCode ==
                                                            'en'
                                                        ? broker_offerProvider!
                                                            .costumeagency!
                                                            .name!
                                                        : broker_offerProvider!
                                                            .costumeagency!
                                                            .nameAr!,
                                                    broker_offerProvider!
                                                        .origin![index],
                                                    broker_offerProvider!
                                                        .packageType!,
                                                    broker_offerProvider!
                                                        .packagesNum!,
                                                    broker_offerProvider!
                                                        .weight![index],
                                                    broker_offerProvider!
                                                        .price![index]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 4,
                                      top: 4,
                                      child: Container(
                                        height: 30,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: AppColor.deepYellow,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Visibility(
                              visible: widget.operationtype == 0,
                              child: Column(
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                    // margin:
                                    //     EdgeInsets.symmetric(horizontal: 10.w),
                                    elevation: 1,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 7.5.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.translate('total_costs')}:",
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.deepBlue,
                                            ),
                                          ),
                                          BlocBuilder<CalculateMultiResultBloc,
                                              CalculateMultiResultState>(
                                            builder: (context, state) {
                                              if (state
                                                  is CalculateMultiResultSuccessed) {
                                                return Text(
                                                  "${finaltotalCost(broker_offerProvider!.costs, double.parse(state.result.totalFinalTotal!))} EGP",
                                                  style: TextStyle(
                                                    color: AppColor.lightBlue,
                                                    fontSize: 17.sp,
                                                  ),
                                                );
                                              } else {
                                                return const LoadingIndicator();
                                              }
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BrokerCostDetailsScreen(
                                                      costs:
                                                          broker_offerProvider!
                                                              .costs,
                                                    ),
                                                  ));

                                              // ignore: use_build_context_synchronously
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(8.h),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('details'),
                                                style: TextStyle(
                                                    color: AppColor.lightBlue,
                                                    fontSize: 17.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              clipBehavior: Clip.antiAlias,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                              // margin: EdgeInsets.symmetric(horizontal: 10.w),
                              elevation: 1,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 7.5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.translate('attachments')}:",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.deepBlue,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BrokerAttachmentsScreen(
                                                      offerId:
                                                          broker_offerProvider!
                                                              .id!,
                                                      offerState:
                                                          broker_offerProvider!
                                                              .orderStatus!),
                                            ));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8.h),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .translate('attachments_details'),
                                          style: TextStyle(
                                              color: AppColor.lightBlue,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Visibility(
                              visible: widget.operationtype == 0,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                                // margin: EdgeInsets.symmetric(horizontal: 10.w),
                                elevation: 1,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 7.5.h),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      initiallyExpanded: false,
                                      tilePadding: EdgeInsets.zero,
                                      trailing: GestureDetector(
                                        onTap: () {
                                          if (userType == "Broker") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderTrackingScreen(
                                                          offer:
                                                              offerstate.offer,
                                                          type: userType ==
                                                                  "Broker"
                                                              ? "broker"
                                                              : "trader"),
                                                ));
                                          }
                                        },
                                        child: SizedBox(
                                          height: 45,
                                          width: 45,
                                          child: Image.asset(
                                              "assets/icons/radar.gif",
                                              gaplessPlayback: true,
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      // controlAffinity: ListTileControlAffinity.leading,
                                      childrenPadding: EdgeInsets.zero,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .translate(
                                                    'operation_tracking'),
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.deepBlue,
                                            ),
                                          )
                                        ],
                                      ),
                                      onExpansionChanged: (value) {},
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(12.h),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              CustomeTimeLine(
                                                isFirst: true,
                                                isLast: true,
                                                isPast: offerstate
                                                    .offer
                                                    .track_offer!
                                                    .attachmentRecivment!,
                                                imageUrl: !offerstate
                                                        .offer
                                                        .track_offer!
                                                        .attachmentRecivment!
                                                    ? "assets/images/step 1 Dark.svg"
                                                    : "assets/images/step 1 blue.svg",
                                                type: "svg",
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'attachments_recivment'),
                                              ),
                                              CustomeTimeLine(
                                                isFirst: true,
                                                isLast: false,
                                                isPast: offerstate
                                                    .offer
                                                    .track_offer!
                                                    .unloadDistenation!,
                                                imageUrl: !offerstate
                                                        .offer
                                                        .track_offer!
                                                        .unloadDistenation!
                                                    ? "assets/images/step 2 Dark.svg"
                                                    : "assets/images/step 2 blue.svg",
                                                type: "svg",
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'unload_distenation'),
                                              ),
                                              CustomeTimeLine(
                                                isFirst: false,
                                                isLast: false,
                                                isPast: offerstate
                                                    .offer
                                                    .track_offer!
                                                    .deliveryPermit!,
                                                imageUrl: !offerstate
                                                        .offer
                                                        .track_offer!
                                                        .deliveryPermit!
                                                    ? "assets/images/step 3 Dark.svg"
                                                    : "assets/images/step 3 blue.svg",
                                                type: "svg",
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'delivery_permit'),
                                              ),
                                              CustomeTimeLine(
                                                isFirst: false,
                                                isLast: false,
                                                isPast: offerstate
                                                    .offer
                                                    .track_offer!
                                                    .customeDeclration!,
                                                isCurrent: true,
                                                imageUrl: !offerstate
                                                        .offer
                                                        .track_offer!
                                                        .customeDeclration!
                                                    ? "assets/images/step 4 Dark.svg"
                                                    : "assets/images/step 4 blue.svg",
                                                type: "svg",
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'custome_declration'),
                                              ),
                                              CustomeTimeLine(
                                                isFirst: false,
                                                isLast: false,
                                                isPast: offerstate.offer
                                                    .track_offer!.previewGoods!,
                                                imageUrl: !offerstate
                                                        .offer
                                                        .track_offer!
                                                        .previewGoods!
                                                    ? "assets/images/step 5 Dark.svg"
                                                    : "assets/images/step 5 blue.svg",
                                                type: "svg",
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .translate('preview_goods'),
                                              ),
                                              CustomeTimeLine(
                                                isFirst: false,
                                                isLast: false,
                                                isPast: offerstate.offer
                                                    .track_offer!.payFeesTaxes!,
                                                imageUrl: !offerstate
                                                        .offer
                                                        .track_offer!
                                                        .payFeesTaxes!
                                                    ? "assets/images/step 6 Dark.svg"
                                                    : "assets/images/step 6 blue.svg",
                                                type: "svg",
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'pay_fees_taxes'),
                                              ),
                                              CustomeTimeLine(
                                                isFirst: false,
                                                isLast: false,
                                                isPast: offerstate
                                                    .offer
                                                    .track_offer!
                                                    .issuingExitPermit!,
                                                imageUrl: !offerstate
                                                        .offer
                                                        .track_offer!
                                                        .issuingExitPermit!
                                                    ? "assets/images/step 7 Dark.svg"
                                                    : "assets/images/step 7 blue.svg",
                                                type: "svg",
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'issuing_exit_permit'),
                                              ),
                                              CustomeTimeLine(
                                                isFirst: false,
                                                isLast: true,
                                                isPast: offerstate
                                                    .offer
                                                    .track_offer!
                                                    .loadDistenation!,
                                                imageUrl: !offerstate
                                                        .offer
                                                        .track_offer!
                                                        .loadDistenation!
                                                    ? "assets/images/step 8 Dark.svg"
                                                    : "assets/images/step 8 blue.svg",
                                                type: "svg",
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .translate(
                                                        'load_distenation'),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (offerstate is OfferDetailsLoadingProgress) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      child: const Center(child: LoadingIndicator()),
                    );
                  } else {
                    return const Text("");
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String totalCost(List<Costs>? costs) {
    double total = 0.0;
    for (var element in costs!) {
      total += element.amount!;
    }
    return total.toInt().toString();
  }
}
