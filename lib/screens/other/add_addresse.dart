import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sohaib_store/server/app_get/app_get.dart';
import 'package:sohaib_store/server/data/server_data_with_auth.dart';
import 'package:sohaib_store/server/model/cities_model.dart';
import 'package:sohaib_store/utils/helpers.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/custom_text_filed.dart';
import 'package:sohaib_store/widgets/loading2.dart';

import '../../widgets/app_style_text.dart';
import '../../widgets/drop_down_city.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> with Helpers {
  late bool visible = true;
  String phoneNumberFinal = '';
  bool isCorrect = false;
  String initialCountry = 'PS';
  PhoneNumber number = PhoneNumber(isoCode: 'PS');
  Icon iconSuffix = const Icon(
    Icons.phone,
    color: AppColors.appColor,
  );
  AppGet appGet = Get.find();

  late TextEditingController _phone;
  late TextEditingController _name;
  late TextEditingController _info;
  Cities _currentSelectedTypeValue =
      Cities(id: 1, nameEn: 'Gaza', nameAr: 'غزة');
  List<Cities> items = [];
  final _keyAgents = GlobalKey<FormState>();

  Cities userAccountSelected = Cities(id: 1, nameEn: 'Gaza', nameAr: 'غزة');
  Cities usersAccount = Cities(id: 1, nameEn: 'Gaza', nameAr: 'غزة');

  @override
  void initState() {
    getListCities();

    // TODO: implement initState
    _phone = TextEditingController();
    _name = TextEditingController();
    _info = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phone.dispose();
    _name.dispose();
    _info.dispose();
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
            name: 'العناوين',
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
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsetsDirectional.zero,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Container(
                margin: EdgeInsets.only(top: 50.h),
                width: 200.w,
                child: FadeInDown(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 0.h),
                    child: Icon(
                      Icons.location_on,
                      size: 80.r,
                      color: AppColors.appColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      FadeInDown(
                        child: AppTextFiledHint(
                          hintText: 'الاسم',
                          controller: _name,
                          prefix: Icons.text_fields,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      FadeInDown(
                        child: AppTextFiledHint(
                          hintText: 'وصف',
                          controller: _info,
                          prefix: Icons.description_outlined,
                          // maxLength: 5,
                          textInputType: TextInputType.multiline,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      FadeInDown(
                        child: Container(
                          padding: EdgeInsetsDirectional.only(
                              bottom: 5.h, top: 5.h, end: 5.w, start: 5.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                color: AppColors.appColor, width: 1.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade100,
                                blurRadius: 1,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              InternationalPhoneNumberInput(
                                errorMessage: 'يرجى التاكد من رقم التواصل',
                                initialValue: number,
                                hintText: 'رقم التواصل',
                                onSubmit: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  // debugPrint("number here ${phoneNumberFinal.toString()}");
                                },
                                onInputChanged: (PhoneNumber number) {
                                  debugPrint(phoneNumberFinal);
                                  setState(() {
                                    phoneNumberFinal = number.phoneNumber!;
                                    // _phone.text = number.phoneNumber!;
                                    debugPrint('phoneFinal $phoneNumberFinal');
                                  });
                                },
                                onInputValidated: (bool value) {
                                  debugPrint(value.toString());
                                  if (value) {
                                    if (mounted) {
                                      setState(() {
                                        isCorrect = true;
                                      });
                                    }
                                  } else if (value == false) {
                                    if (mounted) {
                                      setState(() {
                                        isCorrect = false;
                                      });
                                    }
                                  }
                                },
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                    const TextStyle(color: Colors.black),
                                textFieldController: _phone,
                                formatInput: false,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                cursorColor: Colors.black,
                                inputDecoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5.r, left: 0),
                                  border: InputBorder.none,
                                  hintText: 'رقم التواصل',
                                  prefixIcon: _phone.text.trim().isNotEmpty
                                      ? isCorrect == false
                                          ? Icon(Icons.close_outlined,
                                              color: _phone.text.isNotEmpty
                                                  ? Colors.red
                                                  : Colors.transparent)
                                          : const Icon(Icons.check,
                                              color: Colors.green)
                                      : const Icon(Icons.phone,
                                          color: AppColors.appColor),
                                  hintStyle: GoogleFonts.almarai(
                                    textStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                onSaved: (PhoneNumber number) {
                                  debugPrint('On Saved: $number');
                                },
                              ),
                              Positioned(
                                left: 90,
                                top: 8,
                                bottom: 8,
                                child: Container(
                                  height: 40,
                                  width: 1,
                                  color: Colors.black.withOpacity(0.13),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0.w),
                        child: DropDownCity(
                          items: items,
                          onSaved: (Cities? value) {},
                          onChange: (Cities? value) async {
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
                      SizedBox(
                        height: 20.h,
                      ),
                      FadeInUp(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 65.h),
                            backgroundColor: AppColors.appColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onPressed: () async {
                            log('message');
                            await perform();
                          },
                          child: visible
                              ? AppTextStyle(
                                  name: 'اضافة',
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                )
                              : const Loading2(),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 200.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getListCities() {
    for (int i = 0; i < appGet.cities['list'].length; i++) {
      log('length is ${appGet.cities['list'].length}');
      _currentSelectedTypeValue = Cities(
          id: appGet.cities['list'][0]['id'],
          nameEn: appGet.cities['list'][0]['name_en'],
          nameAr: appGet.cities['list'][0]['name_ar']);
      items.add(Cities(
          id: appGet.cities['list'][i]['id'],
          nameEn: appGet.cities['list'][i]['name_en'],
          nameAr: appGet.cities['list'][i]['name_ar']));
    }
  }

  bool checkData() {
    if (_phone.text.trim().isNotEmpty &&
        _info.text.trim().isNotEmpty &&
        _name.text.trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> addAdderss() async {
    bool status = await ServerDataWithAuth().addAddress(
        context: context,
        name: _name.text,
        info: _info.text,
        contact_number: _phone.text,
        city_id: _currentSelectedTypeValue.id);
    log('status is $status');
    return status;
  }

  Future<void> perform() async {
    if (checkData()) {
      if (mounted) {
        setState(() {
          visible = false;
        });
      }
      log('in perform');
      try {
        await addAdderss();
      } catch (e) {
        log('exception $e');
        if (mounted) {
          setState(() {
            visible = true;
          });
        }
      }
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
      showSnackBar(
          context: context, message: 'يرجى استكمال البيانات', error: true);
    }
  }
}
