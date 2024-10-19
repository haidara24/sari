import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/assign_broker_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/attachment/attachments_list_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/broker_review_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/offer_bloc.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:custome_mobile/data/models/user_model.dart';
import 'package:custome_mobile/data/providers/directorate_provider.dart';
import 'package:custome_mobile/data/providers/order_broker_provider.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/control_view.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectBrokerProfileScreen extends StatefulWidget {
  final CostumBroker broker;
  final List<int>? weight;
  final List<String>? price;
  final List<String>? taxes;
  final int? totalweight;
  final String? totalprice;
  final String? totaltaxes;
  final List<bool>? rawmaterial;
  final List<bool>? industrial;
  final List<bool>? brands;
  final List<bool>? tubes;
  final List<bool>? colored;
  final List<bool>? lycra;
  final List<Package?>? product;
  final List<Origin?>? origin;
  final DateTime? date;
  final bool? isProfile;
  SelectBrokerProfileScreen({
    Key? key,
    required this.broker,
    this.weight,
    this.price,
    this.taxes,
    this.totalweight,
    this.totalprice,
    this.totaltaxes,
    this.product,
    this.origin,
    this.rawmaterial,
    this.industrial,
    this.brands,
    this.tubes,
    this.colored,
    this.lycra,
    this.date,
    this.isProfile,
  }) : super(key: key);

  @override
  State<SelectBrokerProfileScreen> createState() =>
      _SelectBrokerProfileScreenState();
}

class _SelectBrokerProfileScreenState extends State<SelectBrokerProfileScreen> {
  _buildAgenciesWidget(List<CustomeAgency> agencies) {
    List<Widget> list = [];
    for (var element in agencies) {
      list.add(Text(element.name! + " ,"));
    }

    return list;
  }

