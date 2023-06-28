import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:brand_fiesta/controller/edit_post_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/common_text.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:brand_fiesta/utils/font_style.dart';
import 'package:brand_fiesta/view/home/frame/frame1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class EditPostScreen extends StatefulWidget {
  final AllEventDetailModel? data;
  final int? index;
  EditPostScreen({Key? key, this.data, this.index});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen>
    with SingleTickerProviderStateMixin {
  EditPostController editPostController = Get.find();
  WidgetsToImageController imageController = WidgetsToImageController();

  @override
  void initState() {
    editPostController.updateEventData(widget.data!);
    editPostController.updateUpdateGraphic(widget.index!);
    editPostController.updateGraphicList(widget.data!.eventImage!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;
    return Scaffold(
      body: GetBuilder<EditPostController>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(
                height: 125.sp,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30 * size),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20 * size),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CommonText(
                        text: 'Post',
                        color: AppColor.white,
                        fontSize: 20 * font,
                        fontWeight: FontWeight.w600,
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              final bytes = await imageController.capture();

                              try {
                                final time = DateTime.now()
                                    .toIso8601String()
                                    .replaceAll('.', '-')
                                    .replaceAll(':', '-');
                                final name = 'branding$time';
                                final result =
                                    await ImageGallerySaver.saveImage(bytes!,
                                        name: name);
                              } catch (e) {
                                print('Failed to download the file: $e');
                              }
                            },
                            child: SvgPicture.asset(
                              AssetPath.down,
                              height: 25 * size,
                              width: 25 * size,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16 * size,
                      )
                    ],
                  ),
                ),
              ),

              WidgetsToImage(
                controller: imageController,
                child:
                    buildImage(controller, 400 * size, 288 * size, 285 * size),
              ),
              SizedBox(
                height: 24 * size,
              ),
              Container(
                height: 44 * size,
                width: Get.width,
                color: AppColor.blue,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateProfileType();
                        },
                        child: SvgPicture.asset(
                          controller.profile == true
                              ? AssetPath.on
                              : AssetPath.on50,
                          height: 32 * size,
                          width: 32 * size,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateCallType();
                        },
                        child: SvgPicture.asset(
                          controller.call == true
                              ? AssetPath.phone
                              : AssetPath.phone50,
                          height: 32 * size,
                          width: 32 * size,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateMailType();
                        },
                        child: SvgPicture.asset(
                          controller.mail == true
                              ? AssetPath.mail
                              : AssetPath.mail50,
                          height: 32 * size,
                          width: 32 * size,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateLocationType();
                        },
                        child: SvgPicture.asset(
                          controller.location == true
                              ? AssetPath.address
                              : AssetPath.address50,
                          height: 32 * size,
                          width: 32 * size,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateWebSiteType();
                        },
                        child: SvgPicture.asset(
                          controller.website == true
                              ? AssetPath.website
                              : AssetPath.website50,
                          height: 32 * size,
                          width: 32 * size,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateImageType();
                        },
                        child: SvgPicture.asset(
                          controller.image == true
                              ? AssetPath.image
                              : AssetPath.logo50,
                          height: 32 * size,
                          width: 32 * size,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16 * size,
              ),

              /// EDIT  CUSTOM TABBAR
              Container(
                height: 50 * size,
                width: Get.width,
                color: AppColor.blue,
                padding: EdgeInsets.only(left: 20 * size),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        controller.editType.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              controller.updateSelectType(index);
                            },
                            child: SizedBox(
                              width: 140 * size,
                              height: 35 * size,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  controller.selectType == index
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            AssetPath.options,
                                          ),
                                        )
                                      : SizedBox(),
                                  Text(
                                    '${controller.editType[index]}',
                                    style: controller.selectType == index
                                        ? FontTextStyle.kWhite18W600Poppins
                                        : FontTextStyle.kBlack18W600Poppins,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /// FOR FRAME
              if (controller.selectType == 0)
                Expanded(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16 * size, vertical: 20 * size),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 7 * size,
                    crossAxisSpacing: 7 * size,
                    itemCount: controller.frameList.length,
                    itemBuilder: (context, frameIndex) {
                      return GestureDetector(
                        onTap: () {
                          controller.updateUpdateFrame(frameIndex);
                        },
                        child: Container(
                          height: 128 * size,
                          width: Get.width,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8 * size),
                            color: AppColor.blue,
                            border: Border.all(
                              color: controller.selectFrame == frameIndex
                                  ? AppColor.red
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: controller.frameList[frameIndex].isEmpty
                              ? Image.asset(
                                  AssetPath.no_frame,
                                  height: 60,
                                  width: 60,
                                )
                              : SvgPicture.asset(
                                  controller.frameList[frameIndex],
                                  fit: BoxFit.fill,
                                ),
                        ),
                      );
                    },
                  ),
                ),

              /// FOR GRAPHIC
              if (controller.selectType == 1)
                Expanded(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16 * size, vertical: 20 * size),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 7 * size,
                    crossAxisSpacing: 7 * size,
                    itemCount: controller.graphicList.length,
                    itemBuilder: (context, graphicIndex) {
                      return GestureDetector(
                        onTap: () {
                          controller.updateUpdateGraphic(graphicIndex);
                        },
                        child: Container(
                          height: 128 * size,
                          width: Get.width,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8 * size),
                            color: AppColor.blue,
                            border: Border.all(
                              color: controller.selectGraphic == graphicIndex
                                  ? AppColor.red
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8 * size),
                            child: CachedNetworkImage(
                                height: 128 * size,
                                width: Get.width,
                                imageUrl:
                                    '${controller.graphicList[graphicIndex]}',
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Icon(Icons.error_outline),
                                    ),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                          child: CircularProgressIndicator(),
                                        )),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              /// FOR FONT
              if (controller.selectType == 2)
                Expanded(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16 * size, vertical: 20 * size),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 7 * size,
                    crossAxisSpacing: 7 * size,
                    itemCount: controller.fonts.length,
                    itemBuilder: (context, fontIndex) {
                      return GestureDetector(
                        onTap: () {
                          controller.updateUpdateFont(fontIndex);
                        },
                        child: Container(
                          height: 128 * size,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8 * size),
                            color: AppColor.blue,
                            border: Border.all(
                              color: controller.selectFont == fontIndex
                                  ? AppColor.red
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${controller.fonts[fontIndex]}',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: FontTextStyle.kBlack16W600Poppins,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

buildImage(EditPostController controller, double height, double imageHeight,
    double imageWidth) {
  return
      // controller.selectFrame == 0
      //   ?
      BuildFrame1(controller, height, imageHeight, imageWidth);
  // : controller.selectFrame == 1
  //     ? BuildFrame2(controller, height, imageHeight, imageWidth)
  //     : controller.selectFrame == 2
  //         ? BuildFrame3(controller, height, imageHeight, imageWidth)
  //         : controller.selectFrame == 3
  //             ? BuildFrame4(controller, height, imageHeight, imageWidth)
  //             : controller.selectFrame == 4
  //                 ? BuildFrame5(controller, height, imageHeight, imageWidth)
  //                 : controller.selectFrame == 5
  //                     ? BuildFrame6(
  //                         controller, height, imageHeight, imageWidth)
  //                     : controller.selectFrame == 6
  //                         ? BuildFrame7(
  //                             controller, height, imageHeight, imageWidth)
  //                         : controller.selectFrame == 7
  //                             ? BuildFrame8(controller, height, imageHeight,
  //                                 imageWidth)
  //                             : controller.selectFrame == 8
  //                                 ? BuildFrame9(controller, height,
  //                                     imageHeight, imageWidth)
  //                                 : BuildFrame10(controller, height,
  //                                     imageHeight, imageWidth);
}
