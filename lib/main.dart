import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custome_mobile/Localization/app_localizations_setup.dart';
import 'package:custome_mobile/business_logic/bloc/assign_broker_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/attachment/additional_attachment_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/attachment/attachment_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/attachment/attachment_type_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/attachment/attachments_list_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/auth_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/broker_list_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/broker_review_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_multi_result_dart_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculate_result_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/calculate_result/calculator_panel_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/chapter_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/cost_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_add_loading_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_item_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_select_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_trade_description_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/flag_select_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/flags_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/group_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/note_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/notification_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/offer_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/offer_details_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/package_type_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/post_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/saved_post_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/search_section_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/section_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/state_custome_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/sub_chapter_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/trader_additional_attachment_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/trader_log_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/update_track_offer_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/internet_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/stop_scroll_cubit.dart';
import 'package:custome_mobile/data/providers/add_attachment_provider.dart';
import 'package:custome_mobile/data/providers/broker_offer_provider.dart';
import 'package:custome_mobile/data/providers/calculator_provider.dart';
import 'package:custome_mobile/data/providers/directorate_provider.dart';
import 'package:custome_mobile/data/providers/fee_add_provider.dart';
import 'package:custome_mobile/data/providers/notification_provider.dart';
import 'package:custome_mobile/data/providers/order_broker_provider.dart';
import 'package:custome_mobile/data/providers/trader_offer_provider.dart';
import 'package:custome_mobile/data/repositories/accurdion_repository.dart';
import 'package:custome_mobile/data/repositories/auth_repository.dart';
import 'package:custome_mobile/data/repositories/notification_repository.dart';
import 'package:custome_mobile/data/repositories/post_repository.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:custome_mobile/firebase_options.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/control_view.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/screens/introduction_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // you need to initialize firebase first
  await Firebase.initializeApp(
    name: "Sari",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Sari",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool("showHome") ?? false;
  HttpOverrides.global = MyHttpOverrides();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  MyApp({super.key, required this.showHome});
  final Connectivity connectivity = Connectivity();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return ScreenUtilInit(
          designSize: orientation == Orientation.portrait
              ? const Size(428, 926)
              : const Size(926, 428),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) => AuthRepository(),
                ),
                RepositoryProvider(
                  create: (context) => PostRepository(),
                ),
                RepositoryProvider(
                  create: (context) => AccordionRepository(),
                ),
                RepositoryProvider(
                  create: (context) => StateAgencyRepository(),
                ),
                RepositoryProvider(
                  create: (context) => NotificationRepository(),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => AuthBloc(
                          authRepository:
                              RepositoryProvider.of<AuthRepository>(context))),
                  BlocProvider(
                      create: (context) => BrokerListBloc(
                          authRepository:
                              RepositoryProvider.of<AuthRepository>(context))),
                  BlocProvider(
                    create: (context) => PostBloc(
                        postRepository:
                            RepositoryProvider.of<PostRepository>(context)),
                  ),
                  BlocProvider(
                    create: (context) => SearchSectionBloc(
                        accordionRepository:
                            RepositoryProvider.of<AccordionRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => SectionBloc(
                        accordionRepository:
                            RepositoryProvider.of<AccordionRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => ChapterBloc(
                        accordionRepository:
                            RepositoryProvider.of<AccordionRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => SubChapterBloc(
                        accordionRepository:
                            RepositoryProvider.of<AccordionRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => FeeBloc(
                        accordionRepository:
                            RepositoryProvider.of<AccordionRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => FeeTradeDescriptionBloc(
                        accordionRepository:
                            RepositoryProvider.of<AccordionRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => PackageTypeBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => OfferBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => GroupBloc(
                        postRepository:
                            RepositoryProvider.of<PostRepository>(context)),
                  ),
                  BlocProvider(
                    create: (context) => SavedPostBloc(
                        postRepository:
                            RepositoryProvider.of<PostRepository>(context)),
                  ),
                  BlocProvider(
                    create: (context) => CostBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => TraderLogBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => StateCustomeBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => AttachmentTypeBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => NoteBloc(
                        accordionRepository:
                            RepositoryProvider.of<AccordionRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => AttachmentBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => AdditionalAttachmentBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => TraderAdditionalAttachmentBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => UpdateTrackOfferBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => AttachmentsListBloc(),
                  ),
                  BlocProvider(
                    create: (context) => AssignBrokerBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => CalculateResultBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => CalculateMultiResultBloc(
                        stateAgencyRepository:
                            RepositoryProvider.of<StateAgencyRepository>(
                                context)),
                  ),
                  BlocProvider(
                    create: (context) => BrokerReviewBloc(
                        authRepository:
                            RepositoryProvider.of<AuthRepository>(context)),
                  ),
                  BlocProvider(
                    create: (context) => FlagsBloc(),
                  ),
                  BlocProvider(
                      create: (context) =>
                          InternetCubit(connectivity: connectivity)),
                  BlocProvider(create: (context) => BottomNavBarCubit()),
                  BlocProvider(create: (context) => StopScrollCubit()),
                  BlocProvider(create: (context) => LocaleCubit()),
                  BlocProvider(create: (context) => CalculatorPanelBloc()),
                  BlocProvider(create: (context) => FeeItemBloc()),
                  BlocProvider(create: (context) => FeeSelectBloc()),
                  BlocProvider(create: (context) => FlagSelectBloc()),
                  BlocProvider(create: (context) => FeeAddLoadingBloc()),
                  BlocProvider(
                      create: (context) => NotificationBloc(
                          notificationRepository:
                              RepositoryProvider.of<NotificationRepository>(
                                  context))),
                  BlocProvider(
                      create: (context) => OfferDetailsBloc(
                          notificationRepository:
                              RepositoryProvider.of<NotificationRepository>(
                                  context))),
                ],
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => OrderBrokerProvider()),
                    ChangeNotifierProvider(create: (_) => CalculatorProvider()),
                    ChangeNotifierProvider(
                        create: (_) => NotificationProvider()),
                    ChangeNotifierProvider(
                        create: (_) => AddAttachmentProvider()),
                    ChangeNotifierProvider(
                        create: (_) => TraderOfferProvider()),
                    ChangeNotifierProvider(
                        create: (_) => BrokerOfferProvider()),
                    ChangeNotifierProvider(
                        create: (_) => DirectorateProvider()),
                    ChangeNotifierProvider(create: (_) => FeeAddProvider()),
                  ],
                  child: BlocBuilder<LocaleCubit, LocaleState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, localeState) {
                      return MaterialApp(
                        title: 'SARI',
                        debugShowCheckedModeBanner: false,
                        localizationsDelegates:
                            AppLocalizationsSetup.localizationsDelegates,
                        supportedLocales:
                            AppLocalizationsSetup.supportedLocales,
                        // localeResolutionCallback: AppLocalizationsSetup.,
                        locale: localeState.value,
                        scrollBehavior:
                            ScrollConfiguration.of(context).copyWith(
                          physics: const ClampingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                        ),
                        theme: ThemeData(
                          useMaterial3: true,
                          colorScheme: ColorScheme.fromSwatch().copyWith(
                            primary: AppColor.deepBlue,
                            // secondary: Colors.white,
                            primaryContainer: Colors.white,
                          ),
                          cardTheme: const CardTheme(
                            surfaceTintColor: Colors.white,
                            clipBehavior: Clip.antiAlias,
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            labelStyle: TextStyle(
                                fontSize: 18, color: Colors.grey[600]!),
                            suffixStyle: const TextStyle(
                              fontSize: 20,
                            ),
                            floatingLabelStyle: const TextStyle(
                              fontSize: 20,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 11.0, horizontal: 9.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.black26,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColor.deepBlue,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          textTheme: GoogleFonts.tajawalTextTheme(
                            Theme.of(context).textTheme,
                          ),
                          dividerColor: Colors.grey[400],
                          scaffoldBackgroundColor: Colors.white,
                        ),
                        home: EasySplashScreen(
                            logoWidth: 120,
                            logo: Image.asset('assets/images/sari_white.png'),
                            backgroundColor: Colors.white,
                            showLoader: false,
                            loaderColor: const Color.fromRGBO(255, 152, 0, 1),
                            durationInSeconds: 5,
                            navigator: showHome
                                ? const ControlView()
                                : const IntroductionView()),
                        builder: (context, child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 1.0),
                            child: child!,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
