import 'package:brand_fiesta/controller/splash_controller.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.find();

  @override
  void initState() {
    splashController.videoPlayerInitialize();
    splashController.navigation();
    super.initState();
  }

  @override
  void dispose() {
    splashController.videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.videoController.value.isInitialized
                  ? Center(
                      child: SizedBox(
                        height: size * 380,
                        width: size * 380,
                        child: VideoPlayer(controller.videoController),
                      ),
                    )
                  : Center(
                      child: SvgPicture.asset(
                        AssetPath.logo,
                        height: size * 200,
                        width: size * 350,
                        fit: BoxFit.cover,
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}
