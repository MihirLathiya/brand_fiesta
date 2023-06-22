import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static String dateTime = "dateTime";

  ///Device Id
  static Future setDateTime(DateTime value) async {
    await getStorage.write(dateTime, value);
  }

  static getDateTime() {
    return getStorage.read(dateTime);
  }

  static Future getClear() {
    return getStorage.erase();
  }
}
