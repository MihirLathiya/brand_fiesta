import 'dart:typed_data';

import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static String dateTime = "dateTime";
  static String name = "name";
  static String mobile = "mobile";
  static String email = "email";
  static String website = "website";
  static String address = "address";
  static String brandIndex = "brandIndex";
  static String image = "image";

  ///Image
  static Future<Uint8List?> setImage(Uint8List value) async {
    await getStorage.write(image, value);
    return null;
  }

  static getImage() {
    return getStorage.read(image);
  }

  /// Brand Index
  static Future setBrandIndex(int value) async {
    await getStorage.write(brandIndex, value);
  }

  static getBrandIndex() {
    return getStorage.read(brandIndex);
  }

  ///Name
  static Future setName(String value) async {
    await getStorage.write(name, value);
  }

  static getName() {
    return getStorage.read(name);
  }

  ///mobile
  static Future setMobile(String value) async {
    await getStorage.write(mobile, value);
  }

  static getMobile() {
    return getStorage.read(mobile);
  }

  ///email
  static Future setEmail(String value) async {
    await getStorage.write(email, value);
  }

  static getEmail() {
    return getStorage.read(email);
  }

  ///website
  static Future setWebsite(String value) async {
    await getStorage.write(website, value);
  }

  static getWebsite() {
    return getStorage.read(website);
  }

  ///address
  static Future setAddress(String value) async {
    await getStorage.write(address, value);
  }

  static getAddress() {
    return getStorage.read(address);
  }

  ///Device Id
  static Future setDateTime(String value) async {
    await getStorage.write(dateTime, value);
  }

  static getDateTime() {
    return getStorage.read(dateTime);
  }

  static Future getClear() {
    return getStorage.erase();
  }
}
