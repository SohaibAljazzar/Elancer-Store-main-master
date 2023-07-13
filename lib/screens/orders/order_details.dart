// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/server/getx_controller/getx_data_auth.dart';
import 'package:sohaib_store/widgets/size_box.dart';

import '../../value/colors.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool isClick = false;
  List<String> userToken = <String>[''];
  GetxControllerGetDataAuth controller = Get.find();

  @override
  void dispose() {
    isClick = false;
    userToken.clear();
    super.dispose();
  }

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
        extendBody: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: const IconThemeData(color: AppColors.appColor),
          title: const Text(
            'تفاصيل الطبية',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.appColor,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Container(
          // padding: EdgeInsets.symmetric(horizontal: SizeConfig().scaleWidth(5)) ,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ]),
          child: SingleChildScrollView(
            child: Column(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  color: Colors.grey.withOpacity(.3),
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                          child: Text(
                        'المنتج',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                          child: Center(
                              child: Text(
                        'الكمية',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
                      Expanded(
                          child: Center(
                              child: Text(
                        'سعر الوحدة',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
                      Expanded(
                          child: Center(
                              child: Text(
                        'الإجمالي',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height.h * 0.72,
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount:
                          controller.orderDetails['data']['products'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                    controller.orderDetails['data']['products']
                                        [index]['name_ar'],
                                    style: TextStyle(
                                        fontSize: 13.sp, color: Colors.black)),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                      controller.orderDetails['data']
                                              ['products'][index]
                                              ['order_quantity']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.black)),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: controller.orderDetails['data']
                                                  ['products'][index]
                                              ['offer_price'] !=
                                          null
                                      ? Text(
                                          ((double.parse(
                                                  controller.orderDetails['data']
                                                          ['products'][index]
                                                      ['offer_price']))
                                              .toString()),
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.black))
                                      : Text(((double.parse(controller.orderDetails['data']['products'][index]['price'])).toString()),
                                          style: TextStyle(fontSize: 13.sp, color: Colors.black)),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: controller.orderDetails['data']['products']
                                              [index]['offer_price'] !=
                                          null
                                      ? Text(((double.parse(controller.orderDetails['data']['products'][index]['offer_price']) * int.parse(controller.orderDetails['data']['products'][index]['order_quantity'])).toString()),
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.black))
                                      : Text(
                                          ((double.parse(controller.orderDetails['data']['products'][index]['price']) *
                                                  int.parse(controller.orderDetails['data']
                                                          ['products'][index]
                                                      ['order_quantity']))
                                              .toString()),
                                          style: TextStyle(fontSize: 13.sp, color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Divider(
                  color: Colors.grey.withOpacity(.5),
                  thickness: 3,
                  endIndent: 5,
                  indent: 5,
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('إجمالي المبلغ',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                      Text('${controller.orderDetails['data']['total']} ₪',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                const SizeBoxTemp(height: 20, width: 0),
              ],
            ),
          ),
          // SizedBox(height: SizeConfig().scaleHeight(20),)
        ));
  }
}
