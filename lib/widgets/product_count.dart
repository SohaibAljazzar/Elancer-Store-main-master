// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../value/colors.dart';

class ProductCount extends StatelessWidget {
  final IconData icon;
  void Function() count;
  double size;

  ProductCount(
      {Key? key, required this.icon, required this.count, this.size = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: count,
      child: Card(
        color: AppColors.appColor,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(3.r),
          child: Icon(
            size: size.r,
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
