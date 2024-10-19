import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/constants/enums.dart';
import 'package:custome_mobile/data/models/accurdion_model.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ListItems extends StatelessWidget {
  final NoteType noteType;
  final List<SectionNote> sectionnotes;
  final bool loading;
  final BuildContext contxt;
  ListItems(
      {Key? key,
      required this.noteType,
      required this.sectionnotes,
      required this.loading,
      required this.contxt})
      : super(key: key);
  List<Widget> list = [];
  final ScrollController _scrollController = ScrollController();

  List<Widget> buildNoteWidget() {
    List<Widget> list = [];
    if ((noteType == NoteType.Section)) {
      if (!loading) {
        list.add(sectionnotes.isEmpty
            ? const SizedBox(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("no notes"),
                    ),
                  ],
                ),
              )
            : Container(
                height: 280.h,
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: sectionnotes.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index2) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sectionnotes[index2].noteNum!,
                              style: TextStyle(
                                  color: AppColor.deepBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "  ${sectionnotes[index2].noteA!.replaceAll("#", "\n")}"),
                          ]),
                    );
                  },
                ),
              ));
      } else {
        list.add(Shimmer.fromColors(
          baseColor: (Colors.grey[300])!,
          highlightColor: (Colors.grey[100])!,
          enabled: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(contxt).size.width * .9,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, __) => Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      height: 100.h,
                    ),
                  ),
                  itemCount: 2,
                ),
              ),
            ],
          ),
        ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.goldenYellow,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(14)),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              thickness: 2.0,
              radius: const Radius.circular(2),
              child: ListView(
                children: buildNoteWidget(),
              ),
            ),
          ),
        );
      },
    );
  }
}
