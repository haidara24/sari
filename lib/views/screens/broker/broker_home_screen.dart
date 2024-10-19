import 'package:custome_mobile/business_logic/bloc/attachment/attachment_type_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/auth_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/group_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/offer_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/package_type_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/post_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/section_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/state_custome_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/trader_log_bloc.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/screens/broker/log_screens/broker_log_screen.dart';
import 'package:custome_mobile/views/screens/trader/custome_tariff_screen.dart';
import 'package:custome_mobile/views/screens/trader/log_screens/log_screen.dart';
import 'package:custome_mobile/views/screens/broker/trader_orders_screen.dart';
import 'package:custome_mobile/views/screens/trader/trader_calculator_screen.dart';
import 'package:custome_mobile/views/screens/trader/trader_main_screen.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrokerHomeScreen extends StatefulWidget {
  const BrokerHomeScreen({Key? key}) : super(key: key);

  @override
  State<BrokerHomeScreen> createState() => _BrokerHomeScreenState();
}

class _BrokerHomeScreenState extends State<BrokerHomeScreen>
    with TickerProviderStateMixin {
  int currentIndex = 2;
  int navigationValue = 2;
  String title = "الرئيسية";
  Widget currentScreen = const TraderMainScreen();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(PostLoadEvent());
    BlocProvider.of<SectionBloc>(context).add(SectionLoadEvent());
    BlocProvider.of<StateCustomeBloc>(context).add(StateCustomeLoadEvent());
    BlocProvider.of<PackageTypeBloc>(context).add(PackageTypeLoadEvent());
    BlocProvider.of<AttachmentTypeBloc>(context).add(AttachmentTypeLoadEvent());
    BlocProvider.of<OfferBloc>(context).add(OfferLoadEvent());
    BlocProvider.of<GroupBloc>(context).add(GroupLoadEvent());
    _tabController = TabController(
      initialIndex: 2,
      length: 5,
      vsync: this,
    );
  }

  void changeSelectedValue(
      {required int selectedValue, required BuildContext contxt}) async {
    setState(() {
      navigationValue = selectedValue;
    });
    switch (selectedValue) {
      case 0:
        {
          setState(() {
            title = "طلبات التخليص";
            currentScreen = const TraderOrdersScreen();
          });
          break;
        }
      case 1:
        {
          setState(() {
            title = "حاسبة الرسوم";

            currentScreen = TraderCalculatorScreen();
          });
          break;
        }
      case 2:
        {
          setState(() {
            title = "الرئيسية";

            BlocProvider.of<PostBloc>(context).add(PostLoadEvent());

            currentScreen = const TraderMainScreen();
          });
          break;
        }
      case 3:
        {
          setState(() {
            title = "التعرفة الجمركية";

            currentScreen = const CustomeTariffScreen();
          });
          break;
        }
      case 4:
        {
          BlocProvider.of<TraderLogBloc>(context)
              .add(const TraderLogLoadEvent("R"));
          setState(() {
            title = "السجل";
            currentScreen = const BrokerLogScreen();
          });
          break;
        }
    }
  }

  List<Color> bottomNavbarColor() {
    switch (navigationValue) {
      case 0:
        return [
          AppColor.lighterAppBarBlue,
          AppColor.lightAppBarBlue,
          AppColor.deepAppBarBlue,
          AppColor.deepAppBarBlue,
          AppColor.deepAppBarBlue,
        ];
      case 1:
        return [
          AppColor.lightAppBarBlue,
          AppColor.lighterAppBarBlue,
          AppColor.lightAppBarBlue,
          AppColor.deepAppBarBlue,
          AppColor.deepAppBarBlue,
        ];
      case 2:
        return [
          AppColor.deepAppBarBlue,
          AppColor.lightAppBarBlue,
          AppColor.lighterAppBarBlue,
          AppColor.lightAppBarBlue,
          AppColor.deepAppBarBlue,
        ];

      case 3:
        return [
          AppColor.deepAppBarBlue,
          AppColor.deepAppBarBlue,
          AppColor.lightAppBarBlue,
          AppColor.lighterAppBarBlue,
          AppColor.lightAppBarBlue,
        ];

      case 4:
        return [
          AppColor.deepAppBarBlue,
          AppColor.deepAppBarBlue,
          AppColor.deepAppBarBlue,
          AppColor.lightAppBarBlue,
          AppColor.lighterAppBarBlue,
        ];

      default:
        return [
          AppColor.deepAppBarBlue,
          AppColor.lightAppBarBlue,
          AppColor.lighterAppBarBlue,
          AppColor.lightAppBarBlue,
          AppColor.deepAppBarBlue,
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            title: title,
            scaffoldKey: _scaffoldKey,
          ),
          drawer: Drawer(
            backgroundColor: AppColor.deepBlue,
            elevation: 1,
            width: 250,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: ListView(children: [
                SizedBox(
                  height: 35.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColor.goldenYellow,
                      radius: 35.h,
                    ),
                    Text(
                      "Haidara",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                const Divider(
                  color: Colors.white,
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/profile.svg",
                    height: 20.h,
                  ),
                  title: Text(
                    "الملف الشخصي",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/log.svg",
                    height: 20.h,
                  ),
                  title: Text(
                    "السجل",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/icons/favorite.png",
                    height: 20.h,
                  ),
                  title: Text(
                    "المحفوظات",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/calculator.svg",
                    height: 20.h,
                  ),
                  title: Text(
                    "حساباتي ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/tasks.svg",
                    height: 20.h,
                  ),
                  title: Text(
                    "المهام",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/privacy.svg",
                    height: 20.h,
                  ),
                  title: Text(
                    "سياسة الخصوصية",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/icons/settings.png",
                    height: 20.h,
                  ),
                  title: Text(
                    "الاعدادات",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/help.svg",
                    height: 20.h,
                  ),
                  title: Text(
                    "مساعدة",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(UserLoggedOut());
                  },
                  child: ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/log_out.svg",
                      height: 20.h,
                    ),
                    title: Text(
                      "تسجيل خروج",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          bottomNavigationBar: Container(
              height: 88.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: bottomNavbarColor(),
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
              child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  controller: _tabController,
                  indicatorColor: AppColor.goldenYellow,
                  labelColor: AppColor.goldenYellow,
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(fontSize: 15),
                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                  padding: EdgeInsets.zero,
                  onTap: (value) {
                    changeSelectedValue(selectedValue: value, contxt: context);
                  },
                  tabs: [
                    Tab(
                      // text: "طلب مخلص",
                      height: 66.h,
                      icon: navigationValue == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "assets/icons/trader_orders_active.png",
                                  width: 36.w,
                                  height: 36.h,
                                ),
                                Text(
                                  "طلبات التخليص",
                                  style: TextStyle(
                                      color: AppColor.goldenYellow,
                                      fontSize: 13),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "assets/icons/trader_orders.png",
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                const Text(
                                  "طلبات التخليص",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                    ),
                    Tab(
                      // text: "الحاسبة",
                      height: 66.h,
                      icon: navigationValue == 1
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "assets/icons/calculator_active.png",
                                  width: 36.w,
                                  height: 36.h,
                                ),
                                Text(
                                  "الحاسبة",
                                  style: TextStyle(
                                      color: AppColor.goldenYellow,
                                      fontSize: 15),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/calculator.svg",
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                const Text(
                                  "الحاسبة",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                    ),
                    Tab(
                      // text: "الرئيسية",
                      height: 66.h,
                      icon: navigationValue == 2
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "assets/icons/home_active.png",
                                  width: 36.w,
                                  height: 36.h,
                                ),
                                Text(
                                  "الرئيسية",
                                  style: TextStyle(
                                      color: AppColor.goldenYellow,
                                      fontSize: 15),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/home.svg",
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                const Text(
                                  "الرئيسية",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                    ),
                    Tab(
                      // text: "التعرفة",
                      height: 66.h,
                      icon: navigationValue == 3
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "assets/icons/tariff_active.png",
                                  width: 36.w,
                                  height: 36.h,
                                ),
                                Text(
                                  "التعرفة",
                                  style: TextStyle(
                                      color: AppColor.goldenYellow,
                                      fontSize: 15),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/tariff.svg",
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                const Text(
                                  "التعرفة",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                    ),
                    Tab(
                      // text: "السجل",
                      height: 66.h,
                      icon: navigationValue == 4
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "assets/icons/log_active.png",
                                  width: 36.w,
                                  height: 36.h,
                                ),
                                Text(
                                  "السجل",
                                  style: TextStyle(
                                      color: AppColor.goldenYellow,
                                      fontSize: 15),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/log.svg",
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                const Text(
                                  "السجل",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                    ),
                  ])),
          body: currentScreen,
        ),
      ),
    );
  }
}
