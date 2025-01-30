import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/components/core_calculator_report_view.dart';
import 'package:ipotec/calc_module/components/core_calculator_sip_top_up_report_view.dart';
import 'package:ipotec/calc_module/controller/functions/step_up_functions.dart';
import 'package:ipotec/calc_module/controller/step_up_sip_calculator.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _stepUpSIPController = Get.put(StepUpSIPController());

class SipTopUpCalculatorResult extends StatefulWidget {
  const SipTopUpCalculatorResult({super.key});

  @override
  State<SipTopUpCalculatorResult> createState() => _SipTopUpCalculatorResultState();
}

class _SipTopUpCalculatorResultState extends State<SipTopUpCalculatorResult> {
  Widget buildSummary(BuildContext context, {required CoreStepUpSIPModel? state}) {
    Widget buildComparison({required CoreStepUpSIPModel? state}) {
      final report = state?.reports.yearlyReport.last;
      final topUpReport = state?.topUpReports.yearlyReport.last;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: AppBoxDecoration.getBoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Estimated Growth Value ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: "with Step Up",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      state?.topUpReports.yearlyReport.last.currencyValue ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
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
                            "${state?.topUpReports.yearlyReport.last.currencyGainLossPer.toStringAsFixed(2)}%",
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
                          "Total Investments",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          topUpReport?.currencyInvested ?? "",
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
                          "Returns",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          format2INR((state?.topUpReports.yearlyReport.last.value ?? 0) -
                              (topUpReport?.invest ?? 0)),
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
          const SizedBox(height: 12),
          Container(
            decoration: AppBoxDecoration.getBoxDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Estimated Growth Value ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: "without Step Up",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      state?.reports.yearlyReport.last.currencyValue ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Container(
                      decoration: AppBoxDecoration.getBoxDecoration(),
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
                          "Total Investments",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          report?.currencyInvested ?? "",
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
                          "Returns",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          format2INR((state?.reports.yearlyReport.last.value ?? 0) -
                              (report?.invest ?? 0)),
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
        ],
      );
    }

    Widget buildChart({required CoreStepUpSIPModel? state}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Comparison",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 10,
                      color: AppColors.androidGreen,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Value with Step Up",
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.boulder),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 10,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Value without Step Up",
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.boulder),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 240,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return [
                          LineTooltipItem(
                            'without top up ',
                            const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: format2INR(touchedSpots[0].y),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          LineTooltipItem(
                            'with top up  ',
                            const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: format2INR(touchedSpots[1].y),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )
                        ];
                      },
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                  ),
                  gridData: const FlGridData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      color: AppColors.primaryColor,
                      isCurved: true,
                      spots: List.generate(
                        state?.reports.yearlyReport.length ?? 0,
                        (index) {
                          final report = state?.reports.yearlyReport[index];
                          return FlSpot(
                            index.toDouble() + 1,
                            report?.value ?? 0,
                          );
                        },
                      ).toList(),
                    ),
                    LineChartBarData(
                      color: AppColors.androidGreen,
                      isStepLineChart: false,
                      isCurved: true,
                      spots: List.generate(
                        state?.topUpReports.yearlyReport.length ?? 0,
                        (index) {
                          final report = state?.topUpReports.yearlyReport[index];
                          return FlSpot(
                            index.toDouble() + 1,
                            report?.value ?? 0,
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Year",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildComparison(state: state),
          const SizedBox(height: 16),
          buildChart(state: state),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildReports(BuildContext context, {required CoreStepUpSIPModel? state}) {
    return SingleChildScrollView(
      child: CoreCalculatorReportView(
        monthlyReportWidget: ExpandableList(
          items: List.generate(state?.topUpReports.monthlyReport.length ?? 0, (index) {
            final monthlyReport = state?.topUpReports.monthlyReport[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CoreCalculatorSipTopUpMonthlyReport(
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
          child: CoreCalculatorSipTopUpMonthlyReport(
            report: state?.topUpReports.yearlyReport ?? [],
            itemCount: state?.topUpReports.yearlyReport.length ?? 0,
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
        title: "SIP Top Up Result",
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: _stepUpSIPController.obx((state) {
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
