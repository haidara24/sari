
// import 'package:custome_mobile/business_logic/bloc/post_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:custome_mobile/helpers/color_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';


// BottomNavigationBar(
//               backgroundColor: Colors.transparent,
//               iconSize: 30,
//               type: BottomNavigationBarType.fixed,
//               currentIndex: navigationValue,
//               selectedItemColor: Theme.of(context).primaryColor,
//               onTap: (value) {
//                 changeSelectedValue(selectedValue: value, contxt: context);
//               },
//               // fixedColor: Colors.white,
//               unselectedItemColor: Colors.white,
//               items: [
//                 BottomNavigationBarItem(
//                   activeIcon: Icon(
//                     Icons.light_mode_outlined,
//                     size: 45,
//                     color: Colors.green,
//                   ),
//                   icon: Icon(
//                     Icons.light_mode_outlined,
//                     size: 35,
//                     color: Colors.white,
//                   ),
//                   label: "طلب مخلص",
//                 ),
//                 BottomNavigationBarItem(
//                   activeIcon: SvgPicture.asset(
//                     "assets/icons/calculator.svg",
//                     width: 30,
//                   ),
//                   icon: Icon(
//                     Icons.calculate_rounded,
//                     size: 35,
//                     color: Colors.white,
//                   ),
//                   label: "حاسبة الرسوم",
//                 ),
//                 BottomNavigationBarItem(
//                   activeIcon: Icon(
//                     Icons.home,
//                     size: 35,
//                     color: Colors.green,
//                   ),
//                   icon: Icon(
//                     Icons.home,
//                     size: 35,
//                     color: Colors.white,
//                   ),
//                   label: "الرئيسية",
//                 ),
//                 BottomNavigationBarItem(
//                   activeIcon: Icon(
//                     Icons.star,
//                     size: 35,
//                     color: Colors.green,
//                   ),
//                   icon: Icon(
//                     Icons.star,
//                     size: 35,
//                     color: Colors.white,
//                   ),
//                   label: "التعرفة الجمركية",
//                 ),
//                 BottomNavigationBarItem(
//                   activeIcon: Icon(
//                     Icons.list_alt_outlined,
//                     size: 35,
//                     color: Colors.green,
//                   ),
//                   icon: Icon(
//                     Icons.list_alt_outlined,
//                     size: 35,
//                     color: Colors.white,
//                   ),
//                   label: "السجل",
//                 ),
//               ],
//             ),


// class TraderMainScreen extends StatefulWidget {
//   TraderMainScreen({Key? key}) : super(key: key);

//   @override
//   State<TraderMainScreen> createState() => _TraderMainScreenState();
// }

// class _TraderMainScreenState extends State<TraderMainScreen> {
//   int isvisivle = 0;

