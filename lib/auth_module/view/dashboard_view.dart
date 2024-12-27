import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/components/dashboard/stocks_card.dart';
import 'package:ipotec/auth_module/controller/stock_gainers_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _stockGainersController = Get.put(StockGainersController());

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _stockGainersController.getStocksData(type: "gainers");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CoreAppBar(
        showBackButton: false,
        title: "",
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.white,
            child: Container(
              height: 45.0,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(width: 1, color: AppColors.silverChalice30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                child: InkWell(
                  onTap: () {
                    // MyNavigator.pushNamed(GoPaths.searchView);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Search',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.inputBorderColor,
                              ),
                        ),
                      ),
                      const Icon(
                        Icons.search,
                        size: 24.0,
                        color: Color(0xffAAA7A7),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          DefaultTabController(
            length: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Today's Stocks",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                NewCustomTabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabList: [
                    KeyValuePairModel(key: "Gainers", value: "landing-page/gainers.svg"),
                    KeyValuePairModel(key: "Losers", value: "landing-page/losers.svg"),
                    KeyValuePairModel(key: "Most Active", value: "landing-page/most_active.svg"),
                    KeyValuePairModel(key: "52W High", value: "landing-page/52w_high.svg"),
                    KeyValuePairModel(key: "52W Low", value: "landing-page/52w_low.svg"),
                  ],
                ),
                const SizedBox(height: 12),
                _stockGainersController.obx((state) {
                  return SizedBox(
                    height: 320,
                    child: TabBarView(
                      children: [
                        StocksCard(data: state?.data),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                        Text("data"),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
