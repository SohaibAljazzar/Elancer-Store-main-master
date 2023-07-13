import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/app_button.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/size_box.dart';

import '../../server/app_get/app_get.dart';
import '../../server/getx_controller/getx_data_auth.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  AppGet appGet = Get.find();
  GetxControllerGetDataAuth controller = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FadeInDown(
          child: const AppTextStyle(
            fontSize: 18,
            name: 'الأسئلة الاكثر شيوعأ',
            color: Color(0xff505050),
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.appColor,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.appColor,
          ),
        ),
      ),
      body: ListView.separated(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return FadeInRight(
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                semanticContainer: true,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                color: Colors.white.withOpacity(0.90),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 23.w, top: 20.h, bottom: 20.h),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: AppButton.color,
                        child: const Icon(
                          Icons.question_answer,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            AppTextStyle(
                              name: controller.faqs['list'][index]
                                  ['question_ar'],
                              color: AppButton.color,
                              fontSize: 17,
                            ),
                            AppTextStyle(
                              name: controller.faqs['list'][index]['answer_ar'],
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              count: 16,
                              color: AppButton.color,
                            ),
                            const SizeBoxTemp(height: 10, width: 0),
                            // Row(
                            //   // mainAxisSize: MainAxisSize.m,
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     const SizeBoxTemp(height: 0, width: 5),
                            //     Icon(
                            //       Icons.access_time,
                            //       size: 20.r,
                            //       color: AppButton.color,
                            //     ),
                            //     const SizeBoxTemp(height: 0, width: 5),
                            //     const AppTextStyle(
                            //       name: '20-8-2022',
                            //       fontWeight: FontWeight.w500,
                            //       fontSize: 13,
                            //       color: AppButton.color,
                            //     ),
                            //     const SizeBoxTemp(height: 0, width: 15),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizeBoxTemp(height: 5.h, width: 0);
          },
          itemCount: controller.faqs['list'].length),
    );
  }
}
