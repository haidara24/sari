import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/control_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:custome_mobile/Localization/app_localizations.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  PageController controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget builfPage(
          {required Color color,
          required String urlImage,
          required Widget title,
          required Widget subtitle}) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SvgPicture.asset(
                urlImage,
                fit: BoxFit.cover,
                width: 275.w,
                height: 290.w,
                placeholderBuilder: (context) => SizedBox(
                  width: 275.w,
                  height: 290.w,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            title,
            subtitle,
            // Text(
            //   subtitle,
            //   style: TextStyle(color: AppColor.deepYellow, fontSize: 24),
            // ),
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
            SvgPicture.asset(
              "assets/images/sari_white.svg",
              height: 65.h,
              width: 120.w,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(bottom: 80),
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      isLastPage = value == 3;
                    });
                  },
                  children: [
                    builfPage(
                      color: Colors.white,
                      urlImage: "assets/images/intro1.svg",
                      title: Text(
                        AppLocalizations.of(context)!.translate('screen1_1'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.deepBlue,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                            text: AppLocalizations.of(context)!
                                .translate('screen1_2'),
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: AppColor.deepBlue,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .translate('screen1_3'),
                                  style: TextStyle(
                                    color: AppColor.deepYellow,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ]),
                      ),
                    ),
                    builfPage(
                        color: Colors.white,
                        urlImage: "assets/images/intro2.svg",
                        title: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .translate('screen2_1'),
                              style: TextStyle(
                                fontSize: localeState.value.languageCode == 'en'
                                    ? 22.sp
                                    : 24.sp,
                                color: AppColor.deepBlue,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .translate('screen2_2'),
                                  style: TextStyle(
                                    fontSize:
                                        localeState.value.languageCode == 'en'
                                            ? 22.sp
                                            : 24.sp,
                                    color: AppColor.deepYellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.translate('screen2_3'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.deepBlue,
                            fontSize: localeState.value.languageCode == 'en'
                                ? 22.sp
                                : 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    builfPage(
                        color: Colors.white,
                        urlImage: "assets/images/intro3.svg",
                        title: Text(
                          AppLocalizations.of(context)!.translate('screen3_1'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.deepBlue,
                            fontSize: localeState.value.languageCode == 'en'
                                ? 22.sp
                                : 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .translate('screen3_2'),
                              style: TextStyle(
                                fontSize: localeState.value.languageCode == 'en'
                                    ? 22.sp
                                    : 24.sp,
                                color: AppColor.deepBlue,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .translate('screen3_3'),
                                  style: TextStyle(
                                    fontSize:
                                        localeState.value.languageCode == 'en'
                                            ? 22.sp
                                            : 24.sp,
                                    color: AppColor.deepYellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                        )),
                    builfPage(
                        color: Colors.white,
                        urlImage: "assets/images/intro4.svg",
                        title: Text(
                          AppLocalizations.of(context)!.translate('screen4_1'),
                          style: TextStyle(
                            color: AppColor.deepBlue,
                            fontSize: localeState.value.languageCode == 'en'
                                ? 22.sp
                                : 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "",
                          style: TextStyle(
                            color: AppColor.deepBlue,
                            fontSize: localeState.value.languageCode == 'en'
                                ? 22.sp
                                : 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
              ),
            ),
            bottomSheet: isLastPage
                ? TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(80.h)),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool("showHome", true);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ControlView(),
                          ));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate('start_now'),
                      style: TextStyle(
                        fontSize: 26.sp,
                        color: AppColor.deepYellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                : Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 80.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              controller.jumpToPage(3);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.translate('skip'),
                              style: TextStyle(
                                color: AppColor.deepYellow,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Center(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 4,
                            effect: WormEffect(
                                spacing: 14.w,
                                dotHeight: 15.h,
                                dotWidth: 15.w,
                                dotColor: AppColor.lightYellow,
                                activeDotColor: AppColor.deepYellow),
                            onDotClicked: (index) => controller.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.translate('next'),
                              style: TextStyle(
                                color: AppColor.deepYellow,
                                fontSize: 24.sp,
                              ),
                            )),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
