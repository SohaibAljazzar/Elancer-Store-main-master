// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_right.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:sohaib_store/preferences/app_preferences.dart';
import 'package:sohaib_store/value/colors.dart';

import '../../server/app_get/app_get.dart';
import '../../server/getx_controller/getx_data_auth.dart';
import '../../widgets/app_style_text.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  AppGet appGet = Get.find();
  late GetxControllerGetDataAuth controller;
  List<Map<String, dynamic>> dataProduct = [
    {
      'image':
          'https://m.media-amazon.com/images/I/711Swf5efNL._AC_SL1500_.jpg',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'price': '1250',
      'name_ar': '\nلينوفا 2022',
      'name_en': '\nLenovo - 2022 ',
      'isFav': true
    },
    {
      'name_ar': '\nأيسر نيترو 5',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nAcer Nitro 5 ',
      'image':
          'https://m.media-amazon.com/images/I/81bc8mA3nKL._AC_SL1500_.jpg',
      'price': '1000',
      'isFav': true,
    },
    {
      'name_ar': '\nأيسر نيترو 5',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nAcer Nitro 5 ',
      'image':
          'https://m.media-amazon.com/images/I/81bc8mA3nKL._AC_SL1500_.jpg',
      'price': '1000',
      'isFav': true
    },
    {
      'name_ar': '\nلينوفا 2022',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nLenovo - 2022 ',
      'image':
          'https://m.media-amazon.com/images/I/711Swf5efNL._AC_SL1500_.jpg',
      'price': '1250',
      'isFav': false
    },
    {
      'name_ar': '\nلينوفا 2022',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nLenovo - 2022 ',
      'image':
          'https://m.media-amazon.com/images/I/711Swf5efNL._AC_SL1500_.jpg',
      'price': '1250',
      'isFav': false
    },
    {
      'name_ar': '\nلينوفا 2022',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nLenovo - 2022 ',
      'image':
          'https://m.media-amazon.com/images/I/711Swf5efNL._AC_SL1500_.jpg',
      'price': '1250',
      'isFav': false
    },
    {
      'name_ar': '\nلينوفا 2022',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nLenovo - 2022 ',
      'image':
          'https://m.media-amazon.com/images/I/711Swf5efNL._AC_SL1500_.jpg',
      'price': '1250',
      'isFav': false
    },
    {
      'name_ar': '\nلينوفا 2022',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nLenovo - 2022 ',
      'image':
          'https://m.media-amazon.com/images/I/711Swf5efNL._AC_SL1500_.jpg',
      'price': '1250',
      'isFav': false
    },
    {
      'name_ar': '\nلينوفا 2022',
      'sub_name_ar': 'لابتوب احترافي',
      'sub_name_en': 'Gaming Laptops',
      'name_en': '\nLenovo - 2022 ',
      'image':
          'https://m.media-amazon.com/images/I/711Swf5efNL._AC_SL1500_.jpg',
      'price': '1250',
      'isFav': false
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
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
            name: 'التصنيفات الفرعية',
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
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: FadeInRight(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200.h),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: appGet.subCategory['list'].length,
                itemBuilder: (context, index) {
                  return buildAspectRatio(appGet.subCategory['list'][index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAspectRatio(item) {
    return GestureDetector(
      onTap: () async {
        SVProgressHUD.show();

        //ToDo: get list products sub category
        await controller.getSubCategoryProducts(item['id']);

        SVProgressHUD.dismiss();

        await Navigator.pushNamed(context, '/viewed_product_screen');
      },
      child: Column(
        children: [
          SizedBox(
            width: 120.w,
            height: 180.h,
            child: Card(
              margin: EdgeInsetsDirectional.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ImageNetwork(
                      onTap: () async {
                        SVProgressHUD.show();

                        await controller.getSubCategoryProducts(item['id']);
                        SVProgressHUD.dismiss();

                        Navigator.pushNamed(context, '/viewed_product_screen');
                      },
                      imageCache: CachedNetworkImageProvider(
                        item['image_url'],
                        maxHeight: 120,
                        maxWidth: 120,
                      ),
                      image: item['image_url'],
                      width: 120.w,
                      height: 120.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextStyle(
                      name: AppPreferences().getLanguageCode == 'ar'
                          ? item['name_ar']
                          : item['name_en'],
                      color: Colors.grey.shade800,
                      fontSize: 12.sp,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
