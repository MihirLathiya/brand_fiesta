import 'package:flutter/material.dart';

class CommonSnackBar {
  static getSuccessSnackBar({BuildContext? context, String? message}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static getErrorSnackBar(
      {BuildContext? context, String? message, required int second}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: second),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
