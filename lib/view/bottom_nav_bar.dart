import 'package:brand_fiesta/controller/bottom_bar_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  BottomBarController bottomBarController = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: Container(
            height: size * 85,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: size * 10, horizontal: size * 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade700.withOpacity(0.125),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size * 30),
                topRight: Radius.circular(size * 30),
              ),
            ),
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              elevation: 0.05,
              shadowColor: Colors.grey.shade500,
              surfaceTintColor: Colors.grey.shade500,
              child: Container(
                height: size * 40,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    controller.bottomIcon.length,
                    (index) => InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        controller.selectedScreen = index;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: size * 7, horizontal: size * 20),
                        decoration: BoxDecoration(
                            color: controller.selectedScreen == index
                                ? Colors.grey.shade700.withOpacity(0.125)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50)),
                        child: SvgPicture.asset(
                          controller.bottomIcon[index],
                          height: size * 23,
                          width: size * 23,
                          color: controller.selectedScreen == index
                              ? AppColor.red
                              : Color(0xffA19C9C),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: controller.screenList[controller.selectedScreen],
        );
      },
    );
  }
}
