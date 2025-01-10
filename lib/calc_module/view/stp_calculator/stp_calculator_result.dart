import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/components/core_calculator_report_view.dart';
import 'package:ipotec/calc_module/controller/functions/stp_functions.dart';
import 'package:ipotec/calc_module/controller/stp_calculator_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';

final _stpCalculatorController = Get.put(STPCalculatorController());

class StpCalculatorResult extends StatefulWidget {
  const StpCalculatorResult({super.key});

  @override
  State<StpCalculatorResult> createState() => _StpCalculatorResultState();
}

class _StpCalculatorResultState extends State<StpCalculatorResult> {
  Widget buildSummary(BuildContext context, {required CoreSTPModel? state}) {
    List<KeyValuePairModel<String, String, String>> data = [
      KeyValuePairModel(
        key: "Equity Returns",
        value: format2INR(state?.equityReturns),
      ),
      KeyValuePairModel(
        key: "Liquid Fund Returns",
        value: format2INR(state?.liquidReturns),
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
                text: "STP Amount:  ",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: format2INR(state?.stpAmount),
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
                    RichText(
                      text: TextSpan(
                        text: "Estimated Future Value\n",
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: format2INR(state?.growthValue),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
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
                          format2INR(state?.initialAmount),
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
                          "Total Gains",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          format2INR((state?.equityReturns ?? 0) + (state?.liquidReturns ?? 0)),
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
        ],
      ),
    );
  }

  Widget buildReports(BuildContext context, {required CoreSTPModel? state}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: ExpandableList(
        items: List.generate(state?.liquidReport.monthlyReport.length ?? 0, (index) {
          final liquidYear = state?.liquidReport.monthlyReport[index];
          final equityYear = state?.equityReport.monthlyReport[index];

          return CoreCalculatorMonthlyReportwithItemBuilder(
            report: liquidYear ?? [],
            itemBuilder: (context, index, investValueModel) {
              final equity = equityYear?[index];
              return [
                Text((index + 1).toString()),
                Text(format2INR(investValueModel.invest)),
                Text(format2INR(state?.stpAmount)),
                Text(format2INR(equity?.invest)),
                Text(format2INR(equity?.value)),
                Text(format2INR(investValueModel.invest - investValueModel.value)),
              ];
            },
            itemCount: liquidYear?.length ?? 0,
            columns: const [
              "Month",
              "Open Balance",
              "STP Amount",
              "Equity Transferred",
              "Equity Value",
              "Interest on Balance",
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "STP Calculator Result",
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: _stpCalculatorController.obx(
          (state) {
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
          },
        ),
      ),
    );
  }
}
