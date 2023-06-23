import 'dart:async';
import 'dart:collection';

import 'package:brand_fiesta/Hive_model/all_banner_model.dart';
import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:brand_fiesta/utils/get_storage.dart';
import 'package:brand_fiesta/utils/snack_bar.dart';
import 'package:brand_fiesta/view/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SplashController extends GetxController {
  bool? isLoadingData = false;

  updateLoadingData(bool value) {
    isLoadingData = value;
    update();
  }

  Future<void> getData(BuildContext context) async {
    int todayDate = 0;
    int yesterday = 1;
    try {
      todayDate =
          int.parse(DateTime.now().toString().split(' ').first.split('-').last);

      yesterday = PreferenceManager.getDateTime() == null
          ? int.parse(DateTime.now()
              .subtract(Duration(days: 1))
              .toString()
              .split(' ')
              .first
              .split('-')
              .last)
          : int.parse(PreferenceManager.getDateTime()
              .toString()
              .split(' ')
              .first
              .split('-')
              .last);

      print('----yesterday--$yesterday');
      print('----todayDate--$todayDate');
    } catch (e) {
      print('----ERROR--$e');
    }

    if (todayDate != yesterday) {
      updateLoadingData(true);
      try {
        final box = HiveBoxes.getAllEventData();
        final bannerBox = HiveBoxes.getBannerData();
        box.clear();
        bannerBox.clear();
        CollectionReference _collectionRef =
            await FirebaseFirestore.instance.collection('Events');
        CollectionReference _bannerCollectionRef =
            await FirebaseFirestore.instance.collection('Banner');
        QuerySnapshot querySnapshot = await _collectionRef.get();
        QuerySnapshot bannerQuerySnapshot = await _bannerCollectionRef.get();
        final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
        final allBannerData =
            bannerQuerySnapshot.docs.map((doc) => doc.data()).toList();

        for (int i = 0; i < allData.length; i++) {
          final resultList =
              Map<String, dynamic>.from(allData[i] as LinkedHashMap);
          AllEventDetailModel model = AllEventDetailModel(
              docId: '${resultList['docId']}',
              eventName: '${resultList['eventName']}',
              thumbNail: '${resultList['thumbnail']}',
              dateTime: formatTimestamp(resultList['eventDate']),
              upcoming: resultList['upcoming'],
              eventImage: resultList['eventImage']);
          box.add(model);
          model.save();
        }
        for (int i = 0; i < allBannerData.length; i++) {
          final resultList =
              Map<String, dynamic>.from(allBannerData[i] as LinkedHashMap);
          AllBannerDetailModel model = AllBannerDetailModel(
            docId: '${resultList['docId']}',
            bannerImage: '${resultList['bannerImage']}',
            bannerName: '${resultList['name']}',
            dateTime: formatTimestamp(resultList['bannerDate']),
          );
          bannerBox.add(model);
          model.save();
        }

        updateLoadingData(false);
        PreferenceManager.setDateTime(DateTime.now().toString());
        Get.offAll(() => BottomNavBarScreen());
      } catch (e) {
        print('----ERROR--_$e');
        CommonSnackBar.getErrorSnackBar(
            context: context, message: 'Restart the app!', second: 10);
        updateLoadingData(false);
      }
    } else {
      Get.offAll(() => BottomNavBarScreen());
      print('----UNCALL---');
    }
  }

  String formatTimestamp(Timestamp timestamp) {
    var format = new DateFormat('yyyy-MM-dd'); // <- use skeleton here
    return format.format(timestamp.toDate());
  }
}
