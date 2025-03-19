import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/empty_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/free_order/presentation/states/free_order_controller.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/features/free_order/presentation/widgets/add_item_order_popup.dart';
import 'package:learning/routes/app_pages.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

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
                      return Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: 50.r,
                                    height: 50.r,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MainColors.whiteColor,
                                      border: Border.fromBorderSide(
                                        BorderSide(
                                          color: MainColors.primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.chevronLeft,
                                        color: MainColors.primaryColor,
                                        size: 20.r,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.FREE_ORDERS);
                                  },
                                  child: Container(
                                    width: 50.r,
                                    height: 50.r,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MainColors.whiteColor,
                                      border: Border.fromBorderSide(
                                        BorderSide(
                                          color: MainColors.primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.fileZipper,
                                        color: MainColors.primaryColor,
                                        size: 20.r,
                                      ),
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
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: kSpacingMedium.r),
                            Text(
                              "  Phone number",
                              style: TextStyles.smallBodyTextStyle(context),
                            ),
                            SizedBox(height: kSpacingXSmall.r),
                            TextFormField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              validator: Validators.compose([
                                Validators.required("Phone number is required"),
                                Validators.patternRegExp(
                                  RegExp(r'^(05|06|07)[0-9]{8}$'),
                                  "Phone number must be 10 digits and start with 05, 06, or 07",
                                ),
                              ]),
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
                                : Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        _onTap(controller: controller, context: context);
                                      },
                                      child: const EmptyComponent(text: "No items added yet"),
                                    ),
                                  ),
                            SizedBox(height: kSpacingMedium.r),
                          ],
                        ),
                      );
                    },
                  ),
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
                      if (controller.items.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please add items to your order",
                          backgroundColor: MainColors.errorColor(context),
                          colorText: MainColors.whiteColor,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      if (controller.formKey.currentState!.validate()) {
                        controller.addFreeOrder();
                      }
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
                      _onTap(controller: controller, context: context);
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

  _onTap({required FreeOrderController controller, required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (c) => AddFreeOrderItemPopup(controller: controller),
    );
  }
}
