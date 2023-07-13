import 'dart:io';

import '../preferences/app_preferences.dart';
import 'helpers.dart';

class ApiHelpers with Helpers {
  Map<String, String> get headers {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${AppPreferences().token}',
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}
