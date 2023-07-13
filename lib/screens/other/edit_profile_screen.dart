import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/custom_image.dart';
import 'package:sohaib_store/widgets/row_edit.dart';

import '../main_screen/sub_page/home_page.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: AppColors.appColor
    // ));
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: AppColors.white,

      appBar: AppBar(
        elevation: 0,
        // toolbarHeight: 100.h,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(10.r),
        //         bottomRight: Radius.circular(10.r))),
        backgroundColor: AppColors.appColor,
        leadingWidth: 100.w,
        leading: TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 30.r,
            ),
            label: AppTextStyle(
              name: 'رجوع',
              color: Colors.white,
              fontSize: 20.sp,
            )),
      ),
      body: ListView(
        // shrinkWrap: true,
        // padding: EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r)),
                    color: AppColors.appColor),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  padding: EdgeInsets.all(3.r),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.white
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.only(
                      //         bottomLeft: Radius.circular(10.r),
                      //         bottomRight: Radius.circular(10.r))),

                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(8.r),
                      ),
                  child: SizedBox(
                    height: 28.h,
                    width: 28.w,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => ShimmerImage(context),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextStyle(
                      name: 'أحمد علي إبراهيم',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      isMarai: false,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomSvgImage(
                      imageName: 'edit',
                      height: 14.h,
                      width: 14.h,
                      color: AppColors.appColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 28.h,
                ),
                Divider(
                  height: 15.h,
                  color: AppColors.greyC,
                ),
                RowEdit(
                    title: 'العنوان', hint: '25 شارع الملكة - فيصل - الجيزة'),
                Divider(
                  height: 5.h,
                  color: AppColors.greyC,
                ),
                RowEdit(
                  title: 'التقييم العام',
                  hint: 'جيد جدا',
                  visible: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
