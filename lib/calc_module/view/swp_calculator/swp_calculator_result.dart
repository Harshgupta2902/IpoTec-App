import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/components/core_calculator_report_view.dart';
import 'package:ipotec/calc_module/controller/functions/swp_functions.dart';
import 'package:ipotec/calc_module/controller/swp_calculator_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _swpCalculatorController = Get.put(SWPCalculatorController());

class SwpCalculatorResult extends StatefulWidget {
  const SwpCalculatorResult({super.key});

  @override
  State<SwpCalculatorResult> createState() => _SwpCalculatorResultState();
}

class _SwpCalculatorResultState extends State<SwpCalculatorResult> {
  Widget buildSummary(BuildContext context, {required CoreSWPModel? state}) {
    List<KeyValuePairModel<String, String, String>> data = [
      KeyValuePairModel(
        key: "Remaining Balance",
        value: format2INR(state?.reports.yearlyReport.last.value),
      ),
      KeyValuePairModel(
        key: "Monthly Withdrawal",
        value: format2INR(state?.pensionAmount),
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: AppBoxDecoration.getBoxDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: RichText(
              text: TextSpan(
                text: "Total Withdrawal:  ",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: format2INR(state?.withdrawnAmount),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(data.length, (index) {
            final item = data[index];
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: AppBoxDecoration.getBoxDecoration(),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: RichText(
                text: TextSpan(
                  text: "${item.key}:  ",
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: item.value,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: AppBoxDecoration.getBoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: "Final Value\n",
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: format2INR((state?.withdrawnAmount ?? 0) +
                                  (state?.reports.yearlyReport.last.value ?? 0)),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.trending_up,
                            color: Colors.green,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${state?.gainLossPer.toStringAsFixed(2)}%",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Colors.green),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Invested Amount",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          format2INR(state?.corpusAmount),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Returns Earned",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          format2INR(state?.interestEarned),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: AppBoxDecoration.getBoxDecoration(),
            child: Column(
              children: [
                Text(
                  "Comparison",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              String legend = "Invested";
                              if (value == 1) {
                                legend = "Returns";
                              }
                              if (value == 2) {
                                legend = "Final Value";
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(legend, style: Theme.of(context).textTheme.titleSmall),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(),
                        rightTitles: const AxisTitles(),
                      ),
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              compactFormat2INR(rod.toY),
                              Theme.of(context).textTheme.titleSmall ?? const TextStyle(),
                            );
                          },
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barsSpace: 80,
                          showingTooltipIndicators: [0],
                          barRods: [
                            BarChartRodData(
                              toY: state?.corpusAmount ?? 0,
                              color: AppColors.primaryColor,
                              width: 40,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barsSpace: 80,
                          showingTooltipIndicators: [0],
                          barRods: [
                            BarChartRodData(
                              toY: state?.interestEarned ?? 0,
                              color: AppColors.shareGreen,
                              width: 40,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barsSpace: 80,
                          showingTooltipIndicators: [0],
                          barRods: [
                            BarChartRodData(
                              toY: ((state?.withdrawnAmount ?? 0) +
                                  (state?.reports.yearlyReport.last.value ?? 0)),
                              color: AppColors.mediumGreen,
                              width: 40,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReports(BuildContext context, {required CoreSWPModel? state}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: CoreCalculatorReportView(
        monthlyReportWidget: ExpandableList(
          items: List.generate(state?.reports.monthlyReport.length ?? 0, (index) {
            final monthlyReport = state?.reports.monthlyReport[index];
            return CoreCalculatorMonthlyReportwithItemBuilder(
              report: monthlyReport ?? [],
              itemBuilder: (context, index, investValueModel) {
                return [
                  Text((index + 1).toString()),
                  Text(investValueModel.currencyInvested),
                  Text(investValueModel.currencyWithdrawAmount),
                  Text(format2INR(investValueModel.interestEarned)),
                  Text(investValueModel.currencyValue),
                ];
              },
              itemCount: monthlyReport?.length ?? 0,
              columns: const [
                "Year",
                "Open Balance",
                "Withdrawal",
                "Interest on Balance",
                "Final Value",
              ],
            );
          }),
        ),
        yearlyReportWidget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          decoration: AppBoxDecoration.getBoxDecoration(),
          child: CoreCalculatorMonthlyReportwithItemBuilder(
            report: state?.reports.yearlyReport ?? [],
            itemBuilder: (context, index, investValueModel) {
              return [
                Text((index + 1).toString()),
                Text(investValueModel.currencyInvested),
                Text(investValueModel.currencyWithdrawAmount),
                Text(format2INR(investValueModel.interestEarned)),
                Text(investValueModel.currencyValue),
              ];
            },
            itemCount: state?.reports.yearlyReport.length ?? 0,
            columns: const [
              "Year",
              "Open Balance",
              "Withdrawal",
              "Interest on Balance",
              "Final Value",
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "SWP Calculator Result",
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: _swpCalculatorController.obx((state) {
          return Column(
            children: [
              const CoreFlatTabBar(
                isScrollable: false,
                tabs: [
                  "Summary",
                  "Reports",
                ],
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    buildSummary(context, state: state),
                    buildReports(context, state: state),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
