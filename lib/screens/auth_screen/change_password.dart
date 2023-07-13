import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohaib_store/preferences/app_preferences.dart';
import 'package:sohaib_store/server/auth/server_auth.dart';
import 'package:sohaib_store/utils/helpers.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/custom_text_filed.dart';
import 'package:sohaib_store/widgets/loading2.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen>
    with Helpers {
  late TextEditingController _old;
  late TextEditingController _new;
  late TextEditingController _confirmNew;
  late bool isPasswordOld = true;
  late bool isPasswordNew = true;
  late bool isPasswordConfirm = true;
  late bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _old = TextEditingController();
    _new = TextEditingController();
    _confirmNew = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _old.dispose();
    _new.dispose();
    _confirmNew.dispose();
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
                      FadeInDown(
                        child: AppTextFiledHint(
                          hintText: 'كلمة المرور القديمة ',
                          controller: _old,
                          obscureText: isPasswordOld,
                          prefix: Icons.lock,
                          suffix: isPasswordOld
                              ? Icons.visibility
                              : Icons.visibility_off,
                          functionSuffixPressed: () {
                            if (mounted) {
                              setState(() {
                                isPasswordOld = !isPasswordOld;
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
        _old.text.trim().isNotEmpty) {
      if (_confirmNew.text == _new.text) {
        return true;
      }
      showSnackBar(
          context: context, message: 'كلمة المرور غير مطابقة', error: true);
    }

    return false;
  }

  Future<bool> changePassword() async {
    bool status = await ServerAuth().changePassword(
        context: context,
        currentPassword: AppPreferences().getData(key: 'password'),
        newPassword: _new.text);
    return status;
  }

  Future<void> perform() async {
    if (checkData()) {
      if (mounted) {
        setState(() {
          visible = false;
        });
      }
      bool status = await changePassword();
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
