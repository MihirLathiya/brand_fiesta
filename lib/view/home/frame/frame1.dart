import 'package:brand_fiesta/controller/edit_post_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/get_storage.dart';
import 'package:brand_fiesta/view/home/frame/bulletin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// FRAME 1
BuildFrame1(EditPostController controller, double height, double imageHeight,
    double imageWidth) {
  Widget imageWidget = PreferenceManager.getImage() == null
      ? SvgPicture.asset(
          AssetPath.logoText,
          fit: BoxFit.fill,
          height: 34.sp,
          width: 132.sp,
        )
      : Visibility(
          visible: controller.image,
          child: Image.memory(
            controller.logo!,
            height: 40.sp,
            width: 40.sp,
            fit: BoxFit.cover,
          ),
        );

  Widget emailWidget = Visibility(
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
  );
  Widget profileNameWidget = Visibility(
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
  );
  Widget locationWidget = Visibility(
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
  );
  Widget numberWidget = Visibility(
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
  );
  Widget websiteWidget = Visibility(
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
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Stack(
      clipBehavior: Clip.none,
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
        if (controller.selectFrame == 1)
          SvgPicture.asset(
            controller.frameList[controller.selectFrame],
            fit: BoxFit.fill,
            height: height,
            width: Get.width,
          ),
        Positioned(
          left: controller.emailPosition.dx - 16,
          top: controller.emailPosition.dy - 125.sp,
          child: Draggable(
            maxSimultaneousDrags: 1,
            feedback: emailWidget,
            childWhenDragging: Opacity(
              opacity: .3,
              child: emailWidget,
            ),
            onDragEnd: (details) =>
                controller.updateEmailPosition(details.offset),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {
                    print('-----------OBG-----');
                  },
                  child: emailWidget),
            ),
          ),
        ),
        Positioned(
          left: controller.namePosition.dx - 16,
          top: controller.namePosition.dy - 125.sp,
          child: Draggable(
            maxSimultaneousDrags: 1,
            feedback: profileNameWidget,
            childWhenDragging: Opacity(
              opacity: .3,
              child: profileNameWidget,
            ),
            onDragEnd: (details) =>
                controller.updateNamePosition(details.offset),
            child: profileNameWidget,
          ),
        ),
        Positioned(
          left: controller.addressPosition.dx - 16,
          top: controller.addressPosition.dy - 125.sp,
          child: Draggable(
            maxSimultaneousDrags: 1,
            feedback: locationWidget,
            childWhenDragging: Opacity(
              opacity: .3,
              child: locationWidget,
            ),
            onDragEnd: (details) =>
                controller.updateAddressPosition(details.offset),
            child: locationWidget,
          ),
        ),
        Positioned(
          left: controller.numberPosition.dx - 16,
          top: controller.numberPosition.dy - 125.sp,
          child: Draggable(
            maxSimultaneousDrags: 1,
            feedback: numberWidget,
            childWhenDragging: Opacity(
              opacity: .3,
              child: numberWidget,
            ),
            onDragEnd: (details) =>
                controller.updateNumberPosition(details.offset),
            child: numberWidget,
          ),
        ),
        Positioned(
          left: controller.websitePosition.dx - 16,
          top: controller.websitePosition.dy - 125.sp,
          child: Draggable(
            maxSimultaneousDrags: 1,
            feedback: websiteWidget,
            childWhenDragging: Opacity(
              opacity: .3,
              child: websiteWidget,
            ),
            onDragEnd: (details) =>
                controller.updateWebsitePosition(details.offset),
            child: websiteWidget,
          ),
        ),
        Positioned(
          left: controller.imagePosition.dx - 16,
          top: controller.imagePosition.dy - 125.sp,
          child: Draggable(
            maxSimultaneousDrags: 1,
            feedback: imageWidget,
            childWhenDragging: Opacity(
              opacity: .3,
              child: imageWidget,
            ),
            onDragEnd: (details) =>
                controller.updateImagePosition(details.offset),
            child: imageWidget,
          ),
        ),
      ],
    ),
  );
}
