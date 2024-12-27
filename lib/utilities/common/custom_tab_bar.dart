import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/default_app_drawer.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final List<KeyValuePairModel> tabList;
  final TabController? tabController;
  const CustomTabBar({
    super.key,
    required this.tabList,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.alabaster,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: 0.0,
              blurRadius: 0.0,
              offset: const Offset(0, 0),
            ),
            if (true)
              const BoxShadow(
                color: Colors.white,
                spreadRadius: -2.0,
                blurRadius: 10.0,
              ),
          ],
        ),
        child: TabBar(
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          isScrollable: true,
          unselectedLabelColor: AppColors.black,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: const EdgeInsets.all(6),
          splashBorderRadius: BorderRadius.circular(40),
          controller: tabController,
          splashFactory: NoSplash.splashFactory,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30 - 4),
            color: AppColors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0.0,
                blurRadius: 4.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
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
    );
  }
}
