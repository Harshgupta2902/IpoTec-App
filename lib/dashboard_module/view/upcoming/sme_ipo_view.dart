import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/components/mainboard_listing_card.dart';
import 'package:ipotec/dashboard_module/components/mainboard_upcoming_card.dart';
import 'package:ipotec/dashboard_module/controller/upcoming/mainboard_ipo_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_error_or_empty.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/error_widget.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

final _mainBoardIpoController = Get.put(MainBoardIpoController());

class SmeIpoView extends StatelessWidget {
  const SmeIpoView({super.key});

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
            child: Column(
              children: [
                const CustomTabBar(
                  tabList: ["Upcoming IPO's", "Listed IPO's"],
                  horizontalPadding: 16,
                  verticalPadding: 10,
                ),
                Flexible(
                  child: TabBarView(
                    children: [
                      state?.active?.isEmpty == true
                          ? const CustomErrorOrEmpty(
                              title: "No Upcoming SME IPO's",
                            )
                          : ListView.separated(
                              itemCount:
                                  state?.active?.where((data) => data.isSme == true).length ?? 0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) {
                                final filteredData =
                                    state?.active?.where((data) => data.isSme == true).toList();
                                final data = filteredData?[index];
                                return GestureDetector(
                                  onTap: () => MyNavigator.pushNamed(
                                    GoPaths.mainBoardDetails,
                                    extra: {'slug': data?.searchId, 'name': data?.growwShortName},
                                  ),
                                  child: MainboardUpcomingCard(
                                    type: IpoType.sme,
                                    logo: data?.logoUrl ?? data?.symbol,
                                    name: data?.growwShortName?.trim(),
                                    bid: data?.additionalTxt?.trim(),
                                    data: [
                                      if (data?.minPrice != null && data?.maxPrice != null)
                                        KeyValuePairModel(
                                          key: "Offer Price:",
                                          value: "${data?.minPrice} - ${data?.maxPrice}",
                                        ),
                                      if (data?.lotSize != null)
                                        KeyValuePairModel(
                                          key: "Lot Size:",
                                          value: "${data?.lotSize}",
                                        ),
                                      if (data?.listingDate != null)
                                        KeyValuePairModel(
                                          key: "Start Date:",
                                          value: convertDate(data?.biddingStartDate ?? ""),
                                        ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const SizedBox(height: 16),
                            ),
                      state?.listed?.isEmpty == true
                          ? const CustomErrorOrEmpty(
                              title: "No Listed SME IPO's",
                            )
                          : ListView.separated(
                              itemCount:
                                  state?.listed?.where((data) => data.isSme == true).length ?? 0,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) {
                                final filteredData =
                                    state?.listed?.where((data) => data.isSme == true).toList();
                                final data = filteredData?[index];
                                return GestureDetector(
                                  onTap: () => MyNavigator.pushNamed(
                                    GoPaths.mainBoardDetails,
                                    extra: {'slug': data?.searchId, 'name': data?.growwShortName},
                                  ),
                                  child: MainboardListingCard(
                                    logo: data?.logoUrl ?? data?.symbol,
                                    name: data?.growwShortName,
                                    bid: data?.additionalTxt,
                                    listedTime:
                                        "Listed on: ${convertDate(data?.listingDate ?? "")} at ${format2INR(data?.listingPrice)}",
                                    data: [
                                      KeyValuePairModel(
                                          key: "Offer Price:",
                                          value: "${data?.minPrice} - ${data?.maxPrice}"),
                                      KeyValuePairModel(
                                          key: "Lot Size:", value: "${data?.listingPrice}"),
                                    ],
                                  ),
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
        onError: (error) => TryAgainWidget(
          onTap: _mainBoardIpoController.getMainboardData(),
        ),
      ),
    );
  }
}
