import 'package:shared_preferences/shared_preferences.dart';
import 'package:sohaib_store/server/model/user_model.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  late SharedPreferences _sharedPreferences;

  factory AppPreferences() {
    return _instance;
  }

  AppPreferences._internal();

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //
  Future<void> saveTokenUser({required String token}) async {
    await _sharedPreferences.setString('tokenUser', token);
  }

  String get token => _sharedPreferences.getString('token') ?? '';

  Future<void> saveLocale(
      {required String languageCode, required String countryCode}) async {
    await _sharedPreferences.setString('languageCode', languageCode);
    await _sharedPreferences.setString('countryCode', countryCode);
  }

  String get getTokenUser =>
      _sharedPreferences.getString(AppPrefKey.accessToken) ?? '';

  String get getLanguageCode =>
      _sharedPreferences.getString('languageCode') ?? 'ar';

  String get getCountryCode =>
      _sharedPreferences.getString('countryCode') ?? 'AE';

  Future<void> logOutUser() async {
    await _sharedPreferences.clear();
  }

  Future<void> setLoggedIn() async {
    await _sharedPreferences.setBool('logged_in', true);
  }

  bool get loggedIn => _sharedPreferences.getBool('logged_in') ?? false;

  Future<void> setData({required String key, required String value}) async {
    await _sharedPreferences.setString(key, value);
  }

  String getData({required String key}) {
    return _sharedPreferences.getString(key) ?? '';
  }

  Future<void> setAccountType(String value) async {
    await _sharedPreferences.setString("type", value);
  }

  String get accountType => _sharedPreferences.getString("type") ?? "";

  Future<UserModel> saveData(userModel, password) async {
    setData(key: 'name', value: userModel.name.toString());
    setData(key: 'mobile', value: userModel.mobile.toString());
    setData(key: 'cityId', value: userModel.cityId.toString());
    setData(key: 'id', value: userModel.id.toString());
    setData(key: 'password', value: password.toString());
    setData(key: 'gender', value: userModel.gender.toString());
    setData(key: 'token', value: userModel.token.toString());
    return userModel;
  }
}

class AppPrefKey {
  static const id = "id";
  static const name = "name";
  static const email = "email";
  static const type = "type";
  static const phone = "phone";
  static const detailsAr = "detailsAr";
  static const detailsEn = "detailsEn";
  static const logoImage = "logoImage";
  static const licenseImage = "licenseImage";
  static const nationality = "nationality";
  static const gender = "gender";
  static const dateOfBrth = "dateOfBrth";
  static const passportImage = "passportImage";
  static const idImage = "idImage";
  static const visaImage = "visaImage";
  static const addrse = "addrse";
  static const officeName = "officeName";
  static const governmentName = "governmentName";
  static const status = "status";
  static const citiesId = "citiesId";
  static const userId = "userId";
  static const accessToken = "token";
  static const password = "password";
}
