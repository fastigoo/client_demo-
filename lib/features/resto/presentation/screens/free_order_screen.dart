import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learning/core/components/empty_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/resto/presentation/states/free_order_controller.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/routes/app_pages.dart';

class FreeOrderScreen extends GetView<FreeOrderController> {
  const FreeOrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height - kSpacingMedium.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: GetBuilder(
                      init: controller,
                      builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 50.r,
                                  height: 50.r,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MainColors.whiteColor,
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.ellipsis,
                                      color: MainColors.primaryColor,
                                      size: 20.r,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: kSpacingMedium.r),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: MainColors.primaryColor,
                                borderRadius: BorderRadius.circular(kRadiusMedium.r),
                              ),
                              padding: EdgeInsets.all(kSpacingMedium.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Choose Location",
                                    style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                      color: MainColors.whiteColor,
                                    ),
                                  ),
                                  Text(
                                    'Please select your location where you want to order to be delivered as soon as possible',
                                    style: TextStyles.smallBodyTextStyle(context).copyWith(
                                      color: MainColors.whiteColor,
                                    ),
                                  ),
                                  SizedBox(height: kSpacingMedium.r),
                                  GetBuilder(
                                      init: controller,
                                      builder: (controller) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.MAP);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(kSpacingMedium.r - 3),
                                            decoration: BoxDecoration(
                                              color: MainColors.secondColor,
                                              borderRadius: BorderRadius.circular(kRadiusSmall.r),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  controller.address == null
                                                      ? "Current Location"
                                                      : "${controller.address!.city} - ${controller.address!.road}",
                                                  style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                                    color: MainColors.primaryColor,
                                                  ),
                                                ),
                                                FaIcon(FontAwesomeIcons.locationDot, size: 20.r),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(height: kSpacingMedium.r),
                            Text("  Phone number", style: TextStyles.smallBodyTextStyle(context)),
                            SizedBox(height: kSpacingXSmall.r),
                            TextFormField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Ex: 0777676767",
                                hintStyle: TextStyles.smallBodyTextStyle(context).copyWith(
                                  color: MainColors.disableColor(context),
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: MainColors.disableColor(context),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: kSpacingMedium.r,
                                  vertical: kSpacingMedium.r,
                                ),
                                filled: true,
                                fillColor: MainColors.whiteColor,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                ),
                              ),
                            ),
                            SizedBox(height: kSpacingMedium.r),
                            Text("Order List", style: TextStyles.smallBodyTextStyle(context)),
                            SizedBox(height: kSpacingXSmall.r),
                            controller.items.isNotEmpty
                                ? ListView.separated(
                                    itemBuilder: (c, i) => Container(
                                      decoration: BoxDecoration(
                                        color: MainColors.whiteColor,
                                        borderRadius: BorderRadius.circular(kRadiusSmall.r),
                                      ),
                                      padding: EdgeInsets.all(kSpacingSmall.r + 2),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.items[i].name,
                                                style: TextStyles.smallLabelTextStyle(context),
                                              ),
                                              Text(
                                                "${controller.items[i].quantity} ${controller.items[i].unite}",
                                                style: TextStyles.smallBodyTextStyle(context),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              controller.removeItem(i);
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.trash,
                                              color: MainColors.errorColor(context),
                                              size: 20.r,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    separatorBuilder: (c, i) => SizedBox(height: kSpacingSmall.h),
                                    itemCount: controller.items.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                  )
                                : const Center(
                                    child: EmptyComponent(),
                                  ),
                            SizedBox(height: kSpacingMedium.r),
                          ],
                        );
                      }),
                ),
              ),
              SizedBox(height: kSpacingMedium.r),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MainColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadiusMedium.r),
                      ),
                      minimumSize: Size(1.sw - (kSpacingMedium.w * 6).w, 50.r),
                    ),
                    onPressed: () {
                      // controller.reset();
                    },
                    child: Text(
                      "Place Order",
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(
                        color: MainColors.whiteColor,
                        fontSize: 16.r,
                      ),
                    ),
                  ),
                  SizedBox(width: kSpacingSmall.r),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (c) => SafeArea(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(kRadiusMedium.r),
                                topRight: Radius.circular(kRadiusMedium.r),
                              ),
                            ),
                            padding: EdgeInsets.all(kSpacingMedium.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: controller.nameController,
                                  decoration: InputDecoration(
                                    hintText: "Item Name",
                                    hintStyle: TextStyles.smallBodyTextStyle(context).copyWith(
                                      color: MainColors.disableColor(context),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.edit,
                                      color: MainColors.disableColor(context),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: kSpacingMedium.r,
                                      vertical: kSpacingMedium.r,
                                    ),
                                    filled: true,
                                    fillColor: MainColors.whiteColor,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                    ),
                                  ),
                                ),
                                SizedBox(height: kSpacingMedium.r),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: controller.quantityController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "Quantity",
                                          hintStyle: TextStyles.smallBodyTextStyle(context).copyWith(
                                            color: MainColors.disableColor(context),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.numbers,
                                            color: MainColors.disableColor(context),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: kSpacingMedium.r,
                                            vertical: kSpacingMedium.r,
                                          ),
                                          filled: true,
                                          fillColor: MainColors.whiteColor,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: kSpacingSmall.r),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.removeQuantity();
                                          },
                                          child: Container(
                                            width: 40.r,
                                            height: 40.r,
                                            decoration: BoxDecoration(
                                              color: MainColors.primaryColor,
                                              borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                            ),
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                color: MainColors.secondColor,
                                                size: 20.r,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: kSpacingSmall.r),
                                        GestureDetector(
                                          onTap: () {
                                            controller.addQuantity();
                                          },
                                          child: Container(
                                            width: 40.r,
                                            height: 40.r,
                                            decoration: BoxDecoration(
                                              color: MainColors.primaryColor,
                                              borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                            ),
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.plus,
                                                color: MainColors.secondColor,
                                                size: 20.r,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: kSpacingMedium.r),
                                Obx(
                                  () => Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    spacing: kSpacingSmall.r,
                                    runSpacing: kSpacingSmall.r,
                                    children: [
                                      for (var i = 0; i < controller.unites.length; i++)
                                        GestureDetector(
                                          onTap: () {
                                            controller.setSelectedUnit(controller.unites[i]);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: MainColors.secondColor,
                                              borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                              border: controller.unites[i] == controller.selectedUnite.value
                                                  ? Border.all(
                                                      color: MainColors.primaryColor,
                                                      width: 2.w,
                                                    )
                                                  : null,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: kSpacingMedium.r,
                                              vertical: kSpacingXSmall.r,
                                            ),
                                            child: Text(
                                              controller.unites[i],
                                              style: TextStyles.smallBodyTextStyle(context),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: kSpacingMedium.r),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MainColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                    ),
                                    minimumSize: Size(1.sw, 50.r),
                                  ),
                                  onPressed: () {
                                    controller.addItem();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.plus,
                                        size: 20.r,
                                        color: MainColors.whiteColor,
                                      ),
                                      SizedBox(width: kSpacingSmall.r),
                                      Text(
                                        "Add Item",
                                        style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                          color: MainColors.whiteColor,
                                          fontSize: 16.r,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MainColors.secondColor,
                        borderRadius: BorderRadius.circular(kRadiusMedium.r),
                      ),
                      width: 50.r,
                      height: 50.r,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: MainColors.primaryColor,
                          size: 20.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: kSpacingMedium.r),
        ),
      ),
    );
  }
}
