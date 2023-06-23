import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:brand_fiesta/controller/view_detail_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/common_text.dart';
import 'package:brand_fiesta/view/home/edit_post_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ViewMoreImageScreen extends StatefulWidget {
  final AllEventDetailModel? data;
  final String? title;
  ViewMoreImageScreen({
    Key? key,
    this.data,
    this.title,
  }) : super(key: key);

  @override
  State<ViewMoreImageScreen> createState() => _ViewMoreImageScreenState();
}

class _ViewMoreImageScreenState extends State<ViewMoreImageScreen> {
  ViewDetailController viewDetailController = Get.find();
  @override
  void initState() {
    viewDetailController.updateEventData(widget.data!);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            CommonText(
              text: widget.title!,
              color: AppColor.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        leadingWidth: 0,
      ),
      body: GetBuilder<ViewDetailController>(
        builder: (controller) {
          return MasonryGridView.count(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 20.sp,
            crossAxisSpacing: 20.sp,
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 20.sp),
            itemCount: controller.eventData!.eventImage!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(
                    () => EditPostScreen(
                      index: index,
                      data: controller.eventData,
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.sp),
                  child: CachedNetworkImage(
                    height: 150.sp,
                    width: 150.sp,
                    imageUrl: '${controller.eventData!.eventImage![index]}',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(Icons.error_outline),
                    ),
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.4),
                        highlightColor: Colors.grey.withOpacity(0.2),
                        enabled: true,
                        child: Container(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
