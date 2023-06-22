import 'package:brand_fiesta/Hive_model/all_banner_model.dart';
import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:brand_fiesta/controller/home_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/common_text.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:brand_fiesta/utils/tiles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 70,
        // backgroundColor: Colors.red,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AssetPath.appLogo,
                height: size * 40,
                width: size * 40,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {},
                  child: Container(
                    height: size * 41,
                    width: size * 41,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColor.red,
                        )),
                    child: Center(
                      child: SvgPicture.asset(
                        AssetPath.homeGallery,
                        height: size * 25,
                        width: size * 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<Box<AllBannerDetailModel>>(
                  valueListenable: HiveBoxes.getBannerData().listenable(),
                  builder: (context, value, _) {
                    var data =
                        value.values.toList().cast<AllBannerDetailModel>();

                    return data.isEmpty
                        ? Center(
                            child: Text(
                            'No Data',
                            style: TextStyle(fontSize: 15),
                          ))
                        : Column(
                            children: [
                              CarouselSlider.builder(
                                carouselController:
                                    controller.carouselController,
                                itemCount: data.length,
                                itemBuilder: (BuildContext context,
                                    int itemIndex, int pageViewIndex) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      height: 180 * size,
                                      width: Get.width,
                                      imageUrl:
                                          '${data[itemIndex].bannerImage}',
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Icon(Icons.error_outline,
                                            color: AppColor.red),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) {
                                        return Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.4),
                                          highlightColor:
                                              Colors.grey.withOpacity(0.2),
                                          enabled: true,
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: 180 * size,
                                  viewportFraction: 0.9,
                                  initialPage: controller.selectCarouselPage,
                                  enableInfiniteScroll: false,
                                  reverse: false,
                                  autoPlayInterval: Duration(seconds: 1),
                                  autoPlayAnimationDuration:
                                      Duration(seconds: 3),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.2,
                                  onPageChanged: (index, reason) {
                                    controller.updateCarouselPage(index);
                                  },
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              SizedBox(
                                height: 12 * size,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    data.length,
                                    (index) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 5),
                                        height: controller.selectCarouselPage ==
                                                index
                                            ? 12 * size
                                            : 8 * size,
                                        width: controller.selectCarouselPage ==
                                                index
                                            ? 12 * size
                                            : 8 * size,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color:
                                              controller.selectCarouselPage ==
                                                      index
                                                  ? AppColor.red
                                                  : AppColor.blue,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 1.5,
                                            color:
                                                controller.selectCarouselPage ==
                                                        index
                                                    ? AppColor.white
                                                    : AppColor.transparent,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          );
                  },
                ),

                SizedBox(
                  height: 13 * size,
                ),

                /// UPCOMING EVENTS
                HeadingTile(
                  name: 'Upcoming Events',
                  viewMore: () {},
                ),
                SizedBox(
                  height: 5 * size,
                ),

                ValueListenableBuilder<Box<AllEventDetailModel>>(
                  valueListenable: HiveBoxes.getAllEventData().listenable(),
                  builder: (context, value, _) {
                    var data =
                        value.values.toList().cast<AllEventDetailModel>();

                    return data.isEmpty
                        ? Center(
                            child: Text(
                            'No Data',
                            style: TextStyle(fontSize: 15),
                          ))
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  data.length,
                                  (index) {
                                    return data[index].upcoming == true
                                        ? Padding(
                                            padding: index == 0
                                                ? EdgeInsets.only(
                                                    left: 16 * size,
                                                    right: 8 * size)
                                                : EdgeInsets.symmetric(
                                                    horizontal: 8.0 * size),
                                            child: Container(
                                              width: 100 * size,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20 * size),
                                                      child: CachedNetworkImage(
                                                        height: 100 * size,
                                                        width: 100 * size,
                                                        imageUrl:
                                                            '${data[index].thumbNail}',
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15.0),
                                                          child: Icon(Icons
                                                              .error_outline),
                                                        ),
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                Shimmer
                                                                    .fromColors(
                                                          baseColor: Colors.grey
                                                              .withOpacity(0.4),
                                                          highlightColor: Colors
                                                              .grey
                                                              .withOpacity(0.2),
                                                          enabled: true,
                                                          child: Container(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5 * size,
                                                  ),
                                                  CommonText(
                                                    text:
                                                        '${data[index].eventName}',
                                                    maxLine: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12 * font,
                                                    color: AppColor.white,
                                                  ),
                                                  SizedBox(
                                                    height: 3 * size,
                                                  ),
                                                  CommonText(
                                                    text:
                                                        '${data[index].dateTime}',
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10 * font,
                                                    color: AppColor.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox();
                                  },
                                )
                              ],
                            ),
                          );
                  },
                ),

                SizedBox(
                  height: 20 * size,
                ),

                ///
                ValueListenableBuilder<Box<AllEventDetailModel>>(
                  valueListenable: HiveBoxes.getAllEventData().listenable(),
                  builder: (context, value, _) {
                    var data =
                        value.values.toList().cast<AllEventDetailModel>();

                    return data.isEmpty
                        ? Center(
                            child: Text(
                            'No Data',
                            style: TextStyle(fontSize: 15),
                          ))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Get.width,
                                      child: HeadingTile(
                                        name: '${data[index].eventName}',
                                        viewMore: () {},
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...List.generate(
                                            10,
                                            (index) {
                                              return Padding(
                                                padding: index == 0
                                                    ? EdgeInsets.only(
                                                        left: 16 * size,
                                                        right: 8 * size)
                                                    : EdgeInsets.symmetric(
                                                        horizontal: 8.0 * size),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20 * size),
                                                    child: CachedNetworkImage(
                                                      height: 100 * size,
                                                      width: 100 * size,
                                                      imageUrl:
                                                          'https://wallpapercave.com/fwp/wp12455757.jpg',
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Padding(
                                                        padding: EdgeInsets.all(
                                                            15.0),
                                                        child: Icon(Icons
                                                            .error_outline),
                                                      ),
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Shimmer
                                                                  .fromColors(
                                                        baseColor: Colors.grey
                                                            .withOpacity(0.4),
                                                        highlightColor: Colors
                                                            .grey
                                                            .withOpacity(0.2),
                                                        enabled: true,
                                                        child: Container(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
