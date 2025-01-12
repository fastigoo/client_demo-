import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/core/resources/constants.dart';
import 'package:learning/core/resources/images.dart';
import 'package:learning/core/resources/language_strings.dart';
import 'package:learning/core/services/resource_manager.dart';
import 'package:learning/features/cart/presentation/screens/cart_screen.dart';
import 'package:learning/features/home/presentation/widgets/product_component.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:learning/core/styles/main_colors.dart';
import 'package:learning/features/home/presentation/states/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _list = [
      "https://www.cookwithnabeela.com/wp-content/uploads/2024/02/FrenchFries.webp",
      "https://w0.peakpx.com/wallpaper/47/200/HD-wallpaper-food-sandwich.jpg",
      "https://res.allmacwallpaper.com/get/Retina-MacBook-Air-13-inch-wallpapers/The-delicious-sandwiches-2560x1600/3920-11.jpg",
      "https://www.allrecipes.com/thmb/UsNtGp9OgIsKw6cPqGQ-CxLmnTE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/AR-72657-best-hamburger-ever-ddmfs-4x3-hero-878e801ab30445988d007461782b3c25.jpg",
      "https://images.unsplash.com/photo-1513104890138-7c749659a591?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D",
      "https://t3.ftcdn.net/jpg/00/27/57/96/360_F_27579652_tM7V4fZBBw8RLmZo0Bi8WhtO2EosTRFD.jpg",
      "https://img.freepik.com/free-photo/close-up-delicious-tacos_23-2150831119.jpg",
      "https://static.vecteezy.com/system/resources/thumbnails/028/139/670/small_2x/side-view-shawarma-with-fried-potatoes-in-board-cookware-photo.jpg",
    ];

    return Scaffold(
      extendBody: true,
      body: DefaultTabController(
        length: 9,
        child: NestedScrollView(
          controller: controller.scrollController,
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
                    'FastiGoo',
                    style: GoogleFonts.fredoka(
                      fontSize: 24.sp,
                      color: MainColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Welcome Pawat Taknouchiya",
                    style: GoogleFonts.fredoka(
                      fontSize: 15.sp,
                      color: MainColors.whiteColor.withOpacity(.75),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    ResourceManager.getAssetResource(heartIcon, type: ResourceType.svg),
                    width: 20.w,
                    colorFilter: const ColorFilter.mode(
                      MainColors.whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
              elevation: 0,
              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                indicatorColor: MainColors.primaryColor,
                indicatorWeight: 5.0,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: GoogleFonts.fredoka(),
                unselectedLabelColor: Colors.grey,
                labelColor: MainColors.primaryColor,
                isScrollable: true,
                overlayColor: MaterialStateProperty.all(Colors.green),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
                labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
                tabs: [
                  Tab(
                    child: Text(
                      LanguageStrings.allProducts,
                      style: GoogleFonts.fredoka(
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  for (int i = 0; i < 8; i++) ...{
                    Tab(
                      child: Text(
                        "All products",
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
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              Scaffold(
                backgroundColor: MainColors.backgroundColor(context),
                body: WaterfallFlow.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return ProductComponent(
                      imageUrl: _list[index],
                    );
                  },
                  padding: EdgeInsets.all(kSpacingSmall.r),
                  gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: kSpacingMedium.r,
                    mainAxisSpacing: kSpacingMedium.r,
                    lastChildLayoutTypeBuilder: (index) =>
                        index == _list.length ? LastChildLayoutType.foot : LastChildLayoutType.none,
                  ),
                ),
              ),
              for (int i = 0; i < 8; i++) ...{
                GridView.builder(
                  padding: EdgeInsets.all(10.r),
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.r,
                    mainAxisSpacing: 10.r,
                    childAspectRatio: 1 / 1.25,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200.h,
                      width: 200.w,
                      color: Colors.red,
                    );
                  },
                ),
              },
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CartScreen());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusXLarge.r),
        ),
        backgroundColor: MainColors.primaryColor,
        child: SvgPicture.asset(
          ResourceManager.getAssetResource(
            addCartIcon,
            type: ResourceType.svg,
          ),
          width: 20.w,
          colorFilter: const ColorFilter.mode(
            MainColors.whiteColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
