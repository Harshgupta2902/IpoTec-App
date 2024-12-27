import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/stock_gainers_controller.dart';
import 'package:ipotec/auth_module/models/stock_gainers_model.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/common/skeleton_widget.dart';
import 'package:ipotec/utilities/constants/functions.dart';

final _stockGainersController = Get.put(StockGainersController());

class TodayStockView extends StatefulWidget {
  const TodayStockView({super.key});

  @override
  State<TodayStockView> createState() => _TodayStockViewState();
}

class _TodayStockViewState extends State<TodayStockView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        _fetchDataForTab(_tabController.index);
      }
    });
    _fetchDataForTab(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _fetchDataForTab(int index) {
    switch (index) {
      case 0:
        _stockGainersController.getStocksData(type: "gainers");
        break;
      case 1:
        _stockGainersController.getStocksData(type: "losers");
        break;
      case 2:
        _stockGainersController.getStocksData(type: "active");
        break;
      case 3:
        _stockGainersController.getStocksData(type: "approachingHigh");
        break;
      case 4:
        _stockGainersController.getStocksData(type: "approachingLow");
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
          const SizedBox(height: 8),
          CustomTabBar(
            tabController: _tabController,
            tabList: [
              KeyValuePairModel(key: "Gainers", value: "landing-page/gainers.svg"),
              KeyValuePairModel(key: "Losers", value: "landing-page/losers.svg"),
              KeyValuePairModel(key: "Most Active", value: "landing-page/most_active.svg"),
              KeyValuePairModel(key: "52W High", value: "landing-page/52w_high.svg"),
              KeyValuePairModel(key: "52W Low", value: "landing-page/52w_low.svg"),
            ],
          ),
          const SizedBox(height: 12),
          _stockGainersController.obx(
            (state) {
              return Builder(builder: (context) {
                final TabController tabController = DefaultTabController.of(context);
                tabController.addListener(() {
                  if (!tabController.indexIsChanging) {
                    debugPrint(tabController.index.toString());
                  }
                });
                return SizedBox(
                  height: 320,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      StocksCard(data: state?.data),
                      StocksCard(data: state?.data),
                      StocksCard(data: state?.data),
                      StocksCard(data: state?.data),
                      StocksCard(data: state?.data),
                    ],
                  ),
                );
              });
            },
            onLoading: const StockCardShimmer(),
          ),
        ],
      ),
    );
  }
}

class StocksCard extends StatelessWidget {
  const StocksCard({super.key, this.data});

  final List<Data>? data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final stockData = data?[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              CachedImageNetworkContainer(
                height: 52,
                width: 52,
                url: "https://assets.tickertape.in/stock-logos/${stockData?.sid}.png",
                placeHolder: buildPlaceHolderGrowPath(assetPath: stockData?.name ?? ""),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ('${stockData?.name?.split('').take(26).join('')}...'),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    stockData?.ticker ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${stockData?.price?.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    "${stockData?.change?.toStringAsFixed(2)}%",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: getPercentageColor(stockData?.change?.toString() ?? ""),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}

class StockCardShimmer extends StatelessWidget {
  const StockCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SkeletonWidget(height: 52, width: 52),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonWidget(height: 16, width: 180),
                  SizedBox(height: 10),
                  SkeletonWidget(height: 16, width: 100),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SkeletonWidget(height: 16, width: 60),
                  SizedBox(height: 10),
                  SkeletonWidget(height: 16, width: 40),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}
