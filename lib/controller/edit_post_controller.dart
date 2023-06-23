import 'dart:typed_data';

import 'package:brand_fiesta/Hive_model/all_event_data_model.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/get_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPostController extends GetxController {
  AllEventDetailModel? eventData;
  updateEventData(AllEventDetailModel data) {
    eventData = data;
  }

  String name = '';
  String number = '';
  String email = '';
  String url = '';
  String address = '';
  Uint8List? logo;
  @override
  void onInit() {
    try {
      fonts = GoogleFonts.asMap().keys.toList();
    } catch (e) {
      print('----FONT ERROR---');
    }

    name = PreferenceManager.getName() == '' ||
            PreferenceManager.getName().toString() == 'null'
        ? 'Name'
        : PreferenceManager.getName();
    number = PreferenceManager.getMobile() == '' ||
            PreferenceManager.getMobile().toString() == 'null'
        ? 'Mobile'
        : PreferenceManager.getMobile();
    email = PreferenceManager.getEmail() == '' ||
            PreferenceManager.getEmail().toString() == 'null'
        ? 'Email'
        : PreferenceManager.getEmail();
    url = PreferenceManager.getWebsite() == '' ||
            PreferenceManager.getWebsite().toString() == 'null'
        ? 'Website'
        : PreferenceManager.getWebsite();
    address = PreferenceManager.getAddress() == '' ||
            PreferenceManager.getAddress().toString() == 'null'
        ? 'Address'
        : PreferenceManager.getAddress();
    print(
        '---PreferenceManager.getImage() == null----${PreferenceManager.getImage() == null}');
    print(
        '---PreferenceManager.getImage() == null----${PreferenceManager.getImage().runtimeType}');
    ;
    logo = getImageBinary(PreferenceManager.getImage());
    super.onInit();
  }

  Uint8List getImageBinary(dynamicList) {
    try {
      List<int> intList =
          dynamicList.cast<int>().toList(); //This is the magical line.
      Uint8List data = Uint8List.fromList(intList);
      return data;
    } catch (e) {
      return Uint8List(10);
    }
  }

  /// FOR TAB BAR
  List<String> editType = [
    'Frame',
    'Graphic',
    'Fonts',
  ];

  /// GRAPHIC LIST
  List graphicList = [];

  /// FOR POSITION
  List<String> positionList = [
    'Top-Left',
    'Top-Center',
    'Top-Right',
    'Down-Left',
    'Down-Center',
    'Down-Right',
  ];

  /// FRAME LIST
  List<String> frameList = [
    AssetPath.frame1,
    AssetPath.frame2,
    AssetPath.frame3,
    AssetPath.frame4,
    AssetPath.frame5,
    AssetPath.frame6,
    AssetPath.frame7,
    AssetPath.frame8,
    AssetPath.frame9,
    AssetPath.frame10,
  ];

  /// FOR TAB BAR
  int selectType = 0;

  /// FOR SELECT FRAME
  int selectFrame = 0;

  /// FOR SELECT GRAPHIC
  int selectGraphic = 0;

  /// FOR SELECT POSITION
  int selectPosition = 1;

  /// FOR SELECT STOCK
  // int selectStock = 0;
  // int isShowStockAdd = 0;

  /// FOR SELECT FONT
  int selectFont = 0;

  List fonts = [];

  /// FOR INFOS
  bool profile = true;
  bool call = true;
  bool mail = true;
  bool location = true;
  bool website = true;
  bool image = true;

  /// FOR profile
  updateProfileType() {
    profile = !profile;
    update();
  }

  /// FOR call
  updateCallType() {
    call = !call;
    update();
  }

  /// FOR mail
  updateMailType() {
    mail = !mail;
    update();
  }

  /// FOR location
  updateLocationType() {
    location = !location;
    update();
  }

  /// FOR website
  updateWebSiteType() {
    website = !website;
    update();
  }

  /// FOR image
  updateImageType() {
    image = !image;
    update();
  }

  /// FOR TAB BAR
  updateSelectType(int value) {
    selectType = value;
    update();
  }

  /// FOR UPDATE FRAME
  updateUpdateFrame(int value) {
    selectFrame = value;
    update();
  }

  /// FOR UPDATE GRAPHIC
  updateUpdateGraphic(int value) {
    selectGraphic = value;
    update();
  }

  /// FOR UPDATE POSITION
  updateUpdatePosition(int value) {
    selectPosition = value;
    update();
  }

  /// FOR UPDATE FONT
  updateUpdateFont(int value) {
    selectFont = value;
    update();
  }

  /// Update graphicList
  updateGraphicList(List graphic) {
    graphicList.clear();
    graphicList = graphic;
    update();
  }
}
