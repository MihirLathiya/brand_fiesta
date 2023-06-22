import 'package:brand_fiesta/Hive_model/all_banner_model.dart';
import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:brand_fiesta/Hive_model/brand_details_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

double defaultHeight = 932.0;

class HiveBoxes {
  static Box<BrandDetailsModel> getBusinessData() =>
      Hive.box<BrandDetailsModel>(AppConstant.detailsBox);
  static Box<AllBannerDetailModel> getBannerData() =>
      Hive.box<AllBannerDetailModel>(AppConstant.allBannerBox);

  static Box<AllEventDetailModel> getAllEventData() =>
      Hive.box<AllEventDetailModel>(AppConstant.allEventBox);
}

class AppConstant {
  static var commonPadding = EdgeInsets.symmetric(horizontal: 16);
  static var sixHPadding = EdgeInsets.symmetric(horizontal: 6);
  static String personalDataBoxName = "personalData";
  static String businessDataBoxName = "businessData";
  static String downloadDataBoxName = "downloadData";
  static String detailsBox = "BrandDetails";
  static String allEventBox = "AllEvent";
  static String allBannerBox = "AllBanner";
}
