import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:client/core/helper/translation_util.dart';
import 'package:client/core/styles/main_colors.dart';

class BackComponent extends StatelessWidget {
  const BackComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        width: 50.r,
        height: 50.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MainColors.cardColor(context)!,
        ),
        child: Center(
          child: FaIcon(
            TranslationUtil.isRtl() ? FontAwesomeIcons.chevronRight : FontAwesomeIcons.chevronLeft,
            size: 20.r,
          ),
        ),
      ),
    );
  }
}
