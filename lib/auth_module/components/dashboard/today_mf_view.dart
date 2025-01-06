import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/components/dashboard/today_stock_view.dart';
import 'package:ipotec/auth_module/controller/mf_gainers_controller.dart';
import 'package:ipotec/auth_module/models/mf_gainers_model.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';

final _mfGainersController = Get.put(MfGainersController());

class TodayMfView extends StatefulWidget {
  const TodayMfView({super.key});

  @override
  State<TodayMfView> createState() => _TodayMfViewState();
}

class _TodayMfViewState extends State<TodayMfView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
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
        _mfGainersController.getMfGainersData(type: "large");
        break;
      case 1:
        _mfGainersController.getMfGainersData(type: "mid");
        break;
      case 2:
        _mfGainersController.getMfGainersData(type: "small");
        break;
      case 3:
        _mfGainersController.getMfGainersData(type: "elss");
        break;
      case 4:
        _mfGainersController.getMfGainersData(type: "index");
        break;
      case 5:
        _mfGainersController.getMfGainersData(type: "etf");
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Mutual Funds and ETF's",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          CustomTabBar(
            tabController: _tabController,
            tabList: [
              KeyValuePairModel(key: "Large Cap", value: "landing-page/LargeCap.svg"),
              KeyValuePairModel(key: "Mid Cap", value: "landing-page/MidCap.svg"),
              KeyValuePairModel(key: "Small Cap", value: "landing-page/SmallCap.svg"),
              KeyValuePairModel(key: "Tax Saving", value: "landing-page/TaxSaving.svg"),
              KeyValuePairModel(key: "Index Funds", value: "landing-page/IndexFunds.svg"),
              KeyValuePairModel(key: "ETF's", value: "landing-page/ETFs.svg"),
            ],
          ),
          const SizedBox(height: 12),
          _mfGainersController.obx(
            (state) {
              return SizedBox(
                height: 320,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    MfCard(data: state?.data),
                    MfCard(data: state?.data),
                    MfCard(data: state?.data),
                    MfCard(data: state?.data),
                    MfCard(data: state?.data),
                    MfCard(
                      data: state?.data,
                      type: "etf",
                    ),
                  ],
                ),
              );
            },
            onLoading: const StockCardShimmer(),
          ),
        ],
      ),
    );
  }
}

class MfCard extends StatelessWidget {
  const MfCard({super.key, this.data, this.type});

  final List<Data>? data;
  final String? type;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final mfData = data?[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              CachedImageNetworkContainer(
                height: 52,
                width: 52,
                url: "https://assets.tickertape.in/amc-logos/${mfData?.amcCode}.png",
                placeHolder: buildPlaceHolderGrowPath(assetPath: mfData?.name ?? ""),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ('${mfData?.name?.split('').take(26).join('')}...'),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  type == "etf"
                      ? Text(
                          "${mfData?.sector}".toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      : Text(
                          "${mfData?.sector} • ${mfData?.option}".toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                ],
              ),
              const Spacer(),
              type == "etf"
                  ? Text(
                      "${mfData?.wpct?.toStringAsFixed(2)}%",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: getPercentageColor(mfData?.wpct?.toString() ?? ""),
                            fontWeight: FontWeight.w600,
                          ),
                    )
                  : Text(
                      "${mfData?.ret1y?.toStringAsFixed(2)}%",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: getPercentageColor(mfData?.ret1y?.toString() ?? ""),
                            fontWeight: FontWeight.w600,
                          ),
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
