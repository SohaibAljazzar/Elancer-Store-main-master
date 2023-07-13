import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/preferences/app_preferences.dart';
import 'package:sohaib_store/screens/main_screen/sub_page/home_page.dart';
import 'package:sohaib_store/server/app_get/app_get.dart';
import 'package:sohaib_store/server/auth/server_auth.dart';
import 'package:sohaib_store/value/colors.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';

import '../../../server/getx_controller/getx_data_auth.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  String _language = 'en';
  late GetxControllerGetDataAuth controller;
  AppGet appGet = Get.find();

  @override
  void initState() {
    controller = Get.find();
    controller.getAdderss();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      children: [
        Align(
          alignment: AlignmentDirectional.topCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  color: Colors.white.withOpacity(0.16),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 8, color: Colors.white),
              ),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.appColor,
                        spreadRadius: 1,
                        offset: Offset(0, 0),
                        blurRadius: 5)
                  ],
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/carproject-flutter.appspot.com/o/image.gif?alt=media&token=09ff484d-8c5f-4180-a233-048a6d612248',
                  height: 80.h,
                  // buildContext: context,
                  width: 80.w,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => ShimmerImage(context),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: AppTextStyle(
            name: AppPreferences().getData(key: 'name'),
            fontSize: 16,
            color: AppColors.appColor,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        const Divider(
          thickness: 2,
        ),
        ListTile(
          onTap: () => showLanguageDialog(),
          leading: const Icon(
            Icons.language,
            color: AppColors.appColor,
          ),
          title: const Text('اللغة'),
          subtitle: const Text('اختر اللغة من هنا'),
        ),
        // ListTile(
        //   onTap: () => Navigator.pushNamed(context, '/edit_info_screen'),
        //   leading: const Icon(
        //     Icons.person,
        //     color: AppColors.appColor,
        //   ),
        //   title: const Text('الملف الشخصي'),
        //   subtitle: const Text('عرض معلومات عن حسابك'),
        // ),
        // ListTile(
        //   onTap: () => Navigator.pushNamed(context, '/edit_phone_screen'),
        //   leading: const Icon(
        //     Icons.mobile_friendly,
        //     color: AppColors.appColor,
        //   ),
        //   title: const Text('تعديل رقم الهاتف'),
        //   subtitle: const Text('قم بتعديل رقم هاتفك'),
        // ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, '/change_password_screen'),
          leading: const Icon(
            Icons.lock,
            color: AppColors.appColor,
          ),
          title: const Text('تغيير كلمة المرور'),
          subtitle: const Text('يمكنك تغيير كلمة المرور من هنا'),
        ),
        ListTile(
          onTap: () async {
            SVProgressHUD.show();

            controller.getFAQS();
            SVProgressHUD.dismiss();

            Navigator.pushNamed(context, '/faqs_screen');
          },
          leading: const Icon(
            Icons.question_answer_sharp,
            color: AppColors.appColor,
          ),
          title: const Text('الأسئلة الأكثر شيوعاً'),
          subtitle:
              const Text('يمكنك الاطلاع على الأسئلة الأكثر شيوعاً من هنا'),
        ),
        // ListTile(
        //   onTap: () => Navigator.pushNamed(context, '/viewed_product_screen'),
        //   leading: const Icon(
        //     Icons.line_style,
        //     color: AppColors.appColor,
        //   ),
        //   title: const Text('المنتجات المشاهدة أخيراً'),
        //   subtitle: const Text('يمكنك الاطلاع على المنتجات المشاهدة أخيراً'),
        // ),
        ListTile(
          onTap: () async {
            SVProgressHUD.show();

            controller.getAdderss();
            SVProgressHUD.dismiss();

            Navigator.pushNamed(context, '/addresses_screen');
          },
          leading: const Icon(
            Icons.map,
            color: AppColors.appColor,
          ),
          title: const Text('العناوين'),
          subtitle: const Text('يمكنك الاطلاع على العناوين هنا'),
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, '/contact_us_screen'),
          leading: const Icon(
            Icons.chat,
            color: AppColors.appColor,
          ),
          title: const Text('تواصل معنا'),
          subtitle: const Text('يمكنك التواصل مع إدارة المتجر من هنا'),
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, '/about_screen'),
          leading: const Icon(
            Icons.info,
            color: AppColors.appColor,
          ),
          title: const Text('عن التطبيق'),
          subtitle: const Text('يمكنك التعرف علينا من هنا'),
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, '/payment_screen'),
          leading: const Icon(
            Icons.credit_card,
            color: AppColors.appColor,
          ),
          title: const Text('البطاقات البنكية'),
          subtitle: const Text('أضف بطاقتك البنكية هنا'),
        ),
        ListTile(
          onTap: () {
            SVProgressHUD.show();

            controller.getOrders();
            SVProgressHUD.dismiss();
            Navigator.pushNamed(context, '/order_new');
          },
          leading: const Icon(
            Icons.reorder,
            color: AppColors.appColor,
          ),
          title: const Text('الطلبيات'),
          subtitle: const Text('طلبياتك تجدها هنا'),
        ),
        ListTile(
          onTap: () => showDialogInfo(),
          leading: const Icon(
            Icons.logout,
            color: AppColors.appColor,
          ),
          title: const Text('تسجيل الخروج'),
          subtitle: const Text('نحن بانتظار عودتك'),
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }

  void showDialogInfo() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      borderSide: BorderSide(
        color: Colors.red,
        width: 2.r,
      ),
      width: 400.w,
      buttonsBorderRadius: BorderRadius.all(
        Radius.circular(2.r),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      onDissmissCallback: (type) {},
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'هل تريد تسجيل الخروج؟',
      desc: 'انت على وشك تسجيل الخروج !',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await ServerAuth().logout(context);
      },
      btnCancelText: 'اغلاق',
      btnOkText: 'حسنا',
    ).show();
  }

  void showLanguageDialog() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 15,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  value: 'ar',
                  activeColor: AppColors.appColor,
                  title: const Text('Arabic'),
                  groupValue: _language,
                  onChanged: (String? value) {
                    setState(() {
                      if (value != null) {
                        _language = value;
                      }
                      Navigator.pop(context);
                    });
                  },
                ),
                RadioListTile(
                  value: 'en',
                  activeColor: AppColors.appColor,
                  title: const Text('English'),
                  groupValue: _language,
                  onChanged: (String? value) {
                    setState(() {
                      if (value != null) {
                        _language = value;
                      }
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
