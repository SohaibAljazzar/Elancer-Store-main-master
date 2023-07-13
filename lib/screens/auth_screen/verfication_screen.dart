import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:pinput/pinput.dart';
import 'package:sohaib_store/preferences/app_preferences.dart';
import 'package:sohaib_store/server/auth/server_auth.dart';

import '../../widgets/app_style_text.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  String verificationId = '';
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
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h),
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
                FadeInDown(
                  child: AppTextStyle(
                    name: 'رمز التحقق',
                    fontSize: 29,
                    color: Colors.grey.shade900,
                  ),
                ),
                Visibility(
                  visible: visibleVerfication,
                  child: FadeInDown(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 20.w,
                      ),
                      child: const AppTextStyle(
                        name: 'أدخل رمز OTP للتحقق..',
                        textAlign: TextAlign.center,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // FadeInDown(
                //   child: getOtpFormWidget(context),
                // ),

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
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,

                        controller: _pinPutController,
                        submittedPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme,
                        followingPinTheme: defaultPinTheme,
                        pinAnimationType: PinAnimationType.fade,
                        onChanged: (pin) async {
                          if (pin.isNotEmpty) {
                            if (pin.length == 4) {
                              SVProgressHUD.show();
                              //ToDo:my function verification

                              Future.delayed(
                                const Duration(
                                  seconds: 3,
                                ),
                                () {
                                  ServerAuth().authMobile(
                                      context: context,
                                      code: int.parse(pin),
                                      phone: int.parse(AppPreferences()
                                          .getData(key: 'phone')));
                                  SVProgressHUD.dismiss();
                                },
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 40.h,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