//   String diffText(Duration diff) {
//     if (diff.inSeconds < 60) {
//       return "منذ ${diff.inSeconds.toString()} ثانية";
//     } else if (diff.inMinutes < 60) {
//       return "منذ ${diff.inMinutes.toString()} دقيقة";
//     } else if (diff.inHours < 24) {
//       return "منذ ${diff.inHours.toString()} ساعة";
//     } else {
//       return "منذ ${diff.inDays.toString()} يوم";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: DefaultTabController(
//         length: 3,
//         initialIndex: 1,
//         child: Scaffold(
//           backgroundColor: Colors.grey[200],
//           appBar: AppBar(
//             title: Text("الرئيسية"),
//             bottom: const PreferredSize(
//               preferredSize: Size.fromHeight(45),
//               child: TabBar(
//                   // isScrollable: true,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   tabs: [
//                     Tab(
//                       child: Text(
//                         "أخر الأخبار",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         "عاجل",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         "الأكثر قراءة",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ]),
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: BlocBuilder<PostBloc, PostState>(
//               builder: (context, state) {
//                 if (state is PostLoadedSuccess) {
//                   return ListView.builder(
//                     itemCount: state.posts.length,
//                     itemBuilder: (context, index) {
//                       DateTime now = DateTime.now();
//                       Duration diff = now.difference(state.posts[index].date!);
//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         elevation: 1,
//                         color: Colors.white,
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 25, vertical: 15),
//                         clipBehavior: Clip.hardEdge,
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Image.network(
//                                 state.posts[index].image!,
//                                 height: 185,
//                                 width: double.infinity,
//                               ),
//                               SizedBox(
//                                 height: 12.h,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(state.posts[index].title!),
//                                     Text(
//                                         "المصدر: ${state.posts[index].source!}"),
//                                     Visibility(
//                                       visible:
//                                           isvisivle == state.posts[index].id!,
//                                       child: Text(
//                                         state.posts[index].content!,
//                                         maxLines: 1000,
//                                       ),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(diffText(diff)),
//                                         GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 if (isvisivle ==
//                                                     state.posts[index].id!) {
//                                                   isvisivle = 0;
//                                                 } else {
//                                                   isvisivle =
//                                                       state.posts[index].id!;
//                                                 }
//                                               });
//                                             },
//                                             child: Text("اقرأ المزيد"))
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ]),
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(
//                     child: const LoadingIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   String title;
//   CustomAppBar({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 160.h,
//       padding: const EdgeInsets.only(bottom: 6.0),
//       decoration: BoxDecoration(
//         color: AppColor.deepBlue,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(20.0),
//           bottomRight: Radius.circular(20.0),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 12.w),
//         child: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     margin:
//                         EdgeInsets.symmetric(vertical: 13.h, horizontal: 3.w),
//                     height: 35.h,
//                     width: 35.w,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(45),
//                         color: Colors.white),
//                     child: Center(
//                       child: Icon(
//                         Icons.list,
//                         color: AppColor.deepBlue,
//                         size: 25.w,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin:
//                         EdgeInsets.symmetric(vertical: 13.h, horizontal: 3.w),
//                     height: 35.h,
//                     width: 35.w,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(45),
//                         color: Colors.white),
//                     child: Center(
//                       child: Icon(
//                         Icons.notifications,
//                         color: AppColor.deepBlue,
//                         size: 25.w,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Image.asset(
//                 "assets/images/sari_white_logo.png",
//                 height: 35.h,
//               ),
//             ],
//           ),
//           Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 height: 35.h,
//                 width: 35.w,
//                 margin: EdgeInsets.symmetric(vertical: 13.h, horizontal: 5.w),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(45),
//                     color: Colors.white),
//                 child: Center(
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                     color: AppColor.deepBlue,
//                     size: 25.w,
//                   ),
//                 ),
//               ),
//               Text(
//                 title,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22.sp,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           )
//         ]),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size(double.infinity, 150.0);
// }
 // CurvedNavigationBar(
                          //   index: navigationValue,
                          //   backgroundColor: Colors.transparent,
                          //   color: AppColor.deepBlue,
                          //   animationCurve: Curves.bounceInOut,
                          //   height: 75.h,
                          //   buttonBackgroundColor: AppColor.deepYellow,
                          //   animationDuration: const Duration(milliseconds: 300),
                          //   onTap: (value) {
                          //     changeSelectedValue(selectedValue: value, contxt: context);
                          //   },
                          //   items: [
                          //     navigationValue == 0
                          //         ? Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Image.asset(
                          //               "assets/icons/broker_order.png",
                          //               width: 40.w,
                          //               height: 40.h,
                          //             ),
                          //           )
                          //         : Column(
                          //             mainAxisAlignment: MainAxisAlignment.end,
                          //             children: [
                          //               Image.asset(
                          //                 "assets/icons/broker_order.png",
                          //                 width: 30.w,
                          //                 height: 30.h,
                          //               ),
                          //               const Text(
                          //                 "طلب مخلص",
                          //                 style: TextStyle(color: Colors.white),
                          //               )
                          //             ],
                          //           ),
                          //     navigationValue == 1
                          //         ? Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: SvgPicture.asset(
                          //               "assets/icons/calculator.svg",
                          //               width: 45.w,
                          //               height: 45.h,
                          //             ),
                          //           )
                          //         : Column(
                          //             mainAxisAlignment: MainAxisAlignment.end,
                          //             children: [
                          //               SvgPicture.asset(
                          //                 "assets/icons/calculator.svg",
                          //                 width: 30.w,
                          //                 height: 30.h,
                          //               ),
                          //               const Text(
                          //                 "حاسبة",
                          //                 style: TextStyle(color: Colors.white),
                          //               )
                          //             ],
                          //           ),
                          //     navigationValue == 2
                          //         ? Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: SvgPicture.asset(
                          //               "assets/icons/home.svg",
                          //               width: 40.w,
                          //               height: 40.h,
                          //             ),
                          //           )
                          //         : Column(
                          //             mainAxisAlignment: MainAxisAlignment.end,
                          //             children: [
                          //               SvgPicture.asset(
                          //                 "assets/icons/home.svg",
                          //                 width: 30.w,
                          //                 height: 30.h,
                          //               ),
                          //               const Text(
                          //                 "الرئيسية",
                          //                 style: TextStyle(color: Colors.white),
                          //               )
                          //             ],
                          //           ),
                          //     navigationValue == 3
                          //         ? Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: SvgPicture.asset(
                          //               "assets/icons/tariff.svg",
                          //               width: 40.w,
                          //               height: 40.h,
                          //             ),
                          //           )
                          //         : Column(
                          //             mainAxisAlignment: MainAxisAlignment.end,
                          //             children: [
                          //               SvgPicture.asset(
                          //                 "assets/icons/tariff.svg",
                          //                 width: 30.w,
                          //                 height: 30.h,
                          //               ),
                          //               const Text(
                          //                 "التعرفة",
                          //                 style: TextStyle(color: Colors.white),
                          //               )
                          //             ],
                          //           ),
                          //     navigationValue == 4
                          //         ? Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: SvgPicture.asset(
                          //               "assets/icons/log.svg",
                          //               width: 40.w,
                          //               height: 40.h,
                          //             ),
                          //           )
                          //         : Column(
                          //             mainAxisAlignment: MainAxisAlignment.end,
                          //             children: [
                          //               SvgPicture.asset(
                          //                 "assets/icons/log.svg",
                          //                 width: 30.w,
                          //                 height: 30.h,
                          //               ),
                          //               const Text(
                          //                 "السجل",
                          //                 style: TextStyle(color: Colors.white),
                          //               )
                          //             ],
                          //           ),
                          //   ],
                          // ),

          //                 BlocBuilder<CurrentStepCubit, CurrentStepInitial>(
          //   builder: (context, stepstate) {
          //     return Stepper(
          //       type: StepperType.horizontal,
          //       steps: [
          //         Step(
          //             isActive: stepstate.value >= 0,
          //             title: Text(
          //               "معلومات الشحنة",
          //               style: TextStyle(fontSize: 12.sp),
          //             ),
          //             content: const StepperOrderBrokerScreen()),
          //         Step(
          //             isActive: stepstate.value >= 1,
          //             title: Text(
          //               "حساب الرسوم",
          //               style: TextStyle(fontSize: 12.sp),
          //             ),
          //             content: const TraderBillReview()),
          //         Step(
          //             isActive: stepstate.value >= 2,
          //             title: Text(
          //               "المرفقات",
          //               style: TextStyle(fontSize: 12.sp),
          //             ),
          //             content: TraderAttachementScreen()),
          //       ],
          //       currentStep: stepstate.value,
          //       controlsBuilder: (context, details) {
          //         return const SizedBox.shrink();
          //       },
          //       onStepContinue: () => setState(() {
          //         if (stepstate.value < 2) {
          //           print(stepstate.value);
          //           BlocProvider.of<CurrentStepCubit>(context).increament();
          //         }
          //       }),
          //       onStepCancel: () => setState(() {
          //         if (stepstate.value > 0) {
          //           print(stepstate.value);
          //           BlocProvider.of<CurrentStepCubit>(context).decreament();
          //         }
          //       }),
          //     );
          //   },
          // ),