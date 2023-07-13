import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohaib_store/widgets/app_button.dart';
import 'package:sohaib_store/widgets/app_style_text.dart';
import 'package:sohaib_store/widgets/size_box.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return FadeInRight(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              semanticContainer: true,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              color: Colors.white.withOpacity(0.90),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 23.w, top: 20.h, bottom: 20.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: AppButton.color,
                      child: const Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          const AppTextStyle(
                            name: 'tittle',
                            color: AppButton.color,
                            fontSize: 17,
                          ),
                          const AppTextStyle(
                            name: 'subTittle',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            count: 16,
                            color: AppButton.color,
                          ),
                          const SizeBoxTemp(height: 10, width: 0),
                          Row(
                            // mainAxisSize: MainAxisSize.m,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizeBoxTemp(height: 0, width: 5),
                              Icon(
                                Icons.access_time,
                                size: 20.r,
                                color: AppButton.color,
                              ),
                              const SizeBoxTemp(height: 0, width: 5),
                              const AppTextStyle(
                                name: '20-8-2022',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: AppButton.color,
                              ),
                              const SizeBoxTemp(height: 0, width: 15),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizeBoxTemp(height: 5.h, width: 0);
        },
        itemCount: 20);
  }
}
