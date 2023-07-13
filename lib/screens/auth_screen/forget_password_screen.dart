import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sohaib_store/server/auth/server_auth.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/loading2.dart';

import '../../utils/helpers.dart';
import '../../value/colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Helpers {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _phone;
  late bool isPassword = true;
  late bool visible = true;
  String initialCountry = 'PS';
  PhoneNumber number = PhoneNumber(isoCode: 'PS');

  bool isCorrect = false;

  String phoneNumberFinal = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phone = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phone.dispose();
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
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FadeInDown(
          child: const AppTextStyle(
            fontSize: 18,
            name: 'نسيت كلمة المرور',
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
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsetsDirectional.zero,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Container(
                margin: EdgeInsets.only(top: 50.h),
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
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeInDown(
                        child: Container(
                          padding: EdgeInsetsDirectional.only(
                              bottom: 5.h, top: 5.h, end: 5.w, start: 5.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.appColor,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                offset: Offset(0, 4),
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
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                onInputChanged: (PhoneNumber number) {
                                  debugPrint(phoneNumberFinal);
                                  setState(() {
                                    // _phone.text = number.phoneNumber!;
                                    phoneNumberFinal = number.phoneNumber!;
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
                                // maxLength: 9,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                cursorColor: Colors.black,
                                inputDecoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 5, left: 0),
                                  border: InputBorder.none,
                                  hintText: 'رقم الهاتف',
                                  prefixIcon: isCorrect == false
                                      ? Icon(Icons.close_outlined,
                                          color: _phone.text.isNotEmpty
                                              ? Colors.red
                                              : Colors.transparent)
                                      : const Icon(Icons.check,
                                          color: Colors.green),
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
                        height: 30.h,
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
                            await perform();
                          },
                          child: visible
                              ? AppTextStyle(
                                  name: 'ارسال',
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
    ));
  }

  Future<bool> forgetPassword() async {
    bool status =
        await ServerAuth().forgetPassword(context: context, phone: _phone.text);
    return status;
  }

  bool checkData() {
    if (_phone.text.trim().isNotEmpty) {
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
      try {
        bool status = await forgetPassword();
        log('status is $status');
      } catch (e) {
        log('ex ===>>$e');
      }
      if (mounted) {
        setState(() {
          visible = true;
        });
      }
    } else {
      showSnackBar(
          context: context, message: 'يرجى استكمال البيانات', error: true);
    }
  }
}
