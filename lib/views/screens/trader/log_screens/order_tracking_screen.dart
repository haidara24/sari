import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/offer_details_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/update_track_offer_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/providers/broker_offer_provider.dart';
import 'package:custome_mobile/data/providers/trader_offer_provider.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:custome_mobile/views/widgets/custome_timeline.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrderTrackingScreen extends StatefulWidget {
  final String type;
  final Offer offer;
  OrderTrackingScreen({Key? key, required this.offer, required this.type})
      : super(key: key);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  TraderOfferProvider? trader_offerProvider;

  BrokerOfferProvider? broker_offerProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trader_offerProvider =
          Provider.of<TraderOfferProvider>(context, listen: false);
      broker_offerProvider =
          Provider.of<BrokerOfferProvider>(context, listen: false);
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
                  title: AppLocalizations.of(context)!
                      .translate('operation_tracking')),
              backgroundColor: Colors.grey[200],
              body: BlocConsumer<OfferDetailsBloc, OfferDetailsState>(
                listener: (context, offerstate) {
                  if (offerstate is OfferDetailsLoadedSuccess) {
                    trader_offerProvider!
                        .initAttachment(offerstate.offer.attachments!);
                    trader_offerProvider!.initAdditionalAttachment(
                        offerstate.offer.additional_attachments!);
                    broker_offerProvider!.initOffer(offerstate.offer);
                  }
                },
                builder: (context, offerstate) {
                  if (offerstate is OfferDetailsLoadedSuccess) {
                    return Consumer<BrokerOfferProvider>(
                        builder: (context, brokerOfferProvider, child) {
                      return BlocListener<UpdateTrackOfferBloc,
                          UpdateTrackOfferState>(
                        listener: (context, state) {
                          print(state);

                          if (state is UpdateTrackOfferLoadedSuccess) {
                            brokerOfferProvider
                                .updateTracking(state.trackOffer);
                          }
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(12.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  '${AppLocalizations.of(context)!.translate('operation_number')}: SA-${brokerOfferProvider.id}',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.type == "broker") {
                                      if (!brokerOfferProvider
                                          .track_offer!.attachmentRecivment!) {
                                        BlocProvider.of<UpdateTrackOfferBloc>(context).add(UpdateValuesEvent(
                                            TrackOffer(
                                                id: brokerOfferProvider
                                                    .track_offer!.id,
                                                attachmentRecivment: true,
                                                unloadDistenation:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .unloadDistenation,
                                                deliveryPermit: brokerOfferProvider
                                                    .track_offer!
                                                    .deliveryPermit,
                                                customeDeclration:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .customeDeclration,
                                                previewGoods: brokerOfferProvider
                                                    .track_offer!.previewGoods,
                                                payFeesTaxes: brokerOfferProvider
                                                    .track_offer!.payFeesTaxes,
                                                issuingExitPermit:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .issuingExitPermit,
                                                loadDistenation:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .loadDistenation),
                                            "attachmentRecivment"));
                                      }
                                    }
                                  },
                                  child: CustomeTimeLine(
                                    isFirst: true,
                                    isLast: true,
                                    isPast: brokerOfferProvider
                                        .track_offer!.attachmentRecivment!,
                                    imageUrl: !brokerOfferProvider
                                            .track_offer!.attachmentRecivment!
                                        ? "assets/images/step 1 Dark.svg"
                                        : "assets/images/step 1 blue.svg",
                                    type: "svg",
                                    title: AppLocalizations.of(context)!
                                        .translate('attachments_recivment'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.type == "broker") {
                                      if (!brokerOfferProvider
                                          .track_offer!.unloadDistenation!) {
                                        BlocProvider.of<UpdateTrackOfferBloc>(context).add(UpdateValuesEvent(
                                            TrackOffer(
                                                id: brokerOfferProvider
                                                    .track_offer!.id,
                                                attachmentRecivment:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .attachmentRecivment,
                                                unloadDistenation: true,
                                                deliveryPermit: brokerOfferProvider
                                                    .track_offer!
                                                    .deliveryPermit,
                                                customeDeclration:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .customeDeclration,
                                                previewGoods: brokerOfferProvider
                                                    .track_offer!.previewGoods,
                                                payFeesTaxes: brokerOfferProvider
                                                    .track_offer!.payFeesTaxes,
                                                issuingExitPermit:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .issuingExitPermit,
                                                loadDistenation: brokerOfferProvider
                                                    .track_offer!
                                                    .loadDistenation),
                                            "unloadDistenation"));
                                      }
                                    }
                                  },
                                  child: CustomeTimeLine(
                                    isFirst: true,
                                    isLast: false,
                                    isPast: brokerOfferProvider
                                        .track_offer!.unloadDistenation!,
                                    imageUrl: !brokerOfferProvider
                                            .track_offer!.unloadDistenation!
                                        ? "assets/images/step 2 Dark.svg"
                                        : "assets/images/step 2 blue.svg",
                                    type: "svg",
                                    title: AppLocalizations.of(context)!
                                        .translate('unload_distenation'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.type == "broker") {
                                      if (!brokerOfferProvider
                                          .track_offer!.deliveryPermit!) {
                                        BlocProvider.of<UpdateTrackOfferBloc>(context).add(UpdateValuesEvent(
                                            TrackOffer(
                                                id: brokerOfferProvider
                                                    .track_offer!.id,
                                                attachmentRecivment:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .attachmentRecivment,
                                                unloadDistenation: brokerOfferProvider
                                                    .track_offer!
                                                    .unloadDistenation,
                                                deliveryPermit: true,
                                                customeDeclration:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .customeDeclration,
                                                previewGoods: brokerOfferProvider
                                                    .track_offer!.previewGoods,
                                                payFeesTaxes: brokerOfferProvider
                                                    .track_offer!.payFeesTaxes,
                                                issuingExitPermit:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .issuingExitPermit,
                                                loadDistenation:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .loadDistenation),
                                            "deliveryPermit"));
                                      }
                                    }
                                  },
                                  child: CustomeTimeLine(
                                    isFirst: false,
                                    isLast: false,
                                    isPast: brokerOfferProvider
                                        .track_offer!.deliveryPermit!,
                                    imageUrl: !brokerOfferProvider
                                            .track_offer!.deliveryPermit!
                                        ? "assets/images/step 3 Dark.svg"
                                        : "assets/images/step 3 blue.svg",
                                    type: "svg",
                                    title: AppLocalizations.of(context)!
                                        .translate('delivery_permit'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.type == "broker") {
                                      if (!brokerOfferProvider
                                          .track_offer!.customeDeclration!) {
                                        BlocProvider.of<UpdateTrackOfferBloc>(context).add(UpdateValuesEvent(
                                            TrackOffer(
                                                id: brokerOfferProvider
                                                    .track_offer!.id,
                                                attachmentRecivment:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .attachmentRecivment,
                                                unloadDistenation:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .unloadDistenation,
                                                deliveryPermit: brokerOfferProvider
                                                    .track_offer!
                                                    .deliveryPermit,
                                                customeDeclration: true,
                                                previewGoods: brokerOfferProvider
                                                    .track_offer!.previewGoods,
                                                payFeesTaxes: brokerOfferProvider
                                                    .track_offer!.payFeesTaxes,
                                                issuingExitPermit:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .issuingExitPermit,
                                                loadDistenation: brokerOfferProvider
                                                    .track_offer!
                                                    .loadDistenation),
                                            "customeDeclration"));
                                      }
                                    }
                                  },
                                  child: CustomeTimeLine(
                                    isFirst: false,
                                    isLast: false,
                                    isPast: brokerOfferProvider
                                        .track_offer!.customeDeclration!,
                                    isCurrent: true,
                                    imageUrl: !brokerOfferProvider
                                            .track_offer!.customeDeclration!
                                        ? "assets/images/step 4 Dark.svg"
                                        : "assets/images/step 4 blue.svg",
                                    type: "svg",
                                    title: AppLocalizations.of(context)!
                                        .translate('custome_declration'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.type == "broker") {
                                      if (!brokerOfferProvider
                                          .track_offer!.previewGoods!) {
                                        BlocProvider.of<UpdateTrackOfferBloc>(context).add(UpdateValuesEvent(
                                            TrackOffer(
                                                id: brokerOfferProvider
                                                    .track_offer!.id,
                                                attachmentRecivment:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .attachmentRecivment,
                                                unloadDistenation: brokerOfferProvider
                                                    .track_offer!
                                                    .unloadDistenation,
                                                deliveryPermit: brokerOfferProvider
                                                    .track_offer!
                                                    .deliveryPermit,
                                                customeDeclration:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .customeDeclration,
                                                previewGoods: true,
                                                payFeesTaxes: brokerOfferProvider
                                                    .track_offer!.payFeesTaxes,
                                                issuingExitPermit:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .issuingExitPermit,
                                                loadDistenation: brokerOfferProvider
                                                    .track_offer!
                                                    .loadDistenation),
                                            "previewGoods"));
                                      }
                                    }
                                  },
                                  child: CustomeTimeLine(
                                    isFirst: false,
                                    isLast: false,
                                    isPast: brokerOfferProvider
                                        .track_offer!.previewGoods!,
                                    imageUrl: !brokerOfferProvider
                                            .track_offer!.previewGoods!
                                        ? "assets/images/step 5 Dark.svg"
                                        : "assets/images/step 5 blue.svg",
                                    type: "svg",
                                    title: AppLocalizations.of(context)!
                                        .translate('preview_goods'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.type == "broker") {
                                      if (!brokerOfferProvider
                                          .track_offer!.payFeesTaxes!) {
                                        BlocProvider.of<UpdateTrackOfferBloc>(context).add(UpdateValuesEvent(
                                            TrackOffer(
                                                id: brokerOfferProvider
                                                    .track_offer!.id,
                                                attachmentRecivment:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .attachmentRecivment,
                                                unloadDistenation: brokerOfferProvider
                                                    .track_offer!
                                                    .unloadDistenation,
                                                deliveryPermit: brokerOfferProvider
                                                    .track_offer!
                                                    .deliveryPermit,
                                                customeDeclration:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .customeDeclration,
                                                previewGoods: brokerOfferProvider
                                                    .track_offer!.previewGoods,
                                                payFeesTaxes: true,
                                                issuingExitPermit:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .issuingExitPermit,
                                                loadDistenation: brokerOfferProvider
                                                    .track_offer!
                                                    .loadDistenation),
                                            "payFeesTaxes"));
                                      }
                                    }
                                  },
                                  child: CustomeTimeLine(
                                    isFirst: false,
                                    isLast: false,
                                    isPast: brokerOfferProvider
                                        .track_offer!.payFeesTaxes!,
                                    imageUrl: !brokerOfferProvider
                                            .track_offer!.payFeesTaxes!
                                        ? "assets/images/step 6 Dark.svg"
                                        : "assets/images/step 6 blue.svg",
                                    type: "svg",
                                    title: AppLocalizations.of(context)!
                                        .translate('pay_fees_taxes'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.type == "broker") {
                                      if (!brokerOfferProvider
                                          .track_offer!.issuingExitPermit!) {
                                        BlocProvider.of<UpdateTrackOfferBloc>(context).add(UpdateValuesEvent(
                                            TrackOffer(
                                                id: brokerOfferProvider
                                                    .track_offer!.id,
                                                attachmentRecivment:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .attachmentRecivment,
                                                unloadDistenation: brokerOfferProvider
                                                    .track_offer!
                                                    .unloadDistenation,
                                                deliveryPermit: brokerOfferProvider
                                                    .track_offer!
                                                    .deliveryPermit,
                                                customeDeclration:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .customeDeclration,
                                                previewGoods: brokerOfferProvider
                                                    .track_offer!.previewGoods,
                                                payFeesTaxes: brokerOfferProvider
                                                    .track_offer!.payFeesTaxes,
                                                issuingExitPermit: true,
                                                loadDistenation:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .loadDistenation),
                                            "issuingExitPermit"));
                                      }
                                    }
                                  },
                                  child: CustomeTimeLine(
                                    isFirst: false,
                                    isLast: false,
                                    isPast: brokerOfferProvider
                                        .track_offer!.issuingExitPermit!,
                                    imageUrl: !brokerOfferProvider
                                            .track_offer!.issuingExitPermit!
                                        ? "assets/images/step 7 Dark.svg"
                                        : "assets/images/step 7 blue.svg",
                                    type: "svg",
                                    title: AppLocalizations.of(context)!
                                        .translate('issuing_exit_permit'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.type == "broker") {
                                      if (!brokerOfferProvider
                                          .track_offer!.loadDistenation!) {
                                        BlocProvider.of<UpdateTrackOfferBloc>(context).add(UpdateValuesEvent(
                                            TrackOffer(
                                                id: brokerOfferProvider
                                                    .track_offer!.id,
                                                attachmentRecivment:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .attachmentRecivment,
                                                unloadDistenation: brokerOfferProvider
                                                    .track_offer!
                                                    .unloadDistenation,
                                                deliveryPermit: brokerOfferProvider
                                                    .track_offer!
                                                    .deliveryPermit,
                                                customeDeclration:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .customeDeclration,
                                                previewGoods: brokerOfferProvider
                                                    .track_offer!.previewGoods,
                                                payFeesTaxes: brokerOfferProvider
                                                    .track_offer!.payFeesTaxes,
                                                issuingExitPermit:
                                                    brokerOfferProvider
                                                        .track_offer!
                                                        .issuingExitPermit,
                                                loadDistenation: true),
                                            "loadDistenation"));
                                      }
                                    }
                                  },
                                  child: CustomeTimeLine(
                                    isFirst: false,
                                    isLast: true,
                                    isPast: brokerOfferProvider
                                        .track_offer!.loadDistenation!,
                                    imageUrl: !brokerOfferProvider
                                            .track_offer!.loadDistenation!
                                        ? "assets/images/step 8 Dark.svg"
                                        : "assets/images/step 8 blue.svg",
                                    type: "svg",
                                    title: AppLocalizations.of(context)!
                                        .translate('load_distenation'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  } else if (offerstate is OfferDetailsLoadingProgress) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      child: const Center(child: LoadingIndicator()),
                    );
                  } else {
                    return Text("");
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
