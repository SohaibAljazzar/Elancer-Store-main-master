import 'package:get/get.dart';
import 'package:sohaib_store/server/model/cities_model.dart';

import '../data/server_data.dart';

class GetxControllerGetData extends GetxController {
  RxList<Cities> cities = <Cities>[].obs;
  final ServerData _serverData = ServerData();
  @override
  void onInit() {
    // TODO: implement onInit

    getCities();
    super.onInit();
  }

  Future<void> getCities() async {
    cities.value = await _serverData.getListCities();
  }
}
