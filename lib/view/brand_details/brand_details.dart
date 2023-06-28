import 'dart:convert';

import 'package:brand_fiesta/Hive_model/brand_details_model.dart';
import 'package:brand_fiesta/controller/brand_details/add_deatils_controller.dart';
import 'package:brand_fiesta/controller/brand_details/brand_details_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:brand_fiesta/utils/get_storage.dart';
import 'package:brand_fiesta/view/brand_details/edit_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../brand_details/add_details_screen.dart';

class BrandDetails extends StatefulWidget {
  const BrandDetails({Key? key}) : super(key: key);

  @override
  State<BrandDetails> createState() => _BrandDetailsState();
}

class _BrandDetailsState extends State<BrandDetails> {
  BrandDetailsController brandDetailsController = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;
    return Scaffold(
      appBar: _appBar(font),
      body: GetBuilder<BrandDetailsController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size * 16),
            child: Column(
              children: [
                ///Search Filed
                _searchFiled(size, controller, font),
                SizedBox(
                  height: size * 30,
                ),

                /// List of Brand Details
                HiveBoxes.getBusinessData().length == 0
                    ? _noData(size)
                    : ValueListenableBuilder(
                        valueListenable:
                            HiveBoxes.getBusinessData().listenable(),
                        builder: (context, value, _) {
                          var data =
                              value.values.toList().cast<BrandDetailsModel>();
                          return Expanded(
                            child: ListView.separated(
                              itemCount: data.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                String _base64 =
                                    base64.encode(data[index].image);
                                var key = value.keys.toList()[index];
                                return data[index]
                                        .name
                                        .toString()
                                        .toLowerCase()
                                        .contains(controller.searchText)
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.selectedDetails = index;

                                          PreferenceManager.setName(
                                              data[index].name);
                                          PreferenceManager.setMobile(
                                              data[index].contactNumber);
                                          PreferenceManager.setEmail(
                                              data[index].emailId);
                                          PreferenceManager.setWebsite(
                                              data[index].website);
                                          PreferenceManager.setAddress(
                                              data[index].address);
                                          PreferenceManager.setImage(
                                              data[index].image);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size * 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // color: AppColor.blue,
                                              gradient: LinearGradient(
                                                colors: const [
                                                  Color.fromRGBO(
                                                      11, 60, 67, 0.72),
                                                  Color.fromRGBO(
                                                      11, 60, 67, 0.25),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size * 10),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: size * 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          height: size * 10),
                                                      Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: size * 95,
                                                              width: size * 95,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColor
                                                                    .black,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(size *
                                                                            10),
                                                              ),
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              child: Image.memory(
                                                                  base64Decode(
                                                                      _base64),
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                            SizedBox(
                                                              width: size * 15,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                height:
                                                                    size * 95,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Text(
                                                                      data[index]
                                                                          .name,
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .white,
                                                                          fontSize: font *
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              size * 4),
                                                                      child:
                                                                          Text(
                                                                        '+91 ${data[index].contactNumber}',
                                                                        style: TextStyle(
                                                                            color: AppColor
                                                                                .white,
                                                                            fontSize: font *
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      data[index]
                                                                          .emailId,
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .white,
                                                                          fontSize: font *
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ]),
                                                      SizedBox(
                                                        height: size * 8,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    size * 5),
                                                        child: Text(
                                                          '''${data[index].address}''',
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .white,
                                                              fontSize:
                                                                  font * 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size * 12,
                                                ),
                                                Column(
                                                  children: [
                                                    Divider(
                                                        height: 1,
                                                        thickness: 0.6,
                                                        color: AppColor.red),
                                                    SizedBox(
                                                      // color: AppColor.white,
                                                      height: size * 55,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          /// Selected item
                                                          Container(
                                                            height: size * 24,
                                                            width: size * 24,
                                                            decoration: BoxDecoration(
                                                                color: controller.selectedDetails ==
                                                                        index
                                                                    ? AppColor
                                                                        .red
                                                                    : Colors
                                                                        .transparent,
                                                                border: Border.all(
                                                                    color: controller.selectedDetails !=
                                                                            index
                                                                        ? AppColor
                                                                            .red
                                                                        : Colors
                                                                            .transparent,
                                                                    width: 2),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: controller
                                                                        .selectedDetails ==
                                                                    index
                                                                ? Icon(
                                                                    Icons.check,
                                                                    color: AppColor
                                                                        .white,
                                                                    size: size *
                                                                        15)
                                                                : SizedBox(),
                                                          ),
                                                          VerticalDivider(
                                                            thickness: 0.6,
                                                            color: AppColor.red,
                                                          ),

                                                          /// Edit
                                                          IconButton(
                                                              onPressed: () {
                                                                Get.to(
                                                                    EditDetailsScreen(
                                                                      keyData:
                                                                          key,
                                                                      name: data[
                                                                              index]
                                                                          .name,
                                                                      number: data[
                                                                              index]
                                                                          .contactNumber,
                                                                      email: data[
                                                                              index]
                                                                          .emailId,
                                                                      web: data[
                                                                              index]
                                                                          .website,
                                                                      address: data[
                                                                              index]
                                                                          .address,
                                                                      image: data[
                                                                              index]
                                                                          .image,
                                                                    ),
                                                                    transition:
                                                                        Transition
                                                                            .downToUp);
                                                              },
                                                              splashRadius: 20,
                                                              icon: Image.asset(
                                                                AssetPath.edit,
                                                                height:
                                                                    size * 20,
                                                                width:
                                                                    size * 20,
                                                                color: AppColor
                                                                    .white,
                                                              )),
                                                          VerticalDivider(
                                                            thickness: 0.6,
                                                            color: AppColor.red,
                                                          ),

                                                          /// Delete
                                                          IconButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(size *
                                                                                15)),
                                                                    backgroundColor:
                                                                        AppColor
                                                                            .black,
                                                                    contentPadding:
                                                                        EdgeInsets.symmetric(
                                                                            vertical:
                                                                                size * 8),
                                                                    title: Text(
                                                                      'Are you sure you want to\ndelete it?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize: size *
                                                                              20,
                                                                          color:
                                                                              AppColor.white),
                                                                    ),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              AppColor.red,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          data[index]
                                                                              .delete();
                                                                          Get.back();
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Delete',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              AppColor.white,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        child: Text(
                                                                            'Cancel',
                                                                            style:
                                                                                TextStyle(color: AppColor.red, fontWeight: FontWeight.w600)),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            splashRadius: 20,
                                                            icon: Image.asset(
                                                              AssetPath.delete,
                                                              height: size * 20,
                                                              width: size * 20,
                                                              color: AppColor
                                                                  .white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox();
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: data[index]
                                          .name
                                          .toString()
                                          .toLowerCase()
                                          .contains(controller.searchText)
                                      ? size * 30
                                      : 0,
                                );
                              },
                            ),
                          );
                        },
                      )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.red,
        onPressed: () {
          Get.find<AddDetailsController>().setByDefault();
          Get.to(() => AddDetailsScreen());
        },
        child: CircleAvatar(
          radius: size * 16,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: size * 15,
            backgroundColor: AppColor.red,
            child: Icon(Icons.add, color: Colors.white, size: size * 20),
          ),
        ),
      ),
    );
  }

  Expanded _noData(double size) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Plz enter Your Brand Details to",
            style: TextStyle(
                fontSize: size * 18,
                color: AppColor.red,
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Press “",
                  style: TextStyle(fontSize: size * 17, color: AppColor.white),
                ),
                Text(
                  " + ",
                  style: TextStyle(fontSize: size * 25, color: AppColor.red),
                ),
                Text(
                  "” option.",
                  style: TextStyle(fontSize: size * 17, color: AppColor.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _searchFiled(
      double size, BrandDetailsController controller, double font) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size * 10),
      child: TextFormField(
        controller: controller.searchTextController,
        autofocus: false,
        onChanged: (value) {
          controller.searchText = value;
        },
        textInputAction: TextInputAction.done,
        cursorColor: AppColor.red,
        style: TextStyle(
            color: AppColor.white1,
            fontSize: font * 16,
            decorationColor: AppColor.white.withOpacity(0.0),
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: "Search here",
          hintStyle: TextStyle(
            color: Color(0xffffffff),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetPath.searchIcon),
            ],
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: size * 15, horizontal: size * 30),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(11, 60, 67, 0.72), width: 1),
            borderRadius: BorderRadius.circular(size * 50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(11, 60, 67, 0.72), width: 1),
            borderRadius: BorderRadius.circular(size * 50),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(11, 60, 67, 0.72), width: 1),
            borderRadius: BorderRadius.circular(size * 50),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(11, 60, 67, 0.72), width: 1),
            borderRadius: BorderRadius.circular(size * 50),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(double font) {
    return AppBar(
      title: Text(
        "Brand Details",
        style: TextStyle(
            color: AppColor.white,
            fontSize: font * 22,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
