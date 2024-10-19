import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/control_view.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TraderConfirmScreen extends StatelessWidget {
  const TraderConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColor.deepBlue),
        ),
        backgroundColor: Colors.white,
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 130.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: SvgPicture.asset(
                  "assets/images/welcome.svg",
                  fit: BoxFit.cover,
                  width: 265.w,
                  height: 280.h,
                  placeholderBuilder: (context) => SizedBox(
                    height: 280.h,
                    width: 265.w,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('thanks_for_joining'),
                style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.deepBlue),
              ),
              SizedBox(
                height: 100.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 62.w),
                child: CustomButton(
                  title: Text(
                    AppLocalizations.of(context)!.translate('home'),
                    style: TextStyle(
                      color: AppColor.deepBlue,
                      fontSize: 19.sp,
                    ),
                  ),
                  color: Colors.white,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ControlView(),
                        ));
                  },
                ),
              ),
              const Spacer()
            ]),
      ),
    );
  }
}
