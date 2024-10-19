import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_multi_result_dart_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_result_bloc.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/widgets/calculator_loading_screen.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:custome_mobile/views/widgets/item_taxes_widget.dart';
import 'package:custome_mobile/views/widgets/item_taxes_multi_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BrokerCostDetailsScreen extends StatelessWidget {
  final List<Costs>? costs;
  BrokerCostDetailsScreen({Key? key, required this.costs}) : super(key: key);
  CalculateObject result = CalculateObject();
  double finaltotalcost = 0.0;

  var f = NumberFormat("#,###", "en_US");

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

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // Duration diff = now.difference(offer.createdDate!);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.translate('taxes_costs'),
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              BlocBuilder<CalculateMultiResultBloc, CalculateMultiResultState>(
                builder: (context, state) {
                  if (state is CalculateMultiResultSuccessed) {
                    return ItemTaxesWidget(
                      customsFee: double.parse(state.result.totalCustomsFee!),
                      spendingFee: double.parse(state.result.totalSpendingFee!),
                      conservativeLocality:
                          double.parse(state.result.totalConservativeLocality!),
                      citiesProtectionFee:
                          double.parse(state.result.totalCitiesProtectionFee!),
                      feeSupportingLocalProduction: double.parse(
                          state.result.totalFeeSupportingLocalProduction!),
                      imranLocality: double.parse("0.0"),
                      incomeTaxFee:
                          double.parse(state.result.totalIncomeTaxFee!),
                      naturalDisasterFee:
                          double.parse(state.result.totalNaturalDisasterFee!),
                      finalFee: double.parse(state.result.totalFinalFee!),
                      addedTaxes: double.parse(state.result.totalAddedTaxes!),
                      customsCertificate: double.parse("0.0"),
                      billTax: double.parse("0.0"),
                      stampFee: double.parse(state.result.totalStampFee!),
                      provincialLocalTax:
                          double.parse(state.result.totalProvincialLocalTax!),
                      advanceIncomeTax:
                          double.parse(state.result.totalAdvanceIncomeTax!),
                      reconstructionFee:
                          double.parse(state.result.totalReconstructionFee!),
                      finalTaxes: double.parse(state.result.totalFinalTaxes!),
                      finalTotal: double.parse(state.result.totalFinalTotal!),
                    );
                  } else {
                    return const CalculatorLoadingScreen();
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocBuilder<CalculateMultiResultBloc, CalculateMultiResultState>(
                builder: (context, state) {
                  if (state is CalculateMultiResultSuccessed) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColor.deepYellow,
                            width: 2,
                          ),
                          right: BorderSide(
                            color: AppColor.deepYellow,
                            width: 2,
                          ),
                          left: BorderSide(
                            color: AppColor.deepYellow,
                            width: 2,
                          ),
                          bottom: BorderSide(
                            color: AppColor.deepYellow,
                            width: 2,
                          ),
                        ),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                            bottom: Radius.circular(12)),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .translate('operation_costs'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: costs!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      costs![index].description!,
                                      maxLines: 3,
                                    ),
                                    Text(f
                                        .format(costs![index].amount!.toInt())),
                                  ],
                                );
                              },
                            ),
                            Divider(
                              color: AppColor.deepYellow,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('total_costs'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                  maxLines: 3,
                                ),
                                Text(
                                  "${totalCost(costs)} EGP",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: AppColor.deepYellow,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const CalculatorLoadingScreen();
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocBuilder<CalculateMultiResultBloc, CalculateMultiResultState>(
                builder: (context, state) {
                  if (state is CalculateMultiResultSuccessed) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColor.deepYellow,
                            width: 2,
                          ),
                          right: BorderSide(
                            color: AppColor.deepYellow,
                            width: 2,
                          ),
                          left: BorderSide(
                            color: AppColor.deepYellow,
                            width: 2,
                          ),
                          bottom: BorderSide(
                            color: AppColor.deepYellow,
                            width: 2,
                          ),
                        ),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                            bottom: Radius.circular(12)),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('total_costs_taxes'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                  maxLines: 3,
                                ),
                                Text(
                                  "${finaltotalCost(costs, double.parse(state.result.totalFinalTotal!))} EGP",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                      color: AppColor.deepYellow),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const CalculatorLoadingScreen();
                  }
                },
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String totalCost(List<Costs>? costs) {
    double total = 0.0;
    for (var element in costs!) {
      total += element.amount!;
    }
    return f.format(total.toInt());
  }

  String finaltotalCost(List<Costs>? costs, double finaltotal) {
    double total = 0.0;
    for (var element in costs!) {
      total += element.amount!;
    }
    return f.format((total + finaltotal).toInt());
  }
}
