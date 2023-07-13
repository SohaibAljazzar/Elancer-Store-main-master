import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sohaib_store/server/auth/server_auth.dart';
import 'package:sohaib_store/utils/helpers.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/custom_text_filed.dart';
import 'package:sohaib_store/widgets/loading2.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> with Helpers {
  late TextEditingController _new;
  late TextEditingController _confirmNew;
  late bool isPasswordNew = true;
  late bool isPasswordConfirm = true;
  late bool visible = true;
  bool showLoading = false;
  late bool visibleVerfication = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 60.0.w,
    height: 55.0.h,
    textStyle: const TextStyle(
        locale: Locale('ar'),
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.blue,
      ),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _new = TextEditingController();
    _confirmNew = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _new.dispose();
    _confirmNew.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldkey,
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
                  size: 120.r,
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
                      SizedBox(
                        height: 20.h,
                      ),
                      FadeInUp(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Pinput(
                              length: 4,
                              // textInputAction: TextInputAction.,
                              errorTextStyle: const TextStyle(
                                  fontSize: 25.0, color: Colors.white),
                              focusNode: _pinPutFocusNode,
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              androidSmsAutofillMethod:
                                  AndroidSmsAutofillMethod.smsUserConsentApi,

                              controller: _pinPutController,
                              submittedPinTheme: defaultPinTheme,
                              focusedPinTheme: defaultPinTheme,
                              followingPinTheme: defaultPinTheme,
                              pinAnimationType: PinAnimationType.fade,
                              onChanged: (pin) async {
                                if (pin.isNotEmpty) {
                                  if (pin.length == 4) {}
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeInDown(
                        child: AppTextFiledHint(
                          hintText: 'كلمة المرور الجديدة',
                          controller: _new,
                          obscureText: isPasswordNew,
                          prefix: Icons.lock,
                          suffix: isPasswordNew
                              ? Icons.visibility
                              : Icons.visibility_off,
                          functionSuffixPressed: () {
                            if (mounted) {
                              setState(() {
                                isPasswordNew = !isPasswordNew;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      FadeInDown(
                        child: AppTextFiledHint(
                          hintText: 'تاكيد كلمة المرور الجديدة ',
                          controller: _confirmNew,
                          obscureText: isPasswordConfirm,
                          prefix: Icons.lock,
                          suffix: isPasswordConfirm
                              ? Icons.visibility
                              : Icons.visibility_off,
                          functionSuffixPressed: () {
                            if (mounted) {
                              setState(() {
                                isPasswordConfirm = !isPasswordConfirm;
                              });
                            }
                          },
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

  bool checkData() {
    if (_confirmNew.text.trim().isNotEmpty &&
        _new.text.isNotEmpty &&
        _pinPutController.text.trim().isNotEmpty) {
      if (_pinPutController.text.trim().length == 4) {
        if (_confirmNew.text == _new.text) {
          return true;
        }
        showSnackBar(
            context: context, message: 'كلمة المرور غير مطابقة', error: true);
      }
      showSnackBar(
          context: context,
          message: 'يرجى التحقق من عدد ارقام الكود',
          error: true);
    }
    return false;
  }

  Future<bool> resetPassword() async {
    bool status = await ServerAuth().resetPassword(
        context: context, code: _pinPutController.text, newPassword: _new.text);
    return status;
  }

  Future<void> perform() async {
    if (checkData()) {
      if (mounted) {
        setState(() {
          visible = false;
        });
      }
      bool status = await resetPassword();
      if (status) {
        if (mounted) {
          setState(() {
            visible = true;
          });
        }
      }
    } else {
      showSnackBar(
          context: context, message: 'يرجى استكمال البيانات', error: true);
    }
  }
}
