import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_right.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/widgets/card_item_home.dart';

import '../../server/app_get/app_get.dart';
import '../../server/getx_controller/getx_data_auth.dart';
import '../../value/colors.dart';
import '../../widgets/app_style_text.dart';

class ViewedProductsScreen extends StatefulWidget {
  const ViewedProductsScreen({Key? key}) : super(key: key);

  @override
  State<ViewedProductsScreen> createState() => _ViewedProductsScreenState();
}

class _ViewedProductsScreenState extends State<ViewedProductsScreen> {
  List<Map<String, dynamic>> dataProduct = [
    {
      'image':
          'https://m.media-amazon.com/images/I/711Swf5efNL._AC_SL1500_.jpg',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'price': '1250',
      'name_ar': '\nلينوفا 2022',
      'name_en': '\nLenovo - 2022 ',
    },
    {
      'name_ar': '\nأيسر نيترو 5',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nAcer Nitro 5 ',
      'image':
          'https://m.media-amazon.com/images/I/81bc8mA3nKL._AC_SL1500_.jpg',
      'price': '1000',
    },
    {
      'name_ar': '\nأيسر نيترو 5',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nAcer Nitro 5 ',
      'image':
          'https://m.media-amazon.com/images/I/81bc8mA3nKL._AC_SL1500_.jpg',
      'price': '1000',
    },
    {
      'name_ar': '\nلينوفا 2022',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nLenovo - 2022 ',
      'image':
          'https://m.media-amazon.com/images/I/711Swf5efNL._AC_SL1500_.jpg',
      'price': '1250',
    },
  ];
  AppGet appGet = Get.find();

  late GetxControllerGetDataAuth controller;

  @override
  void initState() {
    Get.put(AppGet(), permanent: true);

    Get.put(GetxControllerGetDataAuth(), permanent: true);
    controller = Get.find();
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
            name: 'المنتجات',
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
      body: ListView(
        children: [
          SizedBox(
            height: 18.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: FadeInRight(
              child: Obx(() {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                      mainAxisExtent: 320.h),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.subCategoryProduct['list'].length,
                  itemBuilder: (context, index) {
                    return CardItemHomeWidget(
                      controller.subCategoryProduct['list'][index],
                      isFav: controller.subCategoryProduct['list'][index]
                          ['is_favorite'],
                    );
                  },
                );
              }),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
        ],
      ),
    );
  }
}
