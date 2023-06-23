import 'package:brand_fiesta/controller/edit_post_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/view/home/frame/bulletin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// FRAME 1
Padding BuildFrame1(EditPostController controller, double height,
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
          //if (controller.selectFrame == 0)
          Positioned(
            bottom: 25.sp,
            left: 10.sp,
            child: Row(
              children: [
                Visibility(
                  visible: controller.mail,
                  child: Row(
                    children: [
                      bulletin(borderColor: AppColor.bulletWhite),
                      SizedBox(
                        width: 6.sp,
                      ),
                      TextSize8WeightBoldBlack(
                        text: '${controller.email}',
                        controller: controller,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: controller.mail,
                  child: SizedBox(
                    width: 20.sp,
                  ),
                ),
                Visibility(
                  visible: controller.profile,
                  child: Row(
                    children: [
                      bulletin(borderColor: AppColor.bulletWhite),
                      SizedBox(
                        width: 6.sp,
                      ),
                      TextSize8WeightBoldBlack(
                        text: '${controller.name}',
                        controller: controller,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          //if (controller.selectFrame == 0)
          Positioned(
            bottom: 8.sp,
            left: 10.sp,
            child: Visibility(
              visible: controller.location,
              child: Row(
                children: [
                  bulletin(borderColor: AppColor.bulletWhite),
                  SizedBox(
                    width: 6.sp,
                  ),
                  TextSize8WeightBoldBlack(
                    text: '${controller.address}',
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
          // if (controller.selectFrame == 0)
          Positioned(
            bottom: 24.sp,
            right: 10.sp,
            child: Visibility(
              visible: controller.call,
              child: Row(
                children: [
                  TextSize8WeightBoldWhite(
                    text: '${controller.number}',
                    controller: controller,
                  ),
                  SizedBox(
                    width: 6.sp,
                  ),
                  bulletin(borderColor: AppColor.bulletWhite),
                ],
              ),
            ),
          ),
          // if (controller.selectFrame == 0)
          Positioned(
            bottom: 5.sp,
            right: 10.sp,
            child: Visibility(
              visible: controller.website,
              child: Row(
                children: [
                  TextSize8WeightBoldBlack(
                    controller: controller,
                    text: '${controller.url}',
                  ),
                  SizedBox(
                    width: 6.sp,
                  ),
                  bulletin(borderColor: AppColor.bulletBlack),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
