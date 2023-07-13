// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/row_icon_abstract.dart';
import 'package:sohaib_store/widgets/size_box.dart';

import '../../../widgets/app_style_text.dart';
import '../../server/app_get/app_get.dart';
import '../../server/getx_controller/getx_data_auth.dart';

// ignore: must_be_immutable
class NewOrder extends StatefulWidget {
  const NewOrder({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  NewOrderState createState() => NewOrderState();
}

class NewOrderState extends State<NewOrder> {
  GetxControllerGetDataAuth controller = Get.find();

  AppGet appGet = Get.find();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColors.appColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: AppColors.appColor),
        title: const AppTextStyle(
          name: '',
          fontSize: 18,
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
              itemCount: controller.orders['list'].length,
              physics: const ScrollPhysics(),
              padding: EdgeInsetsDirectional.zero,
              itemBuilder: (context, index) {
                return InkWell(
                    onLongPress: () {},
                    onTap: () async {
                      SVProgressHUD.show();
                      await controller.getOrderDetails(
                          controller.orders['list'][index]['id']);
                      Navigator.pushNamed(context, '/order_details');
                      SVProgressHUD.dismiss();
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        color: Colors.white,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: controller.orders['list'][index]
                                                ['status']
                                            .toString() ==
                                        'Waiting'
                                    ? AppColors.orangeLogo
                                    : controller.orders['list'][index]['status']
                                                .toString() ==
                                            'Processing'
                                        ? Colors.greenAccent.shade700
                                        : AppColors.appColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizeBoxTemp(height: 0, width: 10),
                                  AppTextStyle(
                                    name: controller.orders['list'][index]['id']
                                        .toString(),
                                    color: Colors.white,
                                    textAlign: TextAlign.start,
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppTextStyle(
                                      name: 'بيانات الطلب', fontSize: 19),
                                  const SizeBoxTemp(height: 17, width: 0),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: RowIconAbstract(
                                            title: controller.orders['list']
                                                    [index]['payment_type']
                                                .toString(),
                                            iconData: Icons.credit_card),
                                      ),
                                      // SizeBoxTemp(height: 10, width: 0),
                                      Expanded(
                                        child: RowIconAbstract2(
                                            title: controller.orders['list']
                                                    [index]['total']
                                                .toString(),
                                            iconData: Images.israel),
                                      ),
                                      // SizeBoxTemp(height: 10, width: 0),
                                    ],
                                  ),
                                  const SizeBoxTemp(height: 15, width: 0),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: RowIconAbstract(
                                            title: controller.orders['list']
                                                    [index]['date']
                                                .toString()
                                                .substring(0, 10),
                                            iconData: Icons.date_range_sharp),
                                      ),
                                      Expanded(
                                        child: RowIconAbstract(
                                            title: controller.orders['list']
                                                    [index]['status']
                                                .toString(),
                                            iconData: Icons.check),
                                      ),
                                    ],
                                  ),
                                  const SizeBoxTemp(height: 15, width: 0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              })),
    );
  }
}

class Images {
  static SvgPicture israel = SvgPicture.asset(
    "images/is.svg",
  );
}
