import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/components/core_calculator_report_view.dart';
import 'package:ipotec/calc_module/controller/swp_calculator_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';

final _swpCalculatorController = Get.put(SWPCalculatorController());

class SwpCalculatorResult extends StatelessWidget {
  const SwpCalculatorResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "SWP Calculator Result",
        centerTitle: false,
        showBorder: true,
      ),
      body: _swpCalculatorController.obx((state) {
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
      }),
    );
  }
}
