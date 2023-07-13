import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sohaib_store/screens/main_screen/sub_page/home_page.dart';
import 'package:sohaib_store/server/data/server_data_with_auth.dart';
import 'package:sohaib_store/server/model/adderss_model.dart';
import 'package:sohaib_store/server/model/cart_sqk_model.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/app_button.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/custom_image.dart';
import 'package:sohaib_store/widgets/custom_text.dart';
import 'package:sohaib_store/widgets/drop_down_adderss.dart';
import 'package:sohaib_store/widgets/loading2.dart';
import 'package:sohaib_store/widgets/product_count.dart';

import '../../../server/app_get/app_get.dart';
import '../../../server/getx_controller/getx_data_auth.dart';
import '../../../utils/helpers.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Helpers {
  bool loadingButton = false;
  late TextEditingController _holderNameController;
  TextEditingController _nameController = TextEditingController();
  late TextEditingController _cardNumberController;
  late TextEditingController _expDateController;
  late TextEditingController _cvvCodeController;
  String paymentType = 'Cash';
  GetxControllerGetDataAuth controller = Get.find();

  List<Adderss> items = [];
  final _keyAgents = GlobalKey<FormState>();
  Adderss _currentSelectedTypeValue = Adderss(id: 1, name: 'غزة');

  late Adderss userAccountSelected;

  Adderss usersAccount = Adderss(id: 1, name: 'غزة');
  List<Adderss> items2 = [];
  final _keyAgents2 = GlobalKey<FormState>();
  Adderss _currentSelectedTypeValue2 = Adderss(id: 1, name: 'غزة');

  late Adderss userAccountSelected2;

  Adderss usersAccount2 = Adderss(id: 1, name: 'غزة');
  AppGet appGet = Get.find();
  List<CartSqlModel> lis = [];
  //listSql
  // listSql => for => element => element.product_id
  // new map {};
  List<Map<String, dynamic>> cart = [
    {
      'product_id': '1100',
      'quantity': 1,
    },
    {
      'product_id': '1086',
      'quantity': 2,
    },
  ];

  @override
  void initState() {
    usersAccount = Adderss(id: 0, name: 'العنوان');
    usersAccount2 = Adderss(id: 0, name: 'البطاقة');
    // TODO: implement initState
    getAdderss();
    getPayments();
    super.initState();
    _holderNameController = TextEditingController();
    _nameController = TextEditingController();
    _cardNumberController = TextEditingController();
    _expDateController = TextEditingController();
    _cvvCodeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _holderNameController.dispose();
    _cardNumberController.dispose();
    _expDateController.dispose();
    _cvvCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: ListView(
        // padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 73.h,
                        width: 73.w,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://modo3.com/thumbs/fit630x300/102052/1471355375/%D9%83%D9%8A%D9%81%D9%8A%D8%A9_%D8%B9%D9%85%D9%84_%D9%81%D8%AA%D8%A9_%D8%A7%D9%84%D8%AD%D9%85%D8%B5.jpg',
                            // height: 72.h,
                            // width: 72.w,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
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
                      SizedBox(
                        width: 7.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            name: 'وجبة فتة شاورما تكفي 3 أفراد',
                            fontSize: 14.sp,
                            color: AppColors.black,
                            isMarai: false,
                            count: 1,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomSvgImage(
                                imageName: 'maps',
                                // color: AppColors.grey,
                                height: 12.h,
                                width: 7.w,
                              ),
                              AppTextStyle(
                                textAlign: TextAlign.center,
                                name: 'شاورما الريم',
                                isMarai: false,

                                fontSize: 12.sp,
                                color: AppColors.black,
                                // fontWeight: FontWeight.w400,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    size: 20.r,
                                    color: AppColors.appColor,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  AppTextStyle(
                                    textAlign: TextAlign.center,
                                    name: '5.0',
                                    isMarai: false,

                                    fontSize: 15.sp,
                                    color: AppColors.black,
                                    // fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //ToDo:Here qty
                                  Row(
                                    children: [
                                      ProductCount(
                                        icon: Icons.add,
                                        count: () {
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(width: 5.w),
                                      const AppTextStyle(
                                        name: '2',
                                        color: AppColors.appColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      ProductCount(
                                        icon: Icons.remove,
                                        count: () {},
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    width: 3.w,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          SizedBox(
                            height: 60.h,
                            width: 60.w,
                            child: Card(
                              color: AppColors.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppTextStyle(
                                    textAlign: TextAlign.center,
                                    name: '140',
                                    fontSize: 15.sp,
                                    isMarai: false,

                                    height: 1,

                                    color: AppColors.white,
                                    // fontWeight: FontWeight.w400,
                                  ),
                                  AppTextStyle(
                                    textAlign: TextAlign.center,
                                    name: 'شيكل',
                                    height: 1,

                                    fontSize: 15.sp,
                                    color: AppColors.white,
                                    // fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomSvgImage(
                                imageName: 'delete',
                                // color: AppColors.grey,
                                height: 18.h,
                                width: 18.w,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              AppTextStyle(
                                textAlign: TextAlign.center,
                                name: 'حذف الطلب',
                                fontSize: 12.sp,

                                color: AppColors.greyC,
                                // fontWeight: FontWeight.w400,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 28.h,
                );
              },
              itemCount: 5),
          SizedBox(
            height: 18.h,
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppTextStyle(
                    textAlign: TextAlign.center,
                    name: 'الإجمالي ',
                    fontSize: 24.sp,
                    color: AppButton.color,
                    // fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 7.w,
                  ),
                  AppTextStyle(
                    textAlign: TextAlign.center,
                    name: '${'213.00'} شيكل ',
                    fontSize: 18.sp,

                    color: AppButton.color,
                    // fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 18.h,
          ),
          AppButton(
            title: 'تأكيد الطلب ',
            onPressed: () {
              showAlertDialog();
            },
            visible: true,
          ),
          SizedBox(
            height: 35.h,
          ),
        ],
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              title: const Center(
                child: CustomText(
                  'بيانات الطلبية',
                  fontSize: 18,
                ),
              ),
              content: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                height: 300.h,
                width: 1400.w,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0.w, 5.0.h, 0.0.w, 5.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 25.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.0.w),
                            child: DropDownAdderss(
                              items: items,
                              onSaved: (Adderss? value) {},
                              onChange: (Adderss? value) async {
                                if (value != null) {
                                  setState(() {
                                    _currentSelectedTypeValue = value;
                                  });
                                }
                              },
                              formKey: _keyAgents,
                              usersAccount: usersAccount,
                            ),
                          ),
                          SizedBox(height: 25.h),
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: RadioListTile<String>(
                                  title: Text('Cash',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12.sp,
                                          color: AppColors.appColor)),
                                  value: 'Cash',
                                  activeColor: AppColors.appColor,
                                  groupValue: paymentType,
                                  onChanged: (String? value) {
                                    setState(
                                        () => paymentType = value.toString());
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: RadioListTile<String>(
                                  title: Text(
                                    'Online',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.sp,
                                        color: AppColors.appColor),
                                  ),
                                  value: 'Online',
                                  activeColor: AppColors.appColor,
                                  groupValue: paymentType,
                                  onChanged: (String? value) {
                                    setState(
                                        () => paymentType = value.toString());
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 25.h),
                          Visibility(
                            visible: paymentType == 'Online',
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0.0.w),
                              child: DropDownAdderss(
                                items: items2,
                                onSaved: (Adderss? value) {},
                                onChange: (Adderss? value) async {
                                  if (value != null) {
                                    setState(() {
                                      _currentSelectedTypeValue2 = value;
                                    });
                                  }
                                },
                                formKey: _keyAgents2,
                                usersAccount: usersAccount2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                SizedBox(
                  height: 65.13.h,
                  width: 300.w,
                  child: ElevatedButton(
                    onPressed: () async {
                      await perform();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                    ),
                    child: loadingButton
                        ? const Loading2()
                        : const CustomText(
                            'ارسال الطلبية',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          });
        });
  }

  void getAdderss() {
    for (int i = 0; i < appGet.addresses['list'].length; i++) {
      log('length is in cart ${appGet.addresses['list'].length}');
      _currentSelectedTypeValue = Adderss(
          id: appGet.addresses['list'][0]['id'],
          name: appGet.addresses['list'][0]['name']);
      items.add(Adderss(
          id: appGet.addresses['list'][i]['id'],
          name: appGet.addresses['list'][i]['name']));
    }
  }

  void getPayments() {
    for (int i = 0; i < appGet.payment['list'].length; i++) {
      log('length is ${appGet.payment['list'].length}');
      _currentSelectedTypeValue2 = Adderss(
          id: appGet.payment['list'][0]['id'],
          name: appGet.payment['list'][0]['holder_name']);
      items2.add(Adderss(
          id: appGet.payment['list'][i]['id'],
          name: appGet.payment['list'][i]['holder_name']));
    }
  }

  bool checkData() {
    if (_currentSelectedTypeValue2.id != 0 &&
        _currentSelectedTypeValue.id != 0) {
      if (paymentType == 'Online') {
        if (_currentSelectedTypeValue2.id != 0) {
          return true;
        } else {
          showSnackBar(
              context: context,
              message: 'يرجى اختيار بطاقة الدفع',
              error: true);
        }
      } else {
        return true;
      }
      showSnackBar(
          context: context, message: 'يرجى التاكد من البيانات', error: true);
    }

    return false;
  }

  Future<bool> createOrder() async {
    bool status = await ServerDataWithAuth().addOrder(
        context: context,
        address_id: _currentSelectedTypeValue.id,
        payment_type: paymentType,
        card_id: _currentSelectedTypeValue2.id,
        cart: cart);
    return status;
  }

  Future<void> perform() async {
    if (checkData()) {
      Navigator.pop(context);

      bool status = await createOrder().catchError((onError) {
        showSnackBar(context: context, message: 'exception is $onError');
        log(onError.toString());
        SVProgressHUD.dismiss();
      });
      if (status) {
        showSnackBar(context: context, message: 'تمت العملية بنجاح');

        SVProgressHUD.dismiss();
      } else {
        SVProgressHUD.dismiss();

        showSnackBar(context: context, message: 'فشلت العملية', error: true);
      }
    } else {
      SVProgressHUD.dismiss();
    }
  }
}
