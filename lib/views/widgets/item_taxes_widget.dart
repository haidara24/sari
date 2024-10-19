import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ItemTaxesWidget extends StatelessWidget {
  final double? customsFee;
  final double? spendingFee;
  final double? imranLocality;
  final double? conservativeLocality;
  final double? feeSupportingLocalProduction;
  final double? citiesProtectionFee;
  final double? naturalDisasterFee;
  final double? incomeTaxFee;
  final double? finalFee;
  final double addedTaxes;
  final double customsCertificate;
  final double billTax;
  final double stampFee;
  final double provincialLocalTax;
  final double advanceIncomeTax;
  final double reconstructionFee;
  final double finalTaxes;
  final double finalTotal;

  ItemTaxesWidget({
    Key? key,
    this.customsFee,
    this.spendingFee,
    this.imranLocality,
    this.conservativeLocality,
    this.feeSupportingLocalProduction,
    this.citiesProtectionFee,
    this.naturalDisasterFee,
    this.incomeTaxFee,
    this.finalFee,
    required this.addedTaxes,
    required this.customsCertificate,
    required this.billTax,
    required this.stampFee,
    required this.provincialLocalTax,
    required this.advanceIncomeTax,
    required this.reconstructionFee,
    required this.finalTaxes,
    required this.finalTotal,
  }) : super(key: key);
  var f = NumberFormat("#,###", "en_US");
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.deepYellow,
          width: 2,
        ),
        borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(12), top: Radius.circular(12)),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.translate('customs_fees_taxes'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 7,
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Text(
                    AppLocalizations.of(context)!.translate('customs_fees'),
                    maxLines: 3,
                  ),
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(customsFee!.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('consumption_fee'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(spendingFee!.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('local_construction'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(imranLocality!.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('local_governorate'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(conservativeLocality!.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: Text(
                    AppLocalizations.of(context)!.translate(
                        'support_and_development_of_local_production'),
                    maxLines: 3,
                  ),
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(feeSupportingLocalProduction!.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: Text(
                    AppLocalizations.of(context)!.translate(
                        'rehabilitation_and_protection_of_cities_and_facilities'),
                    maxLines: 3,
                  ),
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(citiesProtectionFee!.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .translate('drought_and_natural_disaster_fund'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(naturalDisasterFee!.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .translate('advance_on_income_tax'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(incomeTaxFee!.toInt())),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(color: Colors.grey[350]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('total_fees'),
                  maxLines: 3,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${f.format(finalFee!.toInt())} EGP",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.grey[350],
              thickness: 2,
            ),
            Text(
              AppLocalizations.of(context)!.translate('records_taxes'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 7,
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .translate('stamps_and_value-added_taxes'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(addedTaxes.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .translate('customs_certificate'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(customsCertificate.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .translate('mandatory_insurance_fee'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(billTax.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('stamp_fee'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(stampFee.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .translate('Local_governorate_tax'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(provincialLocalTax.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .translate('advance_on_income_tax'),
                  maxLines: 3,
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(advanceIncomeTax.toInt())),
              ],
            ),
            Divider(
              height: 12,
              color: Colors.grey[300]!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: Text(
                    AppLocalizations.of(context)!.translate(
                        'national_contribution_fee_for_reconstruction'),
                    maxLines: 3,
                  ),
                ),
                // SizedBox(
                //   height: 25.h,
                //   child: VerticalDivider(
                //     color: Colors.grey[300],
                //   ),
                // ),
                Text(f.format(reconstructionFee.toInt())),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(color: Colors.grey[350]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('total_taxes'),
                  maxLines: 3,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${f.format(finalTaxes.toInt())} EGP",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Divider(
              color: AppColor.deepYellow,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('total_fees'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "${f.format(finalTotal.toInt())} EGP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: AppColor.deepYellow,
                  ),
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
  }
}
