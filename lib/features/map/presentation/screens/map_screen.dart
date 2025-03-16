import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/features/map/presentation/states/map_state.dart';

class MapScreen extends GetView<MapState> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Map Screen",
              style: TextStyles.mediumLabelTextStyle(context).copyWith(
                color: MainColors.whiteColor,
              ),
            ),
            Obx(
              () => controller.isLoadingAddress.isFalse
                  ? Text(
                     "${controller.address!.city} - ${controller.address!.road}",
                      style: TextStyles.smallBodyTextStyle(context).copyWith(
                        color: MainColors.whiteColor,
                      ),
                    )
                  : SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        color: MainColors.whiteColor,
                      ),
                    ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: kSpacingMedium.w,
                vertical: kSpacingSmall.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kRadiusMedium.r),
              ),
              child: Text(
                LanguageStrings.save,
                style: TextStyles.smallBodyTextStyle(context).copyWith(
                  color: MainColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: kSpacingMedium.w),
        ],
      ),
      body: Obx(
        () => controller.serviceEnabled
            ? controller.isMapReady.isTrue
                ? FlutterMap(
                    mapController: controller.mapController,
                    options: MapOptions(
                      onTap: (TapPosition pos, LatLng point) {
                        // controller.setOrderPos(point);
                      },
                      initialZoom: 15,
                      minZoom: 4,
                      maxZoom: 40,
                      initialCenter: const LatLng(0, 0),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 25,
                            height: 25,
                            point: LatLng(controller.currentPos!.latitude, controller.currentPos!.longitude),
                            child: Container(
                              width: 25.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                color: MainColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: MainColors.primaryColor,
                    ),
                  )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Location is disabled',
                      style: TextStyles.mediumLabelTextStyle(context),
                    ),
                    SizedBox(height: kSpacingMedium.h),
                    ElevatedButton(
                      onPressed: () async {
                        await controller.enableLocationAgain();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MainColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kRadiusMedium.r),
                        ),
                      ),
                      child: Text(
                        'Enable Location',
                        style: TextStyles.smallBodyTextStyle(context).copyWith(
                          color: MainColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MainColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusXLarge.r),
        ),
        onPressed: () {
          controller.goToCurrentLocation();
        },
        child: const FaIcon(
          FontAwesomeIcons.locationCrosshairs,
          color: Colors.white,
        ),
      ),
    );
  }
}
