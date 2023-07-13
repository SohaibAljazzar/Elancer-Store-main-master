import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sohaib_store/server/app_get/app_get.dart';
import 'package:sohaib_store/server/helper/api_setting.dart';
import 'package:sohaib_store/server/model/cities_model.dart';

import '../../utils/api_helpers.dart';

class ServerData extends ApiHelpers {
  AppGet appGet = Get.find();
  Dio dio = Dio();

  initDio() {
    dio = Dio();
    return dio;
  }

  Future<List<Cities>> getListCities({BuildContext? context}) async {
    initDio();

    log(ApiUrl.cities);
    var response = await dio.get(ApiUrl.cities,
        options: Options(headers: {
          'Accept': 'application/json',
        }));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.cities.assignAll(response.data);
      log('getListCities data done');
    } else if (response.statusCode != 500) {
      showMessage(context, jsonDecode(response.data)['message'], error: true);
    } else {
      showMessage(context, 'Something went wrong, Please try again!',
          error: true);
    }
    return [];
  }
}
