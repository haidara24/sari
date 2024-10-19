import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/auth_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/internet_cubit.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/constants/text_constants.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/control_view.dart';
import 'package:custome_mobile/views/screens/trader/trader_confirm_screen.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TraderSigninScreen extends StatefulWidget {
  const TraderSigninScreen({Key? key}) : super(key: key);

  @override
  State<TraderSigninScreen> createState() => _TraderSigninScreenState();
}

class _TraderSigninScreenState extends State<TraderSigninScreen> {
  final focusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    _postData(context);
  }

  void _postData(context) {
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("aasdasd")));
    BlocProvider.of<AuthBloc>(context).add(SignInButtonPressed(
        _usernameController.text, _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColor.deepBlue),
            ),
            backgroundColor: Colors.white,
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
                  return GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 45.h,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: SvgPicture.asset(
                                "assets/images/963.svg",
                                width: 315,
                                height: 210,
                                placeholderBuilder: (context) =>
                                    const SizedBox(height: 210, width: 315),
                                fit: BoxFit.cover,
                              )
                              //  Image.asset(
                              //   "assets/images/963.png",
                              //   fit: BoxFit.cover,
                              //   width: double.infinity,
                              // ),
                              ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('log_in_please'),
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.deepBlue),
                          ),
                          // Text(
                          //   "ادخل رقم الهاتف وسوف نرسل لك رمز التحقق",
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 19.sp,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Card(
                            elevation: 3,
                            clipBehavior: Clip.antiAlias,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            )),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 35),
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 62.w),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 350.w,
                                        child: TextFormField(
                                          // focusNode: focusNode,
                                          // keyboardType: TextInputType.phone,
                                          // initialValue: widget.initialValue,
                                          controller: _usernameController,
                                          onTap: () {
                                            _usernameController.selection =
                                                TextSelection.collapsed(
                                                    offset: _usernameController
                                                        .text.length);
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 3) {
                                              return TextConstants
                                                  .usernameErrorText;
                                            }
                                            return null;
                                          },
                                          onSaved: (newValue) {
                                            _usernameController.text =
                                                newValue!;
                                          },
                                          scrollPadding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom +
                                                  150),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19.sp,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                    vertical: 2.h),
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .translate('username'),
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .translate('username'),
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 19.sp,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34.h,
                                      ),
                                      SizedBox(
                                        width: 350.w,
                                        child: TextFormField(
                                          // focusNode: focusNode,
                                          // keyboardType: TextInputType.phone,
                                          // initialValue: widget.initialValue,
                                          controller: _passwordController,
                                          onTap: () {
                                            _passwordController.selection =
                                                TextSelection.collapsed(
                                                    offset: _passwordController
                                                        .text.length);
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 4) {
                                              return TextConstants
                                                  .passwordErrorText;
                                            }
                                            return null;
                                          },
                                          onSaved: (newValue) {
                                            _passwordController.text =
                                                newValue!;
                                          },
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19.sp,
                                          ),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          scrollPadding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom +
                                                  150),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                    vertical: 2.h),
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .translate('password'),
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .translate('password'),
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 19.sp,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 34.h,
                                      ),
                                      BlocConsumer<AuthBloc, AuthState>(
                                        listener: (context, state) {
                                          if (state is AuthTraderSuccessState) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppColor.deepYellow,
                                                content: const Text(
                                                    'log in successfully, welcome.!'),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ),
                                            );

                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ControlView(),
                                              ),
                                              (route) => false,
                                            );
                                          }
                                          if (state is AuthBrokerSuccessState) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    AppColor.deepYellow,
                                                content: const Text(
                                                    'log in successfully, welcome.!'),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ),
                                            );

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TraderConfirmScreen(),
                                                ));
                                          }
                                          if (state is AuthLoginErrorState) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    Colors.red[300],
                                                content: const Text(
                                                    'there is no vaild account match these input!'),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                          // if (state is AuthFailureState) {
                                          //   var snackBar = SnackBar(
                                          //     elevation: 0,
                                          //     duration: const Duration(seconds: 3),
                                          //     backgroundColor: Colors.transparent,
                                          //     content: Column(
                                          //       children: [
                                          //         AwesomeSnackbarContent(
                                          //           title: 'خطأ',
                                          //           message: state.errorMessage,
                                          //           contentType:
                                          //               ContentType.failure,
                                          //         ),
                                          //         SizedBox(
                                          //           height: 30.h,
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   );
                                          //   ScaffoldMessenger.of(context)
                                          //       .showSnackBar(snackBar);
                                          // }
                                        },
                                        builder: (context, state) {
                                          if (state
                                              is AuthLoggingInProgressState) {
                                            return SizedBox(
                                                width: 350.w,
                                                child: CustomButton(
                                                  color: Colors.white,
                                                  title:
                                                      const LoadingIndicator(),
                                                  onTap: () {},
                                                ));
                                          } else {
                                            return SizedBox(
                                                width: 350.w,
                                                child: CustomButton(
                                                  title: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .translate('log_in'),
                                                    style: TextStyle(
                                                      color: AppColor.deepBlue,
                                                      fontSize: 19.sp,
                                                    ),
                                                  ),
                                                  color: Colors.white,
                                                  onTap: () {
                                                    _formKey.currentState
                                                        ?.save();

                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _login();
                                                    }
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                  },
                                                ));
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
