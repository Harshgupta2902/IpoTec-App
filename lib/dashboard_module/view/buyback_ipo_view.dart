import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/components/buyback_upcoming_card.dart';
import 'package:ipotec/dashboard_module/controller/buyback_ipo_controller.dart';
import 'package:ipotec/dashboard_module/modal/buyback_ipo_model.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';

final _buybackIpoController = Get.put(BuybackBoardIpoController());

class BuybackIpoView extends StatefulWidget {
  const BuybackIpoView({super.key});

  @override
  State<BuybackIpoView> createState() => _BuybackIpoViewState();
}

class _BuybackIpoViewState extends State<BuybackIpoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "BuyBack Ipo",
        centerTitle: false,
        showBackButton: false,
      ),
      body: _buybackIpoController.obx(
        (state) {
          List<Data>? sortedActive = List.from(state?.active as Iterable);
          sortedActive.sort((a, b) {
            DateTime dateA = DateTime.parse(a.endDate ?? "");
            DateTime dateB = DateTime.parse(b.endDate ?? "");
            return dateA.compareTo(dateB);
          });

          List<Data>? sortedClosed = List.from(state?.closed as Iterable);
          sortedClosed.sort((a, b) {
            DateTime dateA = DateTime.parse(a.endDate ?? "");
            DateTime dateB = DateTime.parse(b.endDate ?? "");
            return dateB.compareTo(dateA);
          });
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const CustomTabBar(
                  tabList: ["Current/Upcoming ", "Closed"],
                  horizontalPadding: 16,
                  verticalPadding: 10,
                ),
                Flexible(
                  child: TabBarView(
                    children: [
                      ListView.separated(
                        itemCount: sortedActive.length,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) {
                          final data = sortedActive[index];
                          return GestureDetector(
                            onTap: () => MyNavigator.pushNamed(
                              GoPaths.buyBackDetails,
                              extra: {'slug': data.searchId, 'name': data.companyShortName},
                            ),
                            child: BuybackUpcomingCard(
                              name: getBuyBackName(data.buyBackId ?? ""),
                              logo: data.companyLogo ?? data.companyShortName,
                              bid: "BuyBack Price: ${format2INR(data.offerPrice)}",
                              issueSize: "Issue Size(Amt.): ${data.issuedAmount}",
                              data: [
                                KeyValuePairModel(
                                  key: "Record Date",
                                  value: convertDate(data.recordDate ?? "", showYear: false),
                                ),
                                KeyValuePairModel(
                                  key: "Open Date",
                                  value: convertDate(data.startDate ?? "", showYear: false),
                                ),
                                KeyValuePairModel(
                                  key: "Close Date",
                                  value: convertDate(data.endDate ?? "", showYear: false),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                      ),
                      ListView.separated(
                        itemCount: sortedClosed.length,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) {
                          final data = sortedClosed[index];
                          return GestureDetector(
                            onTap: () => MyNavigator.pushNamed(
                              GoPaths.buyBackDetails,
                              extra: {'slug': data.searchId, 'name': data.companyShortName},
                            ),
                            child: BuybackUpcomingCard(
                              name: getBuyBackName(data.buyBackId ?? ""),
                              logo: data.companyLogo ?? data.companyShortName,
                              bid: "BuyBack Price: ${format2INR(data.offerPrice)}",
                              issueSize: "Issue Size(Amt.): ${data.issuedAmount}",
                              data: [
                                KeyValuePairModel(
                                  key: "Record Date",
                                  value: convertDate(data.recordDate ?? ""),
                                ),
                                KeyValuePairModel(
                                  key: "Open Date",
                                  value: convertDate(data.startDate ?? ""),
                                ),
                                KeyValuePairModel(
                                  key: "Close Date",
                                  value: convertDate(data.endDate ?? ""),
                                )
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
      ),
    );
  }
}
