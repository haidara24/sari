import 'package:custome_mobile/business_logic/bloc/attachment/attachment_type_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/auth_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/flags_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/notification_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/section_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/internet_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/views/screens/broker/broker_home_screen.dart';
import 'package:custome_mobile/views/screens/select_user_type.dart';
import 'package:custome_mobile/views/screens/trader/trader_home_screen.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlView extends StatefulWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    initializeFromPreferences();
  }

  void initializeFromPreferences() {
    final String storedLocale = prefs.getString('language') ?? 'en';

    if (storedLocale == 'en') {
      BlocProvider.of<LocaleCubit>(context).toEnglish();
    } else if (storedLocale == 'ar') {
      BlocProvider.of<LocaleCubit>(context).toArabic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetLoading) {
            return const Center(
              child: LoadingIndicator(),
            );
          } else if (state is InternetDisConnected) {
            return const Center(
              child: Text("no internet connection"),
            );
          } else if (state is InternetConnected) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthTraderSuccessState) {
                  BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                  BlocProvider.of<NotificationBloc>(context)
                      .add(NotificationLoadEvent());
                  BlocProvider.of<AttachmentTypeBloc>(context)
                      .add(AttachmentTypeLoadEvent());
                  BlocProvider.of<SectionBloc>(context).add(SectionLoadEvent());
                  BlocProvider.of<FlagsBloc>(context).add(FlagsLoadEvent());

                  return const TraderHomeScreen();
                }
                if (state is AuthBrokerSuccessState) {
                  BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                  BlocProvider.of<NotificationBloc>(context)
                      .add(NotificationLoadEvent());
                  BlocProvider.of<AttachmentTypeBloc>(context)
                      .add(AttachmentTypeLoadEvent());
                  BlocProvider.of<SectionBloc>(context).add(SectionLoadEvent());
                  BlocProvider.of<FlagsBloc>(context).add(FlagsLoadEvent());

                  return const BrokerHomeScreen();
                } else if (state is AuthInitial) {
                  BlocProvider.of<AuthBloc>(context).add(AuthCheckRequested());
                  return const Center(
                    child: LoadingIndicator(),
                  );
                } else {
                  return SelectUserType();
                }
              },
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
