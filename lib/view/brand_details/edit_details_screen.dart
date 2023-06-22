import 'package:brand_fiesta/Hive_model/brand_details_model.dart';
import 'package:brand_fiesta/controller/brand_details/edit_deatils_controller.dart';
import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditDetailsScreen extends StatefulWidget {
  final String name, number, email, web, address;
  final Uint8List image;
  var keyData;
  EditDetailsScreen(
      {Key? key,
      required this.name,
      required this.number,
      required this.email,
      required this.keyData,
      required this.web,
      required this.address,
      required this.image})
      : super(key: key);

  @override
  State<EditDetailsScreen> createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  EditDetailsController editDetailsController = Get.find();

  @override
  void initState() {
    editDetailsController.setByDefault(
        name: widget.name,
        contact: widget.number,
        email: widget.email,
        website: widget.web,
        address: widget.address,
        image: widget.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;

    return Scaffold(
      bottomNavigationBar: GetBuilder<EditDetailsController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: size * 13, horizontal: size * 15),
            child: SizedBox(
              height: size * 46,
              width: Get.width,
              child: ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      var imageData = controller.imageBytes ?? widget.image;
                      BrandDetailsModel model = BrandDetailsModel(
                          image: imageData,
                          website: controller.websiteTextController.text,
                          address: controller.addressTextController.text,
                          name: controller.brandNameTextController.text,
                          contactNumber:
                              controller.contactNoTextController.text,
                          emailId: controller.emailTextController.text,
                          dateTime: DateTime.now().toString());

                      final box = HiveBoxes.getBusinessData();
                      box.put(widget.keyData, model);
                      model.save();
                      Get.back();
                    }
                  },
                  focusNode: controller.save,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10 * size),
                      )),
                  child: Text(
                    "Update Data",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: font * 18,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
          );
        },
      ),
      body: GetBuilder<EditDetailsController>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(
                height: size * 50,
              ),
              _appBar(font),
              Expanded(
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(size * 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size * 25,
                          ),

                          /// Add image
                          InkWell(
                            focusNode: controller.imageNode,
                            onTap: () {
                              controller.pickImage().then((value) {
                                controller.imageNode!.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(controller.nameNode);
                              });
                              print('Tap on pick image');
                            },
                            borderRadius: BorderRadius.circular(size * 10),
                            child: _addImage(size, font, controller),
                          ),
                          SizedBox(
                            height: size * 40,
                          ),
                          _textFiled(
                            font,
                            size,
                            title: "Brand Name",
                            hintText: "Enter Brand Name",
                            textInputType: TextInputType.name,
                            controller: controller.brandNameTextController,
                            focusNode: controller.nameNode!,
                            onFieldSubmitted: (p0) {
                              controller.nameNode!.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(controller.contactNode);
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Please Enter a Name";
                              }
                            },
                          ),
                          _textFiled(
                            font,
                            size,
                            title: "Contact Number",
                            hintText: "Enter Contact Number",
                            maxLength: 10,
                            textInputType: TextInputType.phone,
                            controller: controller.contactNoTextController,
                            focusNode: controller.contactNode!,
                            onFieldSubmitted: (p0) {
                              controller.contactNode!.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(controller.emailNode);
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Please Enter a Contact Number";
                              } else if (p0.length <= 9) {
                                return "Please Enter a valid 10 Digit Number";
                              }
                            },
                          ),
                          _textFiled(
                            font,
                            size,
                            title: "Email ID",
                            textInputType: TextInputType.emailAddress,
                            hintText: "Enter Email ID",
                            controller: controller.emailTextController,
                            focusNode: controller.emailNode!,
                            onFieldSubmitted: (p0) {
                              controller.emailNode!.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(controller.webNode);
                            },
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                              if (!regex.hasMatch(value!)) {
                                return "Enter valid Email Address";
                              }
                            },
                          ),
                          _textFiled(
                            font,
                            size,
                            title: "Website Url",
                            hintText: "Enter Website Url",
                            textInputType: TextInputType.url,
                            controller: controller.websiteTextController,
                            focusNode: controller.webNode!,
                            onFieldSubmitted: (p0) {
                              controller.webNode!.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(controller.addressNode);
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Please Enter a website url";
                              }
                            },
                          ),
                          _addressTextFiled(
                            font,
                            size,
                            title: "Address",
                            hintText: "Enter Address",
                            textInputType: TextInputType.streetAddress,
                            controller: controller.addressTextController,
                            focusNode: controller.addressNode!,
                            onFieldSubmitted: (p0) {
                              controller.addressNode!.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(controller.save);
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Please Enter a Address";
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Column _textFiled(double font, double size,
      {required TextEditingController controller,
      required String title,
      required String hintText,
      required FocusNode focusNode,
      required Function(String)? onFieldSubmitted,
      TextInputType? textInputType,
      int? maxLength,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: AppColor.white,
              fontSize: font * 17,
              fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size * 10),
          child: TextFormField(
            controller: controller,
            autofocus: false,
            textInputAction: TextInputAction.next,
            focusNode: focusNode,
            validator: validator,
            maxLength: maxLength,
            keyboardType: textInputType ?? TextInputType.text,
            onFieldSubmitted: onFieldSubmitted,
            cursorColor: AppColor.red,
            style: TextStyle(
                color: AppColor.white1,
                fontSize: font * 16,
                decorationColor: AppColor.white.withOpacity(0.0),
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              counterText: "",
              hintText: hintText,
              hintStyle: TextStyle(
                color: Color(0xffADADAD),
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: size * 15, horizontal: size * 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.cyan, width: 0.3),
                borderRadius: BorderRadius.circular(size * 10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.cyan, width: 0.3),
                borderRadius: BorderRadius.circular(size * 10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.cyan, width: 0.3),
                borderRadius: BorderRadius.circular(size * 10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.cyan, width: 0.3),
                borderRadius: BorderRadius.circular(size * 10),
              ),
              filled: true,
              fillColor: Color.fromRGBO(11, 60, 67, 0.72),
            ),
          ),
        ),
        SizedBox(
          height: size * 20,
        )
      ],
    );
  }

  Column _addressTextFiled(double font, double size,
      {required TextEditingController controller,
      required String title,
      required String hintText,
      required FocusNode focusNode,
      required Function(String)? onFieldSubmitted,
      TextInputType? textInputType,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: AppColor.white,
              fontSize: font * 17,
              fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size * 10),
          child: TextFormField(
            controller: controller,
            autofocus: false,
            validator: validator,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            textInputAction: TextInputAction.done,
            cursorColor: AppColor.red,
            style: TextStyle(
                color: AppColor.white1,
                fontSize: font * 16,
                decorationColor: AppColor.white.withOpacity(0.0),
                fontWeight: FontWeight.w500),
            maxLines: 4,
            keyboardType: textInputType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Color(0xffADADAD),
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: size * 15, horizontal: size * 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.cyan, width: 0.3),
                borderRadius: BorderRadius.circular(size * 10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.cyan, width: 0.3),
                borderRadius: BorderRadius.circular(size * 10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.cyan, width: 0.3),
                borderRadius: BorderRadius.circular(size * 10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.cyan, width: 0.3),
                borderRadius: BorderRadius.circular(size * 10),
              ),
              filled: true,
              fillColor: Color.fromRGBO(11, 60, 67, 0.72),
            ),
          ),
        ),
        SizedBox(
          height: size * 20,
        )
      ],
    );
  }

  Container _addImage(
      double size, double font, EditDetailsController controller) {
    return Container(
      height: size * 125,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: AppGradient.blueBlack,
        border: Border.all(color: AppColor.cyan, width: 0.2),
        borderRadius: BorderRadius.circular(size * 10),
      ),
      child: controller.imageFile != null
          ? Image.file(controller.imageFile!)
          : widget.image.isNotEmpty
              ? controller.file == null
                  ? SizedBox()
                  : Image.file(controller.file!)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetPath.gallery,
                      height: size * 28,
                      width: size * 28,
                    ),
                    SizedBox(height: size * 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: size * 2,
                          backgroundColor: AppColor.white,
                        ),
                        Text(
                          "  Please upload Your Brand Logo image in png format.",
                          style: TextStyle(
                              fontSize: font * 14, color: AppColor.white),
                        ),
                      ],
                    ),
                    SizedBox(height: size * 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: size * 2,
                          backgroundColor: AppColor.white,
                        ),
                        Text(
                          "  Max image size is 250px t0 100px",
                          style: TextStyle(
                              fontSize: font * 14, color: AppColor.white),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }

  _appBar(double font) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          Text(
            "Edit Brand",
            style: TextStyle(
                color: AppColor.white,
                fontSize: font * 22,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
