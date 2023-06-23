import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/asset_path.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;
    return Scaffold(
      appBar: _appBar(font),
      body: Padding(
        padding: EdgeInsets.all(size * 20),
        child: Column(children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20 * size),
              border: Border.all(color: AppColor.blue, width: 2),
            ),
            child: Column(children: [
              buildRow(
                  onTap: () {},
                  size: size,
                  font: font,
                  title: "Share App",
                  isDivider: true,
                  imagePath: AssetPath.shareIcon),
              buildRow(
                  onTap: () {},
                  size: size,
                  font: font,
                  title: "Help & Support",
                  isDivider: true,
                  imagePath: AssetPath.helpIcon),
              buildRow(
                  onTap: () {},
                  size: size,
                  font: font,
                  title: "Privacy & Policy ",
                  isDivider: true,
                  imagePath: AssetPath.privacyIcon),
              buildRow(
                  onTap: () {},
                  size: size,
                  font: font,
                  title: "Rate Us",
                  isDivider: false,
                  imagePath: AssetPath.rateIcon),
            ]),
          ),
          SizedBox(
            height: size * 32,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size * 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Created with love ',
                      style: TextStyle(
                        color: Color(0xff6A6A6A),
                        fontSize: font * 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      color: AppColor.red,
                    )
                  ],
                ),
                SizedBox(
                  height: 7 * size,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Column buildRow(
      {required GestureTapCallback onTap,
      required String title,
      required String imagePath,
      required double font,
      required double size,
      bool isDivider = true}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25 * size),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18 * size),
                  child: SvgPicture.asset(imagePath),
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: font * 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.white),
                )
              ],
            ),
          ),
        ),
        isDivider
            ? Divider(
                color: Color.fromRGBO(33, 33, 33, 1),
              )
            : SizedBox()
      ],
    );
  }

  AppBar _appBar(double font) {
    return AppBar(
      title: Text(
        "Details",
        style: TextStyle(
            color: AppColor.white,
            fontSize: font * 22,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
