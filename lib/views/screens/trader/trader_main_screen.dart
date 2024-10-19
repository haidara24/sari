import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/group_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/post_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/widgets/calculator_loading_screen.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TraderMainScreen extends StatefulWidget {
  const TraderMainScreen({Key? key}) : super(key: key);

  @override
  State<TraderMainScreen> createState() => _TraderMainScreenState();
}

class _TraderMainScreenState extends State<TraderMainScreen> {
  int isvisivle = 0;
  bool addgroup = false;
  bool savepost = false;
  List<Color> colors = [
    Colors.red[300]!,
    Colors.yellow[300]!,
    Colors.blue[300]!,
    Colors.pink[200]!,
    Colors.purple[200]!
  ];
  final GlobalKey<FormState> _groupform = GlobalKey();
  String groupName = "";

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

  String diffEnText(Duration diff) {
    if (diff.inSeconds < 60) {
      return "since ${diff.inSeconds.toString()} seconds";
    } else if (diff.inMinutes < 60) {
      return "since ${diff.inMinutes.toString()} minutes";
    } else if (diff.inHours < 24) {
      return "since ${diff.inHours.toString()} hours";
    } else {
      return "since ${diff.inDays.toString()} days";
    }
  }

  @override
  Widget build(BuildContext context) {
    final playDuration = 600.ms;

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey[100],
              body: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostLoadedSuccess) {
                      return ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          DateTime now = DateTime.now();
                          Duration diff =
                              now.difference(state.posts[index].date!);
                          return Card(
                            elevation: 1,
                            clipBehavior: Clip.antiAlias,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            color: Colors.white,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(
                                    state.posts[index].image!,
                                    height: 225.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 225.h,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Text("error on loading "),
                                        ),
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }

                                      return SizedBox(
                                        height: 225.h,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                      .animate(delay: 400.ms)
                                      .shimmer(duration: playDuration - 200.ms)
                                      .flip(),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          localeState.value.languageCode == 'en'
                                              ? diffEnText(diff)
                                              : diffText(diff),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        )
                                            .animate()
                                            .fadeIn(
                                                duration: 300.ms,
                                                delay: playDuration,
                                                curve: Curves.decelerate)
                                            .slideX(begin: 0.2, end: 0),
                                        Text(
                                          state.posts[index].title!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.sp,
                                          ),
                                        )
                                            .animate()
                                            .fadeIn(
                                                duration: 300.ms,
                                                delay: playDuration,
                                                curve: Curves.decelerate)
                                            .slideX(begin: 0.2, end: 0),
                                        Text("${AppLocalizations.of(context)!.translate('source')}: ${state.posts[index].source!}")
                                            .animate()
                                            .scaleXY(
                                                begin: 0,
                                                end: 1,
                                                delay: 300.ms,
                                                duration: playDuration - 100.ms,
                                                curve: Curves.decelerate),
                                        Visibility(
                                          visible: isvisivle ==
                                              state.posts[index].id!,
                                          child: Text(
                                            state.posts[index].content!,
                                            maxLines: 1000,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                state.posts[index].is_saved!
                                                    ? showModalBottomSheet(
                                                        context: context,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        builder: (context) =>
                                                            StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                            (BlocProvider.of<
                                                                        GroupBloc>(
                                                                    context)
                                                                .add(UnSavePostEvent(
                                                                    state
                                                                        .posts[
                                                                            index]
                                                                        .id!)));
                                                            return BlocListener<
                                                                GroupBloc,
                                                                GroupState>(
                                                              listener:
                                                                  (context,
                                                                      state3) {
                                                                if (state3
                                                                    is PostUnsavedSuccessfully) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      backgroundColor:
                                                                          AppColor
                                                                              .deepYellow,
                                                                      content: Text(
                                                                          'تم إزالة المنشور من المحفوظات!'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              3),
                                                                    ),
                                                                  );

                                                                  BlocProvider.of<
                                                                              PostBloc>(
                                                                          context)
                                                                      .add(PostSaveEvent(
                                                                          state
                                                                              .posts[index]
                                                                              .id!,
                                                                          false));
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child: SizedBox(
                                                                height: 100.h,
                                                                child:
                                                                    const Center(
                                                                  child:
                                                                      LoadingIndicator(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : showModalBottomSheet(
                                                        context: context,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        builder: (context) =>
                                                            StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              setStte) {
                                                            return Directionality(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Center(
                                                                  child: BlocConsumer<
                                                                      GroupBloc,
                                                                      GroupState>(
                                                                    listener:
                                                                        (context,
                                                                            state2) {
                                                                      if ((state2
                                                                              is GroupListLoadedSuccess) &
                                                                          savepost) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            backgroundColor:
                                                                                AppColor.deepYellow,
                                                                            content:
                                                                                Text('تم حفظ المنشور في المحفوظات!'),
                                                                            duration:
                                                                                const Duration(seconds: 3),
                                                                          ),
                                                                        );

                                                                        BlocProvider.of<PostBloc>(context).add(PostSaveEvent(
                                                                            state.posts[index].id!,
                                                                            true));

                                                                        Navigator.pop(
                                                                            context);
                                                                        setStte(
                                                                            () {
                                                                          savepost =
                                                                              false;
                                                                        });
                                                                      }
                                                                    },
                                                                    builder:
                                                                        (context,
                                                                            groupstate) {
                                                                      if (groupstate
                                                                          is GroupListLoadedSuccess) {
                                                                        return addgroup
                                                                            ? Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    height: 60,
                                                                                  ),
                                                                                  Form(
                                                                                    key: _groupform,
                                                                                    child: TextFormField(
                                                                                      decoration: InputDecoration(
                                                                                        labelText: "  اسم المجموعة",
                                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                                                                        contentPadding: EdgeInsets.zero,
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        if (value!.isEmpty) {
                                                                                          return "أدخل اسم";
                                                                                        }
                                                                                        return null;
                                                                                      },
                                                                                      onSaved: (newValue) {
                                                                                        groupName = newValue!;
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      ElevatedButton(
                                                                                          onPressed: () {
                                                                                            setStte(() {
                                                                                              addgroup = false;
                                                                                            });
                                                                                          },
                                                                                          child: const Text("إلغاء")),
                                                                                      ElevatedButton(
                                                                                          onPressed: () {
                                                                                            if (_groupform.currentState!.validate()) {
                                                                                              _groupform.currentState!.save();

                                                                                              setStte(() {
                                                                                                addgroup = false;
                                                                                              });
                                                                                              BlocProvider.of<GroupBloc>(context).add(GroupAddEvent(groupName));
                                                                                            }
                                                                                          },
                                                                                          child: const Text("حفظ")),
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              )
                                                                            : Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  const Text(
                                                                                    "حفظ",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                                  ),
                                                                                  const Divider(),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        const Text(
                                                                                          "المجموعات",
                                                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            setStte(() {
                                                                                              addgroup = true;
                                                                                            });
                                                                                          },
                                                                                          child: const Row(
                                                                                            children: [
                                                                                              Text(
                                                                                                "اضافة مجموعة جديدة",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.greenAccent,
                                                                                                ),
                                                                                              ),
                                                                                              Icon(
                                                                                                Icons.add_circle_outline_rounded,
                                                                                                color: Colors.greenAccent,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  const Divider(),
                                                                                  ListView.builder(
                                                                                    shrinkWrap: true,
                                                                                    itemCount: groupstate.groups.length,
                                                                                    itemBuilder: (context, index2) {
                                                                                      return Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: SizedBox(
                                                                                          height: 65.h,
                                                                                          child: Column(
                                                                                            children: [
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                  setStte(() {
                                                                                                    savepost = true;
                                                                                                  });
                                                                                                  BlocProvider.of<GroupBloc>(context).add(SavePostEvent(state.posts[index].id!, groupstate.groups[index2].id!));
                                                                                                },
                                                                                                behavior: HitTestBehavior.opaque,
                                                                                                child: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          height: 45.h,
                                                                                                          width: 45.w,
                                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors[Random().nextInt(5)]),
                                                                                                          child: Center(child: Text(groupstate.groups[index2].name![0])),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          width: 13.w,
                                                                                                        ),
                                                                                                        Text(groupstate.groups[index2].name!),
                                                                                                      ],
                                                                                                    ),
                                                                                                    const Icon(Icons.add_circle_outline_rounded, color: Colors.greenAccent),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              const Divider()
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              );
                                                                      } else if (groupstate
                                                                          is GroupLoadedFailed) {
                                                                        return Center(
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              BlocProvider.of<GroupBloc>(context).add(GroupLoadEvent());
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  AppLocalizations.of(context)!.translate('list_error'),
                                                                                  style: const TextStyle(color: Colors.red),
                                                                                ),
                                                                                const Icon(
                                                                                  Icons.refresh,
                                                                                  color: Colors.grey,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return const LoadingIndicator();
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                              },
                                              child: state
                                                      .posts[index].is_saved!
                                                  ? const Icon(Icons.bookmark)
                                                  : const Icon(
                                                      Icons.bookmark_border),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (isvisivle ==
                                                        state
                                                            .posts[index].id!) {
                                                      isvisivle = 0;
                                                    } else {
                                                      isvisivle = state
                                                          .posts[index].id!;
                                                    }
                                                  });
                                                },
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .translate('read_more')))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                          ).animate().slideX(
                              duration: 200.ms,
                              delay: 0.ms,
                              begin: 1,
                              end: 0,
                              curve: Curves.easeInOutSine);
                        },
                      );
                    } else if (state is PostLoadedFailed) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<PostBloc>(context)
                                .add(PostLoadEvent());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('loading_error'),
                                style: const TextStyle(color: Colors.red),
                              ),
                              const Icon(
                                Icons.refresh,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const CalculatorLoadingScreen();
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
