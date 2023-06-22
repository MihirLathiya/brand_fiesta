import 'dart:collection';
import 'dart:convert';

import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:brand_fiesta/controller/splash_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/common_text.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  SplashController splashController = Get.find();
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _controller.forward(from: 0.0);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addListener(() {
      if (_animation.isCompleted) {
        splashController.getData(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (controller) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: _animation,
                  child: SvgPicture.asset(
                    AssetPath.appLogo,
                    height: 180,
                    width: 150,
                  ),
                ),
              ),
              if (controller.isLoadingData == true)
                Positioned(
                  bottom: 200 * size,
                  child: Container(
                    height: 80,
                    width: Get.width - 200,
                    padding: EdgeInsets.only(left: 30 * size, right: 20 * size),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.blue,
                    ),
                    child: Row(
                      children: [
                        CircularProgressIndicator(
                          color: AppColor.red,
                        ),
                        SizedBox(
                          width: 30 * size,
                        ),
                        Expanded(
                          child: CommonText(
                            text: 'Please wait a moment..',
                            maxLine: 2,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
