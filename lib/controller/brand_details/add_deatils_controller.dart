import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddDetailsController extends GetxController {
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

  void setByDefault() {
    brandNameTextController.clear();
    contactNoTextController.clear();
    emailTextController.clear();
    websiteTextController.clear();
    addressTextController.clear();
    imageFile = null;
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
