import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/row_icon_abstract.dart';
import 'package:sohaib_store/widgets/size_box.dart';

import '../../../widgets/app_style_text.dart';
import 'order_details.dart';

// ignore: must_be_immutable
class FinishOrder extends StatefulWidget {
  const FinishOrder({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FinishOrderState createState() => _FinishOrderState();
}

class _FinishOrderState extends State<FinishOrder> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
            itemCount: 10,
            physics: const ScrollPhysics(),
            padding: EdgeInsetsDirectional.zero,
            itemBuilder: (context, index) {
              return InkWell(
                  onLongPress: () {},
                  onTap: () async {
                    SVProgressHUD.show();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderDetails(),
                        ));
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
                            decoration: const BoxDecoration(
                              color: AppColors.appColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizeBoxTemp(height: 0, width: 10),
                                AppTextStyle(
                                  name: '15451451',
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
                                          title: 'Cash',
                                          iconData: Icons.credit_card),
                                    ),
                                    // SizeBoxTemp(height: 10, width: 0),
                                    Expanded(
                                      child: RowIconAbstract2(
                                          title: '500',
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
                                          title: '25-8-2022',
                                          iconData: Icons.date_range_sharp),
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
            }));
  }
}

class Images {
  static SvgPicture israel = SvgPicture.asset(
    "images/is.svg",
  );
}
