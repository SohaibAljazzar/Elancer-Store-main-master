// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';

class CurrentPage extends StatelessWidget {
  bool selected;

  CurrentPage({Key? key, required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18.w,
          height: 2.h,
          decoration: BoxDecoration(
              color: selected ? AppColors.appColor : const Color(0xFFB8B8B8),
              borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
