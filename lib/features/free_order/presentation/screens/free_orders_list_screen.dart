import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learning/core/components/empty_component.dart';
import 'package:learning/core/components/loading_animation.dart';
import 'package:learning/core/components/others/back_component.dart';
import 'package:learning/core/helper/utils.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/core/styles/text_styles.dart';
import 'package:learning/features/free_order/domain/entities/free_order_item_entity.dart';
import 'package:learning/features/free_order/presentation/states/free_orders_controller.dart';
import 'package:learning/features/free_order/presentation/widgets/order_list_detail_component.dart';
import 'package:learning/routes/app_pages.dart';

class FreeOrdersListScreen extends GetView<FreeOrdersController> {
  const FreeOrdersListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: GetBuilder(
              init: controller,
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackComponent(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.FREE_ORDER);
                          },
                          child: Container(
                            width: 50.r,
                            height: 50.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MainColors.cardColor(context),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: 20.r,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kSpacingMedium.h),
                    Obx(
                      () => controller.isLoading.isFalse
                          ? controller.freeOrderResEntity!.totalOrders != 0 ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.freeOrderResEntity!.orders.length,
                              itemBuilder: (context, index) {
                                return ExpandableOrderItem(
                                  freeOrderItemEntity: controller.freeOrderResEntity!.orders[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: kSpacingMedium.h);
                              },
                            ) : EmptyComponent(
                              text: LanguageStrings.noDataFound,
                            )
                          : const LoadingAnimation(),
                    ),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.isLoadingMore.isTrue) ...{
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(kSpacingMedium.r),
                                child: SizedBox(
                                  width: 30.w,
                                  height: 30.h,
                                  child: const LoadingAnimation(),
                                ),
                              ),
                            ),
                          },
                        ],
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: kSpacingMedium.r);
              }),
        ),
      ),
    );
  }
}

class ExpandableOrderItem extends StatefulWidget {
  final FreeOrderItemEntity freeOrderItemEntity;

  const ExpandableOrderItem({
    Key? key,
    required this.freeOrderItemEntity,
  }) : super(key: key);

  @override
  _ExpandableOrderItemState createState() => _ExpandableOrderItemState();
}

class _ExpandableOrderItemState extends State<ExpandableOrderItem> {
  final _controller = Get.find<FreeOrdersController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.openedId != widget.freeOrderItemEntity.freeOrderId) {
          _controller.freeOrderDetail(id: widget.freeOrderItemEntity.freeOrderId);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(kSpacingMedium.r),
        decoration: BoxDecoration(
          color: MainColors.inputColor(context),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Container(
                    //   width: 45.r,
                    //   height: 45.r,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     border: Border.all(
                    //       color: MainColors.primaryColor,
                    //       width: 2,
                    //     ),
                    //   ),
                    //   child: Center(
                    //     child: FaIcon(
                    //       FontAwesomeIcons.rotate,
                    //       color: MainColors.primaryColor,
                    //       size: 20.r,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(width: kSpacingSmall.w),
                    GestureDetector(
                      onTap: () {
                        _controller.deleteFreeOrder(widget.freeOrderItemEntity.freeOrderId);
                      },
                      child: Container(
                        width: 45.r,
                        height: 45.r,
                        decoration: BoxDecoration(
                          color: MainColors.errorColor(context),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MainColors.errorColor(context)!,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.xmark,
                            color: MainColors.whiteColor,
                            size: 20.r,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "#${widget.freeOrderItemEntity.freeOrderId}",
                  style: TextStyles.mediumLabelTextStyle(context),
                ),
              ],
            ),
            SizedBox(height: kSpacingMedium.h),
            Text(
              "${LanguageStrings.orderDate}: ${widget.freeOrderItemEntity.createdAt.split("T").first} ${widget.freeOrderItemEntity.createdAt.split("T").last.split(".").first}",
              style: TextStyles.mediumBodyTextStyle(context),
            ),
            SizedBox(height: kSpacingXSmall.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: kSpacingSmall.r, vertical: kSpacingXSmall.r),
              decoration: BoxDecoration(
                color: getStatusColor(widget.freeOrderItemEntity.orderStatusValue).withOpacity(0.1),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                  widget.freeOrderItemEntity.orderStatusValue,
                style: TextStyles.mediumBodyTextStyle(context).copyWith(
                  color: getStatusColor(widget.freeOrderItemEntity.orderStatusValue),
                  fontSize: 12.r,
                )
              ),
            ),
            Obx(
              () {
                bool isDetailLoading = _controller.isDetailLoading.value;
                bool isSelected = _controller.openedId == widget.freeOrderItemEntity.freeOrderId;
                return !isSelected
                    ? const SizedBox()
                    : isDetailLoading
                        ? const LoadingAnimation()
                        : OderListDetailComponent(freeOrderItemList: _controller.freeOrderItemList);
              },
            ),
          ],
        ),
      ),
    );
  }
}
