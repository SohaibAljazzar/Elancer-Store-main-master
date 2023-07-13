// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextInputType? textInputType;
  final bool obscureText;
  final TextEditingController? controller;
  final String hint;
  final IconData? suffixIcon;
  final String hint2;
  // final int maxLength;
  final int maxLines;
  Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final Color? suffixIconColor;
  final bool addBorder;

  AppTextField(
      {Key? key,
      this.textInputType,
      this.controller,
      this.obscureText = false,
      // this.maxLength,
      this.maxLines = 1,
      this.suffixIconColor,
      this.suffixIcon,
      this.enabled = true,
      this.hint2 = '',
      this.onTap,
      this.readOnly = false,
      required this.hint,
      this.addBorder = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: textInputType,
      controller: controller,
      textAlign: TextAlign.center,
      // maxLength: maxLength,
      maxLines: maxLines,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(height: 1.h),
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.only(start: 30.w),
          hintText: hint,
          counterText: '',
          enabledBorder: border2,
          focusedBorder: border2,
          disabledBorder: borderDisable,
          hintStyle: const TextStyle(
            color: Color(0xffBCBCBC),
            fontFamily: 'Raleway',
          ),
          filled: true,
          suffixIcon: Icon(suffixIcon),
          suffixIconColor: Colors.black,
          fillColor: const Color(0xffF1F1F3)),
    );
  }

  UnderlineInputBorder get border2 => UnderlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(
          width: 2,
          color: (addBorder) ? const Color(0xffF2F2F2) : Colors.transparent,
        ),
      );

  OutlineInputBorder get border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: BorderSide(
          width: 1,
          color: (addBorder) ? Colors.grey.shade300 : Colors.transparent,
        ),
      );

  OutlineInputBorder get borderDisable => OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.r),
        borderSide: const BorderSide(
          width: 1,
          color: Colors.white,
        ),
      );
}
