import 'dart:io';

import 'package:brand_fiesta/Hive_model/brand_details_model.dart';
import 'package:brand_fiesta/controller/bottom_bar_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'controller/brand_details/add_deatils_controller.dart';
import 'controller/brand_details/brand_details_controller.dart';
import 'controller/brand_details/edit_deatils_controller.dart';
import 'controller/splash_controller.dart';
import 'view/bottom_nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  Hive.registerAdapter(BrandDetailsModelAdapter());
  await Hive.openBox<BrandDetailsModel>(detailsBox);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Brand Fiesta',
      debugShowCheckedModeBanner: false,
      initialBinding: BaseBindings(),
      theme: ThemeData(
          fontFamily: 'Source Sans Pro',
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColor.black,
          appBarTheme: AppBarTheme(backgroundColor: AppColor.black)),
      // home: SplashScreen(),
      home: BottomNavBarScreen(),
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => BottomBarController(), fenix: true);
    Get.lazyPut(() => AddDetailsController(), fenix: true);
    Get.lazyPut(() => BrandDetailsController(), fenix: true);
    Get.lazyPut(() => EditDetailsController(), fenix: true);
  }
}
