import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/widgets/event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomeTimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final bool isCurrent;
  final String title;
  final String imageUrl;
  final String type;
  const CustomeTimeLine(
      {Key? key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.title,
      required this.imageUrl,
      required this.type,
      this.isCurrent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TimelineTile(
        isLast: isLast,
        isFirst: isFirst,
        beforeLineStyle: LineStyle(
          color: isPast ? AppColor.deepBlue : Colors.grey[400]!,
        ),
        indicatorStyle: IndicatorStyle(
            color: isPast ? AppColor.deepBlue : Colors.grey[400]!,
            iconStyle: IconStyle(
                iconData: Icons.done,
                color: isPast ? Colors.white : Colors.grey[400]!,
                fontSize: 15)),
        endChild: EventCardWidget(
            isPast: isPast,
            title: title,
            imageUrl: imageUrl,
            type: type,
            isCurrent: isCurrent),
      ),
    );
  }
}
