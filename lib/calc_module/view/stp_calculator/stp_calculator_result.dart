import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/calc_module/components/core_calculator_report_view.dart';
import 'package:ipotec/calc_module/controller/stp_calculator_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';

final _stpCalculatorController = Get.put(STPCalculatorController());

class StpCalculatorResult extends StatefulWidget {
  const StpCalculatorResult({super.key});

  @override
  State<StpCalculatorResult> createState() => _StpCalculatorResultState();
}

class _StpCalculatorResultState extends State<StpCalculatorResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CoreAppBar(
        title: "STP Calculator Result",
        centerTitle: false,
        showBorder: true,
      ),
      body: _stpCalculatorController.obx(
        (state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
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
        },
      ),
    );
  }
}
