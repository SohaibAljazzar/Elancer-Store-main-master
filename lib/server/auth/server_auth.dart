// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sohaib_store/preferences/app_preferences.dart';
import 'package:sohaib_store/server/data/server_data_with_auth.dart';
import 'package:sohaib_store/server/getx_controller/getx_data_auth.dart';
import 'package:sohaib_store/server/helper/api_setting.dart';
import 'package:sohaib_store/server/model/user_model.dart';
import 'package:sohaib_store/utils/helpers.dart';

class ServerAuth with Helpers {
  Future<bool> createUser({
    required BuildContext context,
    required UserModel user,
    required password,
    required cityId,
  }) async {
    var url = Uri.parse(ApiUrl.registerUrl);
    log('CREATE URL $url');
    var response = await http.post(url, body: {
      'name': user.name,
      'mobile': user.mobile,
      'password': password,
      'gender': user.gender,
      'STORE_API_KEY': ApiUrl.apiKey,
      'city_id': cityId.toString(),
    });
    log(response.body);

    if (jsonDecode(response.body)['status'] == true) {
      //SUCCESS
      showSnackBar(
          context: context,
          seconds: 10,
          message: 'code OTP  ${jsonDecode(response.body)['code']}',
          error: false);
      AppPreferences().setData(key: 'phone', value: user.mobile);
      Navigator.pushReplacementNamed(context, '/verification_screen');

      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response.body, error: true);
      showSnackBar(context: context, message: 'ERROR CREATED', error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'Something went wrong, Please try again!',
          error: true);
    }
    return false;
  }

  Future<bool> authMobile(
      {required BuildContext context, required code, required phone}) async {
    var url = Uri.parse(ApiUrl.activateUrl);
    log('active phone URL $url');
    var response = await http.post(url, body: {
      'mobile': jsonEncode(phone),
      'code': jsonEncode(code),
    });
    log(response.body);

    if (jsonDecode(response.body)['status'] == true) {
      //SUCCESS
      showMessage(context, jsonDecode(response.body)['message'], error: false);

      Navigator.pushReplacementNamed(context, '/login_screen');

      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'Something went wrong, Please try again!',
          error: true);
    }
    return false;
  }

  Future<bool> login(
      {required BuildContext context,
      required password,
      required phone}) async {
    var url = Uri.parse(ApiUrl.loginUrl);
    log('login URL $url');
    var response = await http.post(url, body: {
      'mobile': jsonEncode(phone),
      'password': password,
    }, headers: {
      'lang': 'ar'
    });
    log(response.body);

    if (jsonDecode(response.body)['status'] == true) {
      //SUCCESS
      UserModel user = UserModel.fromJson(jsonDecode(response.body)['data']);
      AppPreferences().saveData(user, password);
      Get.put(GetxControllerGetDataAuth());
      ServerDataWithAuth().getHome();
      ServerDataWithAuth().getOffer();
      showMessage(context, jsonDecode(response.body)['message'], error: false);
      AppPreferences().setLoggedIn();
      Navigator.pushReplacementNamed(context, '/main_screen');

      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'Something went wrong, Please try again!',
          error: true);
    }
    return false;
  }

  Future<bool> forgetPassword(
      {required BuildContext context, required String phone}) async {
    var url = Uri.parse(ApiUrl.forgetPasswordUrl);
    log('login URL $url');
    var response = await http.post(url, body: {
      'mobile': phone,
    }, headers: {
      'Accept': 'application/json',
    });
    log(response.body);
    log('phone type is ${phone.runtimeType}');
    log('phone is $phone');
    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(
          seconds: 50,
          context: context,
          message: jsonDecode(response.body)['code'].toString(),
          error: false);
      AppPreferences().setData(key: 'resetMobile', value: phone.toString());
      Navigator.pushReplacementNamed(context, '/reset_password_screen');

      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'Something went wrong, Please try again!',
          error: true);
    }
    return false;
  }

  Future<bool> resetPassword({
    required BuildContext context,
    required code,
    required newPassword,
  }) async {
    var url = Uri.parse(ApiUrl.resetPasswordUrl);
    log('login URL $url');
    log('phone is ${AppPreferences().getData(key: 'resetMobile')}');
    var response = await http.post(url, body: {
      'mobile': AppPreferences().getData(key: 'resetMobile'),
      'code': code,
      'password': newPassword,
      'password_confirmation': newPassword,
    }, headers: {
      'Accept': 'application/json',
    });
    print(jsonDecode(response.body));

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      Navigator.pushReplacementNamed(context, '/login_screen');

      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'Something went wrong, Please try again!',
          error: true);
    }
    return false;
  }

  Future<bool> changePassword({
    required BuildContext context,
    required currentPassword,
    required newPassword,
  }) async {
    var url = Uri.parse(ApiUrl.changePasswordUrl);

    var response = await http.post(url, body: {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPassword,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppPreferences().getTokenUser}',
    });
    print(jsonDecode(response.body));

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      await logout(context, isShowSnakBar: false);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'Something went wrong, Please try again!',
          error: true);
    }
    return false;
  }

  Future<bool> logout(context, {bool isShowSnakBar = true}) async {
    var url = Uri.parse(ApiUrl.logoutUrl);
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppPreferences().getTokenUser}',
    });
    if (jsonDecode(response.body)['status'] == true) {
      if (isShowSnakBar) {
        showSnackBar(
            context: context,
            message: jsonDecode(response.body)['message'].toString(),
            error: false);
      }
      await AppPreferences().logOutUser();

      Navigator.pushReplacementNamed(context, '/login_screen');
    } else if (response.statusCode != 500) {
      showMessage(context, jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'Something went wrong, Please try again!',
          error: true);
    }
    return false;
  }
}
