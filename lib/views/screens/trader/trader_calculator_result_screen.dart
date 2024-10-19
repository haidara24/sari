import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_multi_result_dart_bloc.dart';
import 'package:custome_mobile/views/widgets/calculator_loading_screen.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/item_taxes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TraderCalculatorResultScreen extends StatelessWidget {
  TraderCalculatorResultScreen({Key? key}) : super(key: key);
  var f = NumberFormat("#,###", "en_US");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.translate('fees_taxes'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: BlocBuilder<CalculateMultiResultBloc,
                    CalculateMultiResultState>(
                  builder: (context, state) {
                    if (state is CalculateMultiResultSuccessed) {
                      return ItemTaxesWidget(
                        customsFee: double.parse(state.result.totalCustomsFee!),
                        spendingFee:
                            double.parse(state.result.totalSpendingFee!),
                        conservativeLocality: double.parse(
                            state.result.totalConservativeLocality!),
                        citiesProtectionFee: double.parse(
                            state.result.totalCitiesProtectionFee!),
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
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  AppLocalizations.of(context)!.translate('calculater_hint'),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: SizedBox(
                        width: 100,
                        child: Center(
                            child: Text(AppLocalizations.of(context)!
                                .translate('back')))),
                  ),
                  // CustomButton(
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) => TraderBillReview(),
                  //     //     ));
                  //   },
                  //   title: const SizedBox(
                  //       width: 100, child: Center(child: Text("حفظ"))),
                  // ),
                  // CustomButton(
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) => TraderAttachementScreen(),
                  //     //     ));
                  //   },
                  //   title: const SizedBox(
                  //       width: 100, child: Center(child: Text("طلب مخلص"))),
                  // ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
