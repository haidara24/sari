import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/assign_broker_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/attachment/attachments_list_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/broker_list_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/broker_review_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/offer_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:custome_mobile/data/providers/directorate_provider.dart';
import 'package:custome_mobile/data/providers/order_broker_provider.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/control_view.dart';
import 'package:custome_mobile/views/screens/trader/select_broker_profile_screen.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SelectBrokerScreen extends StatefulWidget {
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
  SelectBrokerScreen({
    Key? key,
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
  }) : super(key: key);

  @override
  State<SelectBrokerScreen> createState() => _SelectBrokerScreenState();
}

class _SelectBrokerScreenState extends State<SelectBrokerScreen> {
  _buildAgenciesWidget(List<CustomeAgency> agencies) {
    List<Widget> list = [];
    for (var element in agencies) {
      list.add(Text(element.name! + " ,"));
    }

    return list;
  }

  Future<void> _showAlertDialog(
      int index, int brokerId, OrderBrokerProvider provider) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          backgroundColor: Colors.white,
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
                provider.setIsProfile(false);
                List<String> productsId = [];
                List<int> originId = [];
                for (var i = 0; i < widget.product!.length; i++) {
                  productsId.add(widget.product![i]!.id!);
                  originId.add(widget.origin![i]!.id!);
                }
                BlocProvider.of<OfferBloc>(context).add(
                  AddOfferEvent(
                      provider.selectedRadioTile,
                      brokerId,
                      provider.packageNum,
                      provider.tabalehNum,
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
                      directorate_provider!.selectedCustomeAgency!.id!,
                      directorate_provider!.selectedStateCustome!.id!,
                      provider.packageTypeId,
                      "${provider.productExpireDate!.year}-${provider.productExpireDate!.month}-${provider.productExpireDate!.day}",
                      provider.note,
                      provider.source!,
                      originId,
                      productsId,
                      provider.attachmentsId),
                );
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
              appBar: CustomAppBar(
                title: AppLocalizations.of(context)!.translate('select_broker'),
              ),
              backgroundColor: Colors.grey[200],
              body: SingleChildScrollView(
                child: BlocListener<AssignBrokerBloc, AssignBrokerState>(
                  listener: (context, state) {
                    print(state);
                    if (state is AssignBrokerSuccess) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ControlView(),
                        ),
                        (route) => false,
                      );
                    }
                    if (state is AssignBrokerFailed) {
                      print(state.error);
                    }
                  },
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Consumer<OrderBrokerProvider>(
                              builder: (context, orderBrokerProvider, child) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  BlocBuilder<BrokerListBloc, BrokerListState>(
                                builder: (context, state) {
                                  if (state is BrokerListSucess) {
                                    return state.brokers.isEmpty
                                        ? Center(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .translate('no_broker')),
                                          )
                                        : ListView.builder(
                                            itemCount: state.brokers.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // DateTime now = DateTime.now();
                                              // Duration diff = now
                                              //     .difference(state.offers[index].createdDate!);
                                              return GestureDetector(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              BrokerReviewBloc>(
                                                          context)
                                                      .add(
                                                          BrokerReviewLoadEvent(
                                                              state
                                                                  .brokers[
                                                                      index]
                                                                  .id!));
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SelectBrokerProfileScreen(
                                                        broker: state
                                                            .brokers[index],
                                                        weight: widget.weight,
                                                        brands: widget.brands,
                                                        colored: widget.colored,
                                                        industrial:
                                                            widget.industrial,
                                                        lycra: widget.lycra,
                                                        origin: widget.origin,
                                                        price: widget.price,
                                                        product: widget.product,
                                                        rawmaterial:
                                                            widget.rawmaterial,
                                                        taxes: widget.taxes,
                                                        totalprice:
                                                            widget.totalprice,
                                                        totaltaxes:
                                                            widget.totaltaxes,
                                                        totalweight:
                                                            widget.totalweight,
                                                        tubes: widget.tubes,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Card(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.h),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 100.h,
                                                              width: 100.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                // color: AppColor.lightGoldenYellow,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius:
                                                                        25.h,
                                                                    backgroundColor:
                                                                        AppColor
                                                                            .deepBlue,
                                                                    child:
                                                                        Center(
                                                                      child: (state.brokers[index].user!.image!.length >
                                                                              1)
                                                                          ? ClipRRect(
                                                                              borderRadius: BorderRadius.circular(180),
                                                                              child: Image.network(
                                                                                state.brokers[index].user!.image!,
                                                                                height: 55.h,
                                                                                width: 55.w,
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              state.brokers[index].user!.image!,
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 28.sp,
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 100,
                                                                    child:
                                                                        FittedBox(
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                      child:
                                                                          Text(
                                                                        "${state.brokers[index].user!.firstName!} ${state.brokers[index].user!.lastName!}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13.sp),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "${AppLocalizations.of(context)!.translate('directorate')}: ${state.brokers[index].agencies![0].statecustome!.name!}"),
                                                                Text(
                                                                    "Agencies:"),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: _buildAgenciesWidget(state
                                                                      .brokers[
                                                                          index]
                                                                      .agencies!),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
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
                                                                    state.brokers[index].rating! >=
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
                                                                    state.brokers[index].rating! >=
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
                                                                    state.brokers[index].rating! >=
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
                                                                    state.brokers[index].rating! >=
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
                                                                    state.brokers[index].rating! ==
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
                                                              BlocConsumer<
                                                                  OfferBloc,
                                                                  OfferState>(
                                                                listener: (context,
                                                                    offerstate) {
                                                                  if (offerstate
                                                                          is OfferLoadedSuccess &&
                                                                      !orderBrokerProvider
                                                                          .isProfile) {
                                                                    BlocProvider.of<AttachmentsListBloc>(
                                                                            context)
                                                                        .add(
                                                                            ClearAttachmentToListEvent());
                                                                    // BlocProvider.of<BrokerListBloc>(
                                                                    //         context)
                                                                    //     .add(BrokerListLoadEvent());
                                                                    Navigator
                                                                        .pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ControlView(),
                                                                      ),
                                                                      (route) =>
                                                                          false,
                                                                    );
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        backgroundColor:
                                                                            AppColor.deepYellow,
                                                                        content:
                                                                            Text(AppLocalizations.of(context)!.translate('order_success_message')),
                                                                        duration:
                                                                            const Duration(seconds: 3),
                                                                      ),
                                                                    );
                                                                    orderBrokerProvider
                                                                        .initProvider();
                                                                  }
                                                                  if (offerstate
                                                                      is OfferLoadedFailed) {
                                                                    print(offerstate
                                                                        .errortext);
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      content: Text(AppLocalizations.of(
                                                                              context)!
                                                                          .translate(
                                                                              'order_waring_message')),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              3),
                                                                    ));
                                                                  }
                                                                },
                                                                builder: (context,
                                                                    offerstate) {
                                                                  if (offerstate
                                                                      is OfferLoadingProgress) {
                                                                    return CustomButton(
                                                                      onTap:
                                                                          () {},
                                                                      title: SizedBox(
                                                                          width: 100
                                                                              .w,
                                                                          child:
                                                                              Center(child: LoadingIndicator())),
                                                                    );
                                                                  } else {
                                                                    return CustomButton(
                                                                        title:
                                                                            SizedBox(
                                                                          width:
                                                                              100.w,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(AppLocalizations.of(context)!.translate('cb_request')),
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          orderBrokerProvider
                                                                              .setIsProfile(false);
                                                                          List<String>
                                                                              productsId =
                                                                              [];
                                                                          List<int>
                                                                              originId =
                                                                              [];
                                                                          for (var i = 0;
                                                                              i < widget.product!.length;
                                                                              i++) {
                                                                            productsId.add(widget.product![i]!.id!);
                                                                            originId.add(widget.origin![i]!.id!);
                                                                          }
                                                                          BlocProvider.of<OfferBloc>(context)
                                                                              .add(
                                                                            AddOfferEvent(
                                                                                orderBrokerProvider.selectedRadioTile,
                                                                                state.brokers[index].id!,
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
                                                                                directorate_provider!.selectedCustomeAgency!.id!,
                                                                                directorate_provider!.selectedStateCustome!.id!,
                                                                                orderBrokerProvider.packageTypeId,
                                                                                "${orderBrokerProvider.productExpireDate!.year}-${orderBrokerProvider.productExpireDate!.month}-${orderBrokerProvider.productExpireDate!.day}",
                                                                                orderBrokerProvider.note,
                                                                                orderBrokerProvider.source!,
                                                                                originId,
                                                                                productsId,
                                                                                orderBrokerProvider.attachmentsId),
                                                                          );
                                                                          // _showAlertDialog(
                                                                          //     index,
                                                                          //     state.brokers[index].id!,
                                                                          //     orderBrokerProvider);
                                                                        });
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                  } else {
                                    return Shimmer.fromColors(
                                      baseColor: (Colors.grey[300])!,
                                      highlightColor: (Colors.grey[100])!,
                                      enabled: true,
                                      direction: ShimmerDirection.ttb,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (_, __) => Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30.h,
                                                width: 100.w,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                height: 30.h,
                                                width: 150.w,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                height: 30.h,
                                                width: 150.w,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        itemCount: 6,
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      BlocBuilder<AssignBrokerBloc, AssignBrokerState>(
                        builder: (context, state) {
                          if (state is AssignBrokerLoadingProgress) {
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
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
