import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/free_order/presentation/states/free_order_controller.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class AddFreeOrderItemPopup extends StatelessWidget {
  final FreeOrderController controller;

  const AddFreeOrderItemPopup({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kRadiusMedium.r),
            topRight: Radius.circular(kRadiusMedium.r),
          ),
        ),
        padding: EdgeInsets.all(kSpacingMedium.r),
        child: Form(
          key: controller.itemFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller.nameController,
                validator: Validators.compose([
                  Validators.required("Item name is required"),
                ]),
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
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(kRadiusMedium.r),
                  ),
                ),
              ),
              SizedBox(height: kSpacingMedium.r),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.quantityController,
                      validator: Validators.compose([
                        Validators.required("Quantity is required"),
                      ]),
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
                        errorBorder: OutlineInputBorder(
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
                  if (controller.itemFormKey.currentState!.validate()) {
                    controller.addItem();
                  }
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
  }
}
