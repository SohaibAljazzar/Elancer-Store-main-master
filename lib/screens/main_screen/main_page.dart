import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/models_widgets/home_model.dart';
import 'package:sohaib_store/screens/main_screen/sub_page/cart_screen.dart';
import 'package:sohaib_store/screens/main_screen/sub_page/fav_products_screen.dart';
import 'package:sohaib_store/screens/main_screen/sub_page/home_page.dart';
import 'package:sohaib_store/screens/main_screen/sub_page/notifcation_screen.dart';
import 'package:sohaib_store/screens/main_screen/sub_page/settings_screen.dart';
import 'package:sohaib_store/widgets/custom_image.dart';

import '../../server/getx_controller/getx_data_auth.dart';
import '../../widgets/custom_text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<HomeModel> listModel = [
    HomeModel(widget: const HomePage(), tittleAppBar: 'الرئيسية'),
    HomeModel(widget: const FavProductsScreen(), tittleAppBar: 'المفضلة'),
    HomeModel(widget: const NotificationScreen(), tittleAppBar: 'الاشعارات'),
    HomeModel(widget: const SettingScreen(), tittleAppBar: 'حسابي'),
    HomeModel(widget: const CartScreen(), tittleAppBar: 'السلة'),
  ];
  GetxControllerGetDataAuth controller = Get.find();

  int _currentIndex = 0;
  var home = CustomSvgImage(
    imageName: 'home',
    width: 20.w,
    height: 20.h,
  );
  var shop = CustomSvgImage(
    imageName: 'unShop',
    width: 25.w,
    height: 25.h,
  );

  var fav = CustomSvgImage(
    imageName: 'unFav',
    width: 20.w,
    height: 20.h,
  );
  var notification = CustomSvgImage(
    imageName: 'unNotification',
    width: 20.w,
    height: 20.h,
  );
  var profile = CustomSvgImage(
    imageName: 'unProfile',
    width: 20.w,
    height: 20.h,
  );
  var search = CustomSvgImage(
    imageName: 'search',
    width: 20.w,
    height: 20.h,
  );

  setPage(index) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  setIconHome() {
    controller.getOffer();
    controller.getHome();
    if (mounted) {
      setState(() {
        home = CustomSvgImage(
          imageName: _currentIndex == 0 ? 'home' : 'home_disable',
          width: 20.w,
          height: 20.h,
        );
      });
    }
  }

  setIconShop() {
    if (mounted) {
      setState(() {
        shop = CustomSvgImage(
          imageName: _currentIndex == 4 ? 'shop' : 'unShop',
          width: 25.w,
          height: 25.h,
        );
      });
    }
  }

  setIconFav() {
    //ToDo: request to home
    controller.getFavorite();
    if (mounted) {
      setState(() {
        fav = CustomSvgImage(
          imageName: _currentIndex == 1 ? 'fav' : 'unFav',
          width: 25.w,
          height: 25.h,
        );
      });
    }
  }

  setIconNotification() {
    if (mounted) {
      setState(() {
        notification = CustomSvgImage(
          imageName: _currentIndex == 2 ? 'notification' : 'unNotification',
          width: 25.w,
          height: 25.h,
        );
      });
    }
  }

  setIconProfile() {
    if (mounted) {
      setState(() {
        profile = CustomSvgImage(
          imageName: _currentIndex == 3 ? 'profile' : 'unProfile',
          width: 25.w,
          height: 25.h,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: CustomText(listModel[_currentIndex].tittleAppBar,
            color: const Color(0xff202020),
            fontSize: 17.sp,
            fontWeight: FontWeight.w500),
        iconTheme: const IconThemeData(
          color: Color(0xff202020),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: GestureDetector(child: search, onTap: () {}),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 80.h,
        width: 80.w,
        child: FloatingActionButton(
          backgroundColor: const Color(0xffEBEDF0),
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          isExtended: true,
          autofocus: true,
          disabledElevation: 0.0,
          focusElevation: 0.0,
          highlightElevation: 0.0,
          hoverElevation: 0.0,
          tooltip: 'Shop',
          mini: false,
          onPressed: () {
            setPage(4);
            setIconShop();
            setIconHome();
            setIconFav();
            setIconNotification();
            setIconProfile();
          },
          child: shop,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(0),
            topLeft: Radius.circular(0),
          ),
          clipBehavior: Clip.antiAlias,
          child: BottomAppBar(
              color: Colors.white,
              elevation: 0,
              notchMargin: -2.0,
              shape: const CircularNotchedRectangle(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 0.9.w, color: const Color(0xffD2D2D2)),
                    ),
                  ),
                  height: 80.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: InkWell(
                            child: home,
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  setPage(0);
                                  setIconShop();
                                  setIconHome();
                                  setIconFav();
                                  setIconNotification();
                                  setIconProfile();
                                });
                              }
                            }),
                      ),
                      Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: InkWell(
                              child: fav,
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    setPage(1);
                                    setIconShop();
                                    setIconHome();
                                    setIconFav();
                                    setIconNotification();
                                    setIconProfile();
                                  });
                                }
                              })),
                      const SizedBox.shrink(),
                      Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: InkWell(
                              child: notification,
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    setPage(2);
                                    setIconShop();
                                    setIconHome();
                                    setIconFav();
                                    setIconNotification();
                                    setIconProfile();
                                  });
                                }
                              })),
                      Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: InkWell(
                              child: profile,
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    setPage(3);
                                    setIconShop();
                                    setIconHome();
                                    setIconFav();
                                    setIconNotification();
                                    setIconProfile();
                                  });
                                }
                              })),
                    ],
                  )))),
      body: listModel[_currentIndex].widget,
    ));
  }
}
