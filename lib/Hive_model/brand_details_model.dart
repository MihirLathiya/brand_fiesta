import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

part 'brand_details_model.g.dart';

// flutter packages pub run build_runner build
@HiveType(typeId: 1)
class BrandDetailsModel extends HiveObject {
  @HiveField(0)
  final Uint8List image;

  @HiveField(1)
  late final String name;

  @HiveField(2)
  late final String website;

  @HiveField(3)
  late final String contactNumber;

  @HiveField(4)
  late final String emailId;

  @HiveField(5)
  final String dateTime;

  @HiveField(6)
  late final String address;

  BrandDetailsModel(
      {required this.image,
      required this.website,
      required this.address,
      required this.name,
      required this.contactNumber,
      required this.emailId,
      required this.dateTime});
}
