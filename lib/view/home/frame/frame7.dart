import 'package:brand_fiesta/controller/edit_post_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/view/home/frame/bulletin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Padding BuildFrame7(EditPostController controller, double height,
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

          /// NAME & WEBSITE & NUMBER
          Positioned(
            top: 13.sp,
            left: 0.sp,
            right: 0.sp,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: controller.profile || controller.call,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: controller.profile,
                          child: Row(
                            children: [
                              bulletin(borderColor: AppColor.bulletBlack),
                              SizedBox(
                                width: 6.sp,
                              ),
                              TextSize8WeightBoldBlack(
                                controller: controller,
                                text: '${controller.name}',
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: controller.profile,
                          child: SizedBox(
                            height: 3.sp,
                          ),
                        ),
                        Visibility(
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
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.profile,
                    child: SizedBox(
                      width: 20.sp,
                    ),
                  ),
                  Visibility(
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
                  )
                ],
              ),
            ),
          ),

          /// EMAIL & ADDRESS
          Positioned(
            bottom: 12.sp,
            left: 10.sp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        controller: controller,
                        text: '${controller.email}',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.sp,
                ),
                Visibility(
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
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
