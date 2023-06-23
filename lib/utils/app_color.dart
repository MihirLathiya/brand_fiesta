import 'package:flutter/material.dart';

/// APP COLOR
class AppColor {
  static const Color red = Color.fromRGBO(172, 0, 0, 0.8);
  static const Color blue = Color.fromRGBO(11, 60, 67, 0.72);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color white1 = Color.fromRGBO(215, 215, 215, 1);
  static const Color cyan = Color.fromRGBO(0, 158, 225, 1);
  static const Color grey = Color.fromRGBO(34, 34, 34, 1);
  static const Color transparent = Colors.transparent;
  static const textBlack = Color(0xff030D12);
  static const textGrey = Color(0xffADADAD);

  /// Text Color

  /// BULLET COLOR
  static const bulletBlack = Colors.black;
  static const bulletWhite = Colors.white;
  static const bulletOrange = Colors.orange;
}

/// GRADIENT
class AppGradient {
  static const LinearGradient redBlack = LinearGradient(
    colors: [
      Color.fromRGBO(172, 0, 0, .5),
      Color.fromRGBO(172, 0, 0, .095),
    ],
  );
  static const LinearGradient cyanBlack = LinearGradient(
    colors: [
      Color.fromRGBO(0, 158, 225, 0.5),
      Color.fromRGBO(0, 158, 225, 0.08),
    ],
  );
  static const LinearGradient blueBlack = LinearGradient(
    colors: [
      Color.fromRGBO(11, 60, 67, 0.72),
      Color.fromRGBO(11, 60, 67, 0.25),
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );
  static const LinearGradient purpleBlack = LinearGradient(
    colors: [
      Color.fromRGBO(89, 18, 155, 0.5),
      Color.fromRGBO(89, 18, 155, 0.05),
    ],
  );
  static const LinearGradient yellowBlack = LinearGradient(
    colors: [
      Color.fromRGBO(255, 205, 1, 0.5),
      Color.fromRGBO(255, 205, 1, 0.14),
    ],
  );
  static const LinearGradient greenBlack = LinearGradient(
    colors: [
      Color.fromRGBO(59, 218, 190, 0.5),
      Color.fromRGBO(59, 218, 190, 0.05),
    ],
  );
  static const LinearGradient darkGreenBlack = LinearGradient(
    colors: [
      Color.fromRGBO(11, 60, 67, 0.25),
      Color.fromRGBO(11, 60, 67, 0.72),
    ],
  );
}
