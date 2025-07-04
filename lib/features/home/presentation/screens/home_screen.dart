import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:client/core/components/empty_component.dart';
import 'package:client/core/helper/translation_util.dart';
import 'package:client/core/resources/constants.dart';
import 'package:client/core/resources/language_strings.dart';
import 'package:client/features/cart/presentation/screens/cart_screen.dart';
import 'package:client/features/cart/presentation/states/cart_controller.dart';
import 'package:client/features/home/presentation/states/product_detail_controller.dart';
import 'package:client/features/home/presentation/widgets/cart_widget.dart';
import 'package:client/features/home/presentation/widgets/product_component.dart';
import 'package:shimmer/shimmer.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:client/core/styles/main_colors.dart';
import 'package:client/features/home/presentation/states/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late TabController _tabController;

  final controller = Get.put(HomeController());
  final _cartController = Get.put(CartController());
  final _ = Get.put(ProductDetailController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: controller.restaurantMenus.length,
      vsync: this,
    );
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      controller.setSelectedMenuId(controller.restaurantMenus[_tabController.index].menuId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.restaurantMenus.isNotEmpty) {
          if (_tabController.length != controller.restaurantMenus.length) {
            _tabController.dispose();
            _tabController = TabController(
              length: controller.restaurantMenus.length,
              vsync: this,
            );
            _tabController.addListener(_onTabChanged);
          }
        }
        return Scaffold(
          extendBody: true,
          body: controller.menuIsLoading.isFalse
              ? DefaultTabController(
                  length: controller.restaurantMenus.length,
                  child: NestedScrollView(
                    controller: scrollController,
                    floatHeaderSlivers: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        snap: true,
                        backgroundColor: MainColors.primaryColor,
                        automaticallyImplyLeading: false,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: FaIcon(
                                    TranslationUtil.isRtl() ? FontAwesomeIcons.chevronRight : FontAwesomeIcons.chevronLeft,
                                    color: MainColors.whiteColor,
                                    size: 25.sp,
                                  ),
                                ),
                                SizedBox(width: kSpacingMedium.r),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.restaurantName ?? LanguageStrings.noDataFound,
                                      style: GoogleFonts.fredoka(
                                        fontSize: 22.sp,
                                        color: MainColors.whiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      LanguageStrings.heyWelcomeBack,
                                      style: GoogleFonts.fredoka(
                                        fontSize: 15.sp,
                                        color: MainColors.whiteColor.withOpacity(.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (_cartController.cartItems.isNotEmpty)
                              Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.cartShopping,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                  Positioned(
                                    right: -10.r,
                                    top: -10.r,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => const CartScreen());
                                        Get.find<CartController>().setRestaurantId(controller.restaurantId!);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3.r),
                                        decoration: BoxDecoration(
                                          color: MainColors.errorColor(context),
                                          borderRadius: BorderRadius.circular(20.r),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 15.w,
                                          minHeight: 15.h,
                                        ),
                                        child: Center(
                                          child: Text(
                                            _cartController.cartItems.length.toString(),
                                            style: GoogleFonts.fredoka(
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        elevation: 0,
                        bottom: TabBar(
                          controller: _tabController,
                          tabAlignment: TabAlignment.start,
                          indicatorColor: MainColors.primaryColor,
                          indicatorWeight: 5.0,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: GoogleFonts.fredoka(),
                          unselectedLabelColor: Colors.grey,
                          labelColor: MainColors.primaryColor,
                          isScrollable: true,
                          overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(.2)),
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
                          labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
                          dividerHeight: 0.001,
                          onTap: (index) {
                            controller.setSelectedMenuId(controller.restaurantMenus[index].menuId);
                          },
                          tabs: [
                            for (int i = 0; i < controller.restaurantMenus.length; i++) ...{
                              Tab(
                                child: Text(
                                  controller.restaurantMenus[i].name,
                                  style: GoogleFonts.fredoka(
                                    fontSize: 15.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            },
                          ],
                        ),
                      ),
                    ],
                    body: Column(
                      children: [
                        Expanded(
                          child: controller.itemsIsLoading.isFalse
                              ? TabBarView(
                                  physics: const BouncingScrollPhysics(),
                                  controller: _tabController,
                                  children: [
                                    for (int i = 0; i < controller.restaurantMenus.length; i++) ...{
                                      if (controller.menuItems.isEmpty) ...{
                                        EmptyComponent(
                                          text: LanguageStrings.noDataFound,
                                        ),
                                      } else ...{
                                        WaterfallFlow.builder(
                                          itemCount: controller.menuItems.length,
                                          itemBuilder: (context, index) {
                                            return ProductComponent(
                                              item: controller.menuItems[index],
                                            );
                                          },
                                          padding: EdgeInsets.all(kSpacingSmall.r),
                                          gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: kSpacingMedium.r,
                                            mainAxisSpacing: kSpacingMedium.r,
                                          ),
                                        ),
                                      },
                                    },
                                  ],
                                )
                              : WaterfallFlow.builder(
                                  itemCount: 9,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: Container(
                                        width: double.infinity,
                                        height: Random().nextInt(70).h + 200.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(kRadiusMedium.r),
                                          color: MainColors.cardColor(context),
                                        ),
                                      ),
                                    );
                                  },
                                  gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: kSpacingMedium.r / 2,
                                    mainAxisSpacing: kSpacingMedium.r / 2,
                                  ),
                                ),
                        ),
                        if (_cartController.cartItems.isNotEmpty)
                          SafeArea(child: CartWidget(restaurantId: controller.restaurantId!)),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: MainColors.primaryColor,
                    strokeWidth: 2.r,
                  ),
                ),
        );
      },
    );
  }
}
