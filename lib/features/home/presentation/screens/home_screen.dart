import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning/core/resources/language_strings.dart';
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
                body: GridView.builder(
                  padding: EdgeInsets.all(10.r),
                  itemCount: 8,
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
              ),
              // Scaffold(
              //   backgroundColor: MainColors.backgroundColor(context),
              //   body: WaterfallFlow.builder(
              //     itemBuilder: (context, index) {
              //       return Container(
              //         height: 200.h,
              //         width: 200.w,
              //         color: Colors.red,
              //       );
              //     },
              //     padding: const EdgeInsets.all(5.0),
              //     gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 5.0,
              //       mainAxisSpacing: 5.0,
              //       lastChildLayoutTypeBuilder: (index) {
              //         return LastChildLayoutType.foot;
              //       }
              //     ),
              //   ),
              // ),
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
    );
  }
}
