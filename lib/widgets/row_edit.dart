// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohaib_store/value/colors.dart';

import 'app_style_text.dart';
import 'app_text_field_no_border.dart';
import 'custom_image.dart';

class RowEdit extends StatelessWidget {
  String title;

  String hint;
  bool visible;
  bool enable;
  double fontSize;

  RowEdit(
      {Key? key,
      this.enable = true,
      this.fontSize = 16,
      this.visible = true,
      required this.title,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: AppTextStyle(
            name: title,
            fontSize: fontSize.sp,
            color: AppColors.black,
            isMarai: false,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          flex: 2,
          child: AppFieldNoBorder(
            enable: enable,
            hint: hint,
            hintFont: 14.sp,
            controller: TextEditingController(),
          ),
        ),
        Visibility(
          visible: visible,
          child: CustomSvgImage(
            imageName: 'edit',
            height: 14.h,
            width: 14.h,
          ),
        )
      ],
    );
  }
}
