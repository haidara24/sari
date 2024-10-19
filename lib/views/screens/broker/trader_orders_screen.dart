import 'package:custome_mobile/business_logic/bloc/offer_details_bloc.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/screens/broker/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:custome_mobile/business_logic/bloc/offer_bloc.dart';

class TraderOrdersScreen extends StatefulWidget {
  const TraderOrdersScreen({Key? key}) : super(key: key);

  @override
  State<TraderOrdersScreen> createState() => _TraderOrdersScreenState();
}

class _TraderOrdersScreenState extends State<TraderOrdersScreen> {
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
  void initState() {
    super.initState();
    BlocProvider.of<OfferBloc>(context).add(OfferLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<OfferBloc, OfferState>(
              builder: (context, state) {
                if (state is OfferListLoadedSuccess) {
                  return state.offers.isEmpty
                      ? const Center(
                          child: Text("لا يوجد عروض لعرضها"),
                        )
                      : ListView.builder(
                          itemCount: state.offers.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DateTime now = DateTime.now();
                            Duration diff = now
                                .difference(state.offers[index].createdDate!);
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 7.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'رقم العملية: ${state.offers[index].id!}',
                                      style: TextStyle(
                                          color: AppColor.lightBlue,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        'نوع العملية: ${getOfferType(state.offers[index].offerType!)}'),
                                    Text(
                                        'الأمانة الجمركية: ${state.offers[index].costumeagency!.name}'),
                                    Text(
                                        'نوع البضاعة: ${state.offers[index].products![0].label!}'),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          diffText(diff),
                                          style: TextStyle(
                                            color: AppColor.lightBlue,
                                            fontSize: 15,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<OfferDetailsBloc>(
                                                    context)
                                                .add(OfferDetailsLoadEvent(
                                                    state.offers[index].id!));
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetailsScreen(),
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "التفاصيل",
                                              style: TextStyle(
                                                  color: AppColor.lightBlue,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                } else {
                  return Shimmer.fromColors(
                    baseColor: (Colors.grey[300])!,
                    highlightColor: (Colors.grey[100])!,
                    enabled: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 31.h,
                              width: 100.w,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
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
                                borderRadius: BorderRadius.circular(10),
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
                                borderRadius: BorderRadius.circular(10),
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
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
