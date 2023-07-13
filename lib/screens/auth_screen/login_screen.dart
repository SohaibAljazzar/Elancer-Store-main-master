import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_loading_button/icon_loading_button.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sohaib_store/server/auth/server_auth.dart';
import 'package:sohaib_store/utils/helpers.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/custom_text_filed.dart';
import 'package:sohaib_store/widgets/size_box.dart';

import '../../value/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _phone;
  late TextEditingController _password;
  late bool isPassword = true;
  late bool visible = true;
  String phoneNumberFinal = '';
  bool isCorrect = false;
  final IconButtonController _btnController1 = IconButtonController();

  String initialCountry = 'PS';
  PhoneNumber number = PhoneNumber(isoCode: 'PS');
  Icon iconSuffix = const Icon(
    Icons.phone,
    color: AppColors.appColor,
  );

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _phone = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phone.dispose();
    _password.dispose();
    _btnController1.reset();
    super.dispose();
  }

  void buttonPressed() async {
    bool status = await perform();
    Future.delayed(const Duration(seconds: 1), () {
      if (!status) {
        _btnController1.error();
        _btnController1.reset();
      } else {
        _btnController1.success();
        _btnController1.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SizedBox(
              height: 10.h,
            ),
            ListView(
              physics: const ClampingScrollPhysics(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shrinkWrap: false,
              children: [
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
                        SizedBox(
                          height: 15.h,
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
                                    // debugPrint("number here ${phoneNumberFinal.toString()}");
                                  },
                                  onInputChanged: (PhoneNumber number) {
                                    debugPrint(phoneNumberFinal);
                                    setState(() {
                                      phoneNumberFinal = number.phoneNumber!;
                                      // _phone.text = number.phoneNumber!;
                                      debugPrint(
                                          'phoneFinal $phoneNumberFinal');
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
                          height: 15.h,
                        ),
                        FadeInDown(
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                )
                              ],
                              borderRadius: BorderRadius.circular(10.r),
                              // border: Border.all(color: AppColors.appColor, width: 1),
                            ),
                            child: AppTextFiledHint(
                              hintText: 'كلمة المرور ',
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
                        ),
                        SizedBox(
                          height: 30.w,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FadeInUp(
                                child: IconLoadingButton(
                                  height: 60.h,
                                  borderRadius: 5.r,
                                  // width: double.infinity,
                                  width: MediaQuery.of(context).size.width.w,

                                  color: AppColors.appColor,
                                  iconColor: Colors.white,
                                  valueColor: AppColors.appColor,
                                  errorColor: const Color(0xffe0333c),
                                  successColor: const Color(0xff58B09C),
                                  animateOnTap: true,
                                  iconData: Icons.login,
                                  onPressed: () async {
                                    buttonPressed();
                                    // buttonPressed();
                                  },
                                  successIcon: Icons.check,
                                  controller: _btnController1,
                                  child: AppTextStyle(
                                    name: 'تسجيل دخول',
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizeBoxTemp(width: 0.w, height: 5.h),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/register_screen');
                                      },
                                      child: AppTextStyle(
                                        name: 'مستخدم جديد ؟',
                                        fontSize: 16.sp,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                    VerticalDivider(
                                      thickness: 1,
                                      indent: 20.r,
                                      endIndent: 15.r,
                                      color: Colors.grey.shade500,
                                      width: 0.5.w,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/forget_password_screen');
                                      },
                                      child: AppTextStyle(
                                        name: 'نسيت كلمة المرور؟',
                                        fontSize: 16.sp,
                                        color: AppColors.appColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool checkData() {
    if (_phone.text.trim().isNotEmpty && _password.text.trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> login() async {
    bool status = await ServerAuth().login(
        context: context,
        password: _password.text,
        phone: int.parse(_phone.text));
    return status;
  }

  Future<bool> perform() async {
    if (checkData()) {
      return await login();
    }
    showSnackBar(
        context: context, message: 'يرجى استكمال البيانات', error: true);
    return false;
  }
}
