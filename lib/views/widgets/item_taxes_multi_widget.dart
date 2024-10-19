import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PensTaxesWidget extends StatelessWidget {
  final double addedTaxes;
  final double customsCertificate;
  final double billTax;
  final double stampFee;
  final double provincialLocalTax;
  final double advanceIncomeTax;
  final double reconstructionFee;
  final double finalTaxes;

  PensTaxesWidget(
      {Key? key,
      required this.addedTaxes,
      required this.customsCertificate,
      required this.billTax,
      required this.stampFee,
      required this.provincialLocalTax,
      required this.advanceIncomeTax,
      required this.reconstructionFee,
      required this.finalTaxes})
      : super(key: key);
  var f = NumberFormat("#,###", "en_US");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColor.deepYellow,
            width: 0,
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
            width: 1,
          ),
        ),
        borderRadius: const BorderRadius.all(
          Radius.zero,
        ),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ضرائب الأقلام",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "طوابع وضرائب مضافة",
                  maxLines: 3,
                ),
                Text(f.format(addedTaxes.toInt())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "شهادة جمركية",
                  maxLines: 3,
                ),
                Text(f.format(customsCertificate.toInt())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "رسم تأمين إلزامي",
                  maxLines: 3,
                ),
                Text(f.format(billTax.toInt())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "رسم طابع",
                  maxLines: 3,
                ),
                Text(f.format(stampFee.toInt())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "ضريبة محلية محافظة",
                  maxLines: 3,
                ),
                Text(f.format(provincialLocalTax.toInt())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "السلفة على ضريبة الدخل",
                  maxLines: 3,
                ),
                Text(f.format(advanceIncomeTax.toInt())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "رسم المساهمة الوطنية لإعادة الإعمار:",
                  maxLines: 3,
                ),
                Text(f.format(reconstructionFee.toInt())),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(color: AppColor.deepYellow),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "مجموع الضرائب:",
                  maxLines: 3,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  f.format(finalTaxes.toInt()),
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