  Future<void> _showAlertDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Assign Broker'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to assign this broker?'),
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
                // BlocProvider.of<AssignBrokerBloc>(context)
                //     .add(AssignBrokerToOfferEvent(widget.offerId, index));
                // remove(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  DirectorateProvider? directorate_provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      directorate_provider =
          Provider.of<DirectorateProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              // appBar: AppBar(backgroundColor: Colors.transparent),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 220.h,
                                  color: AppColor.deepBlue,
                                ),
                                SizedBox(
                                  height: 60.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          color: AppColor.deepBlue,
                                        ),
                                        child: const Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                              '${widget.broker.user!.firstName!} ${widget.broker.user!.lastName!}'),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 35.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                widget.broker.rating! >= 1
                                                    ? Icon(
                                                        Icons.star,
                                                        color:
                                                            AppColor.deepYellow,
                                                      )
                                                    : Icon(
                                                        Icons.star_border,
                                                        color:
                                                            AppColor.deepYellow,
                                                      ),
                                                widget.broker.rating! >= 2
                                                    ? Icon(
                                                        Icons.star,
                                                        color:
                                                            AppColor.deepYellow,
                                                      )
                                                    : Icon(
                                                        Icons.star_border,
                                                        color:
                                                            AppColor.deepYellow,
                                                      ),
                                                widget.broker.rating! >= 3
                                                    ? Icon(
                                                        Icons.star,
                                                        color:
                                                            AppColor.deepYellow,
                                                      )
                                                    : Icon(
                                                        Icons.star_border,
                                                        color:
                                                            AppColor.deepYellow,
                                                      ),
                                                widget.broker.rating! >= 4
                                                    ? Icon(
                                                        Icons.star,
                                                        color:
                                                            AppColor.deepYellow,
                                                      )
                                                    : Icon(
                                                        Icons.star_border,
                                                        color:
                                                            AppColor.deepYellow,
                                                      ),
                                                widget.broker.rating! == 5
                                                    ? Icon(
                                                        Icons.star,
                                                        color:
                                                            AppColor.deepYellow,
                                                      )
                                                    : Icon(
                                                        Icons.star_border,
                                                        color:
                                                            AppColor.deepYellow,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          color: AppColor.deepBlue,
                                        ),
                                        child: const Icon(
                                          Icons.message,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.broker.user!.bio!),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: AppColor.deepYellow,
                                            ),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${AppLocalizations.of(context)!.translate('directorate')}: ${widget.broker.agencies![0].statecustome!.name!}"),
                                                Wrap(
                                                  children:
                                                      _buildAgenciesWidget(
                                                          widget.broker
                                                              .agencies!),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.email,
                                              color: AppColor.deepYellow,
                                            ),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            Text(
                                              widget.broker.user!.username!,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.call,
                                              color: AppColor.deepYellow,
                                            ),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            Text(
                                              widget.broker.user!.phone!,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                            dividerColor: Colors.transparent),
                                        child: ExpansionTile(
                                          initiallyExpanded: false,
                                          tilePadding: EdgeInsets.zero,

                                          // controlAffinity: ListTileControlAffinity.leading,
                                          childrenPadding: EdgeInsets.zero,
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .84,
                                                child: const Text(
                                                  'reviews',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                          onExpansionChanged: (value) {},
                                          children: [
                                            BlocBuilder<BrokerReviewBloc,
                                                BrokerReviewState>(
                                              builder: (context, state) {
                                                if (state
                                                    is BrokerReviewSucess) {
                                                  return ListView.builder(
                                                    itemCount:
                                                        state.reviews.length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  '${state.reviews[index].trader!.user!.firstName!} ${state.reviews[index].trader!.user!.lastName!}'),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            25.w),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    widget.broker.rating! >=
                                                                            1
                                                                        ? Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          )
                                                                        : Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          ),
                                                                    widget.broker.rating! >=
                                                                            2
                                                                        ? Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          )
                                                                        : Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          ),
                                                                    widget.broker.rating! >=
                                                                            3
                                                                        ? Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          )
                                                                        : Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          ),
                                                                    widget.broker.rating! >=
                                                                            4
                                                                        ? Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          )
                                                                        : Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          ),
                                                                    widget.broker.rating! ==
                                                                            5
                                                                        ? Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          )
                                                                        : Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                AppColor.deepYellow,
                                                                          ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(state
                                                              .reviews[index]
                                                              .review!),
                                                          Divider(
                                                            color: AppColor
                                                                .deepYellow,
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  return const Center(
                                                    child: LoadingIndicator(),
                                                  );
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              top: 30,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 115.h,
                                      backgroundColor: AppColor.deepAppBarBlue,
                                      child: (widget.broker.user!.image!
                                                  .isNotEmpty ||
                                              widget.broker.user!.image! ==
                                                  null)
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(180),
                                              child: Image.network(
                                                widget.broker.user!.image!,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                "AY",
                                                style: TextStyle(
                                                  fontSize: 28.sp,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const AbsorbPointer(
                          absorbing: true,
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        // border: Border(
                        //   top: BorderSide(color: Colors.grey, width: 1),
                        // ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Consumer<OrderBrokerProvider>(
                            builder: (context, orderBrokerProvider, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocConsumer<OfferBloc, OfferState>(
                                listener: (context, offerstate) {
                                  if (offerstate is OfferLoadedSuccess &&
                                      orderBrokerProvider.isProfile) {
                                    BlocProvider.of<AttachmentsListBloc>(
                                            context)
                                        .add(ClearAttachmentToListEvent());
                                    // BlocProvider.of<BrokerListBloc>(
                                    //         context)
                                    //     .add(BrokerListLoadEvent());
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ControlView(),
                                      ),
                                      (route) => false,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: AppColor.deepYellow,
                                      content: Text(AppLocalizations.of(
                                              context)!
                                          .translate('order_success_message')),
                                      duration: const Duration(seconds: 3),
                                    ));
                                    orderBrokerProvider.initProvider();
                                  }
                                  if (offerstate is OfferLoadedFailed) {
                                    print(offerstate.errortext);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(AppLocalizations.of(
                                              context)!
                                          .translate('order_waring_message')),
                                      duration: const Duration(seconds: 3),
                                    ));
                                  }
                                },
                                builder: (context, offerstate) {
                                  if (offerstate is OfferLoadingProgress) {
                                    return CustomButton(
                                      onTap: () {},
                                      title: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .75,
                                          child: const Center(
                                              child: LoadingIndicator())),
                                    );
                                  } else {
                                    return CustomButton(
                                        title: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .75,
                                          child: Center(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('cb_request')),
                                          ),
                                        ),
                                        onTap: () {
                                          orderBrokerProvider
                                              .setIsProfile(true);

                                          List<String> productsId = [];
                                          List<int> originId = [];
                                          for (var i = 0;
                                              i < widget.product!.length;
                                              i++) {
                                            productsId
                                                .add(widget.product![i]!.id!);
                                            originId
                                                .add(widget.origin![i]!.id!);
                                          }
                                          BlocProvider.of<OfferBloc>(context)
                                              .add(
                                            AddOfferEvent(
                                                orderBrokerProvider
                                                    .selectedRadioTile,
                                                widget.broker.id!,
                                                orderBrokerProvider.packageNum,
                                                orderBrokerProvider.tabalehNum,
                                                widget.weight!,
                                                widget.price!,
                                                widget.taxes!,
                                                widget.totalweight!,
                                                widget.totalprice!,
                                                widget.totaltaxes!,
                                                widget.rawmaterial!,
                                                widget.industrial!,
                                                widget.brands!,
                                                widget.tubes!,
                                                widget.colored!,
                                                widget.lycra!,
                                                directorate_provider!
                                                    .selectedCustomeAgency!.id!,
                                                directorate_provider!
                                                    .selectedStateCustome!.id!,
                                                orderBrokerProvider
                                                    .packageTypeId,
                                                "${orderBrokerProvider.productExpireDate!.year}-${orderBrokerProvider.productExpireDate!.month}-${orderBrokerProvider.productExpireDate!.day}",
                                                orderBrokerProvider.note,
                                                orderBrokerProvider.source!,
                                                originId,
                                                productsId,
                                                orderBrokerProvider
                                                    .attachmentsId),
                                          );
                                        });
                                  }
                                },
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
