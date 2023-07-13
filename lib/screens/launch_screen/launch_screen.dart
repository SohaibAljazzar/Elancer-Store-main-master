import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohaib_store/preferences/app_preferences.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    if (AppPreferences().loggedIn) {
      Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () {
          Navigator.pushReplacementNamed(context, '/main_screen');
        },
      );
    } else {
      Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () {
          Navigator.pushReplacementNamed(context, '/login_screen');
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          curve: Curves.bounceInOut,
          size: 80.r,
        ),
      ),
    );
  }
}
