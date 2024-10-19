import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CalculatorLoadingScreen extends StatelessWidget {
  const CalculatorLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: (Colors.grey[300])!,
      highlightColor: (Colors.grey[100])!,
      enabled: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (_, __) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 1,
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            height: 290.h,
          ),
        ),
        itemCount: 4,
      ),
    );
  }
}
