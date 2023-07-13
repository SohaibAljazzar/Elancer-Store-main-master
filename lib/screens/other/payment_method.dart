import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sohaib_store/server/data/server_data_with_auth.dart';
import 'package:sohaib_store/utils/helpers.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/custom_image.dart';
import 'package:sohaib_store/widgets/custom_text.dart';

import '../../widgets/app_style_text.dart';
import '../../widgets/app_text_filed_payment.dart';
import '../../widgets/loading2.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen>
    with Helpers {
  late TextEditingController _holderNameController;
  late TextEditingController _cardNumberController;
  late TextEditingController _expDateController;
  late TextEditingController _cvvCodeController;
  String visaType = 'Visa';
  late bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _holderNameController = TextEditingController();
    _cardNumberController = TextEditingController();
    _expDateController = TextEditingController();
    _cvvCodeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _holderNameController.dispose();
    _cardNumberController.dispose();
    _expDateController.dispose();
    _cvvCodeController.dispose();
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
            name: 'Add Payment',
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const Center(
              child: CustomPngImage(
                imageName: "paymentMethod",
                height: 180,
                width: 341,
              ),
            ),
            SizedBox(height: 20.h),
            Divider(height: 2.h),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0.w, 0.0.h, 20.0.w, 0.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTextField(
                    controller: _holderNameController,
                    hint: 'Holder Name',
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: _cardNumberController,
                    hint: 'Card Number',
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: _expDateController,
                    hint: 'Exp. Date',
                    textInputType: TextInputType.datetime,
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: _cvvCodeController,
                    hint: 'CVV Code',
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'TYPE',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: AppColors.appColor),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: RadioListTile<String>(
                          title: Text('Visa',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12.sp, color: AppColors.appColor)),
                          value: 'Visa',
                          activeColor: AppColors.appColor,
                          groupValue: visaType,
                          onChanged: (String? value) {
                            setState(() => visaType = value.toString());
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: RadioListTile<String>(
                          title: Text(
                            'Master',
                            style: GoogleFonts.montserrat(
                                fontSize: 12.sp, color: AppColors.appColor),
                          ),
                          value: 'Master',
                          activeColor: AppColors.appColor,
                          groupValue: visaType,
                          onChanged: (String? value) {
                            setState(() => visaType = value.toString());
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                      const CustomText('Save credit card information',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: SizedBox(
                      height: 43.h,
                      width: 307.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          await perform();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.r)),
                          ),
                        ),
                        child: visible
                            ? AppTextStyle(
                                name: 'تأكيد',
                                fontSize: 18.sp,
                                color: Colors.white,
                              )
                            : const Loading2(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  const CustomText('Save credit card information',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                  TextButton(
                    onPressed: () {},
                    child: const CustomText('Skip for now',
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkData() {
    if (_holderNameController.text.trim().isNotEmpty &&
        _cardNumberController.text.trim().isNotEmpty &&
        _expDateController.text.trim().isNotEmpty &&
        _cvvCodeController.text.trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> addPayment() async {
    bool status = await ServerDataWithAuth().addPaymentMethod(
        context: context,
        type: visaType,
        cardNumber: _cardNumberController.text,
        cvv: _cvvCodeController.text,
        expDate: _expDateController.text,
        holderName: _holderNameController.text);
    if (status) {
      return true;
    }
    return false;
  }

  Future<void> perform() async {
    if (checkData()) {
      if (mounted) {
        setState(() {
          visible = false;
        });
      }
      bool status = await addPayment().catchError((onError) {
        showSnackBar(context: context, message: 'exception is $onError');
        if (mounted) {
          setState(() {
            visible = true;
          });
        }
      });
      if (status) {
        showSnackBar(context: context, message: 'تمت العملية بنجاح');
        if (mounted) {
          setState(() {
            visible = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            visible = true;
          });
        }
        showSnackBar(context: context, message: 'فشلت العملية', error: true);
      }
    } else {
      if (mounted) {
        setState(() {
          visible = true;
        });
      }
      showSnackBar(
          context: context, message: 'يرجى استكمال البيانات', error: true);
    }
  }
}
