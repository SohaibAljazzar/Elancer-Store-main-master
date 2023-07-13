// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_style_text.dart';
import 'size_box.dart';

class RowIconAbstract extends StatelessWidget {
  late String title;
  late IconData iconData;

  RowIconAbstract({super.key, required this.title, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: const Color(0xFF717070),
          size: 20,
        ),
        const SizeBoxTemp(height: 0, width: 15),
        Flexible(
          child: AppTextStyle(
            name: title,
            fontSize: 14.sp,
            color: const Color(0xFF717070),
          ),
        ),
      ],
    );
  }
}

class RowIconAbstract2 extends StatelessWidget {
  late String title;
  late Widget iconData;

  RowIconAbstract2({super.key, required this.title, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizeBoxTemp(height: 0, width: 5),
        SizedBox(
          height: 20.r,
          width: 20.r,
          child: iconData,
        ),
        const SizeBoxTemp(height: 0, width: 15),
        AppTextStyle(
          name: title,
          fontSize: 14.sp,
          color: const Color(0xFF717070),
        ),
      ],
    );
  }
}
