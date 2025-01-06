import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/search_controller.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _searchController = Get.put(SearchMfController());

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchTextController = TextEditingController();
  final Debounce _debouncer = Debounce(delay: 300);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: CoreAppBar(
            titleWidget: TextFormField(
              controller: _searchTextController,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                filled: false,
                hintText: "Search Stocks, Mutual Funds & more..",
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.darkTextColor,
                    ),
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.black,
                  ),
              onChanged: (val) {
                setState(() {
                  _searchTextController.text = val;
                });
                if (val.length > 3) {
                  _debouncer.run(() {
                    _searchController.searchData(type: 'all', text: _searchTextController.text);
                  });
                }
              },
            ),
          ),
          body: DefaultTabController(
            length: 6,
            initialIndex: 0,
            child: Column(
              children: [
                const SizedBox(height: 8),
                CustomTabBar(
                  tabList: [
                    KeyValuePairModel(key: "Top", value: ""),
                    KeyValuePairModel(key: "Stocks", value: ""),
                    KeyValuePairModel(key: "small case", value: ""),
                    KeyValuePairModel(key: "Mutual Fund", value: ""),
                    KeyValuePairModel(key: "Index", value: ""),
                    KeyValuePairModel(key: "ETF", value: ""),
                  ],
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: TabBarView(
                    children: [
                      _searchController.obx((state) {
                        return ListView.separated(
                          itemCount: state?.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final mfData = state?.data?[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ('${mfData?.name?.split('').take(26).join('')}...'),
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Text(
                                        "${mfData?.sector}".toUpperCase(),
                                        style: Theme.of(context).textTheme.bodySmall,
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${mfData?.quote?.price?.toStringAsFixed(2)}%",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                        );
                      }),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  CustomHeaderDelegate({
    required this.minExtent,
    required this.maxExtent,
    required this.child,
  });

  @override
  final double minExtent;
  @override
  final double maxExtent;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Debounce {
  final int delay;
  Timer? _timer;

  Debounce({required this.delay});

  void run(void Function() action) {
    debugPrint("debounce called");
    _timer?.cancel();

    _timer = Timer(Duration(milliseconds: delay), action);
  }
}
