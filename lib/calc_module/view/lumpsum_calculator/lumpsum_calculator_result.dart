import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/components/core_calculator_report_view.dart';
import 'package:ipotec/calc_module/controller/functions/lumpsum_functions.dart';
import 'package:ipotec/calc_module/controller/lumpsum_calculator_controller.dart';
import 'package:ipotec/calc_module/controller/sip_calculator_controller.dart';
import 'package:ipotec/calc_module/controller/functions/sip_functions.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _lumpSumCalculatorController = Get.put(LumpsumCalculatorController());

class LumpsumCalculatorResult extends StatefulWidget {
  const LumpsumCalculatorResult({super.key});

  @override
  State<LumpsumCalculatorResult> createState() => _LumpsumCalculatorResultState();
}

class _LumpsumCalculatorResultState extends State<LumpsumCalculatorResult> {
  Widget buildSummary(BuildContext context, {required CoreLumpsumModel? state}) {
    final estRet = format2INR(
        ((state?.reports.yearlyReport.last.value ?? 0) - (state?.totalInvestAmount ?? 0)));

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          Container(
            decoration: AppBoxDecoration.getBoxDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                          text: "Estimated Returns\n",
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: estRet,
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
                            "${state?.reports.yearlyReport.last.currencyGainLossPer.toStringAsFixed(2)}%",
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
                        const SizedBox(height: 2),
                        Text(
                          format2INR(state?.totalInvestAmount),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Duration (Years)",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${state?.tenureInYears}",
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
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
                          tooltipRoundedRadius: 8,
                          tooltipPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          tooltipMargin: 10,
                          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              compactFormat2INR(rod.toY),
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                          getTooltipColor: (group) {
                            if (group.x == 0) {
                              return Colors.blue;
                            } else if (group.x == 1) {
                              return Colors.green;
                            } else {
                              return Colors.orange;
                            }
                          },
                          fitInsideHorizontally: true,
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barsSpace: 80,
                          showingTooltipIndicators: [0],
                          barRods: [
                            BarChartRodData(
                              toY: state?.totalInvestAmount ?? 0,
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
                              toY: state?.totalReturns ?? 0,
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
                              toY: ((state?.lumpSumAmount ?? 0) +
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

  Widget buildReports(BuildContext context, {required CoreLumpsumModel? state}) {
    return SingleChildScrollView(
      child: CoreCalculatorReportView(
        monthlyReportWidget: ExpandableList(
          items: List.generate(state?.reports.monthlyReport.length ?? 0, (index) {
            final monthlyReport = state?.reports.monthlyReport[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CoreCalculatorMonthlyReport(
                report: monthlyReport ?? [],
                itemCount: monthlyReport?.length ?? 0,
                columns: const [
                  "Month",
                  "Invested",
                  "Value",
                  "Return",
                ],
              ),
            );
          }),
        ),
        yearlyReportWidget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          child: CoreCalculatorMonthlyReport(
            report: state?.reports.yearlyReport ?? [],
            itemCount: state?.reports.yearlyReport.length ?? 0,
            columns: const [
              "Year",
              "Invested",
              "Value",
              "Return",
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
        title: "Lumpsum Calculator Result",
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: _lumpSumCalculatorController.obx((state) {
          return Column(
            children: [
              const CoreFlatTabBar(
                tabs: ["Summary", "Reports"],
                isScrollable: false,
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

class AmountPercentageColor extends StatelessWidget {
  final String percentage;
  final String amount;
  final double? amountFontSize;
  final double? percentageFontSize;

  const AmountPercentageColor({
    super.key,
    required this.percentage,
    required this.amount,
    this.amountFontSize = 14,
    this.percentageFontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    final number = num.tryParse(percentage);

    final isPositive = number != null && number < 0 ? false : true;
    final color = isPositive ? AppColors.mediumGreen : AppColors.cadmiumRed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
          text: amount,
          children: <TextSpan>[
            TextSpan(
              text: ' ($percentage%)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
