import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'app_style_text.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
              'https://assets9.lottiefiles.com/private_files/lf30_cgfdhxgx.json',
              height: 200.h),
          const AppTextStyle(
            name: 'لا يوجد بيانات',
            fontSize: 16,
          )
        ],
      ),
    );
  }
}
