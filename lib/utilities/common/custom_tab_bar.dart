import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/default_app_drawer.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final List<KeyValuePairModel> tabList;
  final bool isScrollable;
  final bool hasInnerShadow;
  final double height;
  final Color? selectedColor;
  final TabController? tabController;
  final double borderRadius;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Color? unselectedColor;
  final TabAlignment? tabAlignment;

  const CustomTabBar({
    super.key,
    required this.tabList,
    this.isScrollable = false,
    this.hasInnerShadow = true,
    this.height = 50,
    this.tabController,
    this.selectedColor,
    this.borderRadius = 10,
    this.fontSize = 13,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.unselectedColor = AppColors.black,
    this.tabAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: hasInnerShadow ? Colors.transparent : AppColors.whiteSmoke,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 0.0,
                blurRadius: 0.0,
                offset: const Offset(0, 0),
              ),
              if (hasInnerShadow)
                const BoxShadow(
                  color: Colors.white,
                  spreadRadius: -2.0,
                  blurRadius: 10.0,
                ),
            ],
          ),
          child: TabBar(
            tabAlignment: tabAlignment,
            dividerColor: Colors.transparent,
            isScrollable: isScrollable,
            unselectedLabelColor: unselectedColor,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            padding: const EdgeInsets.all(6),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius - 4),
              color: selectedColor ?? AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0.0,
                  blurRadius: 4.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            controller: tabController,
            tabs: tabList.map(
              (tab) {
                return Tab(
                  child: Row(
                    children: [
                      if (tab.value != "") ...[
                        SvgPicture.network(
                          "https://assets.tickertape.in/images/${tab.value}",
                          height: 12,
                          width: 12,
                          semanticsLabel: 'Custom Image',
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        tab.key,
                      )
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

class NewCustomTabBar extends StatelessWidget {
  final List<KeyValuePairModel> tabList;
  final bool isScrollable;
  final bool hasInnerShadow;
  final Color? selectedColor;
  final TabController? tabController;
  final TabAlignment? tabAlignment;

  const NewCustomTabBar({
    super.key,
    required this.tabList,
    this.isScrollable = false,
    this.hasInnerShadow = true,
    this.tabController,
    this.selectedColor,
    this.tabAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TabBar(
        tabAlignment: tabAlignment,
        dividerColor: Colors.transparent,
        isScrollable: isScrollable,
        unselectedLabelColor: AppColors.black,
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        padding: const EdgeInsets.all(6),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selectedColor ?? AppColors.primaryColor,
        ),
        splashBorderRadius: BorderRadius.circular(40),
        controller: tabController,
        splashFactory: NoSplash.splashFactory,
        tabs: tabList.map(
          (tab) {
            return Tab(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.silverChalice30,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    if (tab.value != "") ...[
                      SvgPicture.network(
                        "https://assets.tickertape.in/images/${tab.value}",
                        height: 12,
                        width: 12,
                        semanticsLabel: 'Custom Image',
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      tab.key,
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
