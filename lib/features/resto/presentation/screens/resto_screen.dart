import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/inputs/input_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/resto/presentation/states/resto_controller.dart';
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
    List<String> _list = [
      "https://w0.peakpx.com/wallpaper/47/200/HD-wallpaper-food-sandwich.jpg",
      "https://res.allmacwallpaper.com/get/Retina-MacBook-Air-13-inch-wallpapers/The-delicious-sandwiches-2560x1600/3920-11.jpg",
      "https://www.allrecipes.com/thmb/UsNtGp9OgIsKw6cPqGQ-CxLmnTE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/AR-72657-best-hamburger-ever-ddmfs-4x3-hero-878e801ab30445988d007461782b3c25.jpg",
      "https://images.unsplash.com/photo-1513104890138-7c749659a591?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D",
      "https://t3.ftcdn.net/jpg/00/27/57/96/360_F_27579652_tM7V4fZBBw8RLmZo0Bi8WhtO2EosTRFD.jpg",
      "https://img.freepik.com/free-photo/close-up-delicious-tacos_23-2150831119.jpg",
      "https://static.vecteezy.com/system/resources/thumbnails/028/139/670/small_2x/side-view-shawarma-with-fried-potatoes-in-board-cookware-photo.jpg",
    ];

    return Scaffold(
      backgroundColor: MainColors.backgroundColor(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                  border: Border.all(color: MainColors.disableColor(context)!.withOpacity(.2)),
                  borderRadius: BorderRadius.circular(kRadiusMedium.r),
                ),
                child: TextInputComponent(
                  hint: "Search for a restaurant",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                  borderRadius: kRadiusMedium.r,
                  suffix: SizedBox(
                    width: 30.r,
                    child: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 20.r,
                      color: MainColors.disableColor(context)!,
                    ),
                  ),
                ),
              ),
              SizedBox(height: kSpacingMedium.r),
              Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRadiusMedium.r),
                      child: Image.asset(
                        ResourceManager.getAssetResource(
                          offerBg,
                          type: ResourceType.image,
                        ),
                        fit: BoxFit.cover,
                        height: 200.r,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.8),
                        borderRadius: BorderRadius.circular(kRadiusMedium.r),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(kSpacingMedium.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRadiusMedium.r),
                      border: Border.all(color: MainColors.primaryColor.withOpacity(.3), width: 1),
                      color: MainColors.primaryColor.withOpacity(.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Evolve coffee snack",
                              style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "You can't miss it",
                              style: TextStyles.smallBodyTextStyle(context).copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                      decoration: BoxDecoration(
                        color: MainColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(kRadiusMedium.r),
                          bottomLeft: Radius.circular(kRadiusMedium.r),
                        ),
                      ),
                      child: Text(
                        "50%",
                        style: TextStyles.smallBodyTextStyle(context).copyWith(
                          color: MainColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: SizedBox(
                      height: 5.r,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: kSpacingSmall.r),
                            width: index == 0 ? 30.r : 5.r,
                            height: 5.r,
                            decoration: BoxDecoration(
                              color: MainColors.primaryColor,
                              borderRadius: BorderRadius.circular(2.5.r),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: kSpacingMedium.r),
              Container(
                margin: EdgeInsets.only(bottom: kSpacingMedium.r),
                constraints: BoxConstraints(
                  minHeight: Get.height / 2,
                ),
                child: WaterfallFlow.builder(
                  itemCount: _list.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return RestoComponent(
                      imageUrl: _list[index],
                    );
                  },
                  gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: kSpacingMedium.r / 2,
                    mainAxisSpacing: kSpacingMedium.r / 2,
                    lastChildLayoutTypeBuilder: (index) =>
                        index == _list.length ? LastChildLayoutType.foot : LastChildLayoutType.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
