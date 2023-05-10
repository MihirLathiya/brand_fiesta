import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/view/brand_details/brand_details.dart';
import 'package:brand_fiesta/view/download/download_screen.dart';
import 'package:brand_fiesta/view/home/home_screen.dart';
import 'package:brand_fiesta/view/info/info_screen.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  List bottomIcon = [
    AssetPath.homeIcon,
    AssetPath.detailsIcon,
    AssetPath.downloadIcon,
    AssetPath.infoIcon,
  ];

  List screenList = [
    HomeScreen(),
    BrandDetails(),
    DownloadScreen(),
    InfoScreen()
  ];

  int _selectedScreen = 0;

  int get selectedScreen => _selectedScreen;

  set selectedScreen(int value) {
    _selectedScreen = value;
    update();
  }
}
