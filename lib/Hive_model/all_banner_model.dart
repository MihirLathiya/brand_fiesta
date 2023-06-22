import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

part 'all_banner_model.g.dart';

// flutter packages pub run build_runner build
@HiveType(typeId: 3)
class AllBannerDetailModel extends HiveObject {
  @HiveField(0)
  final String? docId;

  @HiveField(1)
  final String? bannerName;

  @HiveField(2)
  final dynamic bannerImage;

  @HiveField(3)
  String? dateTime;

  AllBannerDetailModel(
      {this.docId, this.bannerImage, this.bannerName, this.dateTime});
}
