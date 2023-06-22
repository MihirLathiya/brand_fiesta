import 'package:brand_fiesta/utils/app_color.dart';
import 'package:brand_fiesta/utils/common_text.dart';
import 'package:brand_fiesta/utils/constant.dart';
import 'package:brand_fiesta/utils/font_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadingTile extends StatelessWidget {
  const HeadingTile({
    super.key,
    this.name,
    this.viewMore,
  });
  final String? name;
  final GestureTapCallback? viewMore;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstant.commonPadding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: name!,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
          TextButton(
            onPressed: viewMore,
            child: CommonText(
              text: 'View More',
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.red,
            ),
          )
        ],
      ),
    );
  }
}
