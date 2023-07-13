import 'dart:io';

import 'package:sohaib_store/preferences/app_preferences.dart';

import '../../utils/helpers.dart';

class ApiHelpers with Helpers {
  Map<String, String> get headers {
    return {
      HttpHeaders.authorizationHeader: AppPreferences().token,
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}
