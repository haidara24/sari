import 'package:custome_mobile/business_logic/bloc/notification_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/data/providers/notification_provider.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  GlobalKey<ScaffoldState>? scaffoldKey;
  Function()? onTap;
  CustomAppBar({super.key, required this.title, this.scaffoldKey, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AppBar(
            backgroundColor: AppColor.deepAppBarBlue,
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold),
            ),
            leading: scaffoldKey == null
                ? IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: SizedBox(
                      // margin:
                      //     EdgeInsets.symmetric(vertical: 13.h, horizontal: 3.w),
                      height: 35.h,
                      width: 35.w,

                      child: Center(
                        child: Image.asset(
                          "assets/icons/ios_back_arrow.png",
                          height: 30.h,
                          width: 30.h,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                      scaffoldKey!.currentState!.openDrawer();
                    },
                    icon: SizedBox(
                      // margin:
                      //     EdgeInsets.symmetric(vertical: 13.h, horizontal: 3.w),
                      height: 35.h,
                      width: 35.w,

                      child: Center(
                        child: Image.asset(
                          "assets/icons/drawer_icon.png",
                          height: 30.h,
                          width: 30.h,
                        ),
                      ),
                    ),
                  ),
            centerTitle: true,
            actions: [
              scaffoldKey == null
                  ? const SizedBox.shrink()
                  : Consumer<NotificationProvider>(
                      builder: (context, notificationProvider, child) {
                        return BlocListener<NotificationBloc,
                            NotificationState>(
                          listener: (context, state) {
                            if (state is NotificationLoadedSuccess) {
                              notificationProvider
                                  .initNotifications(state.notifications);
                            }
                          },
                          child: IconButton(
                            onPressed: () {
                              notificationProvider.clearNotReadedNotification();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationScreen(),
                                  ));
                            },
                            icon: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                  width: 30.h,
                                  child: Center(
                                    child: Image.asset(
                                      "assets/icons/notification.png",
                                      height: 30.h,
                                      width: 30.h,
                                    ),
                                  ),
                                ),
                                notificationProvider.notreadednotifications != 0
                                    ? Positioned(
                                        right: -7.w,
                                        top: -10.h,
                                        child: Container(
                                          height: 20.h,
                                          width: 20.h,
                                          decoration: BoxDecoration(
                                            color: AppColor.goldenYellow,
                                            borderRadius:
                                                BorderRadius.circular(45),
                                          ),
                                          child: Center(
                                            child: Text(
                                              notificationProvider
                                                  .notreadednotifications
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
