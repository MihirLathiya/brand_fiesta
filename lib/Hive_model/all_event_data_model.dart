import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

part 'all_event_data_model.g.dart';

// flutter packages pub run build_runner build
@HiveType(typeId: 2)
class AllEventDetailModel extends HiveObject {
  @HiveField(0)
  final String? docId;

  @HiveField(1)
  final String? eventName;

  @HiveField(2)
  final bool? upcoming;

  @HiveField(3)
  final dynamic thumbNail;

  @HiveField(4)
  String? dateTime;

  AllEventDetailModel(
      {this.docId,
      this.upcoming,
      this.thumbNail,
      this.eventName,
      this.dateTime});
}
