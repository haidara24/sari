import 'package:custome_mobile/business_logic/bloc/offer_details_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/data/providers/notification_provider.dart';
import 'package:custome_mobile/data/services/fcm_service.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/screens/broker/order_details_screen.dart';
import 'package:custome_mobile/views/screens/trader/log_screens/offer_details_screen.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:custome_mobile/Localization/app_localizations.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String usertype = "Trader";

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

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usertype = prefs.getString("userType") ?? "";
  }

  @override
  void initState() {
    super.initState();
    getUserType();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return SafeArea(
          child: Directionality(
            textDirection: localeState.value.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: CustomAppBar(
                title: AppLocalizations.of(context)!.translate('notifications'),
              ),
              body: SingleChildScrollView(
                child: Consumer<NotificationProvider>(
                  builder: (context, notificationProvider, child) {
                    return notificationProvider.notifications.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context)!
                                .translate('no_notifications_text')),
                          )
                        : ListView.builder(
                            itemCount:
                                notificationProvider.notifications.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              // DateTime now = DateTime.now();
                              // Duration diff = now
                              //     .difference(state.offers[index].createdDate!);
                              DateTime now = DateTime.now();
                              Duration diff = now.difference(DateTime.parse(
                                  notificationProvider
                                      .notifications[index].dateCreated!));
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: AppColor.deepBlue, width: 2),
                                  ),
                                  color: notificationProvider
                                          .notifications[index].isread!
                                      ? Colors.white
                                      : Colors.blue[50],
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  onTap: () {
                                    BlocProvider.of<OfferDetailsBloc>(context)
                                        .add(OfferDetailsLoadEvent(
                                            notificationProvider
                                                .notifications[index].offer!));

                                    if (usertype == "Trader") {
                                      if (notificationProvider
                                                  .notifications[index]
                                                  .noteficationType! ==
                                              "A" ||
                                          notificationProvider
                                                  .notifications[index]
                                                  .noteficationType! ==
                                              "T") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OfferDetailsScreen(
                                                type: "trader",
                                                operationtype: 0,
                                              ),
                                            ));
                                      }
                                    } else if (usertype == "Broker") {
                                      if (notificationProvider
                                              .notifications[index]
                                              .noteficationType! ==
                                          "O") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderDetailsScreen(),
                                            ));
                                      }
                                    }
                                    if (!notificationProvider
                                        .notifications[index].isread!) {
                                      NotificationServices
                                          .markNotificationasRead(
                                              notificationProvider
                                                  .notifications[index].id!);
                                      notificationProvider
                                          .markNotificationAsRead(
                                              notificationProvider
                                                  .notifications[index].id!);
                                    }
                                  },
                                  leading: Container(
                                    height: 75.h,
                                    width: 75.w,
                                    decoration: BoxDecoration(
                                        // color: AppColor.lightGoldenYellow,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: CircleAvatar(
                                      radius: 25.h,
                                      backgroundColor: AppColor.deepBlue,
                                      child: Center(
                                        child: (notificationProvider
                                                    .notifications[index]
                                                    .image!
                                                    .length >
                                                1)
                                            ? Image.network(
                                                notificationProvider
                                                    .notifications[index]
                                                    .image!,
                                                height: 55.h,
                                                width: 55.w,
                                                fit: BoxFit.fill,
                                              )
                                            : Text(
                                                notificationProvider
                                                    .notifications[index]
                                                    .image!,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 28.sp,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  title: Text(notificationProvider
                                      .notifications[index].title!),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(notificationProvider
                                          .notifications[index].description!),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(localeState.value.languageCode ==
                                                  'en'
                                              ? diffEnText(diff)
                                              : diffText(diff)),
                                          SizedBox(
                                            width: 9.w,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  dense: false,
                                ),
                              );
                            });
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
