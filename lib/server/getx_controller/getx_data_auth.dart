import 'dart:developer';

import 'package:get/get.dart';

import '../data/server_data_with_auth.dart';

class GetxControllerGetDataAuth extends GetxController {
  var home = {}.obs;
  var offer = {}.obs;
  var subCategory = {}.obs;
  var subCategoryProduct = {}.obs;
  var productDetails = {}.obs;
  var favorite = {}.obs;
  var faqs = {}.obs;
  var addresses = {}.obs;
  var payment = {}.obs;
  var orders = {}.obs;
  var orderDetails = {}.obs;
  final ServerDataWithAuth _serverData = ServerDataWithAuth();

  @override
  void onInit() {
    getHome();
    getOffer();
    getFavorite();
    getFAQS();
    getAdderss();
    getPayments();
    getOrders();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getHome();
    getOffer();
    getAdderss();
    getFAQS();
    getPayments();
    getOrders();
    super.onReady();
  }

  Future<void> getHome() async {
    home.value = await _serverData.getHome();
    log('getHome'.toString());
  }

  Future<void> getOffer() async {
    offer.value = await _serverData.getOffer();
    log('getOffer'.toString());
  }

  Future<void> getFavorite() async {
    favorite.value = await _serverData.getFavorite();
    log('getFavorite'.toString());
  }

  Future<void> getSubCategory(id) async {
    subCategory.value = await _serverData.getSubCategory(id);
    log('getSubCategory'.toString());
  }

  Future<void> getSubCategoryProducts(id) async {
    subCategoryProduct.value = await _serverData.getSubCategoryProducts(id);
    log('getSubCategoryProducts'.toString());
  }

  Future<void> getProductDetails(id) async {
    productDetails.value = await _serverData.getProductDetails(id);
    log('getProductDetails'.toString());
  }

  Future<void> getFAQS() async {
    faqs.value = await _serverData.getFAQS();
    log('await'.toString());
  }

  Future<void> getAdderss() async {
    addresses.value = await _serverData.getAdderss();
    log('getAdderss'.toString());
  }

  Future<void> getPayments() async {
    addresses.value = await _serverData.getPayments();
    log('getPayments'.toString());
  }

  Future<void> getOrders() async {
    orders.value = await _serverData.getOrders();
    log('getOrders'.toString());
  }

  Future<void> getOrderDetails(id) async {
    orderDetails.value = await _serverData.getOrderDetails(id);
    log('getOrders'.toString());
  }
}
