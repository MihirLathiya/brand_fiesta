import 'dart:async';

import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/view/bottom_nav_bar.dart';
import 'package:brand_fiesta/view/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoController;

  /// Video Player Initialize
  void videoPlayerInitialize() {
    try {
      videoController = VideoPlayerController.asset(AssetPath.splashLogo);
      videoController.initialize().then(
        (value) {
          videoController.play();
          update();
        },
      );
      videoController.setLooping(true);
    } catch (e) {
      print('************** Video Player Initialize Error ************** $e');
    }
  }

  void navigation() {
    Timer.periodic(Duration(milliseconds: 3450), (timer) {
      Get.offAll(() => BottomNavBarScreen());
    });
  }
}
