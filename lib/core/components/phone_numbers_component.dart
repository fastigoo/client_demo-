import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneNumbersComponent extends StatelessWidget {
  const PhoneNumbersComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kSpacingMedium.r),
      margin: EdgeInsets.symmetric(horizontal: kSpacingSmall.w, vertical: kSpacingSmall.h),
      decoration: BoxDecoration(
        color: MainColors.cardColor(context),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: MainColors.disableColor(context),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          SizedBox(height: kSpacingMedium.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '0777070060',
                    style: TextStyles.mediumLabelTextStyle(context).copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  Text('Support 1', style: TextStyles.smallBodyTextStyle(context),),
                ],
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MainColors.primaryColor),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.all(kSpacingSmall.r),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusSmall.r),
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.phone,
                  size: 24.sp,
                  color: MainColors.whiteColor,
                ),
                onPressed: () => _callDispatcher(phoneNumber: '0777070060'),
              ),
            ],
          ),
          SizedBox(height: kSpacingSmall.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '0699337862',
                    style: TextStyles.mediumLabelTextStyle(context).copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  Text('Support 2', style: TextStyles.smallBodyTextStyle(context),),
                ],
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MainColors.primaryColor),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.all(kSpacingSmall.r),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusSmall.r),
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.phone,
                  size: 24.sp,
                  color: MainColors.whiteColor,
                ),
                onPressed: () => _callDispatcher(phoneNumber: '0699337862'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _callDispatcher({required String phoneNumber}) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }
}
