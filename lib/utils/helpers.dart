import 'package:flutter/material.dart';

mixin Helpers {
  void showSnackBar(
      {required BuildContext context,
      required String message,
      int seconds = 4,
      bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: seconds),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  void showMessage(BuildContext? context, String message,
      {bool error = false}) {
    if (context != null) {
      showSnackBar(context: context, message: message, error: error);
    }
  }
}
