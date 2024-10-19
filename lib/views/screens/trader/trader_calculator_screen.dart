import 'package:custome_mobile/business_logic/bloc/fee/fee_select_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/bottom_nav_bar_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/stop_scroll_cubit.dart';
import 'package:custome_mobile/views/widgets/calculator_widget.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TraderCalculatorScreen extends StatelessWidget {
  final GlobalKey<FormState> _calformkey = GlobalKey<FormState>();

  final TextEditingController _typeAheadController = TextEditingController();

  final TextEditingController _wieghtController = TextEditingController();

  final TextEditingController _originController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  TraderCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
            textDirection: localeState.value.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[200],
              body: SafeArea(
                  child: Stack(
                children: [
                  BlocBuilder<StopScrollCubit, StopScrollState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        physics: (state is ScrollEnabled)
                            ? const ClampingScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        child: GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            BlocProvider.of<BottomNavBarCubit>(context)
                                .emitShow();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    )),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    elevation: 1,
                                    color: Colors.white,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8.0),
                                      child: CalculatorWidget(
                                          calformkey: _calformkey,
                                          typeAheadController:
                                              _typeAheadController,
                                          originController: _originController,
                                          wieghtController: _wieghtController,
                                          valueController: _valueController,
                                          tariffButton: true,
                                          unfocus: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            BlocProvider.of<BottomNavBarCubit>(
                                                    context)
                                                .emitShow();
                                          }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ]),
                          ),
                        ),
                      );
                    },
                  ),
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
                  ),
                ],
              )),
            ));
      },
    );
  }
}
