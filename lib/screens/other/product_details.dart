import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:sohaib_store/server/app_get/app_get.dart';
import 'package:sohaib_store/server/data/server_data_with_auth.dart';
import 'package:sohaib_store/server/getx_controller/getx_data_auth.dart';
import 'package:sohaib_store/utils/helpers.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/product_count.dart';

import '../../widgets/app_style_text.dart';
import '../../widgets/current_page.dart';
import '../../widgets/size_box.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
  }) : super(key: key);

  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> with Helpers {
  late PageController _pageController;
  int _currentPage = 0;
  bool isEnableClick = true;
  bool active = false;
  late bool activeFav = false;
  late double valueRating;
  AppGet appGet = Get.find();
  late GetxControllerGetDataAuth controller;
  int qty = 1;
  late bool status;

  @override
  void initState() {
    // TODO: implement initState
    Get.put(AppGet(), permanent: true);

    Get.put(GetxControllerGetDataAuth(), permanent: true);
    controller = Get.find();
    _pageController = PageController();
    valueRating = double.parse(
        appGet.productDetails['object']['product_rate'].toString());
    status = appGet.productDetails['object']['is_favorite'];
    getProdImages();
    getProdCont();
    controller.getOffer();
    controller.getHome();
    controller.getFavorite();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.getOffer();
    controller.getHome();
    controller.getFavorite();
    super.dispose();
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
            name: 'تفاصيل المنتج',
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
        actions: [
          Obx(() {
            return IconButton(
                padding: EdgeInsetsDirectional.only(
                    end: 20.w, top: 10.h, bottom: 10.h),
                onPressed: () async {
                  await ServerDataWithAuth().addFavorite(
                      context: context,
                      productId: appGet.productDetails['object']['id']);
                },
                icon: Center(
                  child: Icon(
                    Icons.favorite,
                    size: 30.r,
                  ),
                ),
                color: appGet.productDetails['object']['is_favorite']
                    ? Colors.redAccent
                    : Colors.grey);
          }),
        ],
      ),
      backgroundColor: const Color(0xffFCFCFC),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 31.h),
        child: SizedBox(
          // height: 1000,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          // padding: EdgeInsets.symmetric(vertical: 25.h),
                          alignment: AlignmentDirectional.topStart,
                          // width: double.infinity,
                          // height: double.infinity,
                          // width: 450,
                          height: 300,
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.0.h),
                            child: SizedBox(
                              width: 600,
                              height: 300,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                    child: PageView(
                                      controller: _pageController,
                                      onPageChanged: (int page) {
                                        setState(() {
                                          _currentPage = page;
                                        });
                                      },
                                      scrollDirection: Axis.horizontal,
                                      children: getProdImages(),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10.h,
                                    right: 0,
                                    left: 0,
                                    child: Visibility(
                                      visible: getProdCont().length > 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: getProdCont(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Divider(
                          height: 10,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0.w),
                                      child: SizedBox(
                                        width: 240.w,
                                        child: AppTextStyle(
                                          name: appGet.productDetails['object']
                                              ['name_ar'],
                                          fontSize: 20.sp,
                                          count: 3,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          color: const Color(0xFF132762),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                AppTextStyle(
                                  name:
                                      ' ${appGet.productDetails['object']['price']} شيكل ',
                                  fontSize: 18.sp,
                                  color: const Color(0xFF132762),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Divider(
                          height: 10,
                          color: Colors.grey.shade300,
                        ),
                        SizeBoxTemp(height: 13.h, width: 0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: AppTextStyle(
                            name: 'الوصف',
                            fontSize: 18.sp,
                            color: const Color(0xFF31323B),
                          ),
                        ),
                        SizeBoxTemp(height: 10.h, width: 0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: AppTextStyle(
                            name: appGet.productDetails['object']['info_ar'],
                            fontSize: 16.sp,
                            count: 100,
                            overflow: TextOverflow.ellipsis,
                            color: const Color(0xFF9D9DA8),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Divider(
                          height: 10,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: Row(
                            children: [
                              AppTextStyle(
                                name: 'التقييم :',
                                fontSize: 20.sp,
                                count: 100,
                                overflow: TextOverflow.ellipsis,
                                color: const Color(0xFF31323B),
                              ),
                              SizedBox(width: 10.w),
                              Obx(() {
                                return AppTextStyle(
                                  name: appGet.productDetails['object']
                                      ['overal_rate'],
                                  fontSize: 18.sp,
                                  count: 100,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.appColor,
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        RatingBar.builder(
                          initialRating: valueRating,
                          itemSize: 40.r,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          allowHalfRating: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) async {
                            if (mounted) {
                              setState(() {
                                valueRating = rating;
                              });
                              await ServerDataWithAuth().updateRateProduct(
                                  context: context,
                                  rateValue: rating,
                                  productId: appGet.productDetails['object']
                                      ['id']);
                            }
                            debugPrint(rating.toString());
                          },
                        ),
                        SizedBox(height: 10.h),
                        Divider(
                          height: 10,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //ToDo:Here qty
                              AppTextStyle(
                                name: 'الكمية : ',
                                fontSize: 20.sp,
                                count: 100,
                                overflow: TextOverflow.ellipsis,
                                color: const Color(0xFF31323B),
                              ),
                              SizedBox(width: 10.w),

                              Row(
                                children: [
                                  ProductCount(
                                    icon: Icons.add,
                                    size: 20,
                                    count: () {
                                      if (checkQty()) {
                                        setState(() {
                                          qty++;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(width: 5.w),
                                  AppTextStyle(
                                    name: qty.toString(),
                                    color: AppColors.appColor,
                                  ),
                                  SizedBox(width: 5.w),
                                  ProductCount(
                                    icon: Icons.remove,
                                    size: 20,
                                    count: () {
                                      if (qty > 1) {
                                        setState(() {
                                          qty--;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Divider(
                          height: 10,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MaterialButton(
                                onPressed: () async {
                                  // await openWhatsApp();
                                },
                                height: 70.h,
                                minWidth: double.infinity,
                                color: AppColors.appColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: AppTextStyle(
                                  name: 'اضافة الى السلة',
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getProdCont() {
    List<Widget> list = <Widget>[];
    for (int i = 0; i < appGet.productDetails['object']['images'].length; i++) {
      list.add(
        CurrentPage(selected: _currentPage == i),
      );
    }
    return list;
  }

  List<Widget> getProdImages() {
    List<Widget> list = <Widget>[];
    for (int i = 0; i < appGet.productDetails['object']['images'].length; i++) {
      list.add(
        ImageNetwork(
          fitAndroidIos: BoxFit.cover,
          onTap: () async {},
          imageCache: CachedNetworkImageProvider(
            appGet.productDetails['object']['images'][i]['image_url'],
            maxHeight: 500,
            maxWidth: 120,
          ),
          image: appGet.productDetails['object']['images'][i]['image_url'],
          width: 120.w,
          height: 500.h,
        ),
      );
    }
    return list;
  }

  List<String> listData(List<String> data, String typeAvailable) {
    List<String> dataProduct = [];
    for (int i = 0; i < data.length; i++) {
      String p = data[i];
      debugPrint("here image url is $p");
      dataProduct.add(p);
    }
    return dataProduct;
  }

  bool checkQty() {
    if (qty < int.parse(appGet.productDetails['object']['quantity'])) {
      return true;
    }
    log('false');

    showSnackBar(context: context, message: 'لا يوجد كمية كافية', error: true);
    return false;
  }
}
