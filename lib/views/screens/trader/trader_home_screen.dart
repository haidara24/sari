// import 'package:custome_mobile/business_logic/bloc/attachment_type_bloc.dart';
import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/auth_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_result_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculator_panel_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/chapter_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_item_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_select_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/flag_select_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/flags_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/group_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/package_type_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/post_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/search_section_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/section_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/state_custome_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/sub_chapter_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/trader_log_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/constants/enums.dart';
import 'package:custome_mobile/data/models/accurdion_model.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/providers/calculator_provider.dart';
import 'package:custome_mobile/data/providers/directorate_provider.dart';
import 'package:custome_mobile/data/providers/order_broker_provider.dart';
import 'package:custome_mobile/data/services/fcm_service.dart';
import 'package:custome_mobile/enum/panel_state.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/helpers/formatter.dart';
import 'package:custome_mobile/views/screens/trader/custome_tariff_screen.dart';
import 'package:custome_mobile/views/screens/trader/log_screens/log_screen.dart';
import 'package:custome_mobile/views/screens/trader/order_broker_screen.dart';
import 'package:custome_mobile/views/screens/trader/trader_calculator_multi_screen.dart';
import 'package:custome_mobile/views/screens/trader/trader_calculator_screen.dart';
import 'package:custome_mobile/views/screens/trader/trader_main_screen.dart';
import 'package:custome_mobile/views/widgets/calculator_loading_screen.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/highlight_text.dart';
import 'package:custome_mobile/views/widgets/item_taxes_widget.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intel;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class TraderHomeScreen extends StatefulWidget {
  const TraderHomeScreen({Key? key}) : super(key: key);

  @override
  State<TraderHomeScreen> createState() => _TraderHomeScreenState();
}

