import 'dart:io';

import 'package:brand_fiesta/Hive_model/all_banner_model.dart';
import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:brand_fiesta/Hive_model/brand_details_model.dart';
import 'package:brand_fiesta/controller/bottom_bar_controller.dart';
import 'package:brand_fiesta/controller/edit_post_controller.dart';
import 'package:brand_fiesta/controller/home_controller.dart';
import 'package:brand_fiesta/controller/view_detail_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:brand_fiesta/view/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'controller/brand_details/add_deatils_controller.dart';
import 'controller/brand_details/brand_details_controller.dart';
import 'controller/brand_details/edit_deatils_controller.dart';
import 'controller/splash_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  Hive.registerAdapter(BrandDetailsModelAdapter());
  Hive.registerAdapter(AllEventDetailModelAdapter());
  Hive.registerAdapter(AllBannerDetailModelAdapter());
  await Hive.openBox<BrandDetailsModel>(AppConstant.detailsBox);
  await Hive.openBox<AllEventDetailModel>(AppConstant.allEventBox);
  await Hive.openBox<AllBannerDetailModel>(AppConstant.allBannerBox);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
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
          home: SplashScreen(),
        );
      },
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
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ViewDetailController(), fenix: true);
    Get.lazyPut(() => EditPostController(), fenix: true);
  }
}
