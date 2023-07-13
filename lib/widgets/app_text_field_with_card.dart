// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFieldWithCard extends StatelessWidget {
  late String title;
  late bool obscure;
  late TextInputType inputType;
  late IconData? iconData;

  late IconData? iconDataPref;

  late TextEditingController controller;
  late Color color;
  late void Function() onPressed;
  late bool enable;

  late bool svg;
  late int maxLine;
  late int maxLength;
  late String svgUrl;

  AppTextFieldWithCard({
    Key? key,
    this.maxLine = 2,
    this.maxLength = 2,
    required this.title,
    this.inputType = TextInputType.text,
    this.obscure = false,
    required this.controller,
    this.color = Colors.grey,
    required this.onPressed,
    this.enable = true,
    required this.iconDataPref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: TextField(
        // maxLength: maxLength,
        maxLines: maxLine,
        obscureText: obscure,
        controller: controller,
        enabled: enable,
        style: TextStyle(
          color: const Color(0XFF90959B),
          fontFamily: 'Almarai',
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        keyboardType: inputType,
        decoration: InputDecoration(
          // prefixIcon: Icon(
          //   iconDataPref,
          //   color: Colors.black,
          // ),

          filled: true,
          fillColor: Colors.white,
          hintText: title,
          // hintText: title,
          hintStyle: TextStyle(
            color: const Color(0XFF90959B),
            fontFamily: 'Almarai',
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          // label: AppTextStyle(
          //   name: title,
          //   fontSize: 16,
          // ),
          alignLabelWithHint: true,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
