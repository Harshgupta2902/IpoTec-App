import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/components/mainboard_listing_card.dart';
import 'package:ipotec/dashboard_module/components/mainboard_upcoming_card.dart';
import 'package:ipotec/dashboard_module/controller/mainboard_ipo_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

final _mainBoardIpoController = Get.put(MainBoardIpoController());

class MainBoardIpoView extends StatefulWidget {
  const MainBoardIpoView({super.key});

  @override
  State<MainBoardIpoView> createState() => _MainBoardIpoViewState();
}

class _MainBoardIpoViewState extends State<MainBoardIpoView> {
  @override
  void initState() {
    final filteredData =
        _mainBoardIpoController.state?.listed?.where((data) => data.isSme == true).toList();
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
            child: Column(
              children: [
                const CustomTabBar(
                  tabList: ["Upcoming IPO's", "Listed IPO's"],
                  horizontalPadding: 16,
                  verticalPadding: 10,
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: TabBarView(
                    children: [
                      ListView.separated(
                        itemCount: state?.active?.where((data) => data.isSme == false).length ?? 0,
                        itemBuilder: (context, index) {
                          final filteredData =
                              state?.active?.where((data) => data.isSme == false).toList();
                          final data = filteredData?[index];
                          return GestureDetector(
                            onTap: () => MyNavigator.pushNamed(
                              GoPaths.mainBoardDetails,
                              extra: {'slug': data?.searchId},
                            ),
                            child: MainboardUpcomingCard(
                              logo: data?.symbol,
                              name: data?.growwShortName,
                              bid: data?.additionalTxt,
                              data: [
                                KeyValuePairModel(
                                    key: "Offer Price:",
                                    value: "${data?.minPrice} - ${data?.maxPrice}"),
                                KeyValuePairModel(key: "Lot Size:", value: "${data?.lotSize}"),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                      ),
                      ListView.separated(
                        itemCount: state?.listed?.where((data) => data.isSme == false).length ?? 0,
                        itemBuilder: (context, index) {
                          final filteredData =
                              state?.listed?.where((data) => data.isSme == false).toList();
                          final data = filteredData?[index];
                          return MainboardListingCard(
                            logo: data?.logoUrl ?? data?.symbol,
                            name: data?.growwShortName,
                            bid: data?.additionalTxt,
                            listedTime:
                                "Listed on: ${convertDate(data?.listingDate ?? "")} at ${format2INR(data?.listingPrice)}",
                            data: [
                              KeyValuePairModel(
                                  key: "Offer Price:",
                                  value: "${data?.minPrice} - ${data?.maxPrice}"),
                              KeyValuePairModel(key: "Lot Size:", value: "${data?.listingPrice}"),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
