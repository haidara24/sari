import 'package:custome_mobile/business_logic/bloc/offer_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/offer_details_bloc.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/screens/broker/order_attachments_screen.dart';
import 'package:custome_mobile/views/screens/broker/order_cost_screen.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsScreen extends StatefulWidget {
  // final Offer offer;
  OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int offerAccept = 0;

  String getOfferType(String offer) {
    switch (offer) {
      case "I":
        return "استيراد";
      case "E":
        return "تصدير";
      default:
        return "تصدير";
    }
  }

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

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // Duration diff = now.difference(offer.createdDate!);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: "تفاصيل العملية"),
          backgroundColor: Colors.grey[200],
          body: BlocBuilder<OfferDetailsBloc, OfferDetailsState>(
            builder: (context, offerstate) {
              if (offerstate is OfferDetailsLoadedSuccess) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      )),
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      elevation: 1,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 7.5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 7.h,
                            ),
                            Text(
                              'رقم العملية: SA-${offerstate.offer.id!}',
                              style: TextStyle(
                                color: AppColor.lightBlue,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300]!,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text.rich(
                                TextSpan(
                                    text: "نوع العملية: ",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: getOfferType(
                                            offerstate.offer.offerType!),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300]!,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text.rich(
                                TextSpan(
                                    text: "الأمانة الجمركية: ",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: offerstate
                                            .offer.costumeagency!.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300]!,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text.rich(
                                TextSpan(
                                    text: "نوع البضاعة: ",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: offerstate
                                            .offer.products![0].label!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300]!,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Text.rich(
                                    TextSpan(
                                        text: "منشأ البضاعة: ",
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                offerstate.offer.source!.label!,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                SizedBox(
                                  height: 45.h,
                                  child: VerticalDivider(
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: "الوجهة: ",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: offerstate
                                              .offer.costumestate!.name!,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey[300]!,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Text.rich(
                                    TextSpan(
                                        text: "نوع الطرد: ",
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: offerstate.offer.packageType!
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                SizedBox(
                                  height: 45.h,
                                  child: VerticalDivider(
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: "عدد الطرود: ",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: offerstate.offer.packagesNum!
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey[300]!,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Text.rich(
                                    TextSpan(
                                        text: "الوزن: ",
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: offerstate.offer.weight![0]
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                SizedBox(
                                  height: 45.h,
                                  child: VerticalDivider(
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: "القيمة: ",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: offerstate.offer.price![0]
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey[300]!,
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Text.rich(
                              TextSpan(
                                  text: "تاريخ وصول البضاعة: ",
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${offerstate.offer.expectedArrivalDate!.day}-${offerstate.offer.expectedArrivalDate!.month}-${offerstate.offer.expectedArrivalDate!.year}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 10.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BlocConsumer<OfferBloc, OfferState>(
                            listener: (context, state) {
                          if (state is OfferListLoadedSuccess &&
                              offerAccept == 2) {
                            setState(() {
                              offerAccept = 0;
                            });
                            Navigator.pop(context);
                          }
                        }, builder: (context, state) {
                          if (state is OfferListLoadingProgress &&
                              offerAccept == 2) {
                            return CustomButton(
                              onTap: () {},
                              title: SizedBox(
                                  width: 200.w,
                                  child:
                                      const Center(child: LoadingIndicator())),
                            );
                          } else {
                            return CustomButton(
                              onTap: () {
                                // setState(() {
                                //   offerAccept = 2;
                                // });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      // builder: (context) => OrderCostScreen(offer: offer),
                                      builder: (context) =>
                                          OrderAttachmentScreen(
                                              offer: offerstate.offer),
                                    ));
                                // BlocProvider.of<OfferBloc>(context)
                                //     .add(OfferStatusUpdateEvent(widget.offer.id!, "F"));
                              },
                              title: SizedBox(
                                  width: 200.w,
                                  child: const Center(
                                      child: Text("عرض المرفقات"))),
                            );
                          }
                        }),
                        BlocConsumer<OfferBloc, OfferState>(
                            listener: (context, state) {
                          if (state is OfferListLoadedSuccess &&
                              offerAccept == 1) {
                            setState(() {
                              offerAccept = 0;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // builder: (context) => OrderCostScreen(offer: offer),
                                  builder: (context) =>
                                      OrderCostScreen(offer: offerstate.offer),
                                ));
                          }
                        }, builder: (context, state) {
                          if (state is OfferListLoadingProgress &&
                              offerAccept == 1) {
                            return CustomButton(
                              onTap: () {},
                              title: SizedBox(
                                  width: 200.w,
                                  child:
                                      const Center(child: LoadingIndicator())),
                            );
                          } else {
                            return CustomButton(
                              onTap: () {
                                setState(() {
                                  offerAccept = 1;
                                });
                                BlocProvider.of<OfferBloc>(context).add(
                                    OfferStatusUpdateEvent(
                                        offerstate.offer.id!, "R"));
                              },
                              title: SizedBox(
                                  width: 200.w,
                                  child: const Center(
                                      child: Text("موافقة وادخال التكاليف"))),
                            );
                          }
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                );
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
  }
}
