// ignore_for_file: prefer_typing_uninitialized_variables

class AutoGenerate {
  AutoGenerate({
    required this.status,
    required this.message,
    required this.userModel,
  });

  late final bool status;
  late final String message;
  late UserModel userModel;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userModel = UserModel.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = userModel.toJson();
    return data;
  }
}

class UserModel {
  UserModel();

  UserModel.add(
      {required this.name,
      required this.mobile,
      required this.gender,
      required this.cityId,
      required this.city});

  late final int id;
  late final String name;
  late var email;
  late final String mobile;
  late final String gender;
  late final bool active;
  late final bool verified;
  late final String cityId;
  late final String storeId;
  late var fcmToken;
  late final String token;
  late final String tokenType;
  late final String refreshToken;
  late final City city;
  late final Store store;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = null;
    mobile = json['mobile'];
    gender = json['gender'];
    active = json['active'];
    verified = json['verified'];
    cityId = json['city_id'];
    storeId = json['store_id'];
    fcmToken = null;
    token = json['token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    city = City.fromJson(json['city']);
    store = Store.fromJson(json['store']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['gender'] = gender;
    data['active'] = active;
    data['verified'] = verified;
    data['city_id'] = cityId;
    data['store_id'] = storeId;
    data['fcm_token'] = fcmToken;
    data['token'] = token;
    data['token_type'] = tokenType;
    data['refresh_token'] = refreshToken;
    data['city'] = city.toJson();
    data['store'] = store.toJson();
    return data;
  }
}

class City {
  City({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  late final int id;
  late final String nameEn;
  late final String nameAr;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    return data;
  }
}

class Store {
  Store({
    required this.id,
    required this.name,
    required this.storeName,
    required this.email,
    this.emailVerifiedAt,
    required this.mobile,
    required this.storeUuid,
    required this.cityId,
    this.verificationCode,
    required this.active,
    required this.verified,
    this.firebaseKey,
    this.image,
    required this.address,
    this.facebook,
    this.instagram,
    required this.createdAt,
    required this.updatedAt,
  });

  late final int id;
  late final String name;
  late final String storeName;
  late final String email;
  late var emailVerifiedAt;
  late final String mobile;
  late final String storeUuid;
  late final String cityId;
  late var verificationCode;
  late final String active;
  late final String verified;
  late var firebaseKey;
  late var image;
  late final String address;
  late var facebook;
  late var instagram;
  late final String createdAt;
  late final String updatedAt;

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeName = json['store_name'];
    email = json['email'];
    emailVerifiedAt = null;
    mobile = json['mobile'];
    storeUuid = json['store_uuid'];
    cityId = json['city_id'];
    verificationCode = null;
    active = json['active'];
    verified = json['verified'];
    firebaseKey = null;
    image = null;
    address = json['address'];
    facebook = null;
    instagram = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['store_name'] = storeName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['mobile'] = mobile;
    data['store_uuid'] = storeUuid;
    data['city_id'] = cityId;
    data['verification_code'] = verificationCode;
    data['active'] = active;
    data['verified'] = verified;
    data['firebase_key'] = firebaseKey;
    data['image'] = image;
    data['address'] = address;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
