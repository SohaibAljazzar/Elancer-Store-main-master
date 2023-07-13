import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/screens/auth_screen/change_password.dart';
import 'package:sohaib_store/screens/auth_screen/edit_phone_screen.dart';
import 'package:sohaib_store/screens/auth_screen/forget_password_screen.dart';
import 'package:sohaib_store/screens/auth_screen/login_screen.dart';
import 'package:sohaib_store/screens/auth_screen/register_screen.dart';
import 'package:sohaib_store/screens/auth_screen/reset_password.dart';
import 'package:sohaib_store/screens/auth_screen/verfication_screen.dart';
import 'package:sohaib_store/screens/launch_screen/launch_screen.dart';
import 'package:sohaib_store/screens/main_screen/main_page.dart';
import 'package:sohaib_store/screens/orders/new_order_screen_user.dart';
import 'package:sohaib_store/screens/orders/order_details.dart';
import 'package:sohaib_store/screens/other/about_us.dart';
import 'package:sohaib_store/screens/other/add_addresse.dart';
import 'package:sohaib_store/screens/other/addresses_screen.dart';
import 'package:sohaib_store/screens/other/cateogry_screen.dart';
import 'package:sohaib_store/screens/other/contact_us.dart';
import 'package:sohaib_store/screens/other/edit_profile_screen.dart';
import 'package:sohaib_store/screens/other/faqs_screen.dart';
import 'package:sohaib_store/screens/other/payment_method.dart';
import 'package:sohaib_store/screens/other/product_details.dart';
import 'package:sohaib_store/screens/other/sub_category_screen.dart';
import 'package:sohaib_store/screens/other/viewed_products_screen.dart';
import 'package:sohaib_store/server/data/server_data_with_auth.dart';
import 'package:sohaib_store/server/getx_controller/getx_data_auth.dart';
import 'package:sohaib_store/widgets/app_button.dart';

import 'preferences/app_preferences.dart';
import 'server/app_get/app_get.dart';
import 'server/getx_controller/getx_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().initPreferences();
  Get.put(AppGet());
  Get.put(GetxControllerGetData());
  if (AppPreferences().loggedIn) {
    Get.put(GetxControllerGetDataAuth());
    ServerDataWithAuth().getHome();
    ServerDataWithAuth().getOffer();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColorLight: AppButton.color,
            scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: MaterialStateProperty.all(Colors.grey[500]),
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors.white,
            ),
            // ignore: deprecated_member_use
            accentColor: Colors.white,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            backgroundColor: Colors.white,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          locale: const Locale('ar'),
          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/reset_password_screen': (context) => const ResetPasswordScreen(),
            '/product_details': (context) => const ProductDetails(),
            '/main_screen': (context) => const MainScreen(),
            '/faqs_screen': (context) => const FAQsScreen(),
            '/addresses_screen': (context) => const AddressesScreen(),
            '/edit_phone_screen': (context) => const EditPhoneScreen(),
            '/edit_info_screen': (context) => const EditProfileScreen(),
            '/order_new': (context) => const NewOrder(),
            '/order_details': (context) => const OrderDetails(),
            '/category_screen': (context) => const CategoryScreen(),
            '/sub_category_screen': (context) => const SubCategoryScreen(),
            '/payment_screen': (context) => const PaymentMethodScreen(),
            '/add_address_screen': (context) => const AddAddressScreen(),
            '/about_screen': (context) => const AboutScreen(),
            '/contact_us_screen': (context) => const ContactUs(),
            '/viewed_product_screen': (context) => const ViewedProductsScreen(),
            '/login_screen': (context) => const LoginScreen(),
            '/register_screen': (context) => const RegisterScreen(),
            '/verification_screen': (context) => const VerificationScreen(),
            '/change_password_screen': (context) =>
                const ChangePasswordScreen(),
            '/forget_password_screen': (context) =>
                const ForgetPasswordScreen(),
          },
          initialRoute: '/launch_screen',
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
