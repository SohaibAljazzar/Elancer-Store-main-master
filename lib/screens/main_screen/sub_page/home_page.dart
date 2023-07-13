// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sohaib_store/main.dart';
import 'package:sohaib_store/preferences/app_preferences.dart';
import 'package:sohaib_store/server/app_get/app_get.dart';
import 'package:sohaib_store/server/getx_controller/getx_data_auth.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/size_box.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/card_item_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  AppGet appGet = Get.find();

  List<Map<String, dynamic>> dataCategory = [
    {
      'name_en': 'Gaming Laptops',
      'name_ar': 'لابتوبات احترافية',
      'image': 'https://cdn.mos.cms.futurecdn.net/dkEx6momy9WazkfwuPRLJW.png',
    },
    {
      'name_en': 'Electric Machines',
      'name_ar': 'اجهزة كهربائية',
      'image':
          'https://blackseagrp.com/wp-content/uploads/2022/01/istockphoto-1174598609-612x612-1.jpg',
    },
  ];

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
  ];

  List<Widget> images = [];
  Timer? timer;
  late AnimationController _animationController;
  int _currentPage = 0;
  final controllerPageView =
      PageController(viewportFraction: 1, keepPage: true);

  final ScrollController _scrollControllerOne = ScrollController();
  final ScrollController _scrollControllerTow = ScrollController();
  late GetxControllerGetDataAuth controller;
  @override
  void initState() {
    controller = Get.find();
    getOffer();
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset(); //Reset the controller
        final int page = images.length; //Number of pages in your PageView
        if (_currentPage < page) {
          _currentPage++;
          controllerPageView.animateToPage(_currentPage,
              duration: const Duration(seconds: 2), curve: Curves.easeIn);
          if (_currentPage == page) {
            if (mounted) {
              setState(() {
                _currentPage = -1;
              });
            }
          }
        } else {
          _currentPage = 0;
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    controllerPageView.dispose();
    controller.getOffer();
    controller.getHome();
    controller.getFavorite();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(); //St
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: Colors.white,
        showLeading: false,
        showTrailing: false,
        child: CustomScrollView(
            controller: _scrollController,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shrinkWrap: true,
            scrollBehavior: MyCustomScrollBehavior(),
            physics: const ClampingScrollPhysics(),
            //physics of the scroll

            slivers: [
              SliverFillRemaining(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Colors.white,
                    child: ListView(
                      controller: _scrollControllerOne,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 10.h),
                            FadeInDown(
                              child: SizedBox(
                                height: 200.h,
                                child: NotificationListener<
                                    OverscrollNotification>(
                                  onNotification: (notification) =>
                                      notification.metrics.axisDirection !=
                                      Axis.horizontal,
                                  child: PageView.builder(
                                    scrollBehavior: MyCustomScrollBehavior(),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    allowImplicitScrolling: true,
                                    controller: controllerPageView,
                                    padEnds: true,
                                    pageSnapping: true,
                                    itemCount: images.length,
                                    itemBuilder: (_, index) {
                                      return images[index % images.length];
                                    },
                                    onPageChanged: (value) {
                                      _currentPage = value;
                                      //When page change, start the controller
                                      _animationController.forward();
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizeBoxTemp(height: 20.h, width: 0),
                            FadeInUp(
                              child: SmoothPageIndicator(
                                controller: controllerPageView,
                                count: images.length,
                                effect: ExpandingDotsEffect(
                                  spacing: 4.0.r,
                                  radius: 6.0.r,
                                  dotHeight: 8.0.h,
                                  dotWidth: 20.w,
                                  paintStyle: PaintingStyle.fill,
                                  dotColor: const Color(0xffc1c1c2),
                                  activeDotColor: const Color(0xff0F5DAB),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                        FadeInRight(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AppTextStyle(
                                    name: 'التصنيفات',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17.sp),
                                SizedBox(
                                  width: 25.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: GestureDetector(
                                    onTap: () async {
                                      SVProgressHUD.show();

                                      await controller.getHome();
                                      await controller.getOffer();
                                      SVProgressHUD.dismiss();

                                      await Navigator.pushNamed(
                                          context, '/category_screen');
                                    },
                                    child: AppTextStyle(
                                      name: 'عرض المزيد',
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.only(
                            top: 20.h,
                            start: 10.w,
                          ),
                          height: 140.h,
                          width: double.infinity,
                          child: NotificationListener<OverscrollNotification>(
                            onNotification: (notification) =>
                                notification.metrics.axisDirection !=
                                Axis.horizontal,
                            child: GetX<GetxControllerGetDataAuth>(
                              init: controller,
                              builder: (controller) {
                                return ListView.builder(
                                  controller: _scrollControllerTow,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                      .home['data']['categories'].length,
                                  physics: const ClampingScrollPhysics(),
                                  //physics of the scroll
                                  itemBuilder: (context, index) {
                                    return AspectRatio(
                                      aspectRatio: 0.88,
                                      child: GestureDetector(
                                        onTap: () async {
                                          SVProgressHUD.show();

                                          await controller.getSubCategory(
                                              controller.home['data']
                                                  ['categories'][index]['id']);
                                          SVProgressHUD.dismiss();

                                          await Navigator.pushNamed(
                                              context, '/sub_category_screen');
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              width: 75.w,
                                              height: 80.h,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                              ),
                                              child: Center(
                                                child: ImageNetwork(
                                                  onTap: () async {
                                                    SVProgressHUD.show();

                                                    await controller
                                                        .getSubCategory(controller
                                                                        .home[
                                                                    'data']
                                                                ['categories']
                                                            [index]['id']);
                                                    SVProgressHUD.dismiss();

                                                    await Navigator.pushNamed(
                                                        context,
                                                        '/sub_category_screen');
                                                  },
                                                  imageCache:
                                                      CachedNetworkImageProvider(
                                                    controller.home['data']
                                                            ['categories']
                                                        [index]['image_url'],
                                                    maxHeight: 80,
                                                    maxWidth: 75,
                                                  ),
                                                  image: controller.home['data']
                                                          ['categories'][index]
                                                      ['image_url'],
                                                  width: 75.w,
                                                  height: 80.h,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            AppTextStyle(
                                              name: AppPreferences()
                                                          .getLanguageCode ==
                                                      'ar'
                                                  ? controller.home['data']
                                                          ['categories'][index]
                                                      ['name_ar']
                                                  : controller.home['data']
                                                          ['categories'][index]
                                                      ['name_en'],
                                              color: Colors.grey.shade800,
                                              fontSize: 12.sp,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        FadeInRight(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AppTextStyle(
                                    name: 'منتجات جديدة',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17.sp),
                                SizedBox(
                                  width: 25.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                // Align(
                                //   alignment: AlignmentDirectional.centerEnd,
                                //   child: GestureDetector(
                                //     onTap: () {},
                                //     child: AppTextStyle(
                                //       name: 'عرض المزيد',
                                //       fontSize: 12.sp,
                                //       color: Colors.grey.shade800,
                                //       fontWeight: FontWeight.w400,
                                //     ),
                                //   ),
                                // ),
                              ]),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: FadeInRight(
                            child: Obx(() {
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 7,
                                        mainAxisSpacing: 10,
                                        mainAxisExtent: 320.h),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller
                                    .home['data']['latest_products'].length,
                                itemBuilder: (context, index) {
                                  return CardItemHomeWidget(
                                    controller.home['data']['latest_products']
                                        [index],
                                    isFav: controller.home['data']
                                            ['latest_products'][index]
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
                        FadeInRight(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AppTextStyle(
                                    name: 'منتجات قد تعجبك',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17.sp),
                                SizedBox(
                                  width: 25.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                // Align(
                                //   alignment: AlignmentDirectional.centerEnd,
                                //   child: GestureDetector(
                                //     onTap: () {},
                                //     child: AppTextStyle(
                                //       name: 'عرض المزيد',
                                //       fontSize: 12.sp,
                                //       color: Colors.grey.shade800,
                                //       fontWeight: FontWeight.w400,
                                //     ),
                                //   ),
                                // ),
                              ]),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: FadeInRight(
                            child: Obx(() {
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 7,
                                        mainAxisSpacing: 7,
                                        mainAxisExtent: 320.h),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller
                                    .home['data']['famous_products'].length,
                                itemBuilder: (context, index) {
                                  return CardItemHomeWidget(
                                    controller.home['data']['famous_products']
                                        [index],
                                    isFav: controller.home['data']
                                            ['famous_products'][index]
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
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  void getOffer() async {
    for (int i = 0; i < controller.offer['list'].length; i++) {
      images.add(AdsWidget(
        controller.offer['list'][i]['image_url'],
        controller.offer['list'][i]['discount_ratio'],
      ));
    }
  }

// void getServerData() async {
//   await ServerData().getOffer();
//   await ServerData().getHome();
//   getOffer();
// }
}

class AdsWidget extends StatefulWidget {
  final String url;
  final String discount;

  const AdsWidget(this.url, this.discount, {super.key});

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  @override
  Widget build(BuildContext context) {
    return AppPreferences().getLanguageCode == 'ar'
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w),
            child: SizedBox(
              height: 230.h,
              child: Card(
                margin: EdgeInsetsDirectional.zero,
                clipBehavior: Clip.antiAlias,
                elevation: 5.2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                shadowColor: Colors.black26,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 230.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: CachedNetworkImage(
                            // buildContext: context,
                            width: MediaQuery.of(context).size.width.w * 0.5,
                            imageUrl: widget.url,
                            imageBuilder: (context, imageProvider) => Card(
                              margin: EdgeInsetsDirectional.zero,
                              clipBehavior: Clip.antiAlias,
                              elevation: 5.2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                              shadowColor: Colors.black26,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width.w * 0.5,
                                padding: EdgeInsetsDirectional.zero,
                                margin: EdgeInsetsDirectional.zero,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                ShimmerImage(context),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.zero,
                        child: Container(
                            height: 230.h,
                            // color: Colors.black.withOpacity(0.2),
                            padding: EdgeInsets.only(left: 0, bottom: 0.h),
                            alignment: AlignmentDirectional.topStart,
                            width: double.infinity,
                            child: SizedBox(
                              height: 230.h,
                              width: MediaQuery.of(context).size.width.w * 0.51,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.zero,
                                  bottomLeft: Radius.zero,
                                  topRight: Radius.circular(5.r),
                                  bottomRight: Radius.circular(5.r),
                                )),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsetsDirectional.zero,
                                color: const Color(0xffE2E9F0),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shrinkWrap: true,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    FadeInRight(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0.w),
                                        child: AppTextStyle(
                                          name:
                                              'خصم على ${widget.discount}% جميع المنتجات',
                                          color: const Color(0xff0F5DAB),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    FadeInRight(
                                      child: AppTextStyle(
                                        name: 'تنزيلات نهاية الموسم',
                                        color: const Color(0xff8B9FB3),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    FadeInUp(
                                      child: SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width
                                                .w *
                                            0.35,
                                        height: 41.h,
                                        child: AppButton(
                                          title: 'اشتري الان',
                                          onPressed: () {
                                            //ToDo:get to main page
                                            // Get.offAll(const MainScreen());
                                          },
                                          visible: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w),
            child: SizedBox(
              height: 230.h,
              child: Card(
                margin: EdgeInsetsDirectional.zero,
                clipBehavior: Clip.antiAlias,
                elevation: 5.2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                shadowColor: Colors.black26,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 230.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: CachedNetworkImage(
                            // buildContext: context,
                            width: MediaQuery.of(context).size.width.w * 0.5,
                            imageUrl: widget.url,
                            imageBuilder: (context, imageProvider) => Card(
                              margin: EdgeInsetsDirectional.zero,
                              clipBehavior: Clip.antiAlias,
                              elevation: 5.2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                              shadowColor: Colors.black26,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width.w * 0.5,
                                padding: EdgeInsetsDirectional.zero,
                                margin: EdgeInsetsDirectional.zero,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                ShimmerImage(context),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.zero,
                        child: Container(
                            height: 230.h,
                            // color: Colors.black.withOpacity(0.2),
                            padding: EdgeInsets.only(left: 0, bottom: 0.h),
                            alignment: AlignmentDirectional.topStart,
                            width: double.infinity,
                            child: SizedBox(
                              height: 230.h,
                              width: MediaQuery.of(context).size.width.w * 0.51,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topRight: Radius.zero,
                                  bottomRight: Radius.zero,
                                  topLeft: Radius.circular(5.r),
                                  bottomLeft: Radius.circular(5.r),
                                )),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsetsDirectional.zero,
                                color: const Color(0xffE2E9F0),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shrinkWrap: true,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    FadeInRight(
                                      child: AppTextStyle(
                                        name: 'تنزيلات نهاية الموسم',
                                        color: const Color(0xff8B9FB3),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    FadeInRight(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0.w),
                                        child: AppTextStyle(
                                          name:
                                              'خصم على ${widget.discount}% جميع المنتجات',
                                          color: const Color(0xff0F5DAB),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    FadeInUp(
                                      child: SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width
                                                .w *
                                            0.35,
                                        height: 41.h,
                                        child: AppButton(
                                          title: 'اشتري الان',
                                          onPressed: () {
                                            //ToDo:get to main page
                                            // Get.offAll(const MainScreen());
                                          },
                                          visible: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class ShimmerImage extends StatelessWidget {
  BuildContext context;

  ShimmerImage(this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.only(start: 0.w, end: 0.w),
        child: Shimmer.fromColors(
          baseColor: Colors.blue.withOpacity(0.3),
          highlightColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff0F5DAB),
                  borderRadius: BorderRadius.circular(10.r)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ));
  }
}
