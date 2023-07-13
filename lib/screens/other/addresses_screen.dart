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

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
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
            name: 'العناوين',
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_address_screen');
          },
          backgroundColor: AppColors.appColor,
          child: Icon(
            Icons.add,
            size: 40.r,
            color: Colors.white,
          )),
      backgroundColor: Colors.white,
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
                          Icons.location_city,
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
                              name: controller.addresses['list'][index]['name']
                                  .toString(),
                              color: AppButton.color,
                              fontSize: 17,
                            ),
                            AppTextStyle(
                              name: controller.addresses['list'][index]['info']
                                  .toString(),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              count: 16,
                              color: AppButton.color,
                            ),
                            AppTextStyle(
                              name: controller.addresses['list'][index]
                                      ['contact_number']
                                  .toString(),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              count: 16,
                              color: AppButton.color,
                            ),
                            SizeBoxTemp(height: 10, width: 0),
                            Row(
                              // mainAxisSize: MainAxisSize.m,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizeBoxTemp(height: 0, width: 5),
                                Icon(
                                  Icons.location_city_outlined,
                                  size: 20.r,
                                  color: AppButton.color,
                                ),
                                const SizeBoxTemp(height: 0, width: 5),
                                AppTextStyle(
                                  name: controller.addresses['list'][index]
                                          ['city']['name_ar']
                                      .toString(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: AppButton.color,
                                ),
                                const SizeBoxTemp(height: 0, width: 15),
                              ],
                            ),
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
          itemCount: controller.addresses['list'].length),
    );
  }
}
