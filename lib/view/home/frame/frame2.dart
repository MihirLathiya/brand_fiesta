import 'package:brand_fiesta/controller/edit_post_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/view/home/frame/bulletin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// FRAME 2
Padding BuildFrame2(EditPostController controller, double height,
    double imageHeight, double imageWidth) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.sp),
    child: Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            height: height,
            width: Get.width,
            imageUrl: '${controller.graphicList[controller.selectGraphic]}',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.error_outline),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),

          if (controller.selectFrame != -1)
            SvgPicture.asset(
              controller.frameList[controller.selectFrame],
              fit: BoxFit.fill,
              height: height,
              width: Get.width,
            ),

          /// MAIL & WEBSITE
          Positioned(
            bottom: 25.sp,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: controller.mail,
                    child: Row(
                      children: [
                        bulletin(borderColor: AppColor.bulletBlack),
                        SizedBox(
                          width: 6.sp,
                        ),
                        TextSize8WeightBoldBlack(
                            text: '${controller.email}',
                            controller: controller),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.website,
                    child: Row(
                      children: [
                        TextSize8WeightBoldBlack(
                            text: '${controller.url}', controller: controller),
                        SizedBox(
                          width: 6.sp,
                        ),
                        bulletin(borderColor: AppColor.bulletBlack),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          /// ADDRESS
          Positioned(
            bottom: 3.sp,
            child: Visibility(
              visible: controller.location,
              child: Row(
                children: [
                  bulletin(borderColor: AppColor.bulletWhite),
                  SizedBox(
                    width: 6.sp,
                  ),
                  TextSize8WeightBoldWhite(
                    controller: controller,
                    text: '${controller.address}',
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 24.sp,
            child: Column(
              children: [
                Visibility(
                  visible: controller.profile,
                  child: TextSize6WeightBoldWhite(
                    text: '${controller.name}',
                    controller: controller,
                  ),
                ),
                Visibility(
                  visible: controller.call,
                  child: TextSize6WeightBoldWhite(
                    controller: controller,
                    text: '${controller.number}',
                  ),
                ),
              ],
            ),
          ),

          ///WEBSITE
          // Positioned(
          //   bottom: 5.sp,
          //   right: 10.sp,
          //   child: Visibility(
          //     visible: controller.website,
          //     child: Row(
          //       children: [
          //         Text(
          //           '${controller.url}',
          //           style: TextStyle(
          //             fontSize: 8.sp,
          //           ),
          //         ),
          //         SizedBox(
          //           width: 6.sp,
          //         ),
          //         buleting(borderColor: AppColor.bulletBlack),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    ),
  );
}
