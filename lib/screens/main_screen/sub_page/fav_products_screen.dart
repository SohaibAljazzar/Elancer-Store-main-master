import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_right.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/widgets/card_item_home.dart';
import 'package:sohaib_store/widgets/no_data.dart';

import '../../../server/app_get/app_get.dart';
import '../../../server/getx_controller/getx_data_auth.dart';

class FavProductsScreen extends StatefulWidget {
  const FavProductsScreen({Key? key}) : super(key: key);

  @override
  State<FavProductsScreen> createState() => _FavProductsScreenState();
}

class _FavProductsScreenState extends State<FavProductsScreen> {
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
  late GetxControllerGetDataAuth controller;

  @override
  void initState() {
    Get.put(AppGet(), permanent: true);
    controller = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 18.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: FadeInRight(
            child: Obx(() {
              if (controller.favorite['list'].isNotEmpty) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 350.h),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.favorite['list'].length,
                  itemBuilder: (context, index) {
                    return CardItemHomeWidget(
                      controller.favorite['list'][index],
                      isFav: true,
                    );
                  },
                );
              } else {
                return const NoData();
              }
            }),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }
}
