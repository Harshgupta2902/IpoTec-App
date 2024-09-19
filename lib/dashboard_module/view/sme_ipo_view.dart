import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/components/mainboard_upcoming_card.dart';
import 'package:ipotec/dashboard_module/controller/mainboard_ipo_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';

final _mainBoardIpoController = Get.put(MainBoardIpoController());

class SmeIpoView extends StatefulWidget {
  const SmeIpoView({super.key});

  @override
  State<SmeIpoView> createState() => _SmeIpoViewState();
}

class _SmeIpoViewState extends State<SmeIpoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "SME Ipo",
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
                          itemCount: state?.active?.where((data) => data.isSme == true).length ?? 0,
                          itemBuilder: (context, index) {
                            final filteredData =
                                state?.active?.where((data) => data.isSme == true).toList();
                            final data = filteredData?[index];
                            return MainboardUpcomingCard(
                              logo: data?.symbol,
                              name: data?.growwShortName,
                              bid: data?.additionalTxt,
                              data: [
                                KeyValuePairModel(
                                    key: "Offer Price:",
                                    value: "${data?.minPrice} - ${data?.maxPrice}"),
                                KeyValuePairModel(key: "Lot Size:", value: "${data?.lotSize}"),
                              ],
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
