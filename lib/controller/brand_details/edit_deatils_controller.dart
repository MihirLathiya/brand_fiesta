import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditDetailsController extends GetxController {
  TextEditingController brandNameTextController = TextEditingController();
  TextEditingController contactNoTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController websiteTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();

  FocusNode? imageNode;
  FocusNode? nameNode;
  FocusNode? contactNode;
  FocusNode? emailNode;
  FocusNode? webNode;
  FocusNode? addressNode;
  FocusNode? save;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    imageNode = FocusNode();
    nameNode = FocusNode();
    contactNode = FocusNode();
    emailNode = FocusNode();
    webNode = FocusNode();
    addressNode = FocusNode();
    save = FocusNode();
    nameNode!.unfocus();
    super.onInit();
  }

  @override
  void dispose() {
    brandNameTextController.dispose();
    contactNoTextController.dispose();
    emailTextController.dispose();
    websiteTextController.dispose();
    addressTextController.dispose();
    imageNode!.dispose();
    nameNode!.dispose();
    contactNode!.dispose();
    emailNode!.dispose();
    webNode!.dispose();
    addressNode!.dispose();
    save!.dispose();
    super.dispose();
  }

  void setByDefault(
      {required String name,
      required String contact,
      required String email,
      required String website,
      required String address,
      required image}) {
    brandNameTextController.text = name;
    contactNoTextController.text = contact;
    emailTextController.text = email;
    websiteTextController.text = website;
    addressTextController.text = address;
    base64String = base64.encode(image);
    fileConvert(imageInUnit8List: image);
  }

  File? file;
  fileConvert({required Uint8List imageInUnit8List}) async {
    // Uint8List? imageInUnit8List; // store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    file = await File('${tempDir.path}/image.png').create();
    file!.writeAsBytesSync(imageInUnit8List);
    update();
    return file;
  }

  Uint8List? imageBytes;
  String? base64String;

  /// Image Picker
  final picker = ImagePicker();
  File? imageFile;

  Future pickImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = null;
      base64String = null;

      imageBytes = await pickedFile.readAsBytes();
      base64String = base64.encode(imageBytes!);
      imageFile = File(pickedFile.path);
    }
    update();
  }
}
