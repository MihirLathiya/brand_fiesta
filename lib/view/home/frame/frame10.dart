import 'package:brand_fiesta/controller/edit_post_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/view/home/frame/bulletin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Padding BuildFrame10(EditPostController controller, double height,
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
          // CachedNetworkImage(
          //   height: imageHeight,
          //   width: imageWidth,
          //   imageUrl: '${controller.graphicList[controller.selectGraphic]}',
          //   fit: BoxFit.cover,
          //   errorWidget: (context, url, error) => Padding(
          //     padding: EdgeInsets.all(15.0),
          //     child: Icon(Icons.error_outline),
          //   ),
          //   progressIndicatorBuilder: (context, url, downloadProgress) {
          //     return Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   },
          // ),

          /// EMAIL
          Positioned(
            bottom: 22.sp,
            right: 23.sp,
            child: Visibility(
              visible: controller.mail,
              child: Row(
                children: [
                  TextSize8WeightBoldBlack(
                    controller: controller,
                    text: '${controller.email}',
                  ),
                  SizedBox(
                    width: 6.sp,
                  ),
                  bulletin(borderColor: AppColor.bulletBlack),
                ],
              ),
            ),
          ),

          /// NUMBER
          Positioned(
            bottom: 22.sp,
            left: 23.sp,
            child: Visibility(
              visible: controller.call,
              child: Row(
                children: [
                  bulletin(borderColor: AppColor.bulletBlack),
                  SizedBox(
                    width: 6.sp,
                  ),
                  TextSize8WeightBoldBlack(
                    controller: controller,
                    text: '${controller.number}',
                  ),
                ],
              ),
            ),
          ),

          /// LINK
          Positioned(
            bottom: 22.sp,
            child: Visibility(
              visible: controller.website,
              child: Row(
                children: [
                  bulletin(borderColor: AppColor.bulletBlack),
                  SizedBox(
                    width: 6.sp,
                  ),
                  TextSize8WeightBoldBlack(
                    controller: controller,
                    text: '${controller.url}',
                  ),
                ],
              ),
            ),
          ),

          /// ADDRESS
          Positioned(
            bottom: 7.sp,
            child: Visibility(
              visible: controller.location,
              child: Row(
                children: [
                  bulletin(borderColor: AppColor.bulletBlack),
                  SizedBox(
                    width: 6.sp,
                  ),
                  TextSize8WeightBoldBlack(
                    controller: controller,
                    text: '${controller.address}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
