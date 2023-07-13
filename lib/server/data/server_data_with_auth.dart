// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sohaib_store/server/app_get/app_get.dart';
import 'package:sohaib_store/server/helper/api_setting.dart';
import 'package:sohaib_store/utils/api_helpers.dart';

import '../../preferences/app_preferences.dart';

class ServerDataWithAuth extends ApiHelpers {
  AppGet appGet = Get.find();
  Dio dio = Dio();

  initDio() {
    dio = Dio();
    return dio;
  }

  Future<Map<String, dynamic>> getHome() async {
    initDio();

    log(ApiUrl.cities);
    var response = await dio.get(ApiUrl.home,
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.home.assignAll(response.data);
      log('getHome data done');
    } else if (response.statusCode != 500) {
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<Map<String, dynamic>> getOffer() async {
    initDio();

    log(ApiUrl.offers);
    var response = await dio.get(ApiUrl.offers,
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.offer.assignAll(response.data);
      log('getOffer data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<Map<String, dynamic>> getFavorite() async {
    initDio();

    log(ApiUrl.favorite);
    var response = await dio.get(ApiUrl.favorite,
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.favorite.assignAll(response.data);
      log('getFavorite data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<Map<String, dynamic>> getSubCategory(id) async {
    initDio();

    log('${ApiUrl.categories}/' + jsonEncode(id));
    var response = await dio.get('${ApiUrl.categories}/' + jsonEncode(id),
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.subCategory.assignAll(response.data);
      log('getSubCategory data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<Map<String, dynamic>> getSubCategoryProducts(id) async {
    initDio();

    log('${ApiUrl.subCategories}/' + jsonEncode(id));
    var response = await dio.get('${ApiUrl.subCategories}/' + jsonEncode(id),
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.subCategoryProduct.assignAll(response.data);
      log('getSubCategoryProducts data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<Map<String, dynamic>> getProductDetails(id) async {
    initDio();

    log('${ApiUrl.products}/' + jsonEncode(id));
    var response = await dio.get('${ApiUrl.products}/' + jsonEncode(id),
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.productDetails.assignAll(response.data);
      log('getSubCategoryProducts data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<bool> updateRateProduct({
    required BuildContext context,
    required rateValue,
    required productId,
  }) async {
    var url = Uri.parse(ApiUrl.rate);

    var response = await http.post(url, body: {
      'product_id': jsonEncode(productId),
      'rate': jsonEncode(rateValue),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppPreferences().getTokenUser}',
    });
    log(jsonDecode(response.body).toString());

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      await getProductDetails(appGet.productDetails['object']['id']);
      await getOffer();
      await getHome();
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

  Future<bool> addFavorite({
    required BuildContext context,
    required productId,
  }) async {
    var url = Uri.parse(ApiUrl.favorite);

    var response = await http.post(url, body: {
      'product_id': jsonEncode(productId),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppPreferences().getTokenUser}',
    });
    log(jsonDecode(response.body).toString());

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      await getProductDetails(appGet.productDetails['object']['id']);
      await getOffer();
      await getHome();
      await getFavorite();
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

  Future<Map<String, dynamic>> getFAQS() async {
    initDio();

    log(ApiUrl.faqs);
    var response = await dio.get(ApiUrl.faqs,
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.faqs.assignAll(response.data);
      log('getFAQS data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<Map<String, dynamic>> getAdderss() async {
    initDio();

    log(ApiUrl.addresses);
    var response = await dio.get(ApiUrl.addresses,
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.addresses.assignAll(response.data);
      log('getFAQS data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<bool> addContactUser({
    required BuildContext context,
    required subject,
    required message,
  }) async {
    SVProgressHUD.show();

    var url = Uri.parse(ApiUrl.contact);

    var response = await http.post(url, body: {
      'subject': subject,
      'message': message,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppPreferences().getTokenUser}',
    });
    log(jsonDecode(response.body).toString());

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      SVProgressHUD.dismiss();

      Navigator.pop(context);

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

  Future<bool> addAddress({
    required BuildContext context,
    required name,
    required info,
    required contact_number,
    required city_id,
  }) async {
    var url = Uri.parse(ApiUrl.addresses);

    var response = await http.post(url, body: {
      'name': name,
      'info': info,
      'contact_number': contact_number.toString(),
      'city_id': city_id.toString(),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppPreferences().getTokenUser}',
    });
    log(jsonDecode(response.body).toString());

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      await getAdderss();
      Navigator.pop(context);
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

  Future<bool> addPaymentMethod({
    required BuildContext context,
    required holderName,
    required cardNumber,
    required expDate,
    required cvv,
    required type,
  }) async {
    SVProgressHUD.show();

    var url = Uri.parse(ApiUrl.payment);

    var response = await http.post(url, body: {
      'holder_name': holderName,
      'card_number': cardNumber,
      'exp_date': expDate,
      'cvv': cvv,
      'type': type,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppPreferences().getTokenUser}',
    });
    log(jsonDecode(response.body).toString());

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      //ToDo:get payment method
      await getPayments();
      SVProgressHUD.dismiss();

      Navigator.pop(context);

      return true;
    } else if (response.statusCode != 500) {
      SVProgressHUD.dismiss();

      showMessage(context, jsonDecode(response.body)['message'], error: true);
    } else {
      SVProgressHUD.dismiss();

      showSnackBar(
          context: context,
          message: 'Something went wrong, Please try again!',
          error: true);
    }
    return false;
  }

  Future<Map<String, dynamic>> getPayments() async {
    initDio();

    log(ApiUrl.payment);
    var response = await dio.get(ApiUrl.payment,
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.payment.assignAll(response.data);
      log('getPayments data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<bool> addOrder(
      {required BuildContext context,
      required cart,
      required payment_type,
      required card_id,
      required address_id}) async {
    SVProgressHUD.show();

    var url = Uri.parse(ApiUrl.orders);

    var response = await http.post(url, body: {
      'cart': jsonEncode(cart),
      'payment_type': payment_type,
      'address_id': jsonEncode(address_id),
      'card_id': jsonEncode(card_id),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppPreferences().getTokenUser}',
    });
    log(jsonDecode(response.body).toString());

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'].toString(),
          error: false);
      //ToDo:get order method
      await getOrders();

      // await getPayments();
      SVProgressHUD.dismiss();

      return true;
    } else if (response.statusCode != 500) {
      SVProgressHUD.dismiss();

      showMessage(context, jsonDecode(response.body)['message'], error: true);
    } else {
      SVProgressHUD.dismiss();

      showSnackBar(
          context: context,
          message: 'Something went wrong, Please try again!',
          error: true);
    }
    return false;
  }

  Future<Map<String, dynamic>> getOrders() async {
    initDio();

    log(ApiUrl.orders);
    var response = await dio.get(ApiUrl.orders,
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.orders.assignAll(response.data);
      log('getOrders data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }

  Future<Map<String, dynamic>> getOrderDetails(id) async {
    initDio();

    var response = await dio.get(ApiUrl.orders + '/' + jsonEncode(id),
        options: Options(headers: ApiHelpers().headers));

    if (response.statusCode == 200) {
      log("data is ==>>> ${response.data}");

      appGet.orderDetails.assignAll(response.data);
      log('getOrders data done');
    } else if (response.statusCode != 500) {
      log('server 400');
    } else {
      log('server 500');
    }
    return response.data;
  }
}
