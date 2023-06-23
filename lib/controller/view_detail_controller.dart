import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:get/get.dart';

class ViewDetailController extends GetxController {
  List<AllEventDetailModel> allEvent = [];
  AllEventDetailModel? eventData;
  updateAllEventData(List<AllEventDetailModel> data) {
    allEvent = data;
  }

  updateEventData(AllEventDetailModel data) {
    eventData = data;
  }
}
