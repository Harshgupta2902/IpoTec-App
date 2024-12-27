import 'package:flutter/material.dart';
import 'package:ipotec/auth_module/components/dashboard/today_mf_view.dart';
import 'package:ipotec/auth_module/components/dashboard/today_stock_view.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CoreAppBar(
        showBackButton: false,
        title: "",
      ),
      body: SingleChildScrollView(
        child: Column(
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
            const TodayStockView(),
            const SizedBox(height: 12),
            const TodayMfView(),
          ],
        ),
      ),
    );
  }
}
