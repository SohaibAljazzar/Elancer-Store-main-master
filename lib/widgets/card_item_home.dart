// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/preferences/app_preferences.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';

import '../server/app_get/app_get.dart';
import '../server/data/server_data_with_auth.dart';
import '../server/getx_controller/getx_data_auth.dart';
import 'size_box.dart';

class CardItemHomeWidget extends StatefulWidget {
  // final String item;
  final Map<String, dynamic> data;
  bool isFav = false;

  CardItemHomeWidget(this.data, {Key? key, required this.isFav})
      : super(key: key);

  @override
  State<CardItemHomeWidget> createState() => _CardItemHomeWidgetState();
}

class _CardItemHomeWidgetState extends State<CardItemHomeWidget> {
  double value = 3.5;
  AppGet appGet = Get.find();
  late GetxControllerGetDataAuth controller;
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
    return InkWell(
      onTap: () async {
        SVProgressHUD.show();

        //ToDo: get list products sub category
        await controller.getProductDetails(widget.data['id']);

        SVProgressHUD.dismiss();

        await Navigator.pushNamed(context, '/product_details');
      },
      child: ListView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Card(
            elevation: 5.2,
            color: Colors.white,
            shadowColor: Colors.black26,
            // Change this
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ListView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  //           height: 145.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0.r),
                        topRight: Radius.circular(5.0.r),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.data['image_url'],
                        ),
                        fit: BoxFit.cover,
                        // invertColors: true,
                        isAntiAlias: true,
                        // matchTextDirection: true
                      )),
                  child: Transform.translate(
                    offset: const Offset(50, -70),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 65, vertical: 80),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: IconButton(
                            padding: EdgeInsetsDirectional.only(
                                end: 20.w, top: 10.h, bottom: 10.h),
                            onPressed: () async {
                              if (mounted) {
                                setState(() {
                                  widget.isFav = !widget.isFav;
                                  log('isFav is value ===>>. ${widget.isFav}');
                                });
                              }
                              await ServerDataWithAuth().addFavorite(
                                  context: context,
                                  productId: widget.data['id']);
                              await controller.getFavorite();
                            },
                            icon: Center(
                              child: Icon(
                                Icons.favorite,
                                size: 30.r,
                              ),
                            ),
                            color:
                                widget.isFav ? Colors.redAccent : Colors.grey),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 6.5.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizeBoxTemp(height: 10, width: 0),
                        AppTextStyle(
                            name: AppPreferences().getLanguageCode == 'ar'
                                ? widget.data['name_ar']
                                : widget.data['name_en'],
                            fontWeight: FontWeight.w500,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            fontSize: 15.sp),
                        const SizeBoxTemp(height: 6, width: 0),
                        AppTextStyle(
                            name: AppPreferences().getLanguageCode == 'ar'
                                ? widget.data['name_ar']
                                : widget.data['info_en'],
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                            fontSize: 13.sp),
                        const SizeBoxTemp(height: 8, width: 0),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: AppTextStyle(
                                name: '\$${widget.data['price']}',
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff0F5DAB),
                                fontSize: 16.sp),
                          ),
                        ),
                        RatingBar.builder(
                          initialRating:
                              double.parse(widget.data['overal_rate']),
                          glow: true,
                          itemSize: 20.r,
                          updateOnDrag: true,
                          ignoreGestures: true,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          tapOnlyMode: true,
                          allowHalfRating: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            debugPrint(rating.toString());
                          },
                        ),
                        const SizeBoxTemp(height: 15, width: 0),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
