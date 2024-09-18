import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/contoller/mainboard_ipo_controller.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/customtab_bar.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _mainBoardIpoController = Get.put(MainBoardIpoController());

class MainBoardIpoView extends StatefulWidget {
  const MainBoardIpoView({super.key});

  @override
  State<MainBoardIpoView> createState() => _MainBoardIpoViewState();
}

class _MainBoardIpoViewState extends State<MainBoardIpoView> {
  @override
  void initState() {
    _mainBoardIpoController.getMainboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "MainBoard Ipo",
        centerTitle: false,
        showBackButton: false,
      ),
      body: _mainBoardIpoController.obx(
        (state) {
          return DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  const CustomTabBar(
                    tabList: ["Upcoming IPO's", "Listed IPO's"],
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: TabBarView(
                      children: [
                        ListView.separated(
                          itemCount:
                              state?.active?.where((data) => data.isSme == false).length ?? 0,
                          itemBuilder: (context, index) {
                            final filteredData =
                                state?.active?.where((data) => data.isSme == false).toList();
                            final data = filteredData?[index];
                            return Container(
                              decoration: AppBoxDecoration.getBoxDecoration(),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 45,
                                        width: 45,
                                        decoration: AppBoxDecoration.getBoxDecoration(
                                          borderRadius: 10,
                                        ),
                                        child: SvgPicture.asset(
                                          getLogoPath(data?.symbol ?? "-"),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          "${data?.growwShortName}",
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              color: AppColors.onyx, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  RichText(
                                    text: TextSpan(
                                      text: "Bid Closes on: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColors.onyx),
                                      children: [
                                        TextSpan(
                                          text: formatBidDates(data?.additionalTxt ?? ""),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: AppColors.black, fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  CustomPaint(
                                    size: Size(MediaQuery.of(context).size.width, 1),
                                    painter: HorizontalDashedLinePainter(),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                        ),
                        const Text("data"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
