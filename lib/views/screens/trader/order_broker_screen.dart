import 'package:custome_mobile/business_logic/bloc/agency_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/fee/fee_select_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/data/repositories/state_agency_repository.dart';
import 'package:custome_mobile/views/screens/trader/stepper_multi_order_broker_screen.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBrokerScreen extends StatefulWidget {
  const OrderBrokerScreen({Key? key}) : super(key: key);

  @override
  State<OrderBrokerScreen> createState() => _OrderBrokerScreenState();
}

class _OrderBrokerScreenState extends State<OrderBrokerScreen> {
  // final FocusNode _statenode = FocusNode();
  // final FocusNode _agencynode = FocusNode();
  @override
  void initState() {
    super.initState();
    // FocusScope.of(context).unfocus();
  }

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AgencyBloc(
              stateAgencyRepository:
                  RepositoryProvider.of<StateAgencyRepository>(context)),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return Directionality(
            textDirection: localeState.value.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.grey[100],
              body: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    BlocProvider.of<BottomNavBarCubit>(context).emitShow();
                  },
                  child: Stack(
                    children: [
                      const StepperMultiOrderBrokerScreen(),
                      BlocBuilder<FeeSelectBloc, FeeSelectState>(
                        builder: (context, state) {
                          if (state is FeeSelectLoadingProgress) {
                            return Container(
                              color: Colors.white54,
                              child: const Center(child: LoadingIndicator()),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      )
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  // List<Step> getSteps() => [
  //       Step(
  //           isActive: currentStep >= 0,
  //           title: Text(
  //             "معلومات الشحنة",
  //             style: TextStyle(fontSize: 12.sp),
  //           ),
  //           content: const StepperOrderBrokerScreen()),
  //       Step(
  //           isActive: currentStep >= 1,
  //           title: Text(
  //             "حساب الرسوم",
  //             style: TextStyle(fontSize: 12.sp),
  //           ),
  //           content: const TraderBillReview()),
  //       Step(
  //           isActive: currentStep >= 2,
  //           title: Text(
  //             "المرفقات",
  //             style: TextStyle(fontSize: 12.sp),
  //           ),
  //           content: TraderAttachementScreen()),
  //     ];
}
