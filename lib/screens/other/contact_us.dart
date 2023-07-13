import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sohaib_store/server/data/server_data_with_auth.dart';
import 'package:sohaib_store/utils/helpers.dart';
import 'package:sohaib_store/widgets/size_box.dart';

import '../../value/colors.dart';
import '../../widgets/app_style_text.dart';
import '../../widgets/app_text_field_with_card.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  ContactUsState createState() => ContactUsState();
}

class ContactUsState extends State<ContactUs> with Helpers {
  late TextEditingController _message;
  late TextEditingController _title;

  @override
  void initState() {
    _message = TextEditingController();
    _title = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _message.dispose();
    _title.dispose();
    super.dispose();
  }

  static var what = SvgPicture.asset(
    "images/whatapp.svg",
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.appColor),
        centerTitle: true,
        elevation: 0,
        leading: Container(
            margin:
                EdgeInsetsDirectional.only(top: 0.h, bottom: 0.h, start: 5.w),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          FadeInDown(
              child: Image.asset(
            'images/contacusttwo.jpg',
            height: 300.h,
            width: double.infinity,
            fit: BoxFit.cover,
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 2,
                      offset: const Offset(0, 0),
                      blurRadius: 4),
                ],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade50)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                    child: AppTextStyle(name: 'تواصل معنا', fontSize: 22)),
                const SizeBoxTemp(height: 15, width: 0),
                AppTextFieldWithCard(
                  title: 'عنوان الرسالة',
                  color: Colors.black,
                  iconDataPref: Icons.message,
                  controller: _title,
                  onPressed: () {},
                ),
                AppTextFieldWithCard(
                  title: 'محتوى  الرسالة',
                  maxLine: 10,
                  maxLength: 20,
                  color: Colors.black,
                  iconDataPref: Icons.description,
                  controller: _message,
                  onPressed: () {},
                ),
                const SizeBoxTemp(height: 15, width: 0),
              ],
            ),
          ),
          const SizeBoxTemp(height: 10, width: 0),
          // FadeInDown(
          //   child: MaterialButton(
          //     minWidth: double.infinity,
          //     onPressed: () {
          //       setState(() {
          //         _isLoading = true;
          //       });
          //
          //       Future.delayed(Duration(seconds: 2), () {
          //         setState(() {
          //           _isLoading = false;
          //         });
          //         // Navigator.push(context, MaterialPageRoute(builder: (context) => Verificatoin()));
          //       });
          //     },
          //     color: Colors.black,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(2)),
          //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          //     child: _isLoading
          //         ? Container(
          //             width: 20,
          //             height: 20,
          //             child: CircularProgressIndicator(
          //               backgroundColor: Colors.white,
          //               color: Colors.black,
          //               strokeWidth: 2,
          //             ),
          //           )
          //         : AppTextStyle(
          //             name: "تواصل عبر الواتس اب",
          //             color: Colors.white,
          //             fontSize: 17,
          //           ),
          //   ),
          // ),
          FloatingActionButton(
            isExtended: false,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            onPressed: () async {
              await perform();
            },
            backgroundColor: Colors.white,
            child: SizedBox(
                height: 35,
                width: double.infinity,
                child: Center(
                    child: Image.asset(
                  "images/send.png",
                  fit: BoxFit.cover,
                  // height: double.infinity,
                  // width: double.infinity,
                  alignment: Alignment.center,
                ))),
          ),
        ],
      ),
    ));
  }

  void clear() {
    _message.text = '';
    _title.text = '';
  }

  bool checkData() {
    if (_message.text.trim().isNotEmpty && _title.text.trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> addContactUs() async {
    bool status = await ServerDataWithAuth().addContactUser(
        context: context, subject: _title.text, message: _message.text);
    return status;
  }

  Future<void> perform() async {
    if (checkData()) {
      await addContactUs();
    } else {
      showSnackBar(
          context: context, message: 'يرجى استكمال البيانات', error: true);
    }
  }
}
