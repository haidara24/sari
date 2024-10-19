import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget title;
  final bool isEnabled;
  final double hieght;
  final Color? color;
  final Color? bordercolor;
  final Function() onTap;

  const CustomButton(
      {super.key,
      required this.title,
      this.isEnabled = true,
      this.hieght = 50,
      required this.onTap,
      this.color,
      this.bordercolor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        // margin: const EdgeInsets.all(4),
        height: hieght,
        decoration: BoxDecoration(
          // color: color ?? Colors.white,
          gradient: LinearGradient(
            colors: [
              AppColor.deepYellow,
              AppColor.deepYellow,
              AppColor.deepYellow,
              AppColor.lightYellow,
              AppColor.deepYellow,
              AppColor.deepYellow,
              AppColor.deepYellow,
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          // color: isEnabled ? color : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border(
            top: BorderSide(
                width: 1, color: bordercolor ?? AppColor.goldenYellow),
            right: BorderSide(
                width: 1, color: bordercolor ?? AppColor.goldenYellow),
            left: BorderSide(
                width: 1, color: bordercolor ?? AppColor.goldenYellow),
            bottom: BorderSide(
                width: 1, color: bordercolor ?? AppColor.goldenYellow),
          ),
        ),
        child: Center(
          child: title,
        ),
      ),
    );
  }
}
