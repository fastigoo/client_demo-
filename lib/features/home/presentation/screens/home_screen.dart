import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/core/components/empty_component.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/features/cart/presentation/states/cart_controller.dart';
import 'package:learning/features/home/presentation/states/product_detail_controller.dart';
import 'package:learning/features/home/presentation/widgets/cart_widget.dart';
import 'package:learning/features/home/presentation/widgets/product_component.dart';
import 'package:shimmer/shimmer.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/features/home/presentation/states/home_controller.dart';
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
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Evolve coffee snacks",
                              style: GoogleFonts.fredoka(
                                fontSize: 22.sp,
                                color: MainColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Hey! Welcome back!",
                              style: GoogleFonts.fredoka(
                                fontSize: 15.sp,
                                color: MainColors.whiteColor.withOpacity(.75),
                              ),
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
                                        const EmptyComponent(),
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
                        if (_cartController.cartItems.isNotEmpty) SafeArea(child: CartWidget(restaurantId: controller.restaurantId!)),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
