import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sohaib_store/server/app_get/app_get.dart';
import 'package:sohaib_store/server/auth/server_auth.dart';
import 'package:sohaib_store/server/model/cities_model.dart';
import 'package:sohaib_store/server/model/user_model.dart';
import 'package:sohaib_store/utils/helpers.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/custom_text_filed.dart';
import 'package:sohaib_store/widgets/loading2.dart';

import '../../widgets/drop_down_city.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> with Helpers {
  AppGet appGet = Get.find();
  late TextEditingController _name;
  late TextEditingController _phone;
  late TextEditingController _password;
  late bool isPassword = true;
  late bool visible = true;
  String phoneNumberFinal = '';
  bool isCorrect = false;
  String initialCountry = 'PS';
  PhoneNumber number = PhoneNumber(isoCode: 'PS');
  Icon iconSuffix = const Icon(
    Icons.phone,
    color: AppColors.appColor,
  );
  UserModel user = UserModel();
  Cities _currentSelectedTypeValue =
      Cities(id: 1, nameEn: 'Gaza', nameAr: 'غزة');
  String _gender = 'M';
  List<Cities> items = [];
  final _keyAgents = GlobalKey<FormState>();

  Cities userAccountSelected = Cities(id: 1, nameEn: 'Gaza', nameAr: 'غزة');
  Cities usersAccount = Cities(id: 1, nameEn: 'Gaza', nameAr: 'غزة');

  @override
  void initState() {
    // TODO: implement initState
    getListCities();

    super.initState();
    _name = TextEditingController();
    _phone = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _phone.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FadeInDown(
          child: const AppTextStyle(
            fontSize: 18,
            name: 'إنشاء حساب جديد',
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsetsDirectional.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30.h,
            ),
            FadeInDown(
              child: Container(
                margin: EdgeInsets.only(bottom: 0.h),
                child: FlutterLogo(
                  curve: Curves.bounceInOut,
                  size: 80.r,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 35.w,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeInDown(
                        child: AppTextFiledHint(
                          hintText: 'الاسم',
                          controller: _name,
                          prefix: Icons.person_outline,
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
                                errorMessage: 'يرجى التاكد من رقم الهاتف',
                                initialValue: number,
                                hintText: 'رقم الهاتف',
                                onSubmit: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasFocus) {
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
                                  hintText: 'رقم الهاتف',
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
                      FadeInDown(
                        child: AppTextFiledHint(
                          hintText: 'كلمة المرور',
                          controller: _password,
                          obscureText: isPassword,
                          prefix: Icons.lock,
                          suffix: isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          functionSuffixPressed: () {
                            if (mounted) {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
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
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 8.w,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'الجنس',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.appColor),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text('ذكر',
                                  style: GoogleFonts.montserrat(
                                      color: AppColors.appColor)),
                              value: 'M',
                              activeColor: AppColors.appColor,
                              groupValue: _gender,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (String? value) {
                                setState(() => _gender = value.toString());
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text('أنثى',
                                  style: GoogleFonts.montserrat(
                                      color: AppColors.appColor)),
                              value: 'F',
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColors.appColor,
                              groupValue: _gender,
                              onChanged: (String? value) {
                                setState(() => _gender = value.toString());
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      FadeInUp(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 55.h),
                            backgroundColor: AppColors.appColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onPressed: () async {
                            await performCreateAccount();
                          },
                          child: visible
                              ? AppTextStyle(
                                  name: 'تأكيد',
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
            ),
          ],
        ),
      ),
    ));
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
    if (_name.text.trim().isNotEmpty &&
        _phone.text.trim().isNotEmpty &&
        _password.text.trim().isNotEmpty) {
      user = UserModel.add(
          name: _name.text,
          mobile: _phone.text,
          gender: _gender.toString(),
          cityId: _currentSelectedTypeValue.id.toString(),
          city: City(
            id: _currentSelectedTypeValue.id,
            nameEn: _currentSelectedTypeValue.nameEn,
            nameAr: _currentSelectedTypeValue.nameAr,
          ));
      return true;
    }
    return false;
  }

  Future<bool> createAccount() async {
    bool status = await ServerAuth().createUser(
        context: context,
        user: user,
        password: _password.text,
        cityId: _currentSelectedTypeValue.id);
    if (status) {
      return true;
    }
    return false;
  }

  Future<void> performCreateAccount() async {
    if (checkData()) {
      if (mounted) {
        setState(() {
          visible = false;
        });
      }
      bool status = await createAccount().catchError((onError) {
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
