import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventCardWidget extends StatelessWidget {
  final bool isPast;
  final bool isCurrent;
  final String title;
  final String imageUrl;
  final String type;

  const EventCardWidget(
      {Key? key,
      required this.isPast,
      required this.title,
      required this.imageUrl,
      required this.type,
      required this.isCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          SizedBox(
            height: 40.h,
            width: 40.w,
            child: type == "svg"
                ? SvgPicture.asset(
                    imageUrl,
                    // height: 40.h,
                    width: 40.w,
                    fit: BoxFit.scaleDown,
                  )
                : Image.asset(
                    imageUrl,
                    width: 40.w,
                    height: 40.h,
                  ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            title,
            style: TextStyle(
              color: isPast ? AppColor.lightBlue : AppColor.deepBlue,
            ),
          )
        ],
      ),
    );
  }
}
