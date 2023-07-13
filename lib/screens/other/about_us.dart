import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sohaib_store/widgets/size_box.dart';

import '../../value/colors.dart';
import '../../widgets/app_style_text.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  late TextEditingController _message;

  @override
  void initState() {
    _message = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  static var face = SvgPicture.asset(
    "assets/svg/facebook.svg",
  );

  static var twitter = SvgPicture.asset(
    "assets/svg/twitter.svg",
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.appColor),
        leading: Container(
            margin:
                EdgeInsetsDirectional.only(top: 0.h, bottom: 0.h, start: 5.w),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizeBoxTemp(height: 31, width: 0),

          FadeInUp(
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              width: 200.w,
              child: FadeInDown(
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.h),
                  child: FlutterLogo(
                    curve: Curves.bounceInOut,
                    size: 80.r,
                  ),
                ),

                // image: AssetImage("images/logo.png")
              ),
            ),
          ),
          const SizeBoxTemp(height: 50, width: 0),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 2,
                      offset: const Offset(0, 0),
                      blurRadius: 4),
                ],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade50)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                    child: AppTextStyle(
                        color: Colors.black, name: 'عن التطبيق', fontSize: 22)),
                const SizeBoxTemp(height: 20, width: 0),
                const AppTextStyle(
                  textAlign: TextAlign.center,
                  color: Colors.black,
                  name:
                      ''' تستطيع الأفراد والمتاجر الأخرى من خلال التطبيق عرض منتجاتهم لأكبر عدد ممكن من الزبائن الذين يرغبون بشراء مشغولات التطريز والتحف والهدايا والتراثية، والتي تعبر عن ثقافة وتراث فلسطين. من خلال عرض أفضل السلع وبأسعار مناسبة، مع إمكانية توصيل المنتجات في غزة والضفة حاليًا، كما نسعى في الوقت القريب إمكانية توفير المنتجات الوطنية إلى دول الجوار. ''',
                  fontSize: 16,
                ),
                const SizeBoxTemp(height: 35, width: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: face,
                      onPressed: () {},
                      iconSize: 40,
                    ),
                    IconButton(
                      icon: twitter,
                      onPressed: () {},
                      iconSize: 40,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizeBoxTemp(height: 10, width: 0),

          const Spacer(),
          // FadeInDown(
          //   child: MaterialButton(
          //     minWidth: double.infinity,
          //     onPressed: () {
          //       setState(() {
          //         _isLoading = true;
          //       });
          //
          //       Future.delayed(Duration(seconds: 2), () {
          //         setState(() {
          //           _isLoading = false;
          //         });
          //         // Navigator.push(context, MaterialPageRoute(builder: (context) => Verificatoin()));
          //       });
          //     },
          //     color: Colors.black,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(2)),
          //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          //     child: _isLoading
          //         ? Container(
          //             width: 20,
          //             height: 20,
          //             child: CircularProgressIndicator(
          //               backgroundColor: Colors.white,
          //               color: Colors.black,
          //               strokeWidth: 2,
          //             ),
          //           )
          //         : AppTextStyle(
          //             name: "تواصل عبر الواتس اب",
          //             color: Colors.white,
          //             fontSize: 17,
          //           ),
          //   ),
          // ),
        ],
      ),
    ));
  }
}
