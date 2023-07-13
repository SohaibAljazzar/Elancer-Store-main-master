// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_style_text.dart';
import 'loading2.dart';

@immutable
class AppButton extends StatefulWidget {
  final String title;
  final void Function() onPressed;
  late Color textColor;
  late Color backGroundColor;
  late bool visible;
  static const Color color = Color(0xff0F5DAB);

  AppButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.visible,
      this.textColor = Colors.white,
      this.backGroundColor = AppButton.color})
      : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: AppButton.color,
          minimumSize: Size(double.infinity, 55.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        onPressed: widget.onPressed,
        child: widget.visible
            ? AppTextStyle(
                name: widget.title,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              )
            : SizedBox(width: 30.w, height: 30.h, child: const Loading2()),
      ),
    );
  }
}
