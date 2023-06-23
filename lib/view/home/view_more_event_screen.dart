import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:brand_fiesta/controller/view_detail_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/common_text.dart';
import 'package:brand_fiesta/utils/font_style.dart';
import 'package:brand_fiesta/view/home/view_event_image_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ViewMoreEventScreen extends StatefulWidget {
  final String? title;
  final List<AllEventDetailModel>? data;
  const ViewMoreEventScreen({Key? key, this.title, this.data})
      : super(key: key);

  @override
  State<ViewMoreEventScreen> createState() => _ViewMoreEventScreenState();
}

class _ViewMoreEventScreenState extends State<ViewMoreEventScreen> {
  ViewDetailController viewDetailController = Get.find();

  @override
  void initState() {
    viewDetailController.updateAllEventData(widget.data!);
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
            itemCount: controller.allEvent.length,
            itemBuilder: (context, index) {
              return controller.allEvent[index].upcoming == true
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => ViewMoreImageScreen(
                                data: controller.allEvent[index],
                                title: controller.allEvent[index].eventName,
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.sp),
                            child: CachedNetworkImage(
                              height: 189.sp,
                              width: 189.sp,
                              imageUrl:
                                  '${controller.allEvent[index].thumbNail}',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Icon(Icons.error_outline),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) {
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
                        ),
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(vertical: 6.sp),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15.sp, vertical: 8.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: AppColor.blue,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${DateFormat.MMMd().format(DateTime.parse(controller.allEvent[index].dateTime!))}',
                            style: FontTextStyle.kWhite16W700Poppins,
                          ),
                        )
                      ],
                    )
                  : SizedBox();
            },
          );
        },
      ),
    );
  }
}