class _TraderHomeScreenState extends State<TraderHomeScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  int currentIndex = 2;
  int navigationValue = 2;
  String title = "Home";
  Widget currentScreen = const TraderMainScreen();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  late AnimationController _animationController;
  final panelTransation = const Duration(milliseconds: 500);
  PanelState _panelState = PanelState.hidden;
  final GlobalKey<FormState> _calculatorformkey = GlobalKey<FormState>();
  bool calculateFeeScreen = false;
  CalculatorProvider? calculator_Provider;
  OrderBrokerProvider? order_broker_Provider;
  DirectorateProvider? directorate_provider;
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(PostLoadEvent());
    BlocProvider.of<GroupBloc>(context).add(GroupLoadEvent());

    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    _tabController = TabController(
      initialIndex: 2,
      length: 5,
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        title = AppLocalizations.of(context)!.translate('home');
      });
      calculator_Provider =
          Provider.of<CalculatorProvider>(context, listen: false);
      directorate_provider =
          Provider.of<DirectorateProvider>(context, listen: false);
      order_broker_Provider =
          Provider.of<OrderBrokerProvider>(context, listen: false);
    });
    WidgetsBinding.instance.addObserver(this);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2500,
      ),
    );
  }

  // init();

  @override
  void dispose() {
    // Remove the WidgetsBindingObserver when the state is disposed
    WidgetsBinding.instance.removeObserver(this);
    scroll.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Check the keyboard visibility when the metrics change
  }

  void changeSelectedValue(
      {required int selectedValue, required BuildContext contxt}) async {
    setState(() {
      navigationValue = selectedValue;
    });
    _tabController.animateTo(selectedValue);

    switch (selectedValue) {
      case 0:
        {
          BlocProvider.of<TraderLogBloc>(context)
              .add(const TraderLogLoadEvent("R"));
          setState(() {
            title = AppLocalizations.of(context)!.translate('trader_log_title');
            currentScreen = const LogScreen();
          });
          break;
        }
      case 1:
        {
          calculator_Provider!.initProvider();
          setState(() {
            title = AppLocalizations.of(context)!.translate('calculator_title');

            currentScreen = TraderCalculatorMultiScreen();
          });
          break;
        }
      case 2:
        {
          // print(MediaQuery.of(context).size.width);
          print(DateTime.fromMillisecondsSinceEpoch((1701851497) * 100000));
          setState(() {
            title = AppLocalizations.of(context)!.translate('home');

            BlocProvider.of<PostBloc>(context).add(PostLoadEvent());

            currentScreen = const TraderMainScreen();
          });
          break;
        }
      case 3:
        {
          BlocProvider.of<SectionBloc>(context).add(SectionLoadEvent());
          setState(() {
            title = AppLocalizations.of(context)!.translate('tariff_title');

            currentScreen = const CustomeTariffScreen();
          });
          break;
        }
      case 4:
        {
          order_broker_Provider!.initProvider();
          directorate_provider!.init();
          setState(() {
            title =
                AppLocalizations.of(context)!.translate('broker_order_title');
            BlocProvider.of<StateCustomeBloc>(context)
                .add(StateCustomeLoadEvent());

            BlocProvider.of<PackageTypeBloc>(context)
                .add(PackageTypeLoadEvent());
            currentScreen = const OrderBrokerScreen();
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

  double? _getTopForPanel(PanelState state, Size size) {
    if (state == PanelState.open) {
      return 0;
    } else if (state == PanelState.hidden) {
      return (size.height);
    }
    return null;
  }

  double? _getSizeForPanel(PanelState state, Size size) {
    if (state == PanelState.open) {
      return size.height;
    } else if (state == PanelState.hidden) {
      return (size.height * 0.5);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (_panelState == PanelState.open) {
          if (calculateFeeScreen) {
            setState(() {
              calculateFeeScreen = false;
            });
          } else {
            BlocProvider.of<CalculatorPanelBloc>(context)
                .add(CalculatorPanelHideEvent());
          }
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, _) {
                  return Stack(
                    children: [
                      SafeArea(
                        child: GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            BlocProvider.of<BottomNavBarCubit>(context)
                                .emitShow();
                          },
                          child: Scaffold(
                            key: _scaffoldKey,
                            resizeToAvoidBottomInset: false,
                            appBar: CustomAppBar(
                              title: title,
                              scaffoldKey: _scaffoldKey,
                              onTap: () => changeSelectedValue(
                                  selectedValue: 2, contxt: context),
                            ),
                            drawer: Drawer(
                              backgroundColor: AppColor.deepAppBarBlue,
                              elevation: 1,
                              width: MediaQuery.of(context).size.width * .85,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: ListView(children: [
                                  SizedBox(
                                    height: 35.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColor.goldenYellow,
                                        radius: 35.h,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(180),
                                          child: Image.network(
                                            "",
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Center(
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                  fontSize: 28.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "SFIFF",
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
                                      AppLocalizations.of(context)!
                                          .translate('profile'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Container(
                                      width: 35.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: AppColor.goldenYellow,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Center(
                                        child: Text(
                                          "soon",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // changeSelectedValue(
                                      //     selectedValue: 0, contxt: context);
                                      // _scaffoldKey.currentState!.closeDrawer();
                                    },
                                    child: ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/icons/log.svg",
                                        height: 20.h,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate('log'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Container(
                                        width: 35.w,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                            color: AppColor.goldenYellow,
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: Center(
                                          child: Text(
                                            "soon",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Image.asset(
                                      "assets/icons/favorite.png",
                                      height: 20.h,
                                    ),
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .translate('saved'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Container(
                                      width: 35.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: AppColor.goldenYellow,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Center(
                                        child: Text(
                                          "soon",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: SvgPicture.asset(
                                      "assets/icons/calculator.svg",
                                      height: 20.h,
                                    ),
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .translate('my_calculates'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Container(
                                      width: 35.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: AppColor.goldenYellow,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Center(
                                        child: Text(
                                          "soon",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: SvgPicture.asset(
                                      "assets/icons/tasks.svg",
                                      height: 20.h,
                                    ),
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .translate('tasks'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Container(
                                      width: 35.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: AppColor.goldenYellow,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Center(
                                        child: Text(
                                          "soon",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
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
                                      AppLocalizations.of(context)!
                                          .translate('policy'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Container(
                                      width: 35.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: AppColor.goldenYellow,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Center(
                                        child: Text(
                                          "soon",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (AppLocalizations.of(context)!
                                          .isEnLocale!) {
                                        BlocProvider.of<LocaleCubit>(context)
                                            .toArabic();
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString("language", "ar");
                                      } else {
                                        BlocProvider.of<LocaleCubit>(context)
                                            .toEnglish();

                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString("language", "en");
                                      }
                                      BlocProvider.of<SectionBloc>(context)
                                          .add(SectionLoadEvent());

                                      Future.delayed(
                                              const Duration(milliseconds: 500))
                                          .then((value) => _scaffoldKey
                                              .currentState!
                                              .closeDrawer());
                                    },
                                    child: ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/icons/translate.svg",
                                        height: 20.h,
                                      ),
                                      title: Text(
                                        localeState.value.languageCode != 'en'
                                            ? "English"
                                            : "العربية",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // trailing: Container(
                                      //   width: 35.w,
                                      //   height: 20.h,
                                      //   decoration: BoxDecoration(
                                      //       color: AppColor.goldenYellow,
                                      //       borderRadius:
                                      //           BorderRadius.circular(2)),
                                      //   child: Center(
                                      //     child: Text(
                                      //       "soon",
                                      //       style: TextStyle(
                                      //         color: Colors.white,
                                      //         fontSize: 12.sp,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: SvgPicture.asset(
                                      "assets/icons/help.svg",
                                      height: 20.h,
                                    ),
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .translate('help'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Container(
                                      width: 35.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: AppColor.goldenYellow,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Center(
                                        child: Text(
                                          "soon",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            // <-- SEE HERE
                                            backgroundColor: Colors.white,
                                            title: const Text('Log out'),
                                            content:
                                                const SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                      'Are you sure want to log out?'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('No'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Yes'),
                                                onPressed: () {
                                                  BlocProvider.of<AuthBloc>(
                                                          context)
                                                      .add(UserLoggedOut());
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/icons/log_out.svg",
                                        height: 20.h,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate('log_out'),
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
                            bottomNavigationBar: BlocBuilder<BottomNavBarCubit,
                                BottomNavBarState>(
                              builder: (context, state) {
                                if (state is BottomNavBarShown) {
                                  return Container(
                                    height: 75.h,
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
                                      dividerColor: Colors.transparent,
                                      labelColor: AppColor.goldenYellow,
                                      unselectedLabelColor: Colors.white,
                                      // labelStyle: TextStyle(fontSize: 15.sp),
                                      // unselectedLabelStyle:
                                      //     TextStyle(fontSize: 14.sp),
                                      padding: EdgeInsets.zero,
                                      onTap: (value) {
                                        changeSelectedValue(
                                            selectedValue: value,
                                            contxt: context);
                                      },
                                      tabs: [
                                        Tab(
                                          // text: "طلب مخلص",
                                          height: 62.h,
                                          icon: navigationValue == 0
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/log_active.svg",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'trader_log_nav'),
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .goldenYellow,
                                                            fontSize: 15.sp),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/log.svg",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'trader_log_nav'),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15.sp),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        ),
                                        Tab(
                                          // text: "الحاسبة",
                                          height: 62.h,
                                          icon: navigationValue == 1
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/calculator_active.svg",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'calculator_nav'),
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .goldenYellow,
                                                            fontSize: 15.sp),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/calculator.svg",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'calculator_nav'),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15.sp),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        ),
                                        Tab(
                                          // text: "الرئيسية",
                                          height: 62.h,
                                          icon: navigationValue == 2
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/home_active.svg",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate('home'),
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .goldenYellow,
                                                            fontSize: 15.sp),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/home.svg",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate('home'),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15.sp),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        ),
                                        Tab(
                                          // text: "التعرفة",
                                          height: 62.h,
                                          icon: navigationValue == 3
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/tariff_active.svg",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'tariff_nav'),
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .goldenYellow,
                                                            fontSize: 15.sp),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/tariff.svg",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'tariff_nav'),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15.sp),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        ),
                                        Tab(
                                          // text: "السجل",
                                          height: 62.h,
                                          icon: navigationValue == 4
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/broker_order_active.svg",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'broker_order_nav'),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .goldenYellow,
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/broker_order.png",
                                                      width: 28.w,
                                                      height: 28.w,
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'broker_order_nav'),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                            body: currentScreen,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: panelTransation,
                        curve: Curves.decelerate,
                        left: 0,
                        right: 0,
                        top: _getTopForPanel(_panelState, size),
                        height: _getSizeForPanel(_panelState, size),
                        child: Container(
                          color: Colors.white,
                          child: AnimatedSwitcher(
                            duration: panelTransation,
                            child: _buildPanelOption(context),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          );
        },
      ),
    );
  }

  Widget _buildPanelOption(BuildContext context) {
    return BlocConsumer<CalculatorPanelBloc, CalculatorPanelState>(
      listener: (context, state) {
        if (state is CalculatorPanelOpened ||
            state is TariffPanelOpened ||
            state is FlagsPanelOpened) {
          setState(() {
            _panelState = PanelState.open;
          });
        } else {
          setState(() {
            _panelState = PanelState.hidden;
          });
        }
      },
      builder: (context, state) {
        if (state is CalculatorPanelOpened) {
          if (!calculateFeeScreen) {
            return _buildPanelWidget(context);
          } else {
            return _buildResultPanel(context);
          }
        } else if (state is TariffPanelOpened) {
          return _buildTariffPanel(context);
        } else if (state is FlagsPanelOpened) {
          return _buildFlagsPanel(context);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  final TextEditingController _typeAheadController = TextEditingController();

  final TextEditingController _wieghtController = TextEditingController();

  final TextEditingController _originController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  String syrianExchangeValue = "0.0";

  String syrianTotalValue = "0.0";

  String totalValueWithEnsurance = "0.0";

  Package? selectedPackage;
  Origin? selectedOrigin;

  String wieghtUnit = "";
  String wieghtLabel = "الوزن";

  double usTosp = 30;
  double basePrice = 0.0;
  double wieghtValue = 0.0;

  bool valueEnabled = true;
  bool allowexport = false;
  bool fillorigin = false;
  bool originerror = false;
  bool isfeeequal001 = false;
  bool isBrand = false;
  bool brandValue = false;
  bool rawMaterialValue = false;
  bool industrialValue = false;
  bool isTubes = false;
  bool tubesValue = false;
  bool isLycra = false;
  bool lycraValue = false;
  bool isColored = false;
  bool colorValue = false;
  bool showunit = true;
  bool isdropdwonVisible = false;
  String _placeholder = "";
  var f = intel.NumberFormat("#,###", "en_US");

  CalculateObject result = CalculateObject();
  final FocusNode _statenode = FocusNode();

  List<Extras> items = [];
  Extras? selectedValue;
  void calculateTotalValueWithPrice() {
    var syrianExch = double.parse(_wieghtController.text.replaceAll(",", "")) *
        double.parse(_valueController.text.replaceAll(",", ""));
    var syrianTotal = syrianExch * 30;
    var totalEnsurance = (syrianTotal * 0.0012);
    setState(() {
      syrianExchangeValue = syrianExch.round().toString();
      syrianTotalValue = syrianTotal.round().toString();
      totalValueWithEnsurance = totalEnsurance.round().toString();
    });
  }

  void calculateTotalValue() {
    var syrianTotal =
        double.parse(_valueController.text.replaceAll(",", "")) * 30;
    var totalEnsurance = (syrianTotal * 0.0012);
    setState(() {
      syrianTotalValue = syrianTotal.round().toString();
      totalValueWithEnsurance = totalEnsurance.round().toString();
    });
  }

  void selectSuggestion(Package suggestion, String lang) {
    setState(() {
      _typeAheadController.text = suggestion.label!;
    });
    selectedPackage = suggestion;
    if (suggestion.price! > 0) {
      basePrice = suggestion.price!;

      _valueController.text = suggestion.price!.toString();
      setState(() {
        valueEnabled = false;
      });
    } else {
      setState(() {
        basePrice = 0.0;

        if (_valueController.text.isEmpty) {
          _valueController.text = "0.0";
        }
        valueEnabled = true;
        syrianExchangeValue = "30";
      });
    }

    if (suggestion.extras!.isNotEmpty) {
      if (suggestion.extras![0].brand!) {
        setState(() {
          isBrand = true;
          brandValue = false;
        });
      } else {
        setState(() {
          isBrand = false;
          brandValue = false;
        });
      }

      if (suggestion.extras![0].tubes!) {
        setState(() {
          isTubes = true;
          tubesValue = false;
        });
      } else {
        setState(() {
          isTubes = false;
          tubesValue = false;
        });
      }

      if (suggestion.extras![0].lycra!) {
        setState(() {
          isLycra = true;
          lycraValue = false;
        });
      } else {
        setState(() {
          isLycra = false;
          lycraValue = false;
        });
      }

      if (suggestion.extras![0].coloredThread!) {
        setState(() {
          isColored = true;
          colorValue = false;
        });
      } else {
        setState(() {
          isColored = false;
          colorValue = false;
        });
      }
    }

    if (suggestion.unit!.isNotEmpty) {
      switch (suggestion.unit) {
        case "كغ":
          setState(() {
            wieghtLabel = lang == 'en' ? "weight" : "الوزن";
          });
          break;
        case "طن":
          setState(() {
            wieghtLabel = lang == 'en' ? "weight" : "الوزن";
          });
          break;
        case "قيراط":
          setState(() {
            wieghtLabel = lang == 'en' ? "weight" : "الوزن";
          });
          break;
        case "  كيلو واط بالساعة 1000":
          setState(() {
            wieghtLabel = lang == 'en' ? "power" : "الاستطاعة";
          });
          break;
        case "  الاستطاعة بالطن":
          setState(() {
            wieghtLabel = lang == 'en' ? "power" : "الاستطاعة";
          });
          break;
        case "واط":
          setState(() {
            wieghtLabel = lang == 'en' ? "power" : "الاستطاعة";
          });
          break;
        case "عدد الأزواج":
          setState(() {
            wieghtLabel = lang == 'en' ? "number" : "العدد";
          });
          break;
        case "عدد":
          setState(() {
            wieghtLabel = lang == 'en' ? "number" : "العدد";
          });
          break;
        case "طرد":
          setState(() {
            wieghtLabel = lang == 'en' ? "number" : "العدد";
          });
          break;
        case "قدم":
          setState(() {
            wieghtLabel = lang == 'en' ? "number" : "العدد";
          });
          break;
        case "متر":
          setState(() {
            wieghtLabel = lang == 'en' ? "volume" : "الحجم";
          });
          break;
        case "متر مربع":
          setState(() {
            wieghtLabel = lang == 'en' ? "volume" : "الحجم";
          });
          break;
        case "متر مكعب":
          setState(() {
            wieghtLabel = lang == 'en' ? "volume" : "الحجم";
          });
          break;
        case "لتر":
          setState(() {
            wieghtLabel = lang == 'en' ? "capacity" : "السعة";
          });
          break;
        default:
          setState(() {
            wieghtLabel = lang == 'en' ? "weight" : "الوزن";
          });
      }
      setState(() {
        wieghtUnit = suggestion.unit!;
        showunit = true;
      });
    } else {
      setState(() {
        wieghtUnit = "";
        showunit = false;
      });
    }

    if (suggestion.placeholder != "") {
      setState(() {
        _placeholder = suggestion.placeholder!;
        isdropdwonVisible = false;
        items = suggestion.extras!;
        isdropdwonVisible = true;
      });
    } else {
      setState(() {
        isdropdwonVisible = false;
        _placeholder = "";
        items = [];
      });
    }

    if (suggestion.fee! == 0.01) {
      setState(() {
        isfeeequal001 = true;
      });
    } else {
      setState(() {
        isfeeequal001 = false;
      });
    }

    switch (suggestion.export1) {
      case "0":
        setState(() {
          allowexport = true;
        });
        break;
      case "1":
        setState(() {
          allowexport = false;
        });
        break;
      default:
    }
  }

  void selectOrigin(Origin origin) {
    _originController.text = " ${origin.label!}";
    setState(() {
      selectedOrigin = origin;
      originerror = false;
    });

    if (selectedPackage!.extras!.isNotEmpty) {
      outerLoop:
      for (var element in selectedPackage!.extras!) {
        for (var element1 in origin.countryGroups!) {
          if (element.countryGroup!.contains(element1)) {
            if (element.price! > 0) {
              _valueController.text = element.price!.toString();
              basePrice = element.price!;

              setState(() {
                valueEnabled = false;
              });
              break outerLoop;
            }
          } else {
            setState(() {
              basePrice = 0.0;
              _valueController.text = "0.0";
              valueEnabled = true;
              syrianExchangeValue = "30";
            });
          }
        }
      }
      if (origin.countryGroups!.isEmpty) {
        setState(() {
          basePrice = 0.0;

          _valueController.text = "0.0";
          valueEnabled = true;
          syrianExchangeValue = "30";
        });
      }
    }
    evaluatePrice();
  }

  void calculateExtrasPrice(double percentage, bool add) {
    var price = 0.0;
    if (add) {
      price = double.parse(_valueController.text) + (basePrice * percentage);

      setState(() {
        _valueController.text = price.toString();
      });
    } else {
      price = double.parse(_valueController.text) - (basePrice * percentage);

      setState(() {
        _valueController.text = price.toString();
      });
    }
  }

  void evaluatePrice() {
    if (valueEnabled) {
      calculateTotalValue();
    } else {
      calculateTotalValueWithPrice();
    }
  }

  Widget _buildPanelWidget(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: AppColor.deepBlue,
              title: Text(
                AppLocalizations.of(context)!.translate('calculator_title'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = -1;
                    chapterselected = -1;
                    subchapterselected = -1;
                    feeselected = -1;
                  });
                  BlocProvider.of<CalculatorPanelBloc>(context)
                      .add(CalculatorPanelHideEvent());
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              elevation: 0,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                },
                child: BlocBuilder<LocaleCubit, LocaleState>(
                  builder: (context, localeState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BlocConsumer<FeeItemBloc, FeeItemState>(
                        listener: (context, state) {
                          if (state is FeeItemLoadedSuccess) {
                            setState(() {
                              _wieghtController.text = "0.0";
                              _valueController.text = "0.0";
                              syrianExchangeValue = "0.0";
                              syrianTotalValue = "0.0";
                              totalValueWithEnsurance = "0.0";
                            });
                            selectSuggestion(
                                state.fee, localeState.value.languageCode);
                          }
                        },
                        builder: (context, state) {
                          if (state is FeeItemLoadedSuccess) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 35, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Form(
                                      key: _calculatorformkey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            controller: _typeAheadController,
                                            enabled: false,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .translate('goods_name'),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 9.0,
                                                      vertical: 11.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Visibility(
                                            visible: allowexport,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .translate(
                                                      'fee_import_banned'),
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Visibility(
                                            visible: isdropdwonVisible,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<Extras>(
                                                isExpanded: true,
                                                barrierLabel: _placeholder,
                                                hint: Text(
                                                  _placeholder,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                                items: items
                                                    .map((Extras item) =>
                                                        DropdownMenuItem<
                                                            Extras>(
                                                          value: item,
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                bottom: BorderSide(
                                                                    color: AppColor
                                                                        .goldenYellow,
                                                                    width: 1),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              item.label!,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: selectedValue,
                                                onChanged: (Extras? value) {
                                                  if (value!
                                                      .countryGroup!.isEmpty) {
                                                    if (value.price! > 0) {
                                                      basePrice = value.price!;

                                                      _valueController.text =
                                                          value.price!
                                                              .toString();
                                                      setState(() {
                                                        valueEnabled = false;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        basePrice = 0.0;

                                                        _valueController.text =
                                                            "0.0";
                                                        valueEnabled = true;
                                                        syrianExchangeValue =
                                                            "30";
                                                      });
                                                    }
                                                    evaluatePrice();
                                                  } else {
                                                    if (value.price! > 0) {
                                                      basePrice = value.price!;

                                                      _valueController.text =
                                                          value.price!
                                                              .toString();
                                                      setState(() {
                                                        valueEnabled = false;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        basePrice = 0.0;

                                                        _valueController.text =
                                                            "0.0";
                                                        valueEnabled = true;
                                                        syrianExchangeValue =
                                                            "30";
                                                      });
                                                    }
                                                    evaluatePrice();
                                                  }
                                                  setState(() {
                                                    selectedValue = value;
                                                  });
                                                },
                                                buttonStyleData:
                                                    ButtonStyleData(
                                                  height: 50,
                                                  width: double.infinity,

                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 9.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                      color: Colors.black26,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  // elevation: 2,
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                  ),
                                                  iconSize: 20,
                                                  iconEnabledColor:
                                                      AppColor.AccentBlue,
                                                  iconDisabledColor:
                                                      Colors.grey,
                                                ),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: Colors.white,
                                                  ),
                                                  scrollbarTheme:
                                                      ScrollbarThemeData(
                                                    radius:
                                                        const Radius.circular(
                                                            40),
                                                    thickness:
                                                        MaterialStateProperty
                                                            .all(6),
                                                    thumbVisibility:
                                                        MaterialStateProperty
                                                            .all(true),
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                    MenuItemStyleData(
                                                  height: 40.h,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Wrap(
                                            children: [
                                              Visibility(
                                                visible: isfeeequal001,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: CheckboxListTile(
                                                      value: rawMaterialValue,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text(AppLocalizations
                                                              .of(context)!
                                                          .translate(
                                                              'raw_material')),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          rawMaterialValue =
                                                              value!;
                                                        });
                                                        evaluatePrice();
                                                      }),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isfeeequal001,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: CheckboxListTile(
                                                      value: industrialValue,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'industrial')),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          industrialValue =
                                                              value!;
                                                        });
                                                        evaluatePrice();
                                                      }),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isBrand,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: CheckboxListTile(
                                                      value: brandValue,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'isBrand')),
                                                      onChanged: (value) {
                                                        calculateExtrasPrice(
                                                            1.5, value!);
                                                        setState(() {
                                                          brandValue = value;
                                                        });
                                                        evaluatePrice();
                                                      }),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isTubes,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: CheckboxListTile(
                                                      value: tubesValue,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'isTubeValue')),
                                                      onChanged: (value) {
                                                        calculateExtrasPrice(
                                                            .1, value!);
                                                        setState(() {
                                                          tubesValue = value;
                                                        });
                                                        evaluatePrice();
                                                      }),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isColored,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: CheckboxListTile(
                                                      value: colorValue,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'isColored')),
                                                      onChanged: (value) {
                                                        calculateExtrasPrice(
                                                            .1, value!);
                                                        setState(() {
                                                          colorValue = value;
                                                        });
                                                        evaluatePrice();
                                                      }),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isLycra,
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: CheckboxListTile(
                                                      value: lycraValue,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'isLycra')),
                                                      onChanged: (value) {
                                                        calculateExtrasPrice(
                                                            .05, value!);
                                                        setState(() {
                                                          lycraValue = value;
                                                        });
                                                        evaluatePrice();
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                          BlocBuilder<FlagsBloc, FlagsState>(
                                            builder: (context, flagstate) {
                                              if (flagstate
                                                  is FlagsLoadedSuccess) {
                                                return DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<Origin>(
                                                    isExpanded: true,
                                                    hint: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .translate(
                                                              'select_origin'),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                      ),
                                                    ),
                                                    items: flagstate.origins
                                                        .map((Origin item) =>
                                                            DropdownMenuItem<
                                                                Origin>(
                                                              value: item,
                                                              child: SizedBox(
                                                                // width: 200,
                                                                child: Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .network(
                                                                      item.imageURL!,
                                                                      height:
                                                                          35.h,
                                                                      width:
                                                                          45.w,
                                                                      // semanticsLabel: 'A shark?!',
                                                                      placeholderBuilder:
                                                                          (BuildContext context) =>
                                                                              Container(
                                                                        height:
                                                                            35.h,
                                                                        width:
                                                                            45.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.grey[200],
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            7),
                                                                    Container(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        maxWidth:
                                                                            280.w,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        item.label!,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        // maxLines: 2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  // subtitle: Text('\$${suggestion['price']}'),
                                                                ),
                                                              ),
                                                            ))
                                                        .toList(),
                                                    value: selectedOrigin,
                                                    onChanged: (Origin? value) {
                                                      selectOrigin(value!);
                                                    },
                                                    dropdownSearchData:
                                                        DropdownSearchData(
                                                      searchController:
                                                          _originController,
                                                      searchInnerWidgetHeight:
                                                          60,
                                                      searchInnerWidget:
                                                          Container(
                                                        height: 60,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 8,
                                                          bottom: 4,
                                                          right: 8,
                                                          left: 8,
                                                        ),
                                                        child: TextFormField(
                                                          expands: true,
                                                          maxLines: null,
                                                          controller:
                                                              _originController,
                                                          onTap: () {
                                                            _originController
                                                                    .selection =
                                                                TextSelection(
                                                                    baseOffset:
                                                                        0,
                                                                    extentOffset:
                                                                        _originController
                                                                            .value
                                                                            .text
                                                                            .length);
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10,
                                                              vertical: 8,
                                                            ),
                                                            hintText: AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .translate(
                                                                    'select_origin'),
                                                            hintStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      searchMatchFn:
                                                          (item, searchValue) {
                                                        return item
                                                            .value!.label!
                                                            .contains(
                                                                searchValue);
                                                      },
                                                    ),
                                                    onMenuStateChange:
                                                        (isOpen) {
                                                      if (isOpen) {
                                                        setState(() {
                                                          _originController
                                                              .clear();
                                                        });
                                                      }
                                                    },
                                                    barrierColor:
                                                        Colors.black45,
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      height: 50,
                                                      width: double.infinity,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 14,
                                                              right: 14),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                          color: Colors.black26,
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      // elevation: 2,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_sharp,
                                                      ),
                                                      iconSize: 20,
                                                      iconEnabledColor:
                                                          AppColor.AccentBlue,
                                                      iconDisabledColor:
                                                          Colors.grey,
                                                    ),
                                                    dropdownStyleData:
                                                        DropdownStyleData(
                                                      maxHeight:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color: Colors.white,
                                                      ),
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius: const Radius
                                                            .circular(40),
                                                        thickness:
                                                            MaterialStateProperty
                                                                .all(6),
                                                        thumbVisibility:
                                                            MaterialStateProperty
                                                                .all(true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(
                                                      height: 40,
                                                    ),
                                                  ),
                                                );
                                              } else if (flagstate
                                                  is FlagsLoadingProgressState) {
                                                return const Center(
                                                  child:
                                                      LinearProgressIndicator(),
                                                );
                                              } else {
                                                return Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  FlagsBloc>(
                                                              context)
                                                          .add(
                                                              FlagsLoadEvent());
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'list_error'),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                        const Icon(
                                                          Icons.refresh,
                                                          color: Colors.grey,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          Visibility(
                                              visible: originerror,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .translate(
                                                        'select_origin_error'),
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              )),
                                          Visibility(
                                            visible: originerror,
                                            child: const SizedBox(
                                              height: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Focus(
                                            focusNode: _statenode,
                                            onFocusChange: (bool focus) {
                                              if (!focus) {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                BlocProvider.of<
                                                            BottomNavBarCubit>(
                                                        context)
                                                    .emitShow();
                                              }
                                            },
                                            child: TextFormField(
                                              controller: _wieghtController,
                                              onTap: () =>
                                                  _wieghtController.selection =
                                                      TextSelection(
                                                          baseOffset: 0,
                                                          extentOffset:
                                                              _wieghtController
                                                                  .value
                                                                  .text
                                                                  .length),
                                              // enabled: !valueEnabled,textInputAction: TextInputAction.done,
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  decimal: true, signed: true),
                                              inputFormatters: [
                                                DecimalFormatter(),
                                              ],
                                              decoration: InputDecoration(
                                                suffixText:
                                                    showunit ? wieghtUnit : "",
                                                labelText: wieghtLabel,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 9.0,
                                                        vertical: 11.0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                if (_originController
                                                    .text.isNotEmpty) {
                                                  setState(() {
                                                    originerror = false;
                                                  });
                                                  if (value.isNotEmpty) {
                                                    // calculateTotalValueWithPrice(value);
                                                    wieghtValue =
                                                        double.parse(value);
                                                  } else {
                                                    wieghtValue = 0.0;
                                                  }
                                                  evaluatePrice();
                                                } else {
                                                  setState(() {
                                                    originerror = true;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Focus(
                                            focusNode: _statenode,
                                            onFocusChange: (bool focus) {
                                              if (!focus) {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                BlocProvider.of<
                                                            BottomNavBarCubit>(
                                                        context)
                                                    .emitShow();
                                              }
                                            },
                                            child: TextFormField(
                                              controller: _valueController,
                                              onTap: () =>
                                                  _valueController.selection =
                                                      TextSelection(
                                                          baseOffset: 0,
                                                          extentOffset:
                                                              _valueController
                                                                  .value
                                                                  .text
                                                                  .length),
                                              // enabled: valueEnabled,
                                              textInputAction:
                                                  TextInputAction.done,
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  decimal: true, signed: true),
                                              inputFormatters: [
                                                DecimalFormatter(),
                                              ],
                                              style:
                                                  const TextStyle(fontSize: 18),
                                              decoration: InputDecoration(
                                                labelText: valueEnabled
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                            'total_value_in_dollar')
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .translate(
                                                            'price_for_custome'),
                                                suffixText: "\$",
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 9.0,
                                                        vertical: 11.0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                if (_originController
                                                    .text.isNotEmpty) {
                                                  setState(() {
                                                    originerror = false;
                                                  });
                                                  if (value.isNotEmpty) {
                                                    basePrice =
                                                        double.parse(value);
                                                    // calculateTotalValue();
                                                  } else {
                                                    basePrice = 0.0;
                                                    // calculateTotalValue();
                                                  }
                                                  evaluatePrice();
                                                } else {
                                                  setState(() {
                                                    originerror = true;
                                                  });
                                                }
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                          'insert_value_validate');
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            "${AppLocalizations.of(context)!.translate('convert_to_dollar_value')}: ${f.format(double.parse(syrianExchangeValue).toInt())}\$",
                                            style: TextStyle(fontSize: 17.sp),
                                          ),
                                          Text(
                                            "${AppLocalizations.of(context)!.translate('total_value_in_eygptian_pound')}: ${f.format(double.parse(syrianTotalValue).toInt())} E.P",
                                            style: TextStyle(fontSize: 17.sp),
                                          ),
                                          Text(
                                            "${AppLocalizations.of(context)!.translate('total_value_with_insurance')}: ${f.format(double.parse(totalValueWithEnsurance).toInt())} E.P",
                                            style: TextStyle(fontSize: 17.sp),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              BlocConsumer<CalculateResultBloc,
                                                  CalculateResultState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is CalculateResultSuccessed) {}
                                                },
                                                builder: (context, state) {
                                                  if (state
                                                      is CalculateResultLoading) {
                                                    return ElevatedButton(
                                                        onPressed: () {},
                                                        child:
                                                            const LoadingIndicator());
                                                  }
                                                  if (state
                                                      is CalculateResultFailed) {
                                                    return Text(state.error);
                                                  } else {
                                                    return CustomButton(
                                                        onTap: () {
                                                          result.insurance =
                                                              int.parse(
                                                                  totalValueWithEnsurance);
                                                          result.fee =
                                                              selectedPackage!
                                                                  .fee!;
                                                          result.rawMaterial =
                                                              rawMaterialValue
                                                                  ? 1
                                                                  : 0;
                                                          result.industrial =
                                                              industrialValue
                                                                  ? 1
                                                                  : 0;
                                                          result.totalTax =
                                                              selectedPackage!
                                                                  .totalTaxes!
                                                                  .totalTax!;
                                                          result.partialTax =
                                                              selectedPackage!
                                                                  .totalTaxes!
                                                                  .partialTax!;
                                                          result.origin =
                                                              selectedOrigin!
                                                                  .label!;
                                                          result.spendingFee =
                                                              selectedPackage!
                                                                  .spendingFee!;
                                                          result.supportFee =
                                                              selectedPackage!
                                                                  .supportFee!;
                                                          result.localFee =
                                                              selectedPackage!
                                                                  .localFee!;
                                                          result.protectionFee =
                                                              selectedPackage!
                                                                  .protectionFee!;
                                                          result.naturalFee =
                                                              selectedPackage!
                                                                  .naturalFee!;
                                                          result.taxFee =
                                                              selectedPackage!
                                                                  .taxFee!;
                                                          result.weight =
                                                              wieghtValue
                                                                  .toInt();
                                                          result.price =
                                                              basePrice.toInt();
                                                          result.cnsulate = 1;
                                                          result.dolar = 8585;
                                                          result.arabic_stamp =
                                                              650;
                                                          result.import_fee =
                                                              0.01;
                                                          BlocProvider.of<
                                                                      CalculateResultBloc>(
                                                                  context)
                                                              .add(
                                                                  CalculateTheResultEvent(
                                                                      result));
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //       builder: (context) =>
                                                          //           const TraderCalculatorResultScreen(),
                                                          //     ));
                                                          setState(() {
                                                            calculateFeeScreen =
                                                                true;
                                                          });
                                                        },
                                                        title: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 8.0,
                                                                  horizontal:
                                                                      12.w),
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .translate(
                                                                      'calculate_costume_fee')),
                                                        ));
                                                  }
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]);
                          } else {
                            return const Center(child: LoadingIndicator());
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            )),
          ),
        );
      },
    );
  }

  Widget _buildResultPanel(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: AppColor.deepBlue,
              title: Text(
                AppLocalizations.of(context)!.translate('fees_taxes'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  setState(() {
                    calculateFeeScreen = false;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child:
                        BlocBuilder<CalculateResultBloc, CalculateResultState>(
                      builder: (context, state) {
                        if (state is CalculateResultSuccessed) {
                          return ItemTaxesWidget(
                            customsFee: state.result.customsFee!,
                            spendingFee: state.result.spendingFee!,
                            conservativeLocality:
                                state.result.conservativeLocality!,
                            citiesProtectionFee:
                                state.result.citiesProtectionFee!,
                            feeSupportingLocalProduction:
                                state.result.feeSupportingLocalProduction!,
                            imranLocality: state.result.imranLocality!,
                            incomeTaxFee: state.result.incomeTaxFee!,
                            naturalDisasterFee:
                                state.result.naturalDisasterFee!,
                            finalFee: state.result.finalTotal!,
                            addedTaxes: state.result.addedTaxes!,
                            customsCertificate:
                                state.result.customsCertificate!,
                            billTax: state.result.billTax!,
                            stampFee: state.result.stampFee!,
                            provincialLocalTax:
                                state.result.provincialLocalTax!,
                            advanceIncomeTax: state.result.advanceIncomeTax!,
                            reconstructionFee: state.result.reconstructionFee!,
                            finalTaxes: state.result.finalTaxes!,
                            finalTotal: state.result.finalTotal!,
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
                  Text(AppLocalizations.of(context)!
                      .translate('calculater_hint')),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        onTap: () {
                          setState(() {
                            calculateFeeScreen = false;
                          });
                        },
                        title: const SizedBox(
                            width: 100, child: Center(child: Text("رجوع"))),
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
      },
    );
  }

  int? selected;
  int? chapterselected;
  int? subchapterselected;
  int? feeselected = -1;
  int? flagselected = -1;
  String? feeselectedId;
  Origin? originselected;
  bool shownote = false;
  NoteType noteType = NoteType.None;
  final ScrollController scroll = ScrollController();
  bool isSearch = false;
  String querySearch = "";
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _flagsearchController = TextEditingController();

  Widget _buildFlagsPanel(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: AppColor.deepBlue,
              title: Text(
                AppLocalizations.of(context)!.translate('select_origin'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  setState(() {
                    flagselected = -1;
                    originselected = null;
                    querySearch = "";
                  });
                  BlocProvider.of<CalculatorPanelBloc>(context)
                      .add(CalculatorPanelHideEvent());
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              elevation: 0,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Focus(
                          focusNode: _statenode,
                          onFocusChange: (bool focus) {
                            if (!focus) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              BlocProvider.of<BottomNavBarCubit>(context)
                                  .emitShow();
                            }
                          },
                          child: BlocListener<FlagsBloc, FlagsState>(
                            listener: (context, flagstate) {
                              if (flagstate is FlagsLoadedSuccess) {
                                // print(jsonEncode(flagstate.sections));
                              }
                              if (flagstate is FlagsLoadedFailed) {
                                print(flagstate.error);
                              }
                            },
                            child: TextFormField(
                              controller: _flagsearchController,
                              onTap: () {
                                BlocProvider.of<BottomNavBarCubit>(context)
                                    .emitHide();
                                _flagsearchController.selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: _flagsearchController
                                        .value.text.length);
                              },
                              scrollPadding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          50),
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .translate('search'),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    BlocProvider.of<BottomNavBarCubit>(context)
                                        .emitShow();

                                    if (_searchController.text.isNotEmpty) {
                                      // BlocProvider.of<SearchSectionBloc>(context)
                                      //     .add(SearchSectionLoadEvent(
                                      //         _searchController.text));
                                      setState(() {
                                        isSearch = true;
                                      });
                                    }
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    isSearch = false;
                                  });
                                }
                                setState(() {
                                  querySearch = value;
                                });
                              },
                              onFieldSubmitted: (value) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                BlocProvider.of<BottomNavBarCubit>(context)
                                    .emitShow();
                                _flagsearchController.text = value;
                                if (value.isNotEmpty) {
                                  // BlocProvider.of<SearchSectionBloc>(context)
                                  //     .add(SearchSectionLoadEvent(value));
                                  setState(() {
                                    isSearch = true;
                                    querySearch = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.h),
                        child: BlocConsumer<FlagsBloc, FlagsState>(
                          listener: (context, state) {
                            // if(state is)
                          },
                          builder: (context, state) {
                            if (state is FlagsLoadedSuccess) {
                              return ListView.builder(
                                key: Key('builder ${selected.toString()}'),
                                shrinkWrap: true,
                                controller: scroll,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.origins.length,
                                itemBuilder: (context, index) {
                                  return querySearch.isEmpty ||
                                          state.origins[index].label!
                                              .toLowerCase()
                                              .contains(
                                                  querySearch.toLowerCase()) ||
                                          state.origins[index].labelar!
                                              .toLowerCase()
                                              .contains(
                                                  querySearch.toLowerCase())
                                      ? InkWell(
                                          onTap: () {
                                            // setState(() {
                                            //   // flagselected = index;
                                            //   // querySearch = "";
                                            // });
                                            setState(() {
                                              originselected =
                                                  state.origins[index];
                                              // flagselected = -1;
                                              _flagsearchController.text = "";
                                              querySearch = "";
                                              isSearch = false;
                                            });
                                            BlocProvider.of<FlagSelectBloc>(
                                                    context)
                                                .add(FlagSelectLoadEvent(
                                                    origin: originselected!));
                                            BlocProvider.of<
                                                        CalculatorPanelBloc>(
                                                    context)
                                                .add(
                                                    CalculatorPanelHideEvent());
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 35,
                                                      width: 55,
                                                      child: SvgPicture.network(
                                                        state.origins[index]
                                                            .imageURL!,
                                                        height: 35,
                                                        width: 55,
                                                        // semanticsLabel: 'A shark?!',
                                                        placeholderBuilder:
                                                            (BuildContext
                                                                    context) =>
                                                                Container(
                                                          height: 35.h,
                                                          width: 45.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 7),
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: 280.w,
                                                      ),
                                                      child: Text(
                                                        localeState.value
                                                                    .languageCode ==
                                                                'en'
                                                            ? state
                                                                .origins[index]
                                                                .label!
                                                            : state
                                                                .origins[index]
                                                                .labelar!,
                                                        // overflow:
                                                        //     TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    flagselected == index
                                                        ? const Icon(
                                                            Icons
                                                                .check_box_outlined,
                                                            color: Colors.green,
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                    // : Icon(
                                                    //     Icons
                                                    //         .check_box_outline_blank,
                                                    //     color:
                                                    //         AppColor.deepBlue,
                                                    //   ),
                                                  ],
                                                  // subtitle: Text('\$${suggestion['price']}'),
                                                ),
                                                Divider(
                                                  color: AppColor.deepYellow,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                },
                              );
                            } else if (state is FlagsLoadingProgressState) {
                              return Shimmer.fromColors(
                                baseColor: (Colors.grey[300])!,
                                highlightColor: (Colors.grey[100])!,
                                enabled: true,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (_, __) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 3),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SizedBox(
                                      height: 90.h,
                                    ),
                                  ),
                                  itemCount: 10,
                                ),
                              );
                            } else {
                              return Center(
                                child: GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<FlagsBloc>(context)
                                        .add(FlagsLoadEvent());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('list_error'),
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                      const Icon(
                                        Icons.refresh,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: flagselected != -1,
                  child: Positioned(
                    bottom: 0.h,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: AppColor.deepBlue,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // CustomButton(
                          //   onTap: () {
                          //     setState(() {
                          //       feeselected = -1;
                          //       feeselectedId = "";
                          //     });
                          //   },
                          //   color: Colors.white,
                          //   bordercolor: Colors.red,
                          //   title: const SizedBox(
                          //       width: 100, child: Center(child: Text("إلغاء"))),
                          // ),
                          CustomButton(
                            onTap: () {
                              setState(() {
                                flagselected = -1;
                                _flagsearchController.text = "";
                                querySearch = "";
                                isSearch = false;
                              });
                              BlocProvider.of<FlagSelectBloc>(context).add(
                                  FlagSelectLoadEvent(origin: originselected!));
                              BlocProvider.of<CalculatorPanelBloc>(context)
                                  .add(CalculatorPanelHideEvent());
                            },
                            color: Colors.white,
                            bordercolor: Colors.green,
                            title: SizedBox(
                                width: 100.w,
                                child: const Center(child: Text("select"))),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTariffPanel(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: AppColor.deepBlue,
              title: Text(
                AppLocalizations.of(context)!.translate('select_costume_fee'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = -1;
                    chapterselected = -1;
                    subchapterselected = -1;
                    feeselected = -1;
                  });
                  BlocProvider.of<CalculatorPanelBloc>(context)
                      .add(CalculatorPanelHideEvent());
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              elevation: 0,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Focus(
                          focusNode: _statenode,
                          onFocusChange: (bool focus) {
                            if (!focus) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              BlocProvider.of<BottomNavBarCubit>(context)
                                  .emitShow();
                            }
                          },
                          child: BlocListener<SearchSectionBloc,
                              SearchSectionState>(
                            listener: (context, state) {
                              if (state is SearchSectionLoadedSuccess) {
                                // print(jsonEncode(state.sections));
                              }
                              if (state is SearchSectionLoadedFailed) {
                                print(state.error);
                              }
                            },
                            child: TextFormField(
                              controller: _searchController,
                              onTap: () {
                                BlocProvider.of<BottomNavBarCubit>(context)
                                    .emitHide();
                                _searchController.selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset:
                                        _searchController.value.text.length);
                              },
                              scrollPadding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          50),
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .translate('search'),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    BlocProvider.of<BottomNavBarCubit>(context)
                                        .emitShow();

                                    if (_searchController.text.isNotEmpty) {
                                      BlocProvider.of<SearchSectionBloc>(
                                              context)
                                          .add(SearchSectionLoadEvent(
                                              _searchController.text));
                                      setState(() {
                                        isSearch = true;
                                      });
                                    }
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    isSearch = false;
                                  });
                                }
                              },
                              onFieldSubmitted: (value) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                BlocProvider.of<BottomNavBarCubit>(context)
                                    .emitShow();
                                _searchController.text = value;
                                if (value.isNotEmpty) {
                                  BlocProvider.of<SearchSectionBloc>(context)
                                      .add(SearchSectionLoadEvent(value));
                                  setState(() {
                                    isSearch = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      isSearch
                          ? BlocBuilder<SearchSectionBloc, SearchSectionState>(
                              builder: (context, state) {
                                if (state is SearchSectionLoadedSuccess) {
                                  return ListView.builder(
                                    key: Key('builder ${selected.toString()}'),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.sections.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 4.h, horizontal: 3.w),
                                        clipBehavior: Clip.none,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          side: BorderSide(
                                              color: AppColor.goldenYellow,
                                              width: 2),
                                        ),
                                        color: Colors.white,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   border: selected == index
                                        //       ? Border.all(
                                        //           color: Colors.yellow[600]!, width: 2)
                                        //       : null,
                                        // ),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            key: Key(
                                                index.toString()), //attention
                                            initiallyExpanded: true,
                                            tilePadding: EdgeInsets.symmetric(
                                                horizontal: 5.w),

                                            title: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 65.w,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 36.w,
                                                        height: 36.h,
                                                        child: Img(
                                                          "https://across-mena.com${state.sections[index]!.image!}",
                                                          placeholder:
                                                              Container(
                                                            color: Colors
                                                                .grey[200],
                                                            width: 36.w,
                                                            height: 36.h,
                                                          ),
                                                          errorWidget:
                                                              Container(
                                                            color: Colors
                                                                .grey[200],
                                                            width: 36.w,
                                                            height: 36.h,
                                                            child: const Center(
                                                                child: Text(
                                                                    "error")),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "(${state.sections[index]!.end!}__${state.sections[index]!.start!})",
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.w,
                                                ),
                                                Flexible(
                                                  child: HighlightText(
                                                    highlightStyle: TextStyle(
                                                      height: 1.3,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColor.goldenYellow,
                                                    ),
                                                    style: const TextStyle(
                                                      height: 1.3,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    text: state.sections[index]!
                                                        .label!,
                                                    highlight:
                                                        _searchController.text,
                                                    ignoreCase: false,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            children: buildSearchChapterTiles(
                                                state.sections[index]!
                                                    .chapterSet!),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (state is SearchSectionLoading) {
                                  return Shimmer.fromColors(
                                    baseColor: (Colors.grey[300])!,
                                    highlightColor: (Colors.grey[100])!,
                                    enabled: true,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (_, __) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 3),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                          height: 90.h,
                                        ),
                                      ),
                                      itemCount: 10,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        // BlocProvider.of<SectionBloc>(context)
                                        //     .add(SectionLoadEvent());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .translate('list_error'),
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                          const Icon(
                                            Icons.refresh,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            )
                          : Padding(
                              padding: EdgeInsets.all(8.h),
                              child: BlocConsumer<SectionBloc, SectionState>(
                                listener: (context, state) {
                                  // if(state is)
                                },
                                builder: (context, state) {
                                  if (state is SectionLoadedSuccess) {
                                    return ListView.builder(
                                      key:
                                          Key('builder ${selected.toString()}'),
                                      shrinkWrap: true,
                                      controller: scroll,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.sections.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 4.h, horizontal: 3.w),
                                          clipBehavior: Clip.none,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            side: BorderSide(
                                                color: AppColor.goldenYellow,
                                                width: 2),
                                          ),
                                          color: Colors.white,
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent),
                                            child: ExpansionTile(
                                              key: Key(
                                                  index.toString()), //attention
                                              initiallyExpanded:
                                                  index == selected,
                                              tilePadding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              title: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // Padding(
                                                  //   padding: const EdgeInsets.symmetric(
                                                  //       horizontal: 3),
                                                  //   child: SizedBox(
                                                  //     width: 36.w,
                                                  //     height: 36.h,
                                                  //     child: Img(
                                                  //       state.sections[index].image!,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  SizedBox(
                                                    width: 65.w,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 36.w,
                                                          height: 36.h,
                                                          child: Img(
                                                            state
                                                                .sections[
                                                                    index]!
                                                                .image!,
                                                            placeholder:
                                                                Container(
                                                              color: Colors
                                                                  .grey[200],
                                                              width: 36.w,
                                                              height: 36.h,
                                                            ),
                                                            errorWidget:
                                                                Container(
                                                              color: Colors
                                                                  .grey[200],
                                                              width: 36.w,
                                                              height: 36.h,
                                                              child: const Center(
                                                                  child: Text(
                                                                      "error")),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "(${state.sections[index]!.end!}__${state.sections[index]!.start!})",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.w,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      state.sections[index]!
                                                          .label!,
                                                      maxLines: 10,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              onExpansionChanged: (value) {
                                                if (value) {
                                                  BlocProvider.of<ChapterBloc>(
                                                          context)
                                                      .add(ChapterLoadEvent(
                                                          state.sections[index]!
                                                              .id!));
                                                  setState(() {
                                                    selected = index;
                                                    chapterselected = -1;
                                                    subchapterselected = -1;
                                                  });

                                                  scroll.animateTo(
                                                      index +
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      duration: const Duration(
                                                          seconds: 1),
                                                      curve: Curves.easeIn);
                                                } else {
                                                  setState(() {
                                                    selected = -1;
                                                    shownote = false;
                                                    noteType = NoteType.None;
                                                  });
                                                }
                                              },
                                              children: buildChapterTiles(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else if (state is SectionLoadingProgress) {
                                    return Shimmer.fromColors(
                                      baseColor: (Colors.grey[300])!,
                                      highlightColor: (Colors.grey[100])!,
                                      enabled: true,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (_, __) => Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 3),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: SizedBox(
                                            height: 90.h,
                                          ),
                                        ),
                                        itemCount: 10,
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<SectionBloc>(context)
                                              .add(SectionLoadEvent());
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .translate('list_error'),
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            ),
                                            const Icon(
                                              Icons.refresh,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                      SizedBox(
                        height: 70.h,
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: feeselected != -1,
                  child: Positioned(
                    bottom: 0.h,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: AppColor.deepBlue,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // CustomButton(
                          //   onTap: () {
                          //     setState(() {
                          //       feeselected = -1;
                          //       feeselectedId = "";
                          //     });
                          //   },
                          //   color: Colors.white,
                          //   bordercolor: Colors.red,
                          //   title: const SizedBox(
                          //       width: 100, child: Center(child: Text("إلغاء"))),
                          // ),
                          CustomButton(
                            onTap: () {
                              setState(() {
                                selected = -1;
                                chapterselected = -1;
                                subchapterselected = -1;
                                feeselected = -1;
                                _searchController.text = "";
                                isSearch = false;
                              });
                              BlocProvider.of<FeeSelectBloc>(context)
                                  .add(FeeSelectLoadEvent(id: feeselectedId!));
                              BlocProvider.of<CalculatorPanelBloc>(context)
                                  .add(CalculatorPanelHideEvent());
                            },
                            color: Colors.white,
                            bordercolor: Colors.green,
                            title: SizedBox(
                                width: 100.w,
                                child: const Center(child: Text("Select"))),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  buildSearchChapterTiles(List<ChapterSet?> chapters) {
    // _CustomeTariffScreenState? stateobject =
    //     context.findAncestorStateOfType<_CustomeTariffScreenState>();
    List<Widget> list = [];
    list.add(Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.only(top: 3.0),
      child: ListView.builder(
        key: Key('chapterbuilder ${chapterselected.toString()}'),
        shrinkWrap: true,
        itemCount: chapters.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index2) {
          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(2),
                clipBehavior: Clip.antiAlias,
                elevation: 1,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: Colors.grey[200]!,
                      // color: chapterselected == index2
                      //     ? subchapterselected == -1
                      //         ? AppColor.goldenYellow
                      //         : Colors.grey[200]!
                      //     : Colors.grey[200]!,
                      width: 2),
                ),
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.all(0),
                  dense: true,
                  horizontalTitleGap: 0.0,
                  minLeadingWidth: 0,
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 17.w,
                        ),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chapters[index2]!.id!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Flexible(
                                child: HighlightText(
                                  highlightStyle: TextStyle(
                                    height: 1.3,
                                    fontSize: 17,
                                    color: AppColor.goldenYellow,
                                  ),
                                  style: const TextStyle(
                                    height: 1.3,
                                    fontSize: 17,
                                  ),
                                  text: chapters[index2]!.label!,
                                  highlight: _searchController.text,
                                  ignoreCase: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    key: Key(index2.toString()), //attention
                    initiallyExpanded: true,
                    children: buildSearchSubChapterTiles(
                        chapters[index2]!.subChapterSet!),
                  ),
                ),
              ),
              chapters.length - 1 == index2
                  ? const SizedBox.shrink()
                  : Divider(
                      height: 1,
                      color: AppColor.goldenYellow,
                    ),
            ],
          );
        },
      ),
    ));

    return list;
  }

  buildSearchSubChapterTiles(List<SubChapterSet?> subchapters) {
    List<Widget> list = [];
    list.add(Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 0.0),
      child: ListView.builder(
        key: Key('subchapterbuilder ${subchapterselected.toString()}'),
        shrinkWrap: true,
        itemCount: subchapters.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index3) {
          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(2),
                clipBehavior: Clip.antiAlias,
                elevation: subchapterselected == index3 ? 1 : 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: subchapterselected == index3
                          ? feeselected == -1
                              ? AppColor.goldenYellow
                              : Colors.white
                          : Colors.white,
                      width: 2),
                ),
                child: ExpansionTile(
                  key: Key(index3.toString()), //attention
                  initiallyExpanded: true,
                  tilePadding: EdgeInsets.zero,

                  // controlAffinity: ListTileControlAffinity.leading,
                  childrenPadding: EdgeInsets.zero,
                  // leading: Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 7),
                  //   child: subchapterselected == index3
                  //       ? const Icon(Icons.remove)
                  //       : const Icon(Icons.add),
                  // ),
                  // leading: const SizedBox.shrink(),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subchapters[index3]!.id!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Flexible(
                              child: HighlightText(
                                highlightStyle: TextStyle(
                                  height: 1.3,
                                  fontSize: 17,
                                  color: AppColor.goldenYellow,
                                ),
                                style: const TextStyle(
                                  height: 1.3,
                                  fontSize: 17,
                                ),
                                text: subchapters[index3]!.label!,
                                highlight: _searchController.text,
                                ignoreCase: false,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                          ],
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: const TariffInfoIcon(),
                      // ),
                    ],
                  ),

                  children: subchapters[index3]!.feeSet == null
                      ? []
                      : buildSearchFeesTiles(subchapters[index3]!.feeSet!),
                ),
              ),
              subchapters.length - 1 == index3
                  ? const SizedBox.shrink()
                  : Divider(
                      height: 1,
                      color: AppColor.goldenYellow,
                    ),
            ],
          );
        },
      ),
    ));

    return list;
  }

  buildSearchFeesTiles(List<FeeSet?> feeslist) {
    List<Widget> list = [];
    List<FeeSet?> fees = [];
    for (var element in feeslist) {
      if (fees.singleWhere((it) => it!.id == element!.id, orElse: () => null) ==
          null) {
        fees.add(element);
      }
    }
    list.add(Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(3.0),
      child: ListView.builder(
        key: Key('feebuilder ${feeselected.toString()}'),
        shrinkWrap: true,
        itemCount: fees.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index4) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    if (feeselected == index4) {
                      setState(() {
                        feeselected = -1;
                        feeselectedId = "";
                      });
                    } else {
                      setState(() {
                        feeselected = index4;
                        feeselectedId = fees[index4]!.id!;
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              fees[index4]!.id!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                                child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: feeselected == index4
                                    ? null
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: HighlightText(
                                highlightStyle: TextStyle(
                                  height: 1.3,
                                  fontSize: 17,
                                  color: AppColor.goldenYellow,
                                ),
                                style: const TextStyle(
                                  height: 1.3,
                                  fontSize: 17,
                                ),
                                text: fees[index4]!.label!,
                                highlight: _searchController.text,
                                ignoreCase: false,
                              ),
                            )),
                          ],
                        ),
                      ),
                      feeselected == index4
                          ? const Icon(
                              Icons.check_box_outlined,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.check_box_outline_blank,
                              color: AppColor.deepBlue,
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                index4 == (fees.length - 1)
                    ? const SizedBox.shrink()
                    : Divider(
                        height: 1,
                        color: AppColor.goldenYellow,
                      ),
              ],
            ),
          );
        },
      ),
    ));

    return list;
  }

  buildFeesTiles(int index3) {
    List<Widget> list = [];
    list.add(BlocBuilder<FeeBloc, FeeState>(
      builder: (context, state) {
        if (state is FeeLoadedSuccess) {
          return Container(
            color: Colors.grey[200],
            child: ListView.builder(
              key: Key('feebuilder ${feeselected.toString()}'),
              shrinkWrap: true,
              itemCount: state.fees.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index4) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (feeselected == index4) {
                            setState(() {
                              feeselected = -1;
                              feeselectedId = "";
                            });
                          } else {
                            setState(() {
                              feeselected = index4;
                              feeselectedId = state.fees[index4].id!;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    state.fees[index4].id!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Flexible(
                                      child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: feeselected == index4
                                          ? null
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      state.fees[index4].label!,
                                      style: const TextStyle(
                                        height: 1.3,
                                        fontSize: 17,
                                      ),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            feeselected == index4
                                ? Icon(
                                    Icons.check_box_outlined,
                                    color: AppColor.deepYellow,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    color: AppColor.deepBlue,
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      index4 != (state.fees.length - 1)
                          ? Divider(
                              height: 1,
                              color: AppColor.goldenYellow,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: (Colors.grey[300])!,
            highlightColor: (Colors.grey[100])!,
            enabled: true,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .65,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, __) => Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 40.h,
                  ),
                ),
                itemCount: 4,
              ),
            ),
          );
        }
      },
    ));
    return list;
  }

  buildSubChapterTiles(int index2) {
    List<Widget> list = [];
    list.add(BlocBuilder<SubChapterBloc, SubChapterState>(
      builder: (context, state) {
        if (state is SubChapterLoadedSuccess) {
          return Container(
            color: Colors.white,
            child: ListView.builder(
              key: Key('subchapterbuilder ${subchapterselected.toString()}'),
              shrinkWrap: true,
              itemCount: state.subchapters.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index3) {
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(2),
                      clipBehavior: Clip.antiAlias,
                      // decoration: BoxDecoration(
                      //   color: subchapterselected == index3
                      //       ? Colors.white
                      //       : null,
                      //   border: subchapterselected == index3
                      //       ? feeselected == -1
                      //           ? Border.all(
                      //               color: AppColor.goldenYellow, width: 2)
                      //           : null
                      //       : null,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      elevation: subchapterselected == index3 ? 1 : 0,
                      color: subchapterselected == index3
                          ? Colors.white
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: subchapterselected == index3
                                ? feeselected == -1
                                    ? AppColor.goldenYellow
                                    : Colors.white
                                : Colors.white,
                            width: 2),
                      ),
                      child: ExpansionTile(
                        key: Key(index3.toString()), //attention
                        initiallyExpanded: index3 == subchapterselected,
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 11.w,
                            ),
                            Text(
                              state.subchapters[index3].id!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                                child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              width: double.infinity,
                              child: Text(
                                state.subchapters[index3].label!,
                                maxLines: 10,
                                style: const TextStyle(
                                  height: 1.3,
                                  fontSize: 17,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                          ],
                        ),

                        onExpansionChanged: (value) {
                          if (value) {
                            BlocProvider.of<FeeBloc>(context).add(
                                FeeLoadEvent(state.subchapters[index3].id!));
                            setState(() {
                              subchapterselected = index3;
                            });
                          } else {
                            setState(() {
                              subchapterselected = -1;
                              shownote = false;
                              noteType = NoteType.None;
                            });
                          }
                        },
                        children: buildFeesTiles(index3),
                      ),
                    ),
                    index3 != state.subchapters.length - 1
                        ? Divider(
                            height: 1,
                            color: AppColor.goldenYellow,
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: (Colors.grey[300])!,
            highlightColor: (Colors.grey[100])!,
            enabled: true,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, __) => Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 40.h,
                  ),
                ),
                itemCount: 4,
              ),
            ),
          );
        }
      },
    ));

    return list;
  }

  buildChapterTiles() {
    // _CustomeTariffScreenState? stateobject =
    //     context.findAncestorStateOfType<_CustomeTariffScreenState>();
    List<Widget> list = [];
    list.add(BlocBuilder<ChapterBloc, ChapterState>(
      builder: (context, state) {
        if (state is ChapterLoadedSuccess) {
          return Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.only(top: 3.0),
            child: ListView.builder(
              key: Key('chapterbuilder ${chapterselected.toString()}'),
              shrinkWrap: true,
              itemCount: state.chapters.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index2) {
                return Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(2),
                      clipBehavior: Clip.antiAlias,
                      elevation: chapterselected == index2 ? 1 : 0,
                      color: chapterselected == index2
                          ? Colors.grey[200]
                          : Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: chapterselected == index2
                                ? subchapterselected == -1
                                    ? AppColor.goldenYellow
                                    : Colors.grey[200]!
                                : Colors.grey[200]!,
                            width: 2),
                      ),
                      child: ListTileTheme(
                        contentPadding: EdgeInsets.symmetric(horizontal: 9.w),
                        dense: true,
                        horizontalTitleGap: 0.0,
                        minLeadingWidth: 0,
                        child: ExpansionTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 6.w,
                              ),
                              Text(
                                state.chapters[index2].id!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flexible(
                                  child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  state.chapters[index2].label!,
                                  style: const TextStyle(
                                    height: 1.3,
                                    fontSize: 17,
                                  ),
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                            ],
                          ),
                          key: Key(index2.toString()), //attention
                          initiallyExpanded: index2 == chapterselected,

                          onExpansionChanged: (value) {
                            if (value) {
                              BlocProvider.of<SubChapterBloc>(context).add(
                                  SubChapterLoadEvent(
                                      state.chapters[index2].id!));
                              setState(() {
                                chapterselected = index2;

                                subchapterselected = -1;
                              });
                            } else {
                              setState(() {
                                chapterselected = -1;
                                shownote = false;
                                noteType = NoteType.None;
                              });
                            }
                          },
                          children: buildSubChapterTiles(index2),
                        ),
                      ),
                    ),
                    index2 != (state.chapters.length - 1)
                        ? Divider(
                            height: 1,
                            color: AppColor.goldenYellow,
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: (Colors.grey[300])!,
            highlightColor: (Colors.grey[100])!,
            enabled: true,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, __) => Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 40.h,
                  ),
                ),
                itemCount: 4,
              ),
            ),
          );
        }
      },
    ));

    return list;
  }
}
