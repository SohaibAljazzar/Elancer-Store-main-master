// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohaib_store/screens/orders/working_order_screen_user.dart';

import '../../../widgets/app_style_text.dart';
import '../../value/colors.dart';
import 'finish_order_screen_user.dart';
import 'new_order_screen_user.dart';

// ignore: must_be_immutable
class OrderTabScreen extends StatefulWidget {
  const OrderTabScreen({super.key});

  @override
  _OrderTabScreenState createState() => _OrderTabScreenState();
}

class _OrderTabScreenState extends State<OrderTabScreen> {
  Color backColor = AppColors.appColor;
  List<Widget> widgets = [];
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    widgets = [
      const NewOrder(),
      const WorkingOrder(),
      const FinishOrder(),
    ];
    backColor = AppColors.appColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: widgets.length,
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,

          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.appColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: const IconThemeData(color: AppColors.appColor),
          title: const AppTextStyle(
            name: '',
            fontSize: 18,
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            unselectedLabelColor: AppColors.appColor,
            indicatorSize: TabBarIndicatorSize.label,
            onTap: (index) {
              if (index == 0) {
                setState(() {
                  backColor = AppColors.appColor;
                });
              } else if (index == 1) {
                setState(() {
                  backColor = AppColors.appColor;
                });
              } else if (index == 2) {
                setState(() {
                  backColor = AppColors.appColor;
                });
              }
            },
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r), color: backColor),
            tabs: [
              Tab(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.appColor, width: 1)),
                child: const Align(
                    alignment: Alignment.center, child: Text("جديدة")),
              )),
              Tab(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.appColor, width: 1)),
                child: const Align(
                    alignment: Alignment.center, child: Text("قيد التنفيذ")),
              )),
              Tab(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.appColor, width: 1)),
                child: const Align(
                    alignment: Alignment.center, child: Text("مكتملة")),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: widgets,
        ),
      ),
    ));
  }
}
