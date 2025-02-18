import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/inputs/input_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/resto/presentation/states/resto_controller.dart';
import 'package:learning/features/resto/presentation/widgets/restaurant_animation.dart';
import 'package:learning/features/resto/presentation/widgets/resto_component.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestoScreen extends GetView<RestoController> {
  const RestoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.backgroundColor(context),
      body: SafeArea(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              controller.refreshData();
            },
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: kSpacingSmall.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: kSpacingMedium.r),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(kRadiusLarge),
                          child: Image.asset(
                            ResourceManager.getAssetResource(
                              logoImg,
                            ),
                            width: 40.r,
                          ),
                        ),
                        SizedBox(width: kSpacingSmall.r),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fasti Goo', style: TextStyles.mediumLabelTextStyle(context)),
                            Text("Pick up a restaurant and start ordering", style: TextStyles.smallBodyTextStyle(context)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: kSpacingMedium.r),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRadiusMedium.r),
                      ),
                      child: Expanded(
                        child: TextInputComponent(
                          controller: controller.searchController,
                          hint: "Search for a restaurant ...",
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                          borderRadius: kRadiusMedium.r,
                          onChange: (value) {
                            controller.onSearchChanged();
                          },
                          suffix: SizedBox(
                            width: 50.r,
                            child: Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: MainColors.disableColor(context),
                              size: 20.r,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: kSpacingMedium.r),
                    // Stack(
                    //   children: [
                    //     Positioned.fill(
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(kRadiusMedium.r),
                    //         child: Image.asset(
                    //           ResourceManager.getAssetResource(
                    //             offerBg,
                    //             type: ResourceType.image,
                    //           ),
                    //           fit: BoxFit.cover,
                    //           height: 200.r,
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned.fill(
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           color: Colors.white.withOpacity(.8),
                    //           borderRadius: BorderRadius.circular(kRadiusMedium.r),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.all(kSpacingMedium.r),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(kRadiusMedium.r),
                    //         border: Border.all(color: MainColors.primaryColor.withOpacity(.3), width: 1),
                    //         color: MainColors.primaryColor.withOpacity(.1),
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 "Evolve coffee snack",
                    //                 style: TextStyles.mediumLabelTextStyle(context).copyWith(
                    //                   color: Colors.black,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 "You can't miss it",
                    //                 style: TextStyles.smallBodyTextStyle(context).copyWith(color: Colors.black),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Positioned(
                    //       right: 0,
                    //       top: 0,
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                    //         decoration: BoxDecoration(
                    //           color: MainColors.primaryColor,
                    //           borderRadius: BorderRadius.only(
                    //             topRight: Radius.circular(kRadiusMedium.r),
                    //             bottomLeft: Radius.circular(kRadiusMedium.r),
                    //           ),
                    //         ),
                    //         child: Text(
                    //           "50%",
                    //           style: TextStyles.smallBodyTextStyle(context).copyWith(
                    //             color: MainColors.whiteColor,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       bottom: 10,
                    //       child: SizedBox(
                    //         height: 5.r,
                    //         child: ListView.builder(
                    //           itemCount: 5,
                    //           scrollDirection: Axis.horizontal,
                    //           itemBuilder: (context, index) {
                    //             return Container(
                    //               margin: EdgeInsets.only(right: kSpacingSmall.r),
                    //               width: index == 0 ? 30.r : 5.r,
                    //               height: 5.r,
                    //               decoration: BoxDecoration(
                    //                 color: MainColors.primaryColor,
                    //                 borderRadius: BorderRadius.circular(2.5.r),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: kSpacingMedium.r),
                    Container(
                      margin: EdgeInsets.only(bottom: kSpacingMedium.r),
                      constraints: BoxConstraints(
                        minHeight: Get.height,
                      ),
                      child: controller.isLoading.isFalse
                          ? WaterfallFlow.builder(
                              itemCount: controller.getRestaurantsList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              controller: controller.scrollController,
                              itemBuilder: (context, index) {
                                return RestoComponent(
                                  item: controller.getRestaurantsList[index],
                                );
                              },
                              gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: kSpacingMedium.r / 2,
                                mainAxisSpacing: kSpacingMedium.r / 2,
                                lastChildLayoutTypeBuilder: (index) => index == controller.getRestaurantsList.length
                                    ? LastChildLayoutType.foot
                                    : LastChildLayoutType.none,
                              ),
                            )
                          : const RestaurantAnimation(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
