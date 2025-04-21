import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/empty_component.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/resources/storage_keys.dart';
import 'package:learning/core/services/storage_manager.dart';
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
                                StorageManager.instance.getIntValue(key: StorageKey.userIdKey) != 0
                                    ? GestureDetector(
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
                                      )
                                    : const SizedBox(),
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
                                    LanguageStrings.chooseLocation,
                                    style: TextStyles.mediumLabelTextStyle(context).copyWith(
                                      color: MainColors.whiteColor,
                                    ),
                                  ),
                                  Text(
                                    LanguageStrings.chooseLocationDescription,
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
                                                    ? LanguageStrings.currentLocation
                                                    : "${controller.address!.city} - ${controller.address!.road}",
                                                style: TextStyles.mediumBodyTextStyle(context).copyWith(
                                                  color: MainColors.whiteColor,
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
                              "  ${LanguageStrings.phoneNumber}",
                              style: TextStyles.smallBodyTextStyle(context),
                            ),
                            SizedBox(height: kSpacingXSmall.r),
                            TextFormField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              validator: Validators.compose([
                                Validators.required(LanguageStrings.phoneNumberIsRequired),
                                Validators.patternRegExp(
                                  RegExp(r'^(05|06|07)[0-9]{8}$'),
                                  LanguageStrings.phoneNumberIsNotValid,
                                ),
                              ]),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: LanguageStrings.phoneNumberHint,
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
                                fillColor: MainColors.inputColor(context),
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
                            Text(
                              LanguageStrings.ordersList,
                              style: TextStyles.smallBodyTextStyle(context),
                            ),
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
                                      child: EmptyComponent(text: LanguageStrings.noDataFound),
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
                      minimumSize: Size(1.sw - 10.w - (kSpacingMedium.w * 6).w, 50.r),
                    ),
                    onPressed: () {
                      if (controller.items.isEmpty) {
                        showToast(message: LanguageStrings.pleaseAddItemsToYourOrder);
                        return;
                      }
                      if (controller.formKey.currentState!.validate()) {
                        controller.addFreeOrder();
                      }
                    },
                    child: Text(
                      LanguageStrings.placeOrder,
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
                          color: MainColors.whiteColor,
                          size: 20.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: kSpacingMedium.r),
            ],
          ).paddingSymmetric(horizontal: kSpacingMedium.r),
        ),
      ),
    );
  }

  _onTap({required FreeOrderController controller, required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (c) => SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom),
          child: AddFreeOrderItemPopup(controller: controller),
        ),
      ),
    );
  }
}
